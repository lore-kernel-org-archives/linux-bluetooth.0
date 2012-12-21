Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 21/25] broadcaster: Add list of broadcaster sessions
Date: Fri, 21 Dec 2012 16:26:48 -0400
Message-Id: <1356121612-15172-22-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

The adapter will keep a list of broadcasters which set new advertising
data values. The new broadcaster is added to the list when the function
SetServiceData() or SetManufacturerData() is called.
---
 src/adapter.c |  159 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/eir.h     |    3 ++
 2 files changed, 162 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 60c0697..7e0f2b5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -133,6 +133,18 @@ struct observer_watcher {
 	char *path;			/* DBus path */
 };
 
+struct bcast_session {
+	struct btd_adapter	*adapter;
+	DBusMessage		*msg;
+	guint			id;
+	char			*owner;
+	uint8_t			data_type;
+	uint16_t		data_id;
+	uint8_t			data_len;
+	/* Reserve 2 octets for ServiceUUID/CompanyId */
+	uint8_t			data[EIR_DATA_MAX_LEN - sizeof(uint16_t)];
+};
+
 struct btd_adapter {
 	uint16_t dev_id;
 	gboolean powered;
@@ -154,6 +166,7 @@ struct btd_adapter {
 	struct session_req *scanning_session;
 	GSList *connect_list;		/* Devices to connect when found */
 	GSList *observers;		/* Observer watchers */
+	GSList *bcast_sessions;		/* Broadcast sessions */
 	guint discov_id;		/* Discovery timer */
 	struct discovery *discovery;	/* Discovery active */
 	gboolean connecting;		/* Connect active */
@@ -1409,6 +1422,81 @@ static DBusMessage *unregister_manuf_observer(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static void free_bcast_session(gpointer user_data)
+{
+	struct bcast_session *session = user_data;
+
+	btd_adapter_unref(session->adapter);
+	if (session->msg)
+		dbus_message_unref(session->msg);
+
+	g_dbus_remove_watch(btd_get_dbus_connection(), session->id);
+
+	g_free(session->owner);
+	g_free(session);
+}
+
+static gint cmp_bcast_session(gconstpointer a, gconstpointer b)
+{
+	const struct bcast_session *session = a;
+	const struct bcast_session *match = b;
+	int ret;
+
+	ret = g_strcmp0(session->owner, match->owner);
+	if (ret)
+		return ret;
+
+	ret = session->data_type - match->data_type;
+	if (ret)
+		return ret;
+
+	return session->data_id - match->data_id;
+}
+
+static struct bcast_session *find_bcast_session(GSList *list,
+			const char *sender, uint8_t type, uint16_t data_id)
+{
+	struct bcast_session *match;
+	GSList *l;
+
+	match = g_new0(struct bcast_session, 1);
+	match->owner = g_strdup(sender);
+	match->data_type = type;
+	match->data_id = data_id;
+
+	l = g_slist_find_custom(list, match, cmp_bcast_session);
+	g_free(match->owner);
+	g_free(match);
+
+	return l ? l->data : NULL;
+}
+
+static void bcast_session_exit(DBusConnection *conn, void *user_data)
+{
+	struct bcast_session *session = user_data;
+	struct btd_adapter *adapter = session->adapter;
+	uint8_t type = session->data_type;
+
+	if (type == EIR_SVC_DATA)
+		DBG("Service Data Broadcaster watcher %s disconnected",
+								session->owner);
+	else
+		DBG("Manufacturer Data Broadcasterer watcher %s disconnected",
+								session->owner);
+
+	adapter->bcast_sessions = g_slist_remove(adapter->bcast_sessions,
+								session);
+	free_bcast_session(session);
+
+	/* FIXME: Stop advertising, send data blob from others apps to kernel
+	 * with same type and restart advertising*/
+}
+
+static void update_adv_data(struct btd_adapter *adapter,
+		struct bcast_session *session, uint8_t *data, int size)
+{
+}
+
 void adapter_set_controller_data_failed(struct btd_adapter *adapter)
 {
 }
@@ -1417,6 +1505,7 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct btd_adapter *adapter = data;
+	struct bcast_session *session;
 	const char *sender;
 	uint16_t uuid;
 	uint8_t *sdata;
@@ -1430,9 +1519,30 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 
 	sender = dbus_message_get_sender(msg);
 
+	session = find_bcast_session(adapter->bcast_sessions, sender,
+							EIR_SVC_DATA, uuid);
+	if (session) {
+		update_adv_data(adapter, session, sdata, ssize);
+		goto done;
+	}
+
+	session = g_new(struct bcast_session, 1);
+	session->data_id = uuid;
+	session->owner = g_strdup(sender);
+	session->adapter = btd_adapter_ref(adapter);
+	session->data_type = EIR_SVC_DATA;
+	session->msg = dbus_message_ref(msg);
+	session->id = g_dbus_add_disconnect_watch(conn, sender,
+						bcast_session_exit, session,
+						NULL);
+
+	adapter->bcast_sessions = g_slist_prepend(adapter->bcast_sessions,
+								session);
+
 	DBG("Service Data Broadcaster registered for hci%d at %s",
 						adapter->dev_id, sender);
 
+done:
 	return dbus_message_new_method_return(msg);
 }
 
@@ -1440,6 +1550,7 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct btd_adapter *adapter = data;
+	struct bcast_session *session;
 	const char *sender;
 	uint16_t company_id;
 	uint8_t *mdata;
@@ -1453,9 +1564,30 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 
 	sender = dbus_message_get_sender(msg);
 
+	session = find_bcast_session(adapter->bcast_sessions, sender,
+						EIR_MANUF_DATA, company_id);
+	if (session != NULL) {
+		update_adv_data(adapter, session, mdata, msize);
+		goto done;
+	}
+
+	session = g_new(struct bcast_session, 1);
+	session->data_id = company_id;
+	session->owner = g_strdup(sender);
+	session->adapter = btd_adapter_ref(adapter);
+	session->data_type = EIR_MANUF_DATA;
+	session->msg = dbus_message_ref(msg);
+	session->id = g_dbus_add_disconnect_watch(conn, sender,
+						bcast_session_exit, session,
+						NULL);
+
+	adapter->bcast_sessions = g_slist_prepend(adapter->bcast_sessions,
+								session);
+
 	DBG("Manufacturer Specific Data Broadcaster registered for hci%d at %s",
 						adapter->dev_id, sender);
 
+done:
 	return dbus_message_new_method_return(msg);
 }
 
@@ -3067,6 +3199,31 @@ static void release_all_obs(struct btd_adapter *adapter)
 	g_slist_free_full(adapter->observers, destroy_observer);
 }
 
