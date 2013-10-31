Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/hid: Fetch record before attempting to connect
Date: Thu, 31 Oct 2013 17:57:05 +0200
Message-Id: <1383235026-12247-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>

This patch fetch HID record and store the information needed by uHID.
---
 android/Android.mk  |   4 +-
 android/Makefile.am |   4 +-
 android/hid.c       | 134 +++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 72ea8b8..d2afa09 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -35,7 +35,9 @@ LOCAL_SRC_FILES := \
 	../lib/sdp.c \
 	../lib/bluetooth.c \
 	../lib/hci.c \
-	../btio/btio.c
+	../btio/btio.c \
+	../src/sdp-client.c \
+	../src/glib-helper.c
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
diff --git a/android/Makefile.am b/android/Makefile.am
index c5b70ab..ac92510 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -13,7 +13,9 @@ android_bluetoothd_SOURCES =	android/main.c \
 				android/hid.h android/hid.c \
 				android/ipc.h android/ipc.c \
 				android/socket.h android/socket.c \
-				btio/btio.h btio/btio.c
+				btio/btio.h btio/btio.c \
+				src/sdp-client.h src/sdp-client.c \
+				src/glib-helper.h src/glib-helper.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/hid.c b/android/hid.c
index 5caa25b..6b3b1f7 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -31,7 +31,12 @@
 
 #include "btio/btio.h"
 #include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "lib/uuid.h"
 #include "src/shared/mgmt.h"
+#include "src/sdp-client.h"
+#include "src/glib-helper.h"
 
 #include "log.h"
 #include "hal-msg.h"
@@ -52,6 +57,12 @@ static GSList *devices = NULL;
 struct hid_device {
 	bdaddr_t	dst;
 	uint8_t		state;
+	uint16_t	vendor;
+	uint16_t	product;
+	uint16_t	version;
+	uint8_t		country;
+	int		rd_size;
+	void		*rd_data;
 	GIOChannel	*ctrl_io;
 	GIOChannel	*intr_io;
 	guint		ctrl_watch;
@@ -80,6 +91,8 @@ static void hid_device_free(struct hid_device *hdev)
 	if (hdev->ctrl_io)
 		g_io_channel_unref(hdev->ctrl_io);
 
+	g_free(hdev->rd_data);
+
 	devices = g_slist_remove(devices, hdev);
 	g_free(hdev);
 }
@@ -98,10 +111,6 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 
 	DBG("bytes read %d", bread);
 
-	/* TODO: At this moment only baseband is connected, i.e. mouse
-	 * movements keyboard events doesn't effect on UI. Have to send
-	 * this data to uhid fd for profile connection. */
-
 	return TRUE;
 }
 
@@ -186,8 +195,6 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	if (conn_err)
 		goto failed;
 
-	/*TODO: Get device details through SDP and create UHID fd and start
-	 * listening on uhid events */
 	hdev->intr_watch = g_io_add_watch(hdev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, hdev);
@@ -250,14 +257,100 @@ failed:
 	hid_device_free(hdev);
 }
 
+static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
+{
+	struct hid_device *hdev = data;
+	sdp_list_t *list;
+	GError *gerr = NULL;
+	const bdaddr_t *src = bt_adapter_get_address();
+
+	DBG("");
+
+	if (err < 0) {
+		error("Unable to get SDP record: %s", strerror(-err));
+		goto fail;
+	}
+
+	if (!recs || !recs->data) {
+		error("No SDP records found");
+		goto fail;
+	}
+
+	for (list = recs; list != NULL; list = list->next) {
+		sdp_record_t *rec = list->data;
+		sdp_data_t *data;
+
+		data = sdp_data_get(rec, SDP_ATTR_VENDOR_ID);
+		if (data)
+			hdev->vendor = data->val.uint16;
+
+		data = sdp_data_get(rec, SDP_ATTR_PRODUCT_ID);
+		if (data)
+			hdev->product = data->val.uint16;
+
+		data = sdp_data_get(rec, SDP_ATTR_VERSION);
+		if (data)
+			hdev->version = data->val.uint16;
+
+		data = sdp_data_get(rec, SDP_ATTR_HID_COUNTRY_CODE);
+		if (data)
+			hdev->country = data->val.uint8;
+
+		data = sdp_data_get(rec, SDP_ATTR_HID_DESCRIPTOR_LIST);
+		if (data) {
+			if (!SDP_IS_SEQ(data->dtd))
+				goto fail;
+
+			/* First HIDDescriptor */
+			data = data->val.dataseq;
+			if (!SDP_IS_SEQ(data->dtd))
+				goto fail;
+
+			/* ClassDescriptorType */
+			data = data->val.dataseq;
+			if (data->dtd != SDP_UINT8)
+				goto fail;
+
+			/* ClassDescriptorData */
+			data = data->next;
+			if (!data || !SDP_IS_TEXT_STR(data->dtd))
+				goto fail;
+
+			hdev->rd_size = data->unitSize;
+			hdev->rd_data = g_memdup(data->val.str, data->unitSize);
+		}
+	}
+
+	if (hdev->ctrl_io)
+		return;
+
+	hdev->ctrl_io = bt_io_connect(control_connect_cb, hdev, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, src,
+					BT_IO_OPT_DEST_BDADDR, &hdev->dst,
+					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
+
+	return;
+
+fail:
+	bt_hid_set_state(hdev, HAL_HID_STATE_DISCONNECTED);
+	hid_device_free(hdev);
+}
+
 static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 {
 	struct hid_device *hdev;
 	char addr[18];
 	bdaddr_t dst;
 	GSList *l;
-	GError *err = NULL;
 	const bdaddr_t *src = bt_adapter_get_address();
+	uuid_t uuid;
 
 	DBG("");
 
@@ -271,20 +364,15 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 		return HAL_STATUS_FAILED;
 
 	hdev = g_new0(struct hid_device, 1);
-	android2bdaddr(&cmd->bdaddr, &hdev->dst);
-	ba2str(&hdev->dst, addr);
+	bacpy(&hdev->dst, &dst);
 
+	ba2str(&hdev->dst, addr);
 	DBG("connecting to %s", addr);
 
-	hdev->ctrl_io = bt_io_connect(control_connect_cb, hdev, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR, src,
-					BT_IO_OPT_DEST_BDADDR, &hdev->dst,
-					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-					BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
+	bt_string2uuid(&uuid, HID_UUID);
+	if (bt_search_service(src, &hdev->dst, &uuid, hid_sdp_search_cb, hdev,
+								NULL) < 0) {
+		error("Failed to search sdp details");
 		hid_device_free(hdev);
 		return HAL_STATUS_FAILED;
 	}
@@ -354,6 +442,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	uint16_t psm;
 	GError *gerr = NULL;
 	GSList *l;
+	const bdaddr_t *src = bt_adapter_get_address();
+	uuid_t uuid;
 
 	if (err) {
 		error("%s", err->message);
@@ -383,6 +473,14 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		bacpy(&hdev->dst, &dst);
 		hdev->ctrl_io = g_io_channel_ref(chan);
 
+		bt_string2uuid(&uuid, HID_UUID);
+		if (bt_search_service(src, &hdev->dst, &uuid,
+					hid_sdp_search_cb, hdev, NULL) < 0) {
+			error("failed to search sdp details");
+			hid_device_free(hdev);
+			return;
+		}
+
 		devices = g_slist_append(devices, hdev);
 
 		hdev->ctrl_watch = g_io_add_watch(hdev->ctrl_io,
-- 
1.8.3.1

