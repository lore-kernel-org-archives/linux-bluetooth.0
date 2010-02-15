Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] audio/gateway.c: Don't reply to DBus when connection comes from AG
Date: Mon, 15 Feb 2010 17:34:21 -0200
Message-Id: <1266262461-17717-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 46fbb63..22e5da2 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -224,7 +224,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 	struct audio_device *dev = user_data;
 	struct gateway *gw = dev->gateway;
 	DBusMessage *reply;
-	int sk;
+	int sk, ret;
 
 	if (err) {
 		error("connect(): %s", err->message);
@@ -242,11 +242,16 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
 
 	gw->rfcomm = g_io_channel_ref(chan);
 
-	if (!agent_sendfd(gw->agent, sk, newconnection_reply, dev))
+	ret = agent_sendfd(gw->agent, sk, newconnection_reply, dev);
+
+	if (!gw->msg)
+		return;
+
+	if (ret)
+		reply = dbus_message_new_method_return(gw->msg);
+	else
 		reply = g_dbus_create_error(gw->msg, ERROR_INTERFACE ".Failed",
 					"Can not pass file descriptor");
-	else
-		reply = dbus_message_new_method_return(gw->msg);
 
 	g_dbus_send_message(dev->conn, reply);
 
@@ -258,7 +263,6 @@ fail:
 						ERROR_INTERFACE ".Failed",
 						"Connection attempt failed");
 
-
 	change_state(dev, GATEWAY_STATE_DISCONNECTED);
 }
 
-- 
1.6.4.4

