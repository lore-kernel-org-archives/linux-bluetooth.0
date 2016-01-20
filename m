Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ad Zeevaarders <ad.zeevaarders@veynex.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Enabling indications/notifications results in wrong sequence of
 events.
Date: Wed, 20 Jan 2016 13:32:56 +0000
Message-ID: <AM3PR01MB2118217F9817B710F197FACF9C20@AM3PR01MB211.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



Hello everyone,

When using some code from btgatt-client.c for a project of mine, I found that when enabling a value indication/notification on a certain characteristic of a peripheral device I have (Blood pressure meter) the order of events is not linear. I'm using the MGMT API in combination with l2cap sockets and am using btgatt-client.c and btmgmt.c as references. At first I thought it was a problem with my own code, but running the vanilla btgatt-client I found out that:

When enabling notifications, two callbacks are given to the bt_gatt_register_notify method, one to report back if the notification succeeded, and the other one to catch values emitted by the peripheral. The expected order of the callbacks being called is 
1. Notifications/indications success
2. Value A received 
3.Value B received and so on. 

However, the order is actually: 

1. Value A received
2. Notifications/indications success
3. Value A received again
4. Value B received and so on.

My own program starts notifications as soon as GATT Service Discovery is completed. (It calls a StartNotifications method from within that callback actually) and that is also why normal use of btgatt-client does not surface this possible bug; after GATT Service Discovery is completed the user will be prompted for a command again. When I changed some code in btgatt-client.c to immediately start notifications on a characteristic as soon as the GATT Service Discovery completed callback or "ready_cb" was called it exhibited the behavior.

I hope I have been clear and readers will be able to reproduce the error, please let me know what you think.

Thanks for your time and best regards,

Ad Zeevaarders