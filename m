Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: Add bt_dev logging macros
Date: Sun, 30 Aug 2015 18:16:55 +0200
Message-Id: <1440951415-4076-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add specific bluetooth device logging macros since hci device name is
repeatedly referred in bluetooth subsystem logs.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 include/net/bluetooth/bluetooth.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 38d8a34..fcf2ae7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -128,6 +128,13 @@ void bt_err(const char *fmt, ...);
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
+#define bt_dev_info(hdev, fmt, ...)				\
+	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+#define bt_dev_err(hdev, fmt, ...)				\
+	BT_ERR("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+#define bt_dev_dbg(hdev, fmt, ...)				\
+	BT_DBG("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
-- 
1.9.1
