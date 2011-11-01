Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv3 1/9] Bluetooth: Add BT_CHANNEL_POLICY socket option
Date: Tue,  1 Nov 2011 15:29:20 -0700
Message-Id: <1320186568-25493-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1320186568-25493-1-git-send-email-mathewm@codeaurora.org>
References: <1320186568-25493-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow control of AMP functionality on L2CAP sockets. By default,
connections will be restricted to BR/EDR.  Manipulating the
BT_CHANNEL_POLICY option allows for channels to be moved to or created
on AMP controllers.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fb1acb3..38cd3da 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -77,6 +77,33 @@ struct bt_power {
 #define BT_POWER_FORCE_ACTIVE_OFF 0
 #define BT_POWER_FORCE_ACTIVE_ON  1
 
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
 __attribute__((format (printf, 2, 3)))
 int bt_printk(const char *level, const char *fmt, ...);
 
-- 
1.7.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

