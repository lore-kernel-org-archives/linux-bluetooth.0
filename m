Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 23/25] broadcaster: Add ClearBroadcastData() D-Bus method
Date: Fri, 21 Dec 2012 16:26:50 -0400
Message-Id: <1356121612-15172-24-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ClearBroadcastData() function will clean all data (Service Data or
Manufacturer Specific Data) set by the current application. All data set
by any other application will be kept.
---
 src/adapter.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 45471dc..9c99070 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1699,9 +1699,84 @@ done:
 	return NULL;
 }
 
+static void restore_bcast_data(gpointer data, gpointer user_data)
+{
+	struct bcast_session *session = data, *cleared = user_data;
+
+	if (session == cleared)
+		return;
+
+	if (session->data_type != cleared->data_type)
+		return;
+
+	send_advdata_blob(session->adapter, session);
+}
+
+static gint cmp_bcast_session_owner(gconstpointer a, gconstpointer b)
+{
+	const struct bcast_session *session = a;
+	const char *owner = b;
+
+	return g_strcmp0(session->owner, owner);
+}
+
+static gboolean find_bcast_session_by_owner(struct btd_adapter *adapter,
+						const char *sender,
+						struct bcast_session **session)
+{
+	GSList *l;
+
+	l = g_slist_find_custom(adapter->bcast_sessions, sender,
+						cmp_bcast_session_owner);
+	if (!l)
+		return FALSE;
+
+	if (session)
+		*session = l->data;
+
+	return TRUE;
+}
+
 static DBusMessage *clear_broadcast_data(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
+	struct btd_adapter *adapter = data;
+	struct bcast_session *session;
+	const char *sender;
+	int err;
+
+	sender = dbus_message_get_sender(msg);
+
+	DBG("Clear all data in broadcaster registered for hci%d at %s",
+						adapter->dev_id, sender);
+
+	while (find_bcast_session_by_owner(adapter, sender, &session)) {
+		uint8_t type = session->data_type;
+
+		err = mgmt_unset_controller_data(adapter->dev_id, type);
+		if (err < 0)
+			error("Failed to set Broadcaster: %s (%d)",
+							strerror(-err), -err);
+
+		/* mgmt_unset_controller_data() also clears broadcast data from
+		 * other clients with the same data type, so they need to be
+		 * restored. */
+		g_slist_foreach(adapter->bcast_sessions, restore_bcast_data,
+								session);
+
+		adapter->bcast_sessions =
+			g_slist_remove(adapter->bcast_sessions, session);
+
+		free_bcast_session(session);
+	}
+
+	if (!adapter->bcast_sessions) {
+		err = mgmt_set_broadcaster(adapter->dev_id, FALSE);
+		if (err < 0)
+			error("Failed to set Broadcaster: %s (%d)",
+							strerror(-err), -err);
+	}
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.9.5

