Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/7] input: Fix crash on authorization reply with first sixaxis connection
Date: Wed,  8 Jan 2014 01:02:23 +0100
Message-Id: <1389139348-3552-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
References: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bogus unref in sixaxis_sdp_cb was resulting in NULL pointer dereference when
auth_callback was called.

src/adapter.c:connected_callback() hci0 device 00:06:F7:57:08:9E
    connected eir_len 5
src/device.c:device_set_class() /org/bluez/hci0/dev_00_06_F7_57_08_9E
    0x000508
profiles/input/server.c:connect_event_cb() Incoming connection from
    00:06:F7:57:08:9E on PSM 17
profiles/input/device.c:input_device_set_channel() idev (nil) psm 17
profiles/input/server.c:confirm_event_cb()
src/agent.c:agent_ref() 0x8117eb8: ref=2
src/agent.c:agent_authorize_service() authorize service request was
    sent for /org/bluez/hci0/dev_00_06_F7_57_08_9E
src/device.c:device_probe_profiles() Probing profiles for device
    00:06:F7:57:08:9E
profiles/input/device.c:input_device_register()
    /org/bluez/hci0/dev_00_06_F7_57_08_9E
src/service.c:btd_service_ref() 0x811f580: ref=2
src/service.c:change_state() 0x811f580: device 00:06:F7:57:08:9E
    profile input-hid state changed: unavailable -> disconnected (0)
src/device.c:device_svc_resolved()
    /org/bluez/hci0/dev_00_06_F7_57_08_9E err 0
profiles/input/server.c:sixaxis_sdp_cb() err 0 (Success)
profiles/input/device.c:input_device_set_channel() idev 0x8118568 psm
    17
profiles/input/server.c:connect_event_cb() Incoming connection from
    00:06:F7:57:08:9E on PSM 19
profiles/input/device.c:input_device_set_channel() idev 0x8118568 psm
    19
src/service.c:change_state() 0x811f580: device 00:06:F7:57:08:9E
    profile input-hid state changed: disconnected -> connected (0)
sixaxis: compatible device connected: PLAYSTATION(R)3 Controller
    (054C:0268)
plugins/sixaxis.c:setup_leds() number 2
sixaxis: failed to set LEDS (0 bytes written)
src/agent.c:agent_ref() 0x8117eb8: ref=3
Program received signal SIGSEGV, Segmentation fault.
---
 profiles/input/server.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index f6f85a0..f2e5836 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -68,15 +68,10 @@ struct sixaxis_data {
 	uint16_t psm;
 };
 
-static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data);
-
 static void sixaxis_sdp_cb(struct btd_device *dev, int err, void *user_data)
 {
 	struct sixaxis_data *data = user_data;
-	struct input_server *server;
-	GError *gerr = NULL;
 	const bdaddr_t *src;
-	GSList *l;
 
 	DBG("err %d (%s)", err, strerror(-err));
 
@@ -85,29 +80,10 @@ static void sixaxis_sdp_cb(struct btd_device *dev, int err, void *user_data)
 
 	src = btd_adapter_get_address(device_get_adapter(dev));
 
-	l = g_slist_find_custom(servers, src, server_cmp);
-	if (!l)
-		goto fail;
-
-	server = l->data;
-
-	err = input_device_set_channel(src, device_get_address(dev),
-							data->psm, data->chan);
-	if (err < 0)
+	if (input_device_set_channel(src, device_get_address(dev), data->psm,
+								data->chan) < 0)
 		goto fail;
 
-	if (server->confirm) {
-		if (!bt_io_accept(server->confirm, connect_event_cb, server,
-								NULL, &gerr)) {
-			error("bt_io_accept: %s", gerr->message);
-			g_error_free(gerr);
-			goto fail;
-		}
-
-		g_io_channel_unref(server->confirm);
-		server->confirm = NULL;
-	}
-
 	g_io_channel_unref(data->chan);
 	g_free(data);
 
-- 
1.8.5.2

