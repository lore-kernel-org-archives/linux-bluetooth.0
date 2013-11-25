Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 13/13] input: Add support for handling sixaxis devices
Date: Mon, 25 Nov 2013 22:15:52 +0000
Message-Id: <1385417752-25664-14-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
References: <1385417752-25664-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to handle incoming connection from unknown devices.
If device happens to be sixaxis input device is created after
SDP was queried and then connection is authorized.
---
 profiles/input/server.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index 21d4562..8a50d23 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -63,6 +63,100 @@ static int server_cmp(gconstpointer s, gconstpointer user_data)
 	return bacmp(&server->src, src);
 }
 
+struct sixaxis_data {
+	GIOChannel *chan;
+	uint16_t psm;
+};
+
+static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data);
+
+static void sixaxis_sdp_cb(struct btd_device *dev, int err, void *user_data)
+{
+	struct sixaxis_data *data = user_data;
+	struct input_server *server;
+	GError *gerr = NULL;
+	const bdaddr_t *src;
+	GSList *l;
+
+	DBG("err %d (%s)", err, strerror(-err));
+
+	if (err < 0)
+		goto fail;
+
+	src = btd_adapter_get_address(device_get_adapter(dev));
+
+	l = g_slist_find_custom(servers, src, server_cmp);
+	if (!l)
+		goto fail;
+
+	server = l->data;
+
+	err = input_device_set_channel(src, device_get_address(dev),
+							data->psm, data->chan);
+	if (err < 0)
+		goto fail;
+
+	if (server->confirm) {
+		if (!bt_io_accept(server->confirm, connect_event_cb, server,
+								NULL, &gerr)) {
+			error("bt_io_accept: %s", gerr->message);
+			g_error_free(gerr);
+			goto fail;
+		}
+
+		g_io_channel_unref(server->confirm);
+		server->confirm = NULL;
+	}
+
+	g_io_channel_unref(data->chan);
+	g_free(data);
+
+	return;
+
+fail:
+	g_io_channel_shutdown(data->chan, TRUE, NULL);
+	g_io_channel_unref(data->chan);
+	g_free(data);
+}
+
+static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
+						GIOChannel *chan, uint16_t psm)
+{
+	struct btd_device *device;
+	struct sixaxis_data *data;
+
+	if (psm != L2CAP_PSM_HIDP_CTRL)
+		return;
+
+	device = btd_adapter_find_device(adapter_find(src), dst);
+	if (!device)
+		return;
+
+	data = g_new0(struct sixaxis_data, 1);
+	data->chan = g_io_channel_ref(chan);
+	data->psm = psm;
+
+	device_discover_services(device);
+	device_wait_for_svc_complete(device, sixaxis_sdp_cb, data);
+}
+
+static bool check_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
+{
+	struct btd_device *device;
+
+	device = btd_adapter_find_device(adapter_find(src), dst);
+	if (!device)
+		return false;
+
+	if (btd_device_get_vendor(device) != 0x054c)
+		return false;
+
+	if (btd_device_get_product(device) != 0x0268)
+		return false;
+
+	return true;
+}
+
 static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	uint16_t psm;
@@ -95,6 +189,11 @@ static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 	if (ret == 0)
 		return;
 
+	if (ret == -ENOENT && check_sixaxis(&src, &dst)) {
+		sixaxis_browse_sdp(&src, &dst, chan, psm);
+		return;
+	}
+
 	error("Refusing input device connect: %s (%d)", strerror(-ret), -ret);
 
 	/* Send unplug virtual cable to unknown devices */
@@ -129,6 +228,9 @@ static void auth_callback(DBusError *derr, void *user_data)
 		goto reject;
 	}
 
+	if (!input_device_exists(&src, &dst) && check_sixaxis(&src, &dst))
+		return;
+
 	if (!bt_io_accept(server->confirm, connect_event_cb, server,
 				NULL, &err)) {
 		error("bt_io_accept: %s", err->message);
@@ -175,7 +277,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	if (!input_device_exists(&src, &dst)) {
+	if (!input_device_exists(&src, &dst) && !check_sixaxis(&src, &dst)) {
 		error("Refusing connection from %s: unknown device", addr);
 		goto drop;
 	}
-- 
1.8.4.4

