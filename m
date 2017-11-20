Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Gdbus method reply cb not called for sleepy devices
Date: Mon, 20 Nov 2017 13:57:24 +0000
Message-ID: <7B53A3173656CB4190908401FE75F4F8600A4C64@exgmbxfz01.sasken.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

We are using bluez stack to work as a GATT central device on a 32 bit processor. We are trying to call Bluez 5.46 read api. We see that at stack the callback method_call_reply(gdbus/client.c) is not being called, due to which it is unable to call our registered callback.

Few observations:
1) This happens only when Gatt APIs such as read/disconnect/write etc are called, and the peripheral device is in sleep , disconnected.
2) We have verified through dbus-monitor --system and the dbus has sent the message as NOT CONNECTED, but this is not reached to gdbus client.
3) It perfectly works fine on a 64th bit processor , but not working on 32bit processor.

The dbus version used is 1.10.10. The bluez stack used is bluez5.46.Using x86, 32 bit processor.

Any information will be of great help. Thanks!!

Regards,
Anitha

________________________________

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Technologies Limited ( formerly known as "Sasken Communication Technologies Limited" ) unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/mail-disclaimer/

________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
