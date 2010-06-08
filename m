Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH] audio: fix leak on gateway
Date: Tue,  8 Jun 2010 04:14:39 -0300
Message-Id: <1275981279-18175-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 1dd3f5b..07ebdd4 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -561,6 +561,19 @@ static GDBusSignalTable gateway_signals[] = {
 	{ NULL, NULL }
 };
 
+static void path_unregister(void *data)
+{
+	struct audio_device *dev = data;
+
+	DBG("Unregistered interface %s on path %s",
+		AUDIO_GATEWAY_INTERFACE, dev->path);
+
+	gateway_close(dev);
+
+	g_free(dev->gateway);
+	dev->gateway = NULL;
+}
+
 void gateway_unregister(struct audio_device *dev)
 {
 	if (dev->gateway->agent)
@@ -578,7 +591,7 @@ struct gateway *gateway_init(struct audio_device *dev)
 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_GATEWAY_INTERFACE,
 					gateway_methods, gateway_signals,
-					NULL, dev, NULL))
+					NULL, dev, path_unregister))
 		return NULL;
 
 	return g_new0(struct gateway, 1);
-- 
1.7.1

