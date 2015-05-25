Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Ankur Patel' <ankur@embertec.com>, linux-bluetooth@vger.kernel.org
References: <BD5E516FF3711A41B93DC005170007BB010E5D9DFBFD@EMBSVR01.ember.local>
In-reply-to: <BD5E516FF3711A41B93DC005170007BB010E5D9DFBFD@EMBSVR01.ember.local>
Subject: RE: Issue Write Not Permitted Error Response not working
Date: Mon, 25 May 2015 13:17:52 +0530
Message-id: <000701d096bf$1c0194d0$5404be70$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Ankur Patel
> Sent: Saturday, May 23, 2015 9:10 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: Issue Write Not Permitted Error Response not working
> 
> Hello Folks,
> 
> After implementing and running the test case for Characteristics Write Not
> Permitted Response (TC_GAW_SR_BI_15_C), it failed. Following the Trace, I
> found that Bluez (Controller) Sends ATT "Error Response: Write not
> Permitted"  after receiving "Execute Write Request" from Host instead of
> sending the "Error Response" after receiving "Prepare Write Request" from
> Host.
> 
> Current ATT Message Exchange (Host <> Controller)
>  ----------------------------------------------------
> Frame#41(H->C): Prepare Write Request
> Frame#43(C->H): Prepare Write Response
> Frame#44(H->C): Execute Write Request
> Frame#46(C->H): Error Response with code "Write Not Permitted"
> 
> Expected ATT Message Exchange (Host <> Controller)
> ----------------------------------------------------
>  (H->C): Prepare Write Request
> (C->H): Error Response with code "Write Not Permitted"
> 
> Please find the attached Trace Capture via PTS software as
> http://www.filedropper.com/tcgawsrbi15c20150523090341
> 
> Code Snippet (Registered Characteristic as below - for Write not
permitted):
> 
> gatt_db_service_add_characteristic(service, &uuid,
>                         BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
>                         BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_WRITE,
>                         custom_ccc_read_cb,
custom_not_permi_resp_write_cb,
>                         server);
> 

PTS FAILS:
Here you are trying to write on a CHARC which is already given write
permission.
So, in this case BlueZ will send Success Prepare Write Response, which is
correct.

PTS PASS:
But If you remove the write permission from above code snippet, Bluez will
send
Write Not Permitted Error Response, which makes TC_GAW_SR_BI_15_C PASS.

For more info you can start tools/btgatt-server and
emulate all services and cross-check the functionality.

Let others comment on this.
 
> static void custom_not_permi_resp_write_cb(struct gatt_db_attribute
> *attrib,
>                     unsigned int id, uint16_t offset,  const uint8_t
*value, size_t len,
>                     uint8_t opcode, struct bt_att *att,  void *user_data)
{
>     uint8_t ecode = 0x3;
>     gatt_db_attribute_write_result(attrib, id, ecode); }
> 
> Any idea on why Bluez is not sending the Error Response After Prepare
Write
> Request from Host?
> 
> Regards,
> Ankur.
> --

Regards,
Gowtham Anandha Babu

> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

