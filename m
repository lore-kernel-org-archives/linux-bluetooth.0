Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Northfield Stuart <stu@metanate.com>
Content-Type: text/plain; charset=utf-8
Subject: Unable to connect to BLE device with long advertisement period
Date: Tue, 26 Jul 2016 15:52:49 +0100
Message-Id: <8E977046-4084-41D9-B0D4-755F053FC604@metanate.com>
Cc: johan.hedberg@intel.com
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are currently working with a BLE device which (for power consumption reasons) uses an unusually large advertisement period of ten seconds (unusual, but allowed within the BLE specification).

This works with older kernels (e.g. 4.2.6 in RH F23), but on later kernels it appears that the kernel times out the connection attempt after only two seconds.

I believe I have tracked down the change responsible to a patch from Johan Hedberg <johan.hedberg@intel.com> on 2014-07-06, which appears to split the BLE connection timeout in to two variants, HCI_LE_CONN_TIMEOUT which remains at 20 seconds, and the newly added one, HCI_LE_AUTOCONN_TIMEOUT, which has been reduced down to two seconds. There may be other changes in the BlueZ kernel code which cause this change to become an issue.

Original patch in archive: <http://marc.info/?l=linux-bluetooth&m=140464328310643&w=2>

Summary from that patch:

“When we establish connections as a consequence of receiving an
advertising report it makes no sense to wait the normal 20 second LE
connection timeout. This patch modifies the hci_connect_le function to
take an extra timeout value and uses a lower 2 second timeout for the
auto-connection case. This timeout is intentionally chosen to be just a
bit higher than the 1.28 second timeout that High Duty Cycle Advertising
uses."

Although this timeout reduction is probably OK for the majority of devices, it appears to prevent a perfectly conformant device from working with more recent kernels (recent being relative in this context I guess, given the patch was two years ago!).

I believe it will be necessary to revert this timeout back to 20 seconds in order to support all possible BLE devices - as per the patch below.

I have tested this modification, and it does indeed enable us to work with our BLE device - would anyone care to comment on whether this is the correct solution or not?

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

