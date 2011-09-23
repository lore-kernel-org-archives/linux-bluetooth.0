Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/3] Remove unneeded checks in gateway_is_connected
Date: Fri, 23 Sep 2011 14:59:24 +0200
Message-Id: <1316782765-24147-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1316782765-24147-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1316782765-24147-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index ca44576..b98dfba 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -760,8 +760,12 @@ struct gateway *gateway_init(struct audio_device *dev)
 
 gboolean gateway_is_connected(struct audio_device *dev)
 {
-	return (dev && dev->gateway &&
-			dev->gateway->state == GATEWAY_STATE_CONNECTED);
+	struct gateway *gw = dev->gateway;
+
+	if (gw->state == GATEWAY_STATE_CONNECTED)
+		return TRUE;
+
+	return FALSE;
 }
 
 gboolean gateway_is_active(struct audio_device *dev)
-- 
1.7.4.1

