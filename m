Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/2] Add watch for RFCOMM disconnect to HFP HF role
Date: Thu,  4 Aug 2011 15:31:13 +0200
Message-Id: <1312464674-18828-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 345f397..77aec59 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -192,9 +192,26 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 				(GIOFunc) sco_io_cb, dev);
 }
 
+static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+			struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	g_io_channel_shutdown(gw->rfcomm, TRUE, NULL);
+	g_io_channel_unref(gw->rfcomm);
+	gw->rfcomm = NULL;
+	change_state(dev, GATEWAY_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
 static void newconnection_reply(DBusPendingCall *call, void *data)
 {
 	struct audio_device *dev = data;
+	struct gateway *gw = dev->gateway;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	DBusError derr;
 
@@ -206,6 +223,8 @@ static void newconnection_reply(DBusPendingCall *call, void *data)
 	dbus_error_init(&derr);
 	if (!dbus_set_error_from_message(&derr, reply)) {
 		DBG("Agent reply: file descriptor passed successfully");
+		g_io_add_watch(gw->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) rfcomm_disconnect_cb, dev);
 		change_state(dev, GATEWAY_STATE_CONNECTED);
 		goto done;
 	}
-- 
1.7.1