+static void release_all_bcast(struct btd_adapter *adapter)
+{
+	int err;
+
+	if (!adapter->bcast_sessions)
+		return;
+
+	err = mgmt_set_broadcaster(adapter->dev_id, FALSE);
+	if (err < 0)
+		error("Failed to set Broadcaster: %s (%d)", strerror(-err),
+									-err);
+
+	err = mgmt_unset_controller_data(adapter->dev_id, EIR_SVC_DATA);
+	if (err < 0)
+		error("Failed to unset service data: %s (%d)", strerror(-err),
+									-err);
+
+	err = mgmt_unset_controller_data(adapter->dev_id, EIR_MANUF_DATA);
+	if (err < 0)
+		error("Failed to unset manufacturer spcific data: %s (%d)",
+							strerror(-err), -err);
+
+	g_slist_free_full(adapter->bcast_sessions, free_bcast_session);
+}
+
 void adapter_remove(struct btd_adapter *adapter)
 {
 	GSList *l;
@@ -3091,6 +3248,8 @@ void adapter_remove(struct btd_adapter *adapter)
 
 	release_all_obs(adapter);
 
+	release_all_bcast(adapter);
+
 	if (adapter->powered)
 		mgmt_set_powered(adapter->dev_id, FALSE);
 }
diff --git a/src/eir.h b/src/eir.h
index e410753..9fb0ba1 100644
--- a/src/eir.h
+++ b/src/eir.h
@@ -40,6 +40,9 @@
 #define EIR_GAP_APPEARANCE          0x19  /* GAP appearance */
 #define EIR_MANUF_DATA              0xFF  /* manufacturer specific data */
 
+/* Reserve 2 octets for length and data type */
+#define EIR_DATA_MAX_LEN            (HCI_LE_MAX_ADV_DATA_LENGTH - 2)
+
 struct svc_data {
 	uint16_t uuid;
 	uint8_t data_len;
-- 
1.7.9.5

