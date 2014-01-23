Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] android/AVRCP: Add initial socket handling
Date: Thu, 23 Jan 2014 18:39:58 +0200
Message-Id: <1390495198-28400-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390495198-28400-1-git-send-email-luiz.dentz@gmail.com>
References: <1390495198-28400-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial socket listening and handling incoming connections.
---
 android/avrcp.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index 02dbb68..a230ab8 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -28,6 +28,7 @@
 #include <stdbool.h>
 #include <glib.h>
 
+#include "btio/btio.h"
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
@@ -36,6 +37,7 @@
 #include "avrcp.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "avctp.h"
 
 #define L2CAP_PSM_AVCTP 0x17
 
@@ -46,6 +48,13 @@
 
 static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
+static GSList *devices = NULL;
+static GIOChannel *server = NULL;
+
+struct avrcp_device {
+	bdaddr_t	dst;
+	struct avctp	*session;
+};
 
 static const struct ipc_handler cmd_handlers[] = {
 };
@@ -118,14 +127,124 @@ static sdp_record_t *avrcp_record(void)
 	return record;
 }
 
+static void avrcp_device_free(void *data)
+{
+	struct avrcp_device *dev = data;
+
+	if (dev->session)
+		avctp_shutdown(dev->session);
+
+	devices = g_slist_remove(devices, dev);
+	g_free(dev);
+}
+
+static struct avrcp_device *avrcp_device_new(const bdaddr_t *dst)
+{
+	struct avrcp_device *dev;
+
+	dev = g_new0(struct avrcp_device, 1);
+	bacpy(&dev->dst, dst);
+	devices = g_slist_prepend(devices, dev);
+
+	return dev;
+}
+
+static int device_cmp(gconstpointer s, gconstpointer user_data)
+{
+	const struct avrcp_device *dev = s;
+	const bdaddr_t *dst = user_data;
+
+	return bacmp(&dev->dst, dst);
+}
+
+static void disconnect_cb(void *data)
+{
+	struct avrcp_device *dev = data;
+
+	DBG("");
+
+	dev->session = NULL;
+
+	avrcp_device_free(dev);
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct avrcp_device *dev;
+	bdaddr_t src, dst;
+	char address[18];
+	uint16_t imtu, omtu;
+	GError *gerr = NULL;
+	GSList *l;
+	int fd;
+
+	if (err) {
+		error("%s", err->message);
+		return;
+	}
+
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	ba2str(&dst, address);
+	DBG("Incoming connection from %s", address);
+
+	l = g_slist_find_custom(devices, &dst, device_cmp);
+	if (l) {
+		error("Unexpected connection");
+		return;
+	}
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	dev = avrcp_device_new(&dst);
+	dev->session = avctp_new(fd, imtu, omtu, 0x0100);
+
+	if (!dev->session) {
+		avrcp_device_free(dev);
+		return;
+	}
+
+	avctp_set_destroy_cb(dev->session, disconnect_cb, dev);
+
+	/* FIXME: get the real name of the device */
+	avctp_init_uinput(dev->session, "bluetooth", address);
+
+	g_io_channel_set_close_on_unref(chan, FALSE);
+
+	DBG("%s connected", address);
+}
+
 bool bt_avrcp_register(const bdaddr_t *addr)
 {
+	GError *err = NULL;
 	sdp_record_t *rec;
 
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
+	server = bt_io_listen(connect_cb, NULL, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_PSM, L2CAP_PSM_AVCTP,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID);
+	if (!server) {
+		error("Failed to listen on AVDTP channel: %s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
 	rec = avrcp_record();
 	if (!rec) {
 		error("Failed to allocate AVRCP record");
@@ -149,8 +268,17 @@ void bt_avrcp_unregister(void)
 {
 	DBG("");
 
+	g_slist_free_full(devices, avrcp_device_free);
+	devices = NULL;
+
 	ipc_unregister(HAL_SERVICE_ID_AVRCP);
 
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
+
+	if (server) {
+		g_io_channel_shutdown(server, TRUE, NULL);
+		g_io_channel_unref(server);
+		server = NULL;
+	}
 }
-- 
1.8.4.2

