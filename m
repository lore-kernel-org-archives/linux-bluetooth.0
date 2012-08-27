Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 30/33] broadcaster: Build and send ADV/EIR data blob to kernel
Date: Mon, 27 Aug 2012 13:03:22 -0400
Message-Id: <1346087005-24693-31-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SetServiceData() and SetManufacturerData() operations will save all data
and send the ADV/EIR data to kernel. The ADV/EIR data will added in the
current one.

Note: For now, the maximum ADV/EIR data length is limited to 236
(HCI_MAX_EIR_LENGTH - 4) octets. This is need to reserve 2 octets for
length and data type and more 2 octets for UUID/CompanyID. If the
ADV/EIR data from new broadcaster session try to insert more octets than
236 bytes the operation will fail.
---
 src/adapter.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3041d6c..02306a1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -86,6 +86,9 @@
 #define FILTER_SERVICE_UUID	0x01
 #define FILTER_COMPANY_IC	0x02
 
+/* Flags for Broadcaster */
+#define BCAST_DATA_NORMAL_PRIORITY	0x00
+
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
 
@@ -1928,6 +1931,60 @@ static struct bcast_session *find_bcast_session(GSList *list,
 	return (l ? l->data : NULL);
 }
 
+static void send_advdata_blob(struct btd_adapter *adapter,
+						struct bcast_session *session)
+{
+	uint8_t data[EIR_DATA_MAX_LEN];
+	uint16_t *u16 = (void *) data;
+	int err;
+
+	bt_put_unaligned(htobs(session->data_id), u16);
+	memcpy(data + sizeof(session->data_id), session->data,
+							session->data_len);
+
+	err = mgmt_set_controller_data(adapter->dev_id,
+				BCAST_DATA_NORMAL_PRIORITY,
+				session->data_type, data,
+				session->data_len + sizeof(session->data_id));
+	if (err < 0)
+		error("Failed to set controller data in Broadcaster: %s (%d)",
+							strerror(-err), -err);
+}
+
+static void restore_bcast_type(struct btd_adapter *adapter, uint8_t type)
+{
+	GSList *l;
+	int err;
+
+	err = mgmt_set_broadcaster(adapter->dev_id, FALSE);
+	if (err < 0) {
+		error("Failed to set Broadcaster: %s (%d)", strerror(-err),
+									-err);
+		return;
+	}
+
+	err = mgmt_unset_controller_data(adapter->dev_id, type);
+	if (err < 0) {
+		error("Failed to unset controller data: %s (%d)",
+							strerror(-err), -err);
+		return;
+	}
+
+	for (l = adapter->bcast_sessions; l; l = g_slist_next(l)) {
+		struct bcast_session *session = l->data;
+
+		if (session->data_type == type)
+			send_advdata_blob(adapter, session);
+	}
+
+	if (adapter->bcast_sessions) {
+		err = mgmt_set_broadcaster(adapter->dev_id, TRUE);
+		if (err < 0)
+			error("Failed to set Broadcaster: %s (%d)",
+							strerror(-err), -err);
+	}
+}
+
 static void bcast_session_exit(DBusConnection *conn, void *user_data)
 {
 	struct bcast_session *session = user_data;
@@ -1943,10 +2000,10 @@ static void bcast_session_exit(DBusConnection *conn, void *user_data)
 
 	adapter->bcast_sessions = g_slist_remove(adapter->bcast_sessions,
 								session);
-	free_bcast_session(session);
 
-	/* FIXME: Stop advertising, send data blob from others apps to kernel
-	 * with same type and restart advertising*/
+	restore_bcast_type(adapter, type);
+
+	free_bcast_session(session);
 }
 
 static void update_adv_data(struct btd_adapter *adapter,
@@ -1962,7 +2019,7 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 	const char *sender;
 	uint16_t uuid;
 	uint8_t *sdata;
-	int ssize;
+	int ssize, err;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &uuid,
 						DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
@@ -1970,6 +2027,12 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 						DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
+	/* It will accept new ADV/EIR data only if there is space for complete
+	 * data. Reserve 2 octets for Service UUID */
+	if (ssize + sizeof(uint16_t) > EIR_DATA_MAX_LEN)
+		return btd_error_failed(msg, "New ADV/EIR data is bigger than"
+								" permitted");
+
 	sender = dbus_message_get_sender(msg);
 
 	session = find_bcast_session(adapter->bcast_sessions, sender,
@@ -1981,8 +2044,13 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 
 	session = g_new(struct bcast_session, 1);
 	session->data_id = uuid;
+	session->data_len = ssize;
 	session->owner = g_strdup(sender);
 	session->adapter = btd_adapter_ref(adapter);
+	session->data_type = EIR_SVC_DATA;
+
+	memcpy(session->data, sdata, ssize);
+
 	session->id = g_dbus_add_disconnect_watch(conn, sender,
 						bcast_session_exit, session,
 						NULL);
@@ -1990,11 +2058,30 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 	adapter->bcast_sessions = g_slist_prepend(adapter->bcast_sessions,
 								session);
 
+	err = mgmt_set_broadcaster(adapter->dev_id, FALSE);
+	if (err < 0)
+		goto failed;
+
+	send_advdata_blob(adapter, session);
+
+	err = mgmt_set_broadcaster(adapter->dev_id, TRUE);
+	if (err < 0)
+		goto failed;
+
 	DBG("Service Data Broadcaster registered for hci%d at %s",
 						adapter->dev_id, sender);
 
 done:
 	return dbus_message_new_method_return(msg);
+
+failed:
+	error("Failed to set Broadcaster: %s (%d)", strerror(-err), -err);
+
+	adapter->bcast_sessions = g_slist_remove(adapter->bcast_sessions,
+								session);
+	free_bcast_session(session);
+
+	return btd_error_failed(msg, strerror(-err));
 }
 
 static DBusMessage *set_manufacturer_data(DBusConnection *conn,
@@ -2005,7 +2092,7 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 	const char *sender;
 	uint16_t company_id;
 	uint8_t *mdata;
-	int msize;
+	int msize, err;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &company_id,
 						DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
@@ -2013,6 +2100,12 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 						DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
+	/* It will accept new ADV/EIR data only if there is space for complete
+	 * data. Reserve 2 octets for Company Identifier Code */
+	if (msize + sizeof(uint16_t) > EIR_DATA_MAX_LEN)
+		return btd_error_failed(msg, "New ADV/EIR data is bigger than"
+								" permitted");
+
 	sender = dbus_message_get_sender(msg);
 
 	session = find_bcast_session(adapter->bcast_sessions, sender,
@@ -2024,8 +2117,13 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 
 	session = g_new(struct bcast_session, 1);
 	session->data_id = company_id;
+	session->data_len = msize;
 	session->owner = g_strdup(sender);
 	session->adapter = btd_adapter_ref(adapter);
+	session->data_type = EIR_MANUF_DATA;
+
+	memcpy(session->data, mdata, msize);
+
 	session->id = g_dbus_add_disconnect_watch(conn, sender,
 						bcast_session_exit, session,
 						NULL);
@@ -2033,11 +2131,30 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 	adapter->bcast_sessions = g_slist_prepend(adapter->bcast_sessions,
 								session);
 
+	err = mgmt_set_broadcaster(adapter->dev_id, FALSE);
+	if (err < 0)
+		goto failed;
+
+	send_advdata_blob(adapter, session);
+
+	err = mgmt_set_broadcaster(adapter->dev_id, TRUE);
+	if (err < 0)
+		goto failed;
+
 	DBG("Manufacturer Specific Data Broadcaster registered for hci%d at %s",
 						adapter->dev_id, sender);
 
 done:
 	return dbus_message_new_method_return(msg);
+
+failed:
+	error("Failed to set Broadcaster: %s (%d)", strerror(-err), -err);
+
+	adapter->bcast_sessions = g_slist_remove(adapter->bcast_sessions,
+								session);
+	free_bcast_session(session);
+
+	return btd_error_failed(msg, strerror(-err));
 }
 
 static DBusMessage *clear_broadcast_data(DBusConnection *conn,
-- 
1.7.9.5

