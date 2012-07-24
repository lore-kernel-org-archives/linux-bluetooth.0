Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 4/4] media: Remove transport in_use flag
Date: Tue, 24 Jul 2012 17:52:30 +0200
Message-Id: <1343145150-6427-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

With the introduction of the playing flag, the previously existing
in_use flag is somehow redundant. The playing flag along with the lock
states implicitly represent the same information.
---
 audio/transport.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index ffc637c..bef04e5 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -87,7 +87,6 @@ struct media_transport {
 	gboolean		read_lock;
 	gboolean		write_lock;
 	gboolean		playing;
-	gboolean		in_use;
 	guint			(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
 	guint			(*suspend) (struct media_transport *transport,
@@ -215,7 +214,7 @@ static void media_transport_remove(struct media_transport *transport,
 	media_owner_free(owner);
 
 	/* Suspend if there is no longer any owner */
-	if (transport->owners == NULL && transport->in_use)
+	if (transport->owners == NULL && transport->playing)
 		transport->suspend(transport, NULL);
 }
 
@@ -297,11 +296,10 @@ static guint resume_a2dp(struct media_transport *transport,
 			return 0;
 	}
 
-	if (transport->in_use == TRUE)
+	if (transport->playing == TRUE)
 		goto done;
 
-	transport->in_use = a2dp_sep_lock(sep, a2dp->session);
-	if (transport->in_use == FALSE)
+	if (a2dp_sep_lock(sep, a2dp->session) == FALSE)
 		return 0;
 
 done:
@@ -324,7 +322,6 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	}
 
 	a2dp_sep_unlock(sep, a2dp->session);
-	transport->in_use = FALSE;
 	media_transport_remove(transport, owner);
 }
 
@@ -337,7 +334,6 @@ static guint suspend_a2dp(struct media_transport *transport,
 
 	if (!owner) {
 		a2dp_sep_unlock(sep, a2dp->session);
-		transport->in_use = FALSE;
 		return 0;
 	}
 
@@ -399,12 +395,11 @@ static guint resume_headset(struct media_transport *transport,
 {
 	struct audio_device *device = transport->device;
 
-	if (transport->in_use == TRUE)
+	if (transport->playing == TRUE)
 		goto done;
 
-	transport->in_use = headset_lock(device, HEADSET_LOCK_READ |
-						HEADSET_LOCK_WRITE);
-	if (transport->in_use == FALSE)
+	if (headset_lock(device, HEADSET_LOCK_READ |
+						HEADSET_LOCK_WRITE) == FALSE)
 		return 0;
 
 done:
@@ -425,7 +420,6 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 	}
 
 	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-	transport->in_use = FALSE;
 	media_transport_remove(transport, owner);
 }
 
@@ -436,7 +430,6 @@ static guint suspend_headset(struct media_transport *transport,
 
 	if (!owner) {
 		headset_unlock(device, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-		transport->in_use = FALSE;
 		return 0;
 	}
 
@@ -504,12 +497,11 @@ static guint resume_gateway(struct media_transport *transport,
 {
 	struct audio_device *device = transport->device;
 
-	if (transport->in_use == TRUE)
+	if (transport->playing == TRUE)
 		goto done;
 
-	transport->in_use = gateway_lock(device, GATEWAY_LOCK_READ |
-						GATEWAY_LOCK_WRITE);
-	if (transport->in_use == FALSE)
+	if (gateway_lock(device, GATEWAY_LOCK_READ |
+						GATEWAY_LOCK_WRITE) == FALSE)
 		return 0;
 
 done:
@@ -531,7 +523,6 @@ static gboolean gateway_suspend_complete(gpointer user_data)
 	}
 
 	gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
-	transport->in_use = FALSE;
 	media_transport_remove(transport, owner);
 	return FALSE;
 }
@@ -544,7 +535,6 @@ static guint suspend_gateway(struct media_transport *transport,
 
 	if (!owner) {
 		gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
-		transport->in_use = FALSE;
 		return 0;
 	}
 
-- 
1.7.7.6

