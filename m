Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 16/25] observer: Add Service/ManufacturerReceived() D-Bus method
Date: Fri, 21 Dec 2012 16:26:43 -0400
Message-Id: <1356121612-15172-17-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an advertising matches with the filter registered in
RegisterServiceObserver() or RegisterManufacturerObserver(), the data is
sent to all observers registered using ServiceReceived() or
ManufacturerReceived(), respectively.
---
 src/adapter.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 316acb9..4fc4fa9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -86,6 +86,8 @@
 
 static const char *base_path = "/org/bluez";
 
+#define OBSERVER_INTERFACE "org.bluez.Observer1"
+
 /* Filter Types (for Observer) */
 #define FILTER_SERVICE_UUID	0x01
 #define FILTER_COMPANY_IC	0x02
@@ -180,6 +182,11 @@ struct btd_adapter {
 
 static gboolean process_auth_queue(gpointer user_data);
 
+struct broadcast_data {
+	struct eir_data *eir_data;
+	char peer_addr[18];
+};
+
 int btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 							uint8_t minor)
 {
@@ -3179,6 +3186,106 @@ static gboolean connect_pending_cb(gpointer user_data)
 	return FALSE;
 }
 
+static void service_received(struct observer_watcher *obs, char *peer_addr,
+							struct svc_data *sdata)
+{
+	const char *paddr = peer_addr;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(obs->sender, obs->path,
+							OBSERVER_INTERFACE,
+							"ServiceReceived");
+	if (msg == NULL) {
+		error("Unable to allocate new ServiceReceived method");
+		return;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &paddr,
+						DBUS_TYPE_UINT16, &sdata->uuid,
+						DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+						&sdata->data, sdata->data_len,
+						DBUS_TYPE_INVALID);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+}
+
+static void manufacturer_received(struct observer_watcher *obs,
+				char *peer_addr, struct manuf_data *mdata)
+{
+	const char *paddr = peer_addr;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(obs->sender, obs->path,
+							OBSERVER_INTERFACE,
+							"ManufacturerReceived");
+	if (msg == NULL) {
+		error("Unable to allocate new ManufacturerReceived method");
+		return;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &paddr,
+					DBUS_TYPE_UINT16, &mdata->company_id,
+					DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+					&mdata->data, mdata->data_len,
+					DBUS_TYPE_INVALID);
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
+}
+
+static void update_observer(gpointer data, gpointer user_data)
+{
+	struct observer_watcher *obs = data;
+	struct broadcast_data *bdata = user_data;
+	struct eir_data *eir = bdata->eir_data;
+	GSList *l;
+
+	if (obs->filter_type == FILTER_SERVICE_UUID) {
+		for (l = eir->svcs_data; l != NULL; l = g_slist_next(l)) {
+			struct svc_data *sdata = l->data;
+			uint16_t uuid = GPOINTER_TO_UINT(obs->filter_data);
+
+			if (uuid == sdata->uuid)
+				service_received(obs, bdata->peer_addr, sdata);
+		}
+	} else if (obs->filter_type == FILTER_COMPANY_IC) {
+		for (l = eir->manufs_data; l != NULL; l = g_slist_next(l)) {
+			struct manuf_data *mdata = l->data;
+			uint16_t company_id =
+					GPOINTER_TO_UINT(obs->filter_data);
+
+			if (company_id == mdata->company_id)
+				manufacturer_received(obs, bdata->peer_addr,
+									mdata);
+		}
+	}
+}
+
+static void adapter_broadcast_received(struct btd_adapter *adapter,
+			const bdaddr_t *bdaddr, struct eir_data *eir_data)
+{
+	struct broadcast_data *bdata;
+
+	/* No observers listening for advertising */
+	if (adapter->observers == NULL)
+		return;
+
+	/* No service/manufacturer data was sent */
+	if (eir_data->svcs_data == NULL && eir_data->manufs_data == NULL)
+		return;
+
+	bdata = g_new(struct broadcast_data, 1);
+	bdata->eir_data = eir_data;
+	ba2str(bdaddr, bdata->peer_addr);
+
+	DBG("Broadcast received from %s", bdata->peer_addr);
+
+	g_slist_foreach(adapter->observers, update_observer, bdata);
+
+	g_free(bdata);
+}
+
 void adapter_update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
@@ -3192,7 +3299,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 	int err;
 	GSList *l;
 
-	if (!discovery) {
+	if (!discovery && !adapter->observers) {
 		error("Device found event while no discovery in progress");
 		return;
 	}
@@ -3204,6 +3311,14 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
+	/* Send advertising to observers */
+	adapter_broadcast_received(adapter, bdaddr, &eir_data);
+
+	if (!discovery) {
+		eir_data_free(&eir_data);
+		return;
+	}
+
 	if (eir_data.name != NULL && eir_data.name_complete)
 		adapter_store_cached_name(&adapter->bdaddr, bdaddr,
 								eir_data.name);
-- 
1.7.9.5

