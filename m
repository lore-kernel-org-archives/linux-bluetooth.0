Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 22/25] broadcaster: Build and send ADV/EIR data blob to kernel
Date: Fri, 21 Dec 2012 16:26:49 -0400
Message-Id: <1356121612-15172-23-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SetServiceData() and SetManufacturerData() operations will save all data
and send the ADV/EIR data to kernel. The new ADV/EIR data will be added
to the current one.

Note: For now, the maximum ADV/EIR data length is limited to 27
(HCI_LE_MAX_ADV_DATA_LENGTH - 4) octets. This is needed to reserve 2
octets for length and data type and more 2 octets for UUID/CompanyID. If
the ADV/EIR data from new broadcaster session tries to insert more
octets than 27 bytes the operation will fail.
---
 src/adapter.c |  130 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 119 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7e0f2b5..45471dc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -92,6 +92,9 @@ static const char *base_path = "/org/bluez";
 #define FILTER_SERVICE_UUID	0x01
 #define FILTER_COMPANY_IC	0x02
 
+/* Flags for Broadcaster */
+#define BCAST_DATA_NORMAL_PRIORITY	0x00
+
 static GSList *adapter_drivers = NULL;
 
 enum session_req_type {
@@ -601,6 +604,31 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 
 void adapter_set_controller_data_complete(struct btd_adapter *adapter)
 {
+	struct bcast_session *session = adapter->bcast_sessions->data;
+	DBusMessage *msg = session->msg;
+	DBusMessage *reply;
+	int err;
+
+	if (!adapter->bcast_sessions)
+		error("No Broadcaster session running");
+
+	err = mgmt_set_broadcaster(adapter->dev_id, TRUE);
+	if (err < 0) {
+		error("Failed to set Broadcaster: %s (%d)", strerror(-err),
+									-err);
+		reply = btd_error_failed(msg, strerror(-err));
+	} else
+		reply = dbus_message_new_method_return(msg);
+
+
+	if (session->data_type == EIR_SVC_DATA)
+		DBG("Service Data Broadcaster registered for hci%d at %s",
+					adapter->dev_id, session->owner);
+	else
+		DBG("Manufacturer Data Broadcaster registered for hci%d at %s",
+					adapter->dev_id, session->owner);
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 int adapter_set_name(struct btd_adapter *adapter, const char *name)
@@ -1471,6 +1499,53 @@ static struct bcast_session *find_bcast_session(GSList *list,
 	return l ? l->data : NULL;
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
+	if (!adapter->bcast_sessions) {
+		err = mgmt_set_broadcaster(adapter->dev_id, FALSE);
+		if (err < 0)
+			error("Failed to set Broadcaster: %s (%d)",
+							strerror(-err), -err);
+	}
+}
+
 static void bcast_session_exit(DBusConnection *conn, void *user_data)
 {
 	struct bcast_session *session = user_data;
@@ -1486,10 +1561,10 @@ static void bcast_session_exit(DBusConnection *conn, void *user_data)
 
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
@@ -1499,6 +1574,21 @@ static void update_adv_data(struct btd_adapter *adapter,
 
 void adapter_set_controller_data_failed(struct btd_adapter *adapter)
 {
+	struct bcast_session *session = adapter->bcast_sessions->data;
+	DBusMessage *msg = session->msg;
+	DBusMessage *reply;
+
+	DBG("Manufacturer Specific Data Broadcaster failed for hci%d at %s",
+					adapter->dev_id, session->owner);
+
+	reply = btd_error_failed(msg,
+				"Broadcaster: No resources, data too long");
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	adapter->bcast_sessions = g_slist_remove(adapter->bcast_sessions,
+								session);
+
+	free_bcast_session(session);
 }
 
 static DBusMessage *set_service_data(DBusConnection *conn,
@@ -1517,6 +1607,12 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 						DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
+	/* It will accept new ADV/EIR data only if there is space for complete
+	 * data. Reserve 2 octets for Service UUID */
+	if (ssize + sizeof(uint16_t) > EIR_DATA_MAX_LEN)
+		return btd_error_failed(msg,
+				"ADV/EIR data is bigger than permitted");
+
 	sender = dbus_message_get_sender(msg);
 
 	session = find_bcast_session(adapter->bcast_sessions, sender,
@@ -1528,22 +1624,25 @@ static DBusMessage *set_service_data(DBusConnection *conn,
 
 	session = g_new(struct bcast_session, 1);
 	session->data_id = uuid;
+	session->data_len = ssize;
 	session->owner = g_strdup(sender);
 	session->adapter = btd_adapter_ref(adapter);
 	session->data_type = EIR_SVC_DATA;
 	session->msg = dbus_message_ref(msg);
+
+	memcpy(session->data, sdata, ssize);
+
 	session->id = g_dbus_add_disconnect_watch(conn, sender,
 						bcast_session_exit, session,
 						NULL);
 
+	send_advdata_blob(adapter, session);
+
 	adapter->bcast_sessions = g_slist_prepend(adapter->bcast_sessions,
 								session);
 
-	DBG("Service Data Broadcaster registered for hci%d at %s",
-						adapter->dev_id, sender);
-
 done:
-	return dbus_message_new_method_return(msg);
+	return NULL;
 }
 
 static DBusMessage *set_manufacturer_data(DBusConnection *conn,
@@ -1562,6 +1661,12 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 						DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
+	/* It will accept new ADV/EIR data only if there is space for complete
+	 * data. Reserve 2 octets for Company Identifier Code */
+	if (msize + sizeof(uint16_t) > EIR_DATA_MAX_LEN)
+		return btd_error_failed(msg,
+				"ADV/EIR data is bigger than permitted");
+
 	sender = dbus_message_get_sender(msg);
 
 	session = find_bcast_session(adapter->bcast_sessions, sender,
@@ -1573,22 +1678,25 @@ static DBusMessage *set_manufacturer_data(DBusConnection *conn,
 
 	session = g_new(struct bcast_session, 1);
 	session->data_id = company_id;
+	session->data_len = msize;
 	session->owner = g_strdup(sender);
 	session->adapter = btd_adapter_ref(adapter);
 	session->data_type = EIR_MANUF_DATA;
 	session->msg = dbus_message_ref(msg);
+
+	memcpy(session->data, mdata, msize);
+
 	session->id = g_dbus_add_disconnect_watch(conn, sender,
 						bcast_session_exit, session,
 						NULL);
 
+	send_advdata_blob(adapter, session);
+
 	adapter->bcast_sessions = g_slist_prepend(adapter->bcast_sessions,
 								session);
 
-	DBG("Manufacturer Specific Data Broadcaster registered for hci%d at %s",
-						adapter->dev_id, sender);
-
 done:
-	return dbus_message_new_method_return(msg);
+	return NULL;
 }
 
 static DBusMessage *clear_broadcast_data(DBusConnection *conn,
-- 
1.7.9.5

