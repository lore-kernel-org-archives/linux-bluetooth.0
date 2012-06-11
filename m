Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio: Separate profile specific fields from media_transport
Date: Mon, 11 Jun 2012 15:55:10 +0300
Message-Id: <1339419310-4777-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/transport.c |  116 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 34 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 1fccff8..3953c4e 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -62,11 +62,20 @@ struct media_owner {
 	guint			watch;
 };
 
+struct a2dp_transport {
+	struct avdtp		*session;
+	uint16_t		delay;
+	uint16_t		volume;
+};
+
+struct headset_transport {
+	unsigned int		nrec_id;
+};
+
 struct media_transport {
 	DBusConnection		*conn;
 	char			*path;		/* Transport object path */
 	struct audio_device	*device;	/* Transport device */
-	struct avdtp		*session;	/* Signalling session (a2dp only) */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
 	GSList			*owners;	/* Transport owners */
 	uint8_t			*configuration; /* Transport configuration */
@@ -74,9 +83,6 @@ struct media_transport {
 	int			fd;		/* Transport file descriptor */
 	uint16_t		imtu;		/* Transport input mtu */
 	uint16_t		omtu;		/* Transport output mtu */
-	uint16_t		delay;		/* Transport delay (a2dp only) */
-	unsigned int		nrec_id;	/* Transport nrec watch (headset only) */
-	uint16_t		volume;		/* Transport volume */
 	gboolean		read_lock;
 	gboolean		write_lock;
 	gboolean		in_use;
@@ -93,6 +99,8 @@ struct media_transport {
 					struct media_transport *transport,
 					const char *property,
 					DBusMessageIter *value);
+	GDestroyNotify		destroy;
+	void			*data;
 };
 
 void media_transport_destroy(struct media_transport *transport)
@@ -276,26 +284,26 @@ fail:
 static guint resume_a2dp(struct media_transport *transport,
 				struct media_owner *owner)
 {
+	struct a2dp_transport *a2dp = transport->data;
 	struct media_endpoint *endpoint = transport->endpoint;
 	struct audio_device *device = transport->device;
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
 
-	if (transport->session == NULL) {
-		transport->session = avdtp_get(&device->src, &device->dst);
-		if (transport->session == NULL)
+	if (a2dp->session == NULL) {
+		a2dp->session = avdtp_get(&device->src, &device->dst);
+		if (a2dp->session == NULL)
 			return 0;
 	}
 
 	if (transport->in_use == TRUE)
 		goto done;
 
-	transport->in_use = a2dp_sep_lock(sep, transport->session);
+	transport->in_use = a2dp_sep_lock(sep, a2dp->session);
 	if (transport->in_use == FALSE)
 		return 0;
 
 done:
-	return a2dp_resume(transport->session, sep, a2dp_resume_complete,
-				owner);
+	return a2dp_resume(a2dp->session, sep, a2dp_resume_complete, owner);
 }
 
 static void a2dp_suspend_complete(struct avdtp *session,
@@ -303,6 +311,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 {
 	struct media_owner *owner = user_data;
 	struct media_transport *transport = owner->transport;
+	struct a2dp_transport *a2dp = transport->data;
 	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
 
 	/* Release always succeeds */
@@ -312,7 +321,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 		media_owner_remove(owner);
 	}
 
-	a2dp_sep_unlock(sep, transport->session);
+	a2dp_sep_unlock(sep, a2dp->session);
 	transport->in_use = FALSE;
 	media_transport_remove(transport, owner);
 }
@@ -320,17 +329,17 @@ static void a2dp_suspend_complete(struct avdtp *session,
 static guint suspend_a2dp(struct media_transport *transport,
 						struct media_owner *owner)
 {
+	struct a2dp_transport *a2dp = transport->data;
 	struct media_endpoint *endpoint = transport->endpoint;
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
 
 	if (!owner) {
-		a2dp_sep_unlock(sep, transport->session);
+		a2dp_sep_unlock(sep, a2dp->session);
 		transport->in_use = FALSE;
 		return 0;
 	}
 
-	return a2dp_suspend(transport->session, sep, a2dp_suspend_complete,
-				owner);
+	return a2dp_suspend(a2dp->session, sep, a2dp_suspend_complete, owner);
 }
 
 static void cancel_a2dp(struct media_transport *transport, guint id)
@@ -745,10 +754,12 @@ static int set_property_a2dp(struct media_transport *transport,
 						const char *property,
 						DBusMessageIter *value)
 {
+	struct a2dp_transport *a2dp = transport->data;
+
 	if (g_strcmp0(property, "Delay") == 0) {
 		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
 			return -EINVAL;
-		dbus_message_iter_get_basic(value, &transport->delay);
+		dbus_message_iter_get_basic(value, &a2dp->delay);
 
 		/* FIXME: send new delay */
 		return 0;
@@ -763,7 +774,7 @@ static int set_property_a2dp(struct media_transport *transport,
 		if (volume > 127)
 			return -EINVAL;
 
-		if (transport->volume == volume)
+		if (a2dp->volume == volume)
 			return 0;
 
 		return avrcp_set_volume(transport->device, volume);
@@ -855,11 +866,13 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 static void get_properties_a2dp(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
-	dict_append_entry(dict, "Delay", DBUS_TYPE_UINT16, &transport->delay);
+	struct a2dp_transport *a2dp = transport->data;
+
+	dict_append_entry(dict, "Delay", DBUS_TYPE_UINT16, &a2dp->delay);
 
-	if (transport->volume <= 127)
+	if (a2dp->volume <= 127)
 		dict_append_entry(dict, "Volume", DBUS_TYPE_UINT16,
-							&transport->volume);
+							&a2dp->volume);
 }
 
 static void get_properties_headset(struct media_transport *transport,
@@ -957,6 +970,28 @@ static const GDBusSignalTable transport_signals[] = {
 	{ }
 };
 
+static void destroy_a2dp(void *data)
+{
+	struct media_transport *transport = data;
+	struct a2dp_transport *a2dp = transport->data;
+
+	if (a2dp->session)
+		avdtp_unref(a2dp->session);
+
+	g_free(a2dp);
+}
+
+static void destroy_headset(void *data)
+{
+	struct media_transport *transport = data;
+	struct headset_transport *headset = transport->data;
+
+	if (headset->nrec_id > 0)
+		headset_remove_nrec_cb(transport->device, headset->nrec_id);
+
+	g_free(headset);
+}
+
 static void media_transport_free(void *data)
 {
 	struct media_transport *transport = data;
@@ -970,11 +1005,8 @@ static void media_transport_free(void *data)
 
 	g_slist_free(transport->owners);
 
-	if (transport->session)
-		avdtp_unref(transport->session);
-
-	if (transport->nrec_id)
-		headset_remove_nrec_cb(transport->device, transport->nrec_id);
+	if (transport->destroy != NULL)
+		transport->destroy(transport);
 
 	if (transport->conn)
 		dbus_connection_unref(transport->conn);
@@ -1015,26 +1047,38 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 	transport->size = size;
 	transport->path = g_strdup_printf("%s/fd%d", device->path, fd++);
 	transport->fd = -1;
-	transport->volume = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
 	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0 ||
 			strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
+		struct a2dp_transport *a2dp;
+
+		a2dp = g_new0(struct a2dp_transport, 1);
+		a2dp->volume = -1;
+
 		transport->resume = resume_a2dp;
 		transport->suspend = suspend_a2dp;
 		transport->cancel = cancel_a2dp;
 		transport->get_properties = get_properties_a2dp;
 		transport->set_property = set_property_a2dp;
+		transport->data = a2dp;
+		transport->destroy = destroy_a2dp;
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 			strcasecmp(uuid, HSP_AG_UUID) == 0) {
+		struct headset_transport *headset;
+
+		headset = g_new0(struct headset_transport, 1);
+		headset->nrec_id = headset_add_nrec_cb(device,
+							headset_nrec_changed,
+							transport);
+
 		transport->resume = resume_headset;
 		transport->suspend = suspend_headset;
 		transport->cancel = cancel_headset;
 		transport->get_properties = get_properties_headset;
 		transport->set_property = set_property_headset;
-		transport->nrec_id = headset_add_nrec_cb(device,
-							headset_nrec_changed,
-							transport);
+		transport->data = headset;
+		transport->destroy = destroy_headset;
 	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 			strcasecmp(uuid, HSP_HS_UUID) == 0) {
 		transport->resume = resume_gateway;
@@ -1068,15 +1112,17 @@ const char *media_transport_get_path(struct media_transport *transport)
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay)
 {
+	struct a2dp_transport *a2dp = transport->data;
+
 	/* Check if delay really changed */
-	if (transport->delay == delay)
+	if (a2dp->delay == delay)
 		return;
 
-	transport->delay = delay;
+	a2dp->delay = delay;
 
 	emit_property_changed(transport->conn, transport->path,
 				MEDIA_TRANSPORT_INTERFACE, "Delay",
-				DBUS_TYPE_UINT16, &transport->delay);
+				DBUS_TYPE_UINT16, &a2dp->delay);
 }
 
 struct audio_device *media_transport_get_dev(struct media_transport *transport)
@@ -1087,13 +1133,15 @@ struct audio_device *media_transport_get_dev(struct media_transport *transport)
 void media_transport_update_volume(struct media_transport *transport,
 								uint8_t volume)
 {
+	struct a2dp_transport *a2dp = transport->data;
+
 	/* Check if volume really changed */
-	if (transport->volume == volume)
+	if (a2dp->volume == volume)
 		return;
 
-	transport->volume = volume;
+	a2dp->volume = volume;
 
 	emit_property_changed(transport->conn, transport->path,
 				MEDIA_TRANSPORT_INTERFACE, "Volume",
-				DBUS_TYPE_UINT16, &transport->volume);
+				DBUS_TYPE_UINT16, &a2dp->volume);
 }
-- 
1.7.10.2

