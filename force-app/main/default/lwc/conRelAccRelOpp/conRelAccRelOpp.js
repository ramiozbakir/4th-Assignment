import { LightningElement,track,wire,api } from 'lwc';
import getAllData from '@salesforce/apex/ConRelAccRelOppApex.getAllData';

export default class ConRelAccRelOppLwc extends LightningElement {
  @api recordId;
    data;
    error;
    contactName;
    accountName;
    contactEmail;
    @wire(getAllData, {recordId: '$recordId'
    })
    wiredclass({
        data, error
    }){
        if (data) { 
            console.log('data' + JSON.stringify(data));
            this.data  = data;
            if(data.length > 0){
                this.contactName = data[0].contactName;
                this.contactEmail = data[0].contactEmail;
                this.accountName = data[0].accountName;
            }
            this.error = undefined;  
           } else if (error) {  
            this.error = error;  
            this.data  = undefined;
           }  
    }
}