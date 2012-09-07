Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3 8/9] media: Expose transport state in D-Bus
Date: Fri,  7 Sep 2012 17:20:32 +0200
Message-Id: <1347031233-21621-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347031233-21621-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347031233-21621-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the Media API to expose the transport state in D-Bus, as a
property of the transport. This way the clients do not have to find
out which is the corresponding profile-specific interface for the
transport.

Additionally, this state along with the automatic release of transports
will allow clients to avoid the "optional release" or "accept remote
release" race condition. For example, with HSP/HFP profiles, the problem
is the following:

1. User suspends SCO in the remote end.
2. BlueZ signals the Playing->Connected state change in D-Bus.
3. Exactly afterwards, the user resumes SCO in the remote end.
4. In parallel, PulseAudio sees the aforementioned transition to
   Connected, and thus releases the transport.
5. BlueZ receives a Release() request while SCO is up. So the audio
   stream will be suspended.

The last step is an undesired behavior since the user explicitly wanted
to route the audio stream through Bluetooth.

The issue is difficult to reproduce but it can easily be solved by
exposing the transport state in D-Bus.
---
 audio/transport.c |   29 +++++++++++++++++++++++++++++
 doc/media-api.txt |    8 ++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 79fa38d..05bb953 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -155,6 +155,22 @@ static transport_lock_t str2lock(const char *str)
 	return lock;
 }
 
+static const char *state2str(transport_state_t state)
+{
+	switch (state) {
+	case TRANSPORT_STATE_IDLE:
+	case TRANSPORT_STATE_REQUESTING:
+		return "idle";
+	case TRANSPORT_STATE_PENDING:
+		return "pending";
+	case TRANSPORT_STATE_ACQUIRED:
+	case TRANSPORT_STATE_SUSPENDING:
+		return "acquired";
+	}
+
+	return NULL;
+}
+
 static gboolean state_in_use(transport_state_t state)
 {
 	switch (state) {
@@ -174,6 +190,7 @@ static void transport_set_state(struct media_transport *transport,
 							transport_state_t state)
 {
 	transport_state_t old_state = transport->state;
+	const char *str;
 
 	if (old_state == state)
 		return;
@@ -182,6 +199,13 @@ static void transport_set_state(struct media_transport *transport,
 
 	DBG("State changed %s: %s -> %s", transport->path, str_state[old_state],
 							str_state[state]);
+
+	str = state2str(state);
+
+	if (g_strcmp0(str, state2str(old_state)) != 0)
+		emit_property_changed(transport->conn, transport->path,
+					MEDIA_TRANSPORT_INTERFACE, "State",
+					DBUS_TYPE_STRING, &str);
 }
 
 void media_transport_destroy(struct media_transport *transport)
@@ -1017,6 +1041,7 @@ void transport_get_properties(struct media_transport *transport,
 	DBusMessageIter dict;
 	const char *uuid;
 	uint8_t codec;
+	const char *state;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -1036,6 +1061,10 @@ void transport_get_properties(struct media_transport *transport,
 	dict_append_array(&dict, "Configuration", DBUS_TYPE_BYTE,
 				&transport->configuration, transport->size);
 
+	/* State */
+	state = state2str(transport->state);
+	dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
+
 	if (transport->get_properties)
 		transport->get_properties(transport, &dict);
 
diff --git a/doc/media-api.txt b/doc/media-api.txt
index e5eeaa0..dfbff2e 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -317,6 +317,14 @@ Properties	object Device [readonly]
 			Configuration blob, it is used as it is so the size and
 			byte order must match.
 
+		string State [readonly]
+
+			Indicates the state of the transport. Possible
+			values are:
+				"idle": not streaming
+				"pending": streaming but not acquired
+				"acquired": streaming and acquired
+
 		uint16 Delay [readwrite]
 
 			Optional. Transport delay in 1/10 of millisecond, this
-- 
1.7.7.6

