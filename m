Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 2/2] audio: Fix crash on gateway close while connected
Date: Mon,  1 Oct 2012 17:24:06 +0200
Message-Id: <1349105046-20035-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1349105046-20035-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1349105046-20035-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

RFCOMM and SCO watches need to be removed in gateway_close(), otherwise
the watch callbacks might get called later on, resulting in a second
call to gateway_close().

The issue can be easily reproduced if a device is removed (unpaired) a
device while HFP gateway is connected:

bluetoothd[26579]: audio/gateway.c:path_unregister() Unregistered interface org.bluez.HandsfreeGateway on path /org/bluez/26579/hci0/dev_90_84_0D_B2_C7_04
bluetoothd[26579]: audio/media.c:gateway_state_changed()
bluetoothd[26579]: audio/media.c:gateway_state_changed() Clear endpoint 0x555555822cb0
bluetoothd[26579]: audio/source.c:path_unregister() Unregistered interface org.bluez.AudioSource on path /org/bluez/26579/hci0/dev_90_84_0D_B2_C7_04
bluetoothd[26579]: audio/avdtp.c:avdtp_unref() 0x555555827980: ref=2
bluetoothd[26579]: src/device.c:btd_device_unref() 0x55555581a470: ref=1
bluetoothd[26579]: src/device.c:btd_device_unref() 0x55555581a470: ref=0
bluetoothd[26579]: src/device.c:device_free() 0x55555581a470

Program received signal SIGSEGV, Segmentation fault.
gateway_close (device=0x555555820390) at audio/gateway.c:585
585		if (gw->rfcomm) {
---
 audio/gateway.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 9e96296..a9a576e 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -68,6 +68,8 @@ struct gateway {
 	GIOChannel *rfcomm;
 	GIOChannel *sco;
 	GIOChannel *incoming;
+	guint rfcomm_id;
+	guint sco_id;
 	GSList *callbacks;
 	struct hf_agent *agent;
 	DBusMessage *msg;
@@ -251,6 +253,10 @@ static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
 		return FALSE;
 
 	DBG("sco connection is released");
+
+	g_source_remove(gw->sco_id);
+	gw->sco_id = 0;
+
 	g_io_channel_shutdown(gw->sco, TRUE, NULL);
 	g_io_channel_unref(gw->sco);
 	gw->sco = NULL;
@@ -268,15 +274,15 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	gw->sco = g_io_channel_ref(chan);
 
+	gw->sco_id = g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) sco_io_cb, dev);
+
 	if (err) {
 		error("sco_connect_cb(): %s", err->message);
 		gateway_suspend_stream(dev);
 		return;
 	}
 
-	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) sco_io_cb, dev);
-
 	change_state(dev, GATEWAY_STATE_PLAYING);
 	run_connect_cb(dev, NULL);
 }
@@ -306,8 +312,10 @@ static void newconnection_reply(DBusPendingCall *call, void *data)
 	dbus_error_init(&derr);
 	if (!dbus_set_error_from_message(&derr, reply)) {
 		DBG("Agent reply: file descriptor passed successfully");
-		g_io_add_watch(gw->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-					(GIOFunc) rfcomm_disconnect_cb, dev);
+		gw->rfcomm_id = g_io_add_watch(gw->rfcomm,
+						G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) rfcomm_disconnect_cb,
+						dev);
 		change_state(dev, GATEWAY_STATE_CONNECTED);
 		goto done;
 	}
@@ -582,6 +590,16 @@ int gateway_close(struct audio_device *device)
 	struct gateway *gw = device->gateway;
 	int sock;
 
+	if (gw->rfcomm_id != 0) {
+		g_source_remove(gw->rfcomm_id);
+		gw->rfcomm_id = 0;
+	}
+
+	if (gw->sco_id != 0) {
+		g_source_remove(gw->sco_id);
+		gw->sco_id = 0;
+	}
+
 	if (gw->rfcomm) {
 		sock = g_io_channel_unix_get_fd(gw->rfcomm);
 		shutdown(sock, SHUT_RDWR);
@@ -832,7 +850,7 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 
 	gw->sco = g_io_channel_ref(io);
 
-	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+	gw->sco_id = g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 						(GIOFunc) sco_io_cb, dev);
 
 	change_state(dev, GATEWAY_STATE_PLAYING);
@@ -934,6 +952,9 @@ void gateway_suspend_stream(struct audio_device *dev)
 	if (!gw || !gw->sco)
 		return;
 
+	g_source_remove(gw->sco_id);
+	gw->sco_id = 0;
+
 	g_io_channel_shutdown(gw->sco, TRUE, NULL);
 	g_io_channel_unref(gw->sco);
 	gw->sco = NULL;
-- 
1.7.11.4

