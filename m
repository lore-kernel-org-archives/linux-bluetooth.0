Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: flushable packet supports headers
Date: Tue, 25 Jan 2011 11:45:47 +0200
Message-Id: <1295948747-11094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Modify headers to enable support for flushable packets. Following
commit: 8bcbd526c84724d8de087130d53e79da256e34bf to linux kernel
implements functionality on kernel side.
---
 lib/bluetooth.h |    5 +++++
 lib/hci.h       |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

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
index 0cb120f..9b5388b 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -196,6 +196,7 @@ enum {
 #define HCI_HOST_BUSY_PAIRING			0x38
 
 /* ACL flags */
+#define ACL_START_NO_FLUSH	0x00
 #define ACL_CONT		0x01
 #define ACL_START		0x02
 #define ACL_ACTIVE_BCAST	0x04
-- 
1.7.1

