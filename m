Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sat, 23 May 2015 13:09:31 +0930
Subject: Issue Write Not Permitted Error Response not working
Message-ID: <BD5E516FF3711A41B93DC005170007BB010E5D9DFBFD@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

After implementing and running the test case for Characteristics Write Not Permitted Response (TC_GAW_SR_BI_15_C), it failed. Following the Trace, I found that Bluez (Controller) Sends ATT "Error Response: Write not Permitted"  after receiving "Execute Write Request" from Host instead of sending the "Error Response" after receiving "Prepare Write Request" from Host.

Current ATT Message Exchange (Host <> Controller)
 ----------------------------------------------------
Frame#41(H->C): Prepare Write Request
Frame#43(C->H): Prepare Write Response
Frame#44(H->C): Execute Write Request
Frame#46(C->H): Error Response with code "Write Not Permitted"

Expected ATT Message Exchange (Host <> Controller)
----------------------------------------------------
 (H->C): Prepare Write Request
(C->H): Error Response with code "Write Not Permitted"

Please find the attached Trace Capture via PTS software as http://www.filedropper.com/tcgawsrbi15c20150523090341

Code Snippet (Registered Characteristic as below - for Write not permitted):

gatt_db_service_add_characteristic(service, &uuid,
                        BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
                        BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_WRITE,
                        custom_ccc_read_cb, custom_not_permi_resp_write_cb,
                        server);

static void custom_not_permi_resp_write_cb(struct gatt_db_attribute *attrib,
                    unsigned int id, uint16_t offset,  const uint8_t *value, size_t len,
                    uint8_t opcode, struct bt_att *att,  void *user_data)
{
    uint8_t ecode = 0x3;
    gatt_db_attribute_write_result(attrib, id, ecode);
}

Any idea on why Bluez is not sending the Error Response After Prepare Write Request from Host? 

Regards,
Ankur.
