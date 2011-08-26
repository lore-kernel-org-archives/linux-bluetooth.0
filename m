Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 1/8] Fix disconnect SCO at same time than RFCOMM
Date: Fri, 26 Aug 2011 17:39:31 +0200
Message-Id: <1314373178-11337-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314373178-11337-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If RFCOMM disconnects, SCO should be disconnected too.
---
 audio/gateway.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 142b12e..59c91dd 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -222,15 +222,10 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 static gboolean rfcomm_disconnect_cb(GIOChannel *chan, GIOCondition cond,
 			struct audio_device *dev)
 {
-	struct gateway *gw = dev->gateway;
-
 	if (cond & G_IO_NVAL)
 		return FALSE;
 
-	g_io_channel_shutdown(gw->rfcomm, TRUE, NULL);
-	g_io_channel_unref(gw->rfcomm);
-	gw->rfcomm = NULL;
-	change_state(dev, GATEWAY_STATE_DISCONNECTED);
+	gateway_close(dev);
 
 	return FALSE;
 }
-- 
1.7.1

