Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] fix the bug introduced by commit "re-use the sco_server initiated by audio plugin"
Date: Fri, 19 Jun 2009 13:30:22 +0800
Message-Id: <1245389422-22318-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    3 ---
 audio/main.c    |    4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index a170bec..607a4a0 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -1079,9 +1079,6 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *io)
 {
 	struct gateway *gw = dev->gateway;
 
-	if (gw->sco)
-		return -EISCONN;
-
 	gw->sco = g_io_channel_ref(io);
 
 	return 0;
diff --git a/audio/main.c b/audio/main.c
index 4e5eda2..cf16fd4 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -93,6 +93,10 @@ static void sco_server_cb(GIOChannel *chan, GError *err, gpointer data)
 	device = manager_find_device(NULL, &src, &dst, AUDIO_HEADSET_INTERFACE,
 					FALSE);
 	if (!device)
+		device = manager_find_device(NULL, &src, &dst,
+						AUDIO_GATEWAY_INTERFACE, FALSE);
+
+	if (!device)
 		goto drop;
 
 	if (device->headset) {
-- 
1.5.4.5

