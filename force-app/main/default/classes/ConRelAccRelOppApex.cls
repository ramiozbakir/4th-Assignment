public with sharing class ConRelAccRelOppApex {
    @AuraEnabled(cacheable=true)
    public static List<OppWrapperClass> getAllData(string recordId){
        // Select Id, LastName, Account.Name,(select Id,Name from opportunities) from Contact
        
        List<OppWrapperClass> oppWrapperList = new List<OppWrapperClass>();

        Contact con = [SELECT Id, LastName, Account.Name,AccountId FROM Contact Where ID =:recordId];
        List<OpportunityContactRole>  oppConList=[Select id, Opportunity.Name, Opportunity.StageName, Contact.Account.Name, Contact.Name, Contact.Email from OpportunityContactRole where ContactId=:recordId];
        if(!oppConList.isEmpty()){
            OppWrapperClass opWrp=new OppWrapperClass();
            for(OpportunityContactRole opRoleFor : oppConList){
                opWrp=new OppWrapperClass();
                opWrp.Id=opRoleFor.Id;
                opWrp.oppName=opRoleFor.Opportunity.Name;
                opWrp.contactName='';
                opWrp.contactEmail = '';
                opWrp.accountName= '';
                if(opRoleFor.Contact != null){
                    opWrp.contactName=opRoleFor.Contact.Name;
                    opWrp.contactEmail=opRoleFor.Contact.Email;
                    if(opRoleFor.Contact.Account != null){
                        opWrp.accountName=opRoleFor.Contact.Account.Name;
                    }
                }         
                opWrp.oppStageName = '';       
                if(opRoleFor.Opportunity != null)
                    opWrp.oppStageName=opRoleFor.Opportunity.StageName;
                oppWrapperList.add(opWrp);
            }
       }   
            
        return oppWrapperList;
    }
    public class OppWrapperClass{
        @AuraEnabled
        public String Id;
        @AuraEnabled
        public String contactName;
        @AuraEnabled
        public string contactEmail;
        @AuraEnabled
        public String accountName;
       @AuraEnabled
       public string oppName;
       @AuraEnabled
       public string oppStageName;
    }
}