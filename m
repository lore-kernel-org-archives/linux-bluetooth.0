Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Query Regaring usage of RegisterApplication Method using Gio Api
Date: Tue, 8 Aug 2017 12:01:02 +0000
Message-ID: <7B53A3173656CB4190908401FE75F4F85CC0D1CE@exgmbxfz01.sasken.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi ,

We need to call RegisterApplication function from our application for auto-connect of devices. We are registering the GattProfile1 object and calling RegisterApplication method using Gio Api.

But we are getting a "No object Found " error every time. Could you please let us know if there is any example code for the same or if you could suggest the API usage from d-feet tool.
d-feet ->
I dont see GattProfile1 being listed in d-feet and there is only RegisterApplication api, can I know what input params to be given and usage of it.Thanks in advance.

Regards,
Anitha

________________________________

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Technologies Limited ( formerly known as "Sasken Communication Technologies Limited" ) unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/mail-disclaimer/

________________________________
