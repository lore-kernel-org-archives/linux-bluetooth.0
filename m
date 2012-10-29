Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] player: Add support for SetProperty
Date: Mon, 29 Oct 2012 16:41:45 +0200
Message-Id: <1351521709-4063-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351521709-4063-1-git-send-email-luiz.dentz@gmail.com>
References: <1351521709-4063-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Properties Equalizer, Repeat, Shuffle and Scan can be set by user
application.
---
 audio/avrcp.c  | 129 ++++++++++++++++++++++++++++++++++++++++++++++-
 audio/player.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 audio/player.h |   9 ++++
 3 files changed, 288 insertions(+), 4 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 7c26491..724e139 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -449,6 +449,60 @@ static const char *attr_to_str(uint8_t attr)
 	return NULL;
 }
 
+static int attrval_to_val(uint8_t attr, const char *value)
+{
+	int ret;
+
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_EQUALIZER_OFF;
+		else if (!strcmp(value, "on"))
+			ret = AVRCP_EQUALIZER_ON;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_REPEAT_MODE_OFF;
+		else if (!strcmp(value, "singletrack"))
+			ret = AVRCP_REPEAT_MODE_SINGLE;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_REPEAT_MODE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_REPEAT_MODE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_SHUFFLE_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_SHUFFLE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_SHUFFLE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_SCAN:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_SCAN_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_SCAN_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_SCAN_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
 static int attr_to_val(const char *str)
 {
 	if (!strcasecmp(str, "Equalizer"))
@@ -1528,6 +1582,22 @@ static void avrcp_get_play_status(struct avrcp *session)
 					session);
 }
 
+static const char *status_to_str(uint8_t status)
+{
+	switch (status) {
+	case AVRCP_STATUS_INVALID_COMMAND:
+		return "Invalid Command";
+	case AVRCP_STATUS_INVALID_PARAM:
+		return "Invalid Parameter";
+	case AVRCP_STATUS_INTERNAL_ERROR:
+		return "Internal Error";
+	case AVRCP_STATUS_SUCCESS:
+		return "Success";
+	default:
+		return "Unknown";
+	}
+}
+
 static gboolean avrcp_player_value_rsp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -1540,8 +1610,11 @@ static gboolean avrcp_player_value_rsp(struct avctp *conn,
 	uint8_t count;
 	int i;
 
-	if (code == AVC_CTYPE_REJECTED)
+	if (code == AVC_CTYPE_REJECTED) {
+		media_player_set_setting(mp, "Error",
+					status_to_str(pdu->params[0]));
 		return FALSE;
+	}
 
 	count = pdu->params[0];
 
@@ -1811,6 +1884,59 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 					avrcp_handle_event, session);
 }
 
+static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
+								uint8_t val)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 3];
+	struct avrcp_header *pdu = (void *) buf;
+	uint8_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_SET_PLAYER_VALUE;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params[0] = 1;
+	pdu->params[1] = attr;
+	pdu->params[2] = val;
+	pdu->params_len = htons(3);
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
+					AVC_SUBUNIT_PANEL, buf, length,
+					avrcp_player_value_rsp, session);
+}
+
+static bool ct_set_setting(struct media_player *mp, const char *key,
+					const char *value, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	int attr = attr_to_val(key);
+	int val = attrval_to_val(attr, value);
+	struct avrcp *session;
+
+	session = player->sessions->data;
+	if (session == NULL)
+		return false;
+
+	attr = attr_to_val(key);
+	if (attr < 0)
+		return false;
+
+	val = attrval_to_val(attr, value);
+	if (val < 0)
+		return false;
+
+	avrcp_set_player_value(session, attr, val);
+
+	return true;
+}
+
+static const struct media_player_callback ct_cbs = {
+	.set_setting = ct_set_setting,
+};
+
 static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -1845,6 +1971,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 
 	path = device_get_path(session->dev->btd_dev);
 	mp = media_player_controller_create(path);
+	media_player_set_callbacks(mp, &ct_cbs, player);
 	player->user_data = mp;
 	player->destroy = (GDestroyNotify) media_player_destroy;
 
diff --git a/audio/player.c b/audio/player.c
index 1957594..e83b761 100644
--- a/audio/player.c
+++ b/audio/player.c
@@ -49,6 +49,12 @@ struct player_callback {
 	void *user_data;
 };
 
+struct pending_req {
+	DBusMessage *msg;
+	const char *key;
+	const char *value;
+};
+
 struct media_player {
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
@@ -58,6 +64,7 @@ struct media_player {
 	GTimer			*progress;
 	guint			process_id;
 	struct player_callback	*cb;
+	GSList			*pending;
 };
 
 static void append_settings(void *key, void *value, void *user_data)
@@ -142,10 +149,96 @@ static DBusMessage *media_player_get_track(DBusConnection *conn,
 	return reply;
 }
 
+static struct pending_req *find_pending(struct media_player *mp,
+							const char *key)
+{
+	GSList *l;
+
+	for (l = mp->pending; l; l = l->next) {
+		struct pending_req *p = l->data;
+
+		if (strcasecmp(key, p->key) == 0)
+			return p;
+	}
+
+	return NULL;
+}
+
+static struct pending_req *pending_new(DBusMessage *msg, const char *key,
+							const char *value)
+{
+	struct pending_req *p;
+
+	p = g_new0(struct pending_req, 1);
+	p->msg = dbus_message_ref(msg);
+	p->key = key;
+	p->value = value;
+
+	return p;
+}
+
+static DBusMessage *player_set_setting(struct media_player *mp,
+					DBusMessage *msg, const char *key,
+					const char *value)
+{
+	struct player_callback *cb = mp->cb;
+	struct pending_req *p;
+
+	if (cb == NULL || cb->cbs->set_setting == NULL)
+		return btd_error_not_supported(msg);
+
+	p = find_pending(mp, key);
+	if (p != NULL)
+		return btd_error_in_progress(msg);
+
+	if (!cb->cbs->set_setting(mp, key, value, cb->user_data))
+		return btd_error_invalid_args(msg);
+
+	p = pending_new(msg, key, value);
+
+	mp->pending = g_slist_append(mp->pending, p);
+
+	return NULL;
+}
+
 static DBusMessage *media_player_set_property(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	struct media_player *mp = data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *key, *value, *curval;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &key);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&var, &value);
