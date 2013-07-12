Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 03/10] transport: Regroup a2dp-specific members in struct
Date: Fri, 12 Jul 2013 12:54:36 +0200
Message-Id: <1373626483-2031-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Any property accessible in D-Bus should be associated to the transport
object regardless of its type.
---
 profiles/audio/transport.c | 65 ++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f585c3a..9e9efe3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -79,8 +79,8 @@ struct media_owner {
 
 struct a2dp_transport {
 	struct avdtp		*session;
-	uint16_t		delay;
-	uint16_t		volume;
+	guint			source_watch;
+	guint			sink_watch;
 };
 
 struct media_transport {
@@ -93,10 +93,9 @@ struct media_transport {
 	int			fd;		/* Transport file descriptor */
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
+	uint16_t		delay;
+	uint16_t		volume;
 	transport_state_t	state;
-	guint			hs_watch;
-	guint			source_watch;
-	guint			sink_watch;
 	guint			(*resume) (struct media_transport *transport,
 					struct media_owner *owner);
 	guint			(*suspend) (struct media_transport *transport,
@@ -167,12 +166,6 @@ void media_transport_destroy(struct media_transport *transport)
 {
 	char *path;
 
-	if (transport->sink_watch)
-		sink_remove_state_cb(transport->sink_watch);
-
-	if (transport->source_watch)
-		source_remove_state_cb(transport->source_watch);
-
 	path = g_strdup(transport->path);
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 						MEDIA_TRANSPORT_INTERFACE);
@@ -606,18 +599,17 @@ static gboolean get_state(const GDBusPropertyTable *property,
 static gboolean delay_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
 
-	return a2dp->delay != 0;
+	return transport->delay != 0;
 }
 
 static gboolean get_delay(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &a2dp->delay);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&transport->delay);
 
 	return TRUE;
 }
@@ -625,18 +617,17 @@ static gboolean get_delay(const GDBusPropertyTable *property,
 static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
 
-	return a2dp->volume <= 127;
+	return transport->volume <= 127;
 }
 
 static gboolean get_volume(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &a2dp->volume);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&transport->volume);
 
 	return TRUE;
 }
@@ -646,7 +637,6 @@ static void set_volume(const GDBusPropertyTable *property,
 			void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
 	uint16_t volume;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
@@ -665,10 +655,10 @@ static void set_volume(const GDBusPropertyTable *property,
 		return;
 	}
 
-	if (a2dp->volume != volume)
+	if (transport->volume != volume)
 		avrcp_set_volume(transport->device, volume);
 
-	a2dp->volume = volume;
+	transport->volume = volume;
 
 	g_dbus_pending_property_success(id);
 }
@@ -703,6 +693,12 @@ static void destroy_a2dp(void *data)
 {
 	struct a2dp_transport *a2dp = data;
 
+	if (a2dp->sink_watch)
+		sink_remove_state_cb(a2dp->sink_watch);
+
+	if (a2dp->source_watch)
+		source_remove_state_cb(a2dp->source_watch);
+
 	if (a2dp->session)
 		avdtp_unref(a2dp->session);
 
@@ -788,6 +784,7 @@ struct media_transport *media_transport_create(struct audio_device *device,
 	transport->path = g_strdup_printf("%s/fd%d",
 				device_get_path(device->btd_dev), fd++);
 	transport->fd = -1;
+	transport->volume = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
 	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0 ||
@@ -803,14 +800,13 @@ struct media_transport *media_transport_create(struct audio_device *device,
 		transport->destroy = destroy_a2dp;
 
 		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
-			a2dp->volume = -1;
-			transport->sink_watch = sink_add_state_cb(device,
+			a2dp->sink_watch = sink_add_state_cb(device,
 							sink_state_changed,
 							transport);
 		} else {
-			a2dp->volume = 127;
-			avrcp_set_volume(device, a2dp->volume);
-			transport->source_watch = source_add_state_cb(device,
+			transport->volume = 127;
+			avrcp_set_volume(device, transport->volume);
+			a2dp->source_watch = source_add_state_cb(device,
 							source_state_changed,
 							transport);
 		}
@@ -842,13 +838,11 @@ const char *media_transport_get_path(struct media_transport *transport)
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay)
 {
-	struct a2dp_transport *a2dp = transport->data;
-
 	/* Check if delay really changed */
-	if (a2dp->delay == delay)
+	if (transport->delay == delay)
 		return;
 
-	a2dp->delay = delay;
+	transport->delay = delay;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 					transport->path,
@@ -862,20 +856,17 @@ struct audio_device *media_transport_get_dev(struct media_transport *transport)
 
 uint16_t media_transport_get_volume(struct media_transport *transport)
 {
-	struct a2dp_transport *a2dp = transport->data;
-	return a2dp->volume;
+	return transport->volume;
 }
 
 void media_transport_update_volume(struct media_transport *transport,
 								uint8_t volume)
 {
-	struct a2dp_transport *a2dp = transport->data;
-
 	/* Check if volume really changed */
-	if (a2dp->volume == volume)
+	if (transport->volume == volume)
 		return;
 
-	a2dp->volume = volume;
+	transport->volume = volume;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 					transport->path,
-- 
1.8.1.4

