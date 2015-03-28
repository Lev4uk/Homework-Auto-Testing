
function Main()
{

  Run();
  NewOrder();
  SelectOrders_OneByOne_AndVerifyName();
  Close_and_Clear ();

}

function Run()
{
  TestedApps.Orders.Run();
}

function NewOrder()
  { 

  var Ordersbtn = Aliases.Sys.Orders.MainForm.MainMenu;
  var doc = Files.FileNameByName("by.csv");
  var driver = DDT.CSVDriver(doc);
 
    while(!driver.EOF())
    {
     
   Ordersbtn.Click("Orders|New order...");    
   var name = driver.value(0);
   
   Aliases.Customer1.Select();
   Aliases.Customer1.wText = name;
   var street = driver.value(1);
   Aliases.Street.Select();
   Aliases.Street.wText = street;
   var city = driver.value(2);
   Aliases.City.Select();
   Aliases.City.wText = city;
   var state = driver.value(3);  
   Aliases.State.Select();
   Aliases.State.wText = state;
   var zip = driver.value(4);
   Aliases.Zip.Select();
   Aliases.Zip.wText = zip;
   var card = driver.value(5)+"" ; 
   Aliases.CardNo.Select();
   Aliases.CardNo.wText = card;
   Aliases.ButtonOK.Click(); 
   
   Log.PopLogFolder();
   Log.AppendFolder(name);   

   
    driver.Next();
    }
   DDT.CloseDriver(doc);  
      
    }
        
function SelectOrders_OneByOne_AndVerifyName()

{
    var doc = Files.FileNameByName("by.csv");
  var driver = DDT.CSVDriver(doc);
     while(!driver.EOF())
    {
      for (i=0;i<=4;i++)
  {  //4 - количество строк в списке
    Aliases.MainForm.OrdersView.SelectItem(i)
    Delay(500);
    var name= driver.value(0);
       driver.Next();
    if(Aliases.MainForm.OrdersView.FocusedItem.Text.OleValue !=name)
      Log.Error("The property value does not equal the baseline value.");
    else
      Log.Message("OK");  
      
    }
   DDT.CloseDriver(doc);      
  }
  }
  
function Close_and_Clear ()
{
 Aliases.Sys.Orders.Close () ;
 Aliases.Sys.Orders.dlgConfirmation.btnNo.ClickButton();  
}
