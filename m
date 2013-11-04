Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/hid: Use BT_IO_OPT_SOURCE_BDADDR whenever possible
Date: Mon,  4 Nov 2013 11:34:57 +0200
Message-Id: <1383557698-4475-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hid.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index e660552..59fc90b 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -661,12 +661,11 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct hid_device *dev;
-	bdaddr_t dst;
+	bdaddr_t src, dst;
 	char address[18];
 	uint16_t psm;
 	GError *gerr = NULL;
 	GSList *l;
-	const bdaddr_t *src = bt_adapter_get_address();
 	uuid_t uuid;
 
 	if (err) {
@@ -675,6 +674,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 
 	bt_io_get(chan, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
 			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_PSM, &psm,
 			BT_IO_OPT_INVALID);
@@ -699,7 +699,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		dev->uhid_fd = -1;
 
 		bt_string2uuid(&uuid, HID_UUID);
-		if (bt_search_service(src, &dev->dst, &uuid,
+		if (bt_search_service(&src, &dev->dst, &uuid,
 					hid_sdp_search_cb, dev, NULL) < 0) {
 			error("failed to search sdp details");
 			hid_device_free(dev);
@@ -732,12 +732,14 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 {
 	GError *err = NULL;
+	const bdaddr_t *src = bt_adapter_get_address();
 
 	DBG("");
 
 	notification_io = g_io_channel_ref(io);
 
 	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
@@ -748,6 +750,7 @@ bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 	}
 
 	intr_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
 				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
-- 
1.8.3.1

