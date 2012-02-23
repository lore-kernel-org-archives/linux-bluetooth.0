Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] bluez: Copy L2CAP chan policy defines from kernel
Date: Thu, 23 Feb 2012 17:20:16 +0200
Message-Id: <1330010418-2613-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those defines will be used by user space.
---
 lib/bluetooth.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 1dee6df..52606e6 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -77,6 +77,33 @@ struct bt_security {
 #define BT_FLUSHABLE_OFF	0
 #define BT_FLUSHABLE_ON		1
 
+#define BT_CHANNEL_POLICY	10
+
+/* BR/EDR only (default policy)
+ *   AMP controllers cannot be used.
+ *   Channel move requests from the remote device are denied.
+ *   If the L2CAP channel is currently using AMP, move the channel to BR/EDR.
+ */
+#define BT_CHANNEL_POLICY_BREDR_ONLY		0
+
+/* BR/EDR Preferred
+ *   Allow use of AMP controllers.
+ *   If the L2CAP channel is currently on AMP, move it to BR/EDR.
+ *   Channel move requests from the remote device are allowed.
+ */
+#define BT_CHANNEL_POLICY_BREDR_PREFERRED	1
+
+/* AMP Preferred
+ *   Allow use of AMP controllers
+ *   If the L2CAP channel is currently on BR/EDR and AMP controller
+ *     resources are available, initiate a channel move to AMP.
+ *   Channel move requests from the remote device are allowed.
+ *   If the L2CAP socket has not been connected yet, try to create
+ *     and configure the channel directly on an AMP controller rather
+ *     than BR/EDR.
+ */
+#define BT_CHANNEL_POLICY_AMP_PREFERRED		2
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
-- 
1.7.9

