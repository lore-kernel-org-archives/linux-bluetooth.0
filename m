Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: flushable packet supports headers
Date: Tue, 25 Jan 2011 11:36:19 +0200
Message-Id: <1295948179-10942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Modify headers to enable support for flushable packets. Following
commit: 8bcbd526c84724d8de087130d53e79da256e34bf to linux kernel
implements functionality on kernel side.
---
 lib/bluetooth.h |    5 +++++
 lib/hci.h       |    3 ++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index a0486c7..bc0921e 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -70,6 +70,11 @@ struct bt_security {
 
 #define BT_DEFER_SETUP	7
 
+#define BT_FLUSHABLE	8
+
+#define BT_FLUSHABLE_OFF	0
+#define BT_FLUSHABLE_ON		1
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/lib/hci.h b/lib/hci.h
index 0cb120f..d8d62b0 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -196,6 +196,7 @@ enum {
 #define HCI_HOST_BUSY_PAIRING			0x38
 
 /* ACL flags */
+#define ACL_START_NO_FLUSH	0x00
 #define ACL_CONT		0x01
 #define ACL_START		0x02
 #define ACL_ACTIVE_BCAST	0x04
@@ -261,7 +262,7 @@ enum {
 #define LMP_SIMPLE_PAIR	0x08
 #define LMP_ENCAPS_PDU	0x10
 #define LMP_ERR_DAT_REP	0x20
-#define LMP_NFLUSH_PKTS	0x40
+#define LMP_NO_FLUSH	0x40
 
 #define LMP_LSTO	0x01
 #define LMP_INQ_TX_PWR	0x02
-- 
1.7.1

