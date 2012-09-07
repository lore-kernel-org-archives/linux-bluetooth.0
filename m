Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3 4/9] media: Replace transport->in_use flag with state
Date: Fri,  7 Sep 2012 17:20:28 +0200
Message-Id: <1347031233-21621-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347031233-21621-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347031233-21621-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Refactor the code to use a enum type to represent the transport state.
This should scale better when additional states need to be represented.

A helper function has been added to help track the mapping between the
enum type and the old in_use flag.
---
 audio/transport.c |   77 ++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index d418878..0ae9a8c 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -54,6 +54,16 @@ typedef enum {
 	TRANSPORT_LOCK_WRITE = 1 << 1,
 } transport_lock_t;
 
+typedef enum {
+	TRANSPORT_STATE_IDLE,		/* Not acquired */
+	TRANSPORT_STATE_ACQUIRED,	/* Acquired (not necessarily playing) */
+} transport_state_t;
+
+static char *str_state[] = {
+	"TRANSPORT_STATE_IDLE",
+	"TRANSPORT_STATE_ACQUIRED",
+};
+
 struct media_request {
 	DBusMessage		*msg;
 	guint			id;
@@ -90,7 +100,7 @@ struct media_transport {
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
 	transport_lock_t	lock;
-	gboolean		in_use;
+	transport_state_t	state;
 	guint			(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
 	guint			(*suspend) (struct media_transport *transport,
@@ -133,6 +143,32 @@ static transport_lock_t str2lock(const char *str)
 	return lock;
 }
 
+static gboolean state_in_use(transport_state_t state)
+{
+	switch (state) {
+	case TRANSPORT_STATE_IDLE:
+		return FALSE;
+	case TRANSPORT_STATE_ACQUIRED:
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void transport_set_state(struct media_transport *transport,
+							transport_state_t state)
+{
+	transport_state_t old_state = transport->state;
+
+	if (old_state == state)
+		return;
+
+	transport->state = state;
+
+	DBG("State changed %s: %s -> %s", transport->path, str_state[old_state],
+							str_state[state]);
+}
+
 void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
@@ -240,7 +276,7 @@ static void media_transport_remove(struct media_transport *transport,
 	media_owner_free(owner);
 
 	/* Suspend if there is no longer any owner */
-	if (transport->owners == NULL && transport->in_use)
+	if (transport->owners == NULL && state_in_use(transport->state))
 		transport->suspend(transport, NULL);
 }
 
@@ -322,13 +358,14 @@ static guint resume_a2dp(struct media_transport *transport,
 			return 0;
 	}
 
-	if (transport->in_use == TRUE)
+	if (state_in_use(transport->state))
 		goto done;
 
-	transport->in_use = a2dp_sep_lock(sep, a2dp->session);
-	if (transport->in_use == FALSE)
+	if (a2dp_sep_lock(sep, a2dp->session) == FALSE)
 		return 0;
 
+	transport_set_state(transport, TRANSPORT_STATE_ACQUIRED);
+
 done:
 	return a2dp_resume(a2dp->session, sep, a2dp_resume_complete, owner);
 }
@@ -349,7 +386,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 	}
 
 	a2dp_sep_unlock(sep, a2dp->session);
-	transport->in_use = FALSE;
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	media_transport_remove(transport, owner);
 }
 
@@ -362,7 +399,7 @@ static guint suspend_a2dp(struct media_transport *transport,
 
 	if (!owner) {
 		a2dp_sep_unlock(sep, a2dp->session);
-		transport->in_use = FALSE;
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		return 0;
 	}
 
@@ -424,14 +461,15 @@ static guint resume_headset(struct media_transport *transport,
 {
 	struct audio_device *device = transport->device;
 
-	if (transport->in_use == TRUE)
+	if (state_in_use(transport->state))
 		goto done;
 
-	transport->in_use = headset_lock(device, HEADSET_LOCK_READ |
-						HEADSET_LOCK_WRITE);
-	if (transport->in_use == FALSE)
+	if (headset_lock(device, HEADSET_LOCK_READ |
+						HEADSET_LOCK_WRITE) == FALSE)
 		return 0;
 
+	transport_set_state(transport, TRANSPORT_STATE_ACQUIRED);
+
 done:
 	return headset_request_stream(device, headset_resume_complete,
 					owner);
@@ -450,7 +488,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 	}
 
 	headset_unlock(dev, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-	transport->in_use = FALSE;
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	media_transport_remove(transport, owner);
 }
 
@@ -461,7 +499,7 @@ static guint suspend_headset(struct media_transport *transport,
 
 	if (!owner) {
 		headset_unlock(device, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-		transport->in_use = FALSE;
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		return 0;
 	}
 
@@ -529,14 +567,15 @@ static guint resume_gateway(struct media_transport *transport,
 {
 	struct audio_device *device = transport->device;
 
-	if (transport->in_use == TRUE)
+	if (state_in_use(transport->state))
 		goto done;
 
-	transport->in_use = gateway_lock(device, GATEWAY_LOCK_READ |
-						GATEWAY_LOCK_WRITE);
-	if (transport->in_use == FALSE)
+	if (gateway_lock(device, GATEWAY_LOCK_READ |
+						GATEWAY_LOCK_WRITE) == FALSE)
 		return 0;
 
+	transport_set_state(transport, TRANSPORT_STATE_ACQUIRED);
+
 done:
 	return gateway_request_stream(device, gateway_resume_complete,
 					owner);
@@ -556,7 +595,7 @@ static gboolean gateway_suspend_complete(gpointer user_data)
 	}
 
 	gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
-	transport->in_use = FALSE;
+	transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	media_transport_remove(transport, owner);
 	return FALSE;
 }
@@ -569,7 +608,7 @@ static guint suspend_gateway(struct media_transport *transport,
 
 	if (!owner) {
 		gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
-		transport->in_use = FALSE;
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		return 0;
 	}
 
-- 
1.7.7.6

