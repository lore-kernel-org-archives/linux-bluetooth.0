Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>, Alex Gal <a.gal@miip.ca>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC v2 3/3] profiles/input: Remove sixaxis specific code
Date: Wed,  8 Apr 2015 22:51:31 +0200
Message-Id: <1428526291-11217-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1428526291-11217-1-git-send-email-szymon.janc@gmail.com>
References: <1428526291-11217-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sixaxis devices now have provides SDP record while being created.
There is no need to punch sixaxis holes in input code anymore.
---
 profiles/input/server.c | 89 ++-----------------------------------------------
 1 file changed, 2 insertions(+), 87 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index eb3fcf8..43733ea 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -67,85 +67,6 @@ static int server_cmp(gconstpointer s, gconstpointer user_data)
 	return bacmp(&server->src, src);
 }
 
-struct sixaxis_data {
-	GIOChannel *chan;
-	uint16_t psm;
-};
-
-static void sixaxis_sdp_cb(struct btd_device *dev, int err, void *user_data)
-{
-	struct sixaxis_data *data = user_data;
-	const bdaddr_t *src;
-
-	DBG("err %d (%s)", err, strerror(-err));
-
-	if (err < 0)
-		goto fail;
-
-	src = btd_adapter_get_address(device_get_adapter(dev));
-
-	if (input_device_set_channel(src, device_get_address(dev), data->psm,
-								data->chan) < 0)
-		goto fail;
-
-	g_io_channel_unref(data->chan);
-	g_free(data);
-
-	return;
-
-fail:
-	g_io_channel_shutdown(data->chan, TRUE, NULL);
-	g_io_channel_unref(data->chan);
-	g_free(data);
-}
-
-static void sixaxis_browse_sdp(const bdaddr_t *src, const bdaddr_t *dst,
-						GIOChannel *chan, uint16_t psm)
-{
-	struct btd_device *device;
-	struct sixaxis_data *data;
-
-	device = btd_adapter_find_device(adapter_find(src), dst, BDADDR_BREDR);
-	if (!device)
-		return;
-
-	data = g_new0(struct sixaxis_data, 1);
-	data->chan = g_io_channel_ref(chan);
-	data->psm = psm;
-
-	if (psm == L2CAP_PSM_HIDP_CTRL)
-		device_discover_services(device);
-
-	device_wait_for_svc_complete(device, sixaxis_sdp_cb, data);
-}
-
-static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
-{
-	struct btd_device *device;
-	uint16_t vid, pid;
-
-	device = btd_adapter_find_device(adapter_find(src), dst, BDADDR_BREDR);
-	if (!device)
-		return false;
-
-	vid = btd_device_get_vendor(device);
-	pid = btd_device_get_product(device);
-
-	/* DualShock 3 */
-	if (vid == 0x054c && pid == 0x0268)
-		return true;
-
-	/* DualShock 4 */
-	if (vid == 0x054c && pid == 0x05c4)
-		return true;
-
-	/* Navigation Controller */
-	if (vid == 0x054c && pid == 0x042f)
-		return true;
-
-	return false;
-}
-
 static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	uint16_t psm;
@@ -178,11 +99,6 @@ static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 	if (ret == 0)
 		return;
 
-	if (ret == -ENOENT && dev_is_sixaxis(&src, &dst)) {
-		sixaxis_browse_sdp(&src, &dst, chan, psm);
-		return;
-	}
-
 	error("Refusing input device connect: %s (%d)", strerror(-ret), -ret);
 
 	/* Send unplug virtual cable to unknown devices */
@@ -207,8 +123,7 @@ static void auth_callback(DBusError *derr, void *user_data)
 		goto reject;
 	}
 
-	if (!input_device_exists(&server->src, &confirm->dst) &&
-				!dev_is_sixaxis(&server->src, &confirm->dst))
+	if (!input_device_exists(&server->src, &confirm->dst))
 		return;
 
 	if (!bt_io_accept(confirm->io, connect_event_cb, server, NULL, &err)) {
@@ -259,7 +174,7 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 		goto drop;
 	}
 
-	if (!input_device_exists(&src, &dst) && !dev_is_sixaxis(&src, &dst)) {
+	if (!input_device_exists(&src, &dst)) {
 		error("Refusing connection from %s: unknown device", addr);
 		goto drop;
 	}
-- 
2.1.4

