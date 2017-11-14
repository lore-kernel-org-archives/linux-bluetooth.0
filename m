Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH] Bluetooth: Define l2cap sock option for LE PHYs
Date: Tue, 14 Nov 2017 16:02:15 +0530
Message-Id: <1510655538-12883-2-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This defines two socket options, BT_LE_PHY and BT_LE_SUPPORTED_PHYS.

BT_LE_SUPPORTED_PHYS cab ne used to get supported phys of the peer devices.

BT_LE_PHY can be used to get the current phy of the connection and also
to switch phy for the connection.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/bluetooth.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e89cff0..f9271d1 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,6 +122,16 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
 
+/* This can be used for both set/get the current phy */
+#define BT_LE_PHY	14
+
+#define BT_LE_PHY_1M 		0
+#define BT_LE_PHY_2M		1
+#define BT_LE_PHY_CODED		2
+
+/* This can be used only for get peer supported phys */
+#define BT_LE_SUPPORTED_PHYS 15
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
-- 
2.7.4

