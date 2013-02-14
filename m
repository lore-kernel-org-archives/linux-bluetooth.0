Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0] transport: Add new transport state set during init
Date: Thu, 14 Feb 2013 08:38:16 +0100
Message-Id: <1360827496-9612-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The currently existing D-Bus transport states present a problem when
implementing a client: the AVDTP transition from CONFIGURED to OPEN is
never announced in D-Bus. Therefore, the client doesn't know when the
transport is actually usable, since any acquisition attempt during the
CONFIGURED state will return an error ("SEP in bad state for resume").

The proposed solution is to add one more transport state ("configuring")
in order to distinguish the setup phase from the usable state ("idle").
---
Patches to test this with PulseAudio in:
git://github.com/mastiz/pulseaudio-bluez5.git

 doc/media-api.txt          |  1 +
 profiles/audio/transport.c | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index db1575f..eeaa9bc 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -487,6 +487,7 @@ Properties	object Device [readonly]
 
 			Indicates the state of the transport. Possible
 			values are:
+				"configuring": initializing (cannot be acquired)
 				"idle": not streaming
 				"pending": streaming but not acquired
 				"active": streaming and acquired
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 32ba50b..e927523 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -50,6 +50,7 @@
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
 typedef enum {
+	TRANSPORT_STATE_CONFIGURING,	/* Configuring */
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
@@ -58,6 +59,7 @@ typedef enum {
 } transport_state_t;
 
 static char *str_state[] = {
+	"TRANSPORT_STATE_CONFIGURING",
 	"TRANSPORT_STATE_IDLE",
 	"TRANSPORT_STATE_PENDING",
 	"TRANSPORT_STATE_REQUESTING",
@@ -112,6 +114,8 @@ static GSList *transports = NULL;
 static const char *state2str(transport_state_t state)
 {
 	switch (state) {
+	case TRANSPORT_STATE_CONFIGURING:
+		return "configuring";
 	case TRANSPORT_STATE_IDLE:
 	case TRANSPORT_STATE_REQUESTING:
 		return "idle";
@@ -128,6 +132,7 @@ static const char *state2str(transport_state_t state)
 static gboolean state_in_use(transport_state_t state)
 {
 	switch (state) {
+	case TRANSPORT_STATE_CONFIGURING:
 	case TRANSPORT_STATE_IDLE:
 	case TRANSPORT_STATE_PENDING:
 		return FALSE;
@@ -726,14 +731,15 @@ static void media_transport_free(void *data)
 	g_free(transport);
 }
 
-static void transport_update_playing(struct media_transport *transport,
+static void transport_update_state(struct media_transport *transport,
 							gboolean playing)
 {
 	DBG("%s State=%s Playing=%d", transport->path,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if (transport->state == TRANSPORT_STATE_PENDING)
+		if (transport->state == TRANSPORT_STATE_CONFIGURING ||
+				transport->state == TRANSPORT_STATE_PENDING)
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
 			/* Remove owner */
@@ -754,10 +760,13 @@ static void sink_state_changed(struct audio_device *dev,
 	if (dev != transport->device)
 		return;
 
+	if (new_state == SINK_STATE_CONNECTING)
+		return;
+
 	if (new_state == SINK_STATE_PLAYING)
-		transport_update_playing(transport, TRUE);
+		transport_update_state(transport, TRUE);
 	else
-		transport_update_playing(transport, FALSE);
+		transport_update_state(transport, FALSE);
 }
 
 static void source_state_changed(struct audio_device *dev,
@@ -770,10 +779,13 @@ static void source_state_changed(struct audio_device *dev,
 	if (dev != transport->device)
 		return;
 
+	if (new_state == SOURCE_STATE_CONNECTING)
+		return;
+
 	if (new_state == SOURCE_STATE_PLAYING)
-		transport_update_playing(transport, TRUE);
+		transport_update_state(transport, TRUE);
 	else
-		transport_update_playing(transport, FALSE);
+		transport_update_state(transport, FALSE);
 }
 
 struct media_transport *media_transport_create(struct audio_device *device,
-- 
1.8.1

