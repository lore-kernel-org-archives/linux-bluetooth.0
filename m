Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/1] Bluetooth:  Add socket option definitions for AMP
Date: Tue, 17 Aug 2010 16:07:06 -0700
Message-Id: <1282086426-8423-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a new BT_AMP socket option to control the use of AMP channels.
It is for use with the SOL_BLUETOOTH option level on L2CAP sockets.

Available option values are defined as:

BT_AMP_REQUIRE_BR_EDR
 * Default
 * AMP controllers cannot be used
 * Channel move requests from the remote device are denied
 * If the L2CAP channel is currently using AMP, move the channel to
   BR/EDR

BT_AMP_PREFER_AMP
 * Allow use of AMP controllers
 * If the L2CAP channel is currently on BR/EDR and AMP controller
   resources are available, initiate a channel move to AMP
 * Channel move requests from the remote device are allowed
 * If the L2CAP socket has not been connected yet, try to create
   and configure the channel directly on an AMP controller rather
   than BR/EDR

BT_AMP_PREFER_BR_EDR
 * Allow use of AMP controllers
 * If the L2CAP channel is currently on AMP, move it to BR/EDR
 * Channel move requests from the remote device are allowed

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/bluetooth.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 27a902d..0d41b99 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -64,6 +64,11 @@ struct bt_security {
 
 #define BT_DEFER_SETUP	7
 
+#define BT_AMP		8
+#define BT_AMP_REQUIRE_BR_EDR	0
+#define BT_AMP_PREFER_AMP	1
+#define BT_AMP_PREFER_BR_EDR	2
+
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR "%s: " fmt "\n" , __func__ , ## arg)
 #define BT_DBG(fmt, arg...)  pr_debug("%s: " fmt "\n" , __func__ , ## arg)
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