+
+	if (g_strcmp0(key, "Equalizer") != 0 &&
+				g_strcmp0(key, "Repeat") != 0 &&
+				g_strcmp0(key, "Shuffle") != 0 &&
+				g_strcmp0(key, "Scan") != 0)
+		return btd_error_invalid_args(msg);
+
+	curval = g_hash_table_lookup(mp->settings, key);
+	if (g_strcmp0(curval, value) == 0)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	return player_set_setting(mp, msg, key, value);
 }
 
 static const GDBusMethodTable media_player_methods[] = {
@@ -155,7 +248,7 @@ static const GDBusMethodTable media_player_methods[] = {
 	{ GDBUS_METHOD("GetTrack",
 			NULL, GDBUS_ARGS({ "metadata", "a{sv}" }),
 			media_player_get_track) },
-	{ GDBUS_METHOD("SetProperty",
+	{ GDBUS_ASYNC_METHOD("SetProperty",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" }),
 			NULL, media_player_set_property) },
 	{ }
@@ -169,6 +262,14 @@ static const GDBusSignalTable media_player_signals[] = {
 	{ }
 };
 
+static void pending_free(void *data)
+{
+	struct pending_req *p = data;
+
+	dbus_message_unref(p->msg);
+	g_free(p);
+}
+
 void media_player_destroy(struct media_player *mp)
 {
 	DBG("%s", mp->path);
@@ -185,6 +286,8 @@ void media_player_destroy(struct media_player *mp)
 	if (mp->process_id > 0)
 		g_source_remove(mp->process_id);
 
+	g_slist_free_full(mp->pending, pending_free);
+
 	g_timer_destroy(mp->progress);
 	g_free(mp->cb);
 	g_free(mp->status);
@@ -250,17 +353,46 @@ void media_player_set_setting(struct media_player *mp, const char *key,
 							const char *value)
 {
 	char *curval;
+	struct pending_req *p;
+	DBusMessage *reply;
 
 	DBG("%s: %s", key, value);
 
+	if (strcasecmp(key, "Error") == 0) {
+		p = g_slist_nth_data(mp->pending, 0);
+		if (p == NULL)
+			return;
+
+		reply = btd_error_failed(p->msg, value);
+		goto send;
+	}
+
 	curval = g_hash_table_lookup(mp->settings, key);
 	if (g_strcmp0(curval, value) == 0)
-		return;
+		goto done;
 
 	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
 
 	emit_property_changed(mp->path, MEDIA_PLAYER_INTERFACE, key,
 					DBUS_TYPE_STRING, &value);
+
+done:
+	p = find_pending(mp, key);
+	if (p == NULL)
+		return;
+
+	if (strcasecmp(value, p->value) == 0)
+		reply = g_dbus_create_reply(p->msg, DBUS_TYPE_INVALID);
+	else
+		reply = btd_error_not_supported(p->msg);
+
+send:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	mp->pending = g_slist_remove(mp->pending, p);
+	pending_free(p);
+
+	return;
 }
 
 const char *media_player_get_status(struct media_player *mp)
@@ -341,3 +473,19 @@ void media_player_set_metadata(struct media_player *mp, const char *key,
 
 	g_hash_table_replace(mp->track, g_strdup(key), value);
 }
+
+void media_player_set_callbacks(struct media_player *mp,
+				const struct media_player_callback *cbs,
+				void *user_data)
+{
+	struct player_callback *cb;
+
+	if (mp->cb)
+		g_free(mp->cb);
+
+	cb = g_new0(struct player_callback, 1);
+	cb->cbs = cbs;
+	cb->user_data = user_data;
+
+	mp->cb = cb;
+}
diff --git a/audio/player.h b/audio/player.h
index f3a421a..4a6a9cc 100644
--- a/audio/player.h
+++ b/audio/player.h
@@ -25,6 +25,11 @@
 
 struct media_player;
 
+struct media_player_callback {
+	bool (*set_setting) (struct media_player *mp, const char *key,
+				const char *value, void *user_data);
+};
+
 struct media_player *media_player_controller_create(const char *path);
 void media_player_destroy(struct media_player *mp);
 uint32_t media_player_get_position(struct media_player *mp);
@@ -35,3 +40,7 @@ const char *media_player_get_status(struct media_player *mp);
 void media_player_set_status(struct media_player *mp, const char *status);
 void media_player_set_metadata(struct media_player *mp, const char *key,
 						void *data, size_t len);
+
+void media_player_set_callbacks(struct media_player *mp,
+				const struct media_player_callback *cbs,
+				void *user_data);
-- 
1.7.11.7

