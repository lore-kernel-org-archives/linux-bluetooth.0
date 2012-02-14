Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 1/3] audio: gateway_unlock together with in_use = FALSE
Date: Tue, 14 Feb 2012 10:06:32 +0100
Message-Id: <1329210394-31405-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329210394-31405-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329210394-31405-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Calling gateway_unlock seems safer in gateway_suspend_complete, in
combination with the update of transport->in_use. This avoids the
transitional state of having the gateway unlocked but the transport
still in use.

This approach is also more consistent with the way headset and a2dp
handle it.
---
 audio/transport.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 7bde32d..2092644 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -510,6 +510,7 @@ static gboolean gateway_suspend_complete(gpointer user_data)
 {
 	struct media_owner *owner = user_data;
 	struct media_transport *transport = owner->transport;
+	struct audio_device *device = transport->device;
 
 	/* Release always succeeds */
 	if (owner->pending) {
@@ -518,6 +519,7 @@ static gboolean gateway_suspend_complete(gpointer user_data)
 		media_owner_remove(owner);
 	}
 
+	gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
 	transport->in_use = FALSE;
 	media_transport_remove(transport, owner);
 	return FALSE;
@@ -536,7 +538,6 @@ static guint suspend_gateway(struct media_transport *transport,
 	}
 
 	gateway_suspend_stream(device);
-	gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
 	g_idle_add(gateway_suspend_complete, owner);
 	return id++;
 }
-- 
1.7.6.5

