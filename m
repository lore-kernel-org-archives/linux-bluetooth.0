Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Northfield Stuart <stu@metanate.com>
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] Enable connections to BLE devices with long advertisement period
Date: Wed, 3 Aug 2016 11:29:10 +0100
Message-Id: <EB5048B5-65C1-4B98-A1F1-5A4943169FC7@metanate.com>
Cc: johan.hedberg@intel.com
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Revert earlier change which reduced auto connection timeout from 20s to 2s (http://marc.info/?l=linux-bluetooth&m=140464328310643&w=2), which prevents connections being established to devices which advertise very slowly.

We are currently working with a BLE device which (for power consumption reasons) uses an unusually large advertisement period of ten seconds (unusual, but allowed within the BLE specification).

This works with older kernels (e.g. 4.2.6 in RH F23), but on later kernels it appears that the kernel times out the connection attempt after only two seconds.

I believe I have tracked down the change responsible to a patch from Johan Hedberg <johan.hedberg@intel.com> on 2014-07-06, which appears to split the BLE connection timeout in to two variants, HCI_LE_CONN_TIMEOUT which remains at 20 seconds, and the newly added one, HCI_LE_AUTOCONN_TIMEOUT, which has been reduced down to two seconds. There may be other changes in the BlueZ kernel code which cause this change to become an issue.

Although this timeout reduction is probably OK for the majority of devices, it appears to prevent a perfectly conformant device from working with more recent kernels (recent being relative in this context I guess, given the patch was two years ago!).

Regards

Stu

diff -uNrp a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
--- a/include/net/bluetooth/hci.h	2016-03-14 04:28:54.000000000 +0000
+++ b/include/net/bluetooth/hci.h	2016-06-07 14:51:57.561115398 +0100
@@ -265,7 +265,7 @@ enum {
#define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
#define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
#define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
-#define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
+#define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */

/* HCI data types */
#define HCI_COMMAND_PKT		0x01

