Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/8] android/hidhost: Use adapter address provided on register
Date: Tue, 12 Nov 2013 23:48:16 +0000
Message-Id: <1384300100-8941-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
References: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to use bt_adapter_get_address every time local address
is needed.
---
 android/hidhost.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index cba80a6..cf670d6 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -47,7 +47,6 @@
 #include "hal-msg.h"
 #include "ipc.h"
 #include "hidhost.h"
-#include "adapter.h"
 #include "utils.h"
 
 #define L2CAP_PSM_HIDP_CTRL	0x11
@@ -77,6 +76,8 @@
 /* HID Virtual Cable Unplug */
 #define HID_VIRTUAL_CABLE_UNPLUG	0x05
 
+static const bdaddr_t *adapter_addr = NULL;
+
 static int notification_sk = -1;
 static GIOChannel *ctrl_io = NULL;
 static GIOChannel *intr_io = NULL;
@@ -563,7 +564,6 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 {
 	struct hid_device *dev = user_data;
 	GError *err = NULL;
-	const bdaddr_t *src = bt_adapter_get_address();
 
 	DBG("");
 
@@ -575,7 +575,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 
 	/* Connect to the HID interrupt channel */
 	dev->intr_io = bt_io_connect(interrupt_connect_cb, dev, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, src,
+					BT_IO_OPT_SOURCE_BDADDR, adapter_addr,
 					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
@@ -601,7 +601,6 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	struct hid_device *dev = data;
 	sdp_list_t *list;
 	GError *gerr = NULL;
-	const bdaddr_t *src = bt_adapter_get_address();
 
 	DBG("");
 
@@ -675,7 +674,7 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	}
 
 	dev->ctrl_io = bt_io_connect(control_connect_cb, dev, NULL, &gerr,
-					BT_IO_OPT_SOURCE_BDADDR, src,
+					BT_IO_OPT_SOURCE_BDADDR, adapter_addr,
 					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
@@ -700,7 +699,6 @@ static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
 	char addr[18];
 	bdaddr_t dst;
 	GSList *l;
-	const bdaddr_t *src = bt_adapter_get_address();
 	uuid_t uuid;
 
 	DBG("");
@@ -722,8 +720,8 @@ static uint8_t bt_hid_connect(struct hal_cmd_hidhost_connect *cmd,
 	DBG("connecting to %s", addr);
 
 	bt_string2uuid(&uuid, HID_UUID);
-	if (bt_search_service(src, &dev->dst, &uuid, hid_sdp_search_cb, dev,
-								NULL) < 0) {
+	if (bt_search_service(adapter_addr, &dev->dst, &uuid,
+					hid_sdp_search_cb, dev, NULL) < 0) {
 		error("Failed to search sdp details");
 		hid_device_free(dev);
 		return HAL_STATUS_FAILED;
@@ -1161,12 +1159,13 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 bool bt_hid_register(int sk, const bdaddr_t *addr)
 {
 	GError *err = NULL;
-	const bdaddr_t *src = bt_adapter_get_address();
 
 	DBG("");
 
+	adapter_addr = addr;
+
 	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_SOURCE_BDADDR, adapter_addr,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
@@ -1177,7 +1176,7 @@ bool bt_hid_register(int sk, const bdaddr_t *addr)
 	}
 
 	intr_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_SOURCE_BDADDR, adapter_addr,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
-- 
1.8.4.3

