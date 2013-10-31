Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] android/hid: Add handling of incoming connections
Date: Thu, 31 Oct 2013 14:19:46 +0200
Message-Id: <1383221988-1601-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hid.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/android/hid.c b/android/hid.c
index 49e9c52..92efd72 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -45,6 +45,8 @@
 #define MAX_READ_BUFFER		4096
 
 static GIOChannel *notification_io = NULL;
+static GIOChannel *ctrl_io = NULL;
+static GIOChannel *intr_io = NULL;
 static GSList *devices = NULL;
 
 struct hid_device {
@@ -313,12 +315,94 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 	ipc_send_rsp(io, HAL_SERVICE_ID_HIDHOST, status);
 }
 
+static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct hid_device *hdev;
+	bdaddr_t dst;
+	char address[18];
+	uint16_t psm;
+	GError *gerr = NULL;
+	GSList *l;
+
+	if (err) {
+		error("%s", err->message);
+		return;
+	}
+
+	bt_io_get(chan, &err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_PSM, &psm,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", gerr->message);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	ba2str(&dst, address);
+	DBG("Incoming connection from %s on PSM %d", address, psm);
+
+	switch (psm) {
+	case L2CAP_PSM_HIDP_CTRL:
+		l = g_slist_find_custom(devices, &dst, device_cmp);
+		if (l)
+			return;
+
+		hdev = g_new0(struct hid_device, 1);
+		bacpy(&hdev->dst, &dst);
+		hdev->ctrl_io = g_io_channel_ref(chan);
+
+		devices = g_slist_append(devices, hdev);
+
+		hdev->ctrl_watch = g_io_add_watch(hdev->ctrl_io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					ctrl_watch_cb, hdev);
+
+		break;
+
+	case L2CAP_PSM_HIDP_INTR:
+		l = g_slist_find_custom(devices, &dst, device_cmp);
+		if (!l)
+			return;
+
+		hdev = l->data;
+		hdev->intr_io = g_io_channel_ref(chan);
+		hdev->intr_watch = g_io_add_watch(hdev->intr_io,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				intr_watch_cb, hdev);
+		break;
+	}
+}
+
 bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
 {
+	GError *err = NULL;
+
 	DBG("");
 
 	notification_io = g_io_channel_ref(io);
 
+	ctrl_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
+				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	if (!ctrl_io) {
+		error("Failed to listen on control channel");
+		g_error_free(err);
+		return false;
+	}
+
+	intr_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
+				BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	if (!intr_io) {
+		error("Failed to listen on interrupt channel");
+		g_io_channel_unref(ctrl_io);
+		g_error_free(err);
+		return false;
+	}
+
 	return true;
 }
 
@@ -328,4 +412,10 @@ void bt_hid_unregister(void)
 
 	g_io_channel_unref(notification_io);
 	notification_io = NULL;
+
+	g_io_channel_unref(ctrl_io);
+	ctrl_io = NULL;
+
+	g_io_channel_unref(intr_io);
+	intr_io = NULL;
 }
-- 
1.8.3.1

