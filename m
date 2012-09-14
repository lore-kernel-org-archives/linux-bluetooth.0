Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 6/9] media: Split transport state based on playing flag
Date: Fri, 14 Sep 2012 14:03:13 +0200
Message-Id: <1347624196-11281-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Split the transport states (formerly in_use) into more specific states
where the stream state (playing or suspended) is explicitly represented,
along with the transitional states (locally initiated suspend and
resume).

TRANSPORT_STATE_ACTIVE is an exception since it also includes the state
where the transport is acquired, but the audio was later suspended (not
released yet though).
---
 audio/transport.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 639c87f..e0402ad 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -57,13 +57,19 @@ typedef enum {
 } transport_lock_t;
 
 typedef enum {
-	TRANSPORT_STATE_IDLE,		/* Not acquired */
+	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
+	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
+	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
 	TRANSPORT_STATE_ACTIVE,		/* Acquired (not necessarily playing) */
+	TRANSPORT_STATE_SUSPENDING,     /* Release in progress */
 } transport_state_t;
 
 static char *str_state[] = {
 	"TRANSPORT_STATE_IDLE",
+	"TRANSPORT_STATE_PENDING",
+	"TRANSPORT_STATE_REQUESTING",
 	"TRANSPORT_STATE_ACTIVE",
+	"TRANSPORT_STATE_SUSPENDING",
 };
 
 struct media_request {
@@ -153,8 +159,11 @@ static gboolean state_in_use(transport_state_t state)
 {
 	switch (state) {
 	case TRANSPORT_STATE_IDLE:
+	case TRANSPORT_STATE_PENDING:
 		return FALSE;
+	case TRANSPORT_STATE_REQUESTING:
 	case TRANSPORT_STATE_ACTIVE:
+	case TRANSPORT_STATE_SUSPENDING:
 		return TRUE;
 	}
 
@@ -356,6 +365,8 @@ static void a2dp_resume_complete(struct avdtp *session,
 
 	media_owner_remove(owner);
 
+	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+
 	return;
 
 fail:
@@ -382,7 +393,8 @@ static guint resume_a2dp(struct media_transport *transport,
 	if (a2dp_sep_lock(sep, a2dp->session) == FALSE)
 		return 0;
 
-	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+	if (transport->state == TRANSPORT_STATE_IDLE)
+		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
 
 done:
 	return a2dp_resume(a2dp->session, sep, a2dp_resume_complete, owner);
@@ -417,7 +429,12 @@ static guint suspend_a2dp(struct media_transport *transport,
 
 	if (!owner) {
 		a2dp_sep_unlock(sep, a2dp->session);
-		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
+		if (a2dp_sep_is_playing(sep))
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
 		return 0;
 	}
 
@@ -468,6 +485,8 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 
 	media_owner_remove(owner);
 
+	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+
 	return;
 
 fail:
@@ -486,7 +505,8 @@ static guint resume_headset(struct media_transport *transport,
 						HEADSET_LOCK_WRITE) == FALSE)
 		return 0;
 
-	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+	if (transport->state == TRANSPORT_STATE_IDLE)
+		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
 
 done:
 	return headset_request_stream(device, headset_resume_complete,
@@ -516,8 +536,15 @@ static guint suspend_headset(struct media_transport *transport,
 	struct audio_device *device = transport->device;
 
 	if (!owner) {
+		headset_state_t state = headset_get_state(device);
+
 		headset_unlock(device, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
-		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
+		if (state == HEADSET_STATE_PLAYING)
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
 		return 0;
 	}
 
@@ -574,6 +601,8 @@ static void gateway_resume_complete(struct audio_device *dev, GError *err,
 
 	media_owner_remove(owner);
 
+	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+
 	return;
 
 fail:
@@ -592,7 +621,8 @@ static guint resume_gateway(struct media_transport *transport,
 						GATEWAY_LOCK_WRITE) == FALSE)
 		return 0;
 
-	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+	if (transport->state == TRANSPORT_STATE_IDLE)
+		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
 
 done:
 	return gateway_request_stream(device, gateway_resume_complete,
@@ -625,8 +655,15 @@ static guint suspend_gateway(struct media_transport *transport,
 	static int id = 1;
 
 	if (!owner) {
+		gateway_state_t state = gateway_get_state(device);
+
 		gateway_unlock(device, GATEWAY_LOCK_READ | GATEWAY_LOCK_WRITE);
-		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
+		if (state == GATEWAY_STATE_PLAYING)
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
 		return 0;
 	}
 
@@ -806,6 +843,8 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 				return btd_error_in_progress(msg);
 		}
 
+		transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
+
 		id = transport->suspend(transport, owner);
 		if (id == 0) {
 			media_transport_remove(transport, owner);
@@ -1104,7 +1143,14 @@ static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
 static void transport_update_playing(struct media_transport *transport,
 							gboolean playing)
 {
-	DBG("%s Playing=%d", transport->path, playing);
+	DBG("%s State=%s Playing=%d", transport->path,
+					str_state[transport->state], playing);
+
+	if (playing == FALSE) {
+		if (transport->state == TRANSPORT_STATE_PENDING)
+			transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	} else if (transport->state == TRANSPORT_STATE_IDLE)
+		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
 static void headset_state_changed(struct audio_device *dev,
-- 
1.7.7.6

