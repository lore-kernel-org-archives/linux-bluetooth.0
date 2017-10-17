Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Need info on factory reset api in Bluez
Date: Tue, 17 Oct 2017 11:52:50 +0000
Message-ID: <7B53A3173656CB4190908401FE75F4F860077BD9@exgmbxfz02.sasken.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We are using bluez stack apis for developing BLE client.Our device has an option of factory reset.
I have tried using rfkill etc to reset the controller, but I see that devices are not getting deleted from gatt database.

Is there any single api call, which is used for factory reset in Bluez?

Regards,
Anitha

________________________________

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Technologies Limited ( formerly known as "Sasken Communication Technologies Limited" ) unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/mail-disclaimer/

________________________________
