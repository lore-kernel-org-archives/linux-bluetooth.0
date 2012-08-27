Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 22/33] observer: Add ServiceReceived() and ManufacturerReceived() D-Bus method
Date: Mon, 27 Aug 2012 13:03:14 -0400
Message-Id: <1346087005-24693-23-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an advertising matches with the filter registered in
RegisterServiceObserver() or RegisterManufacturerObserver(), the
respective data is sent to all observers registered with this filter
using ServiceReceived() or ManufacturerReceived(), respectively.
---
 src/adapter.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 3b8cbcd..cd0a1b4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -168,6 +168,11 @@ struct btd_adapter {
 	GSList *loaded_drivers;
 };
 
+struct broadcast_data {
+	struct eir_data *eir_data;
+	char peer_addr[18];
+};
+
 static void dev_info_free(void *data)
 {
 	struct remote_dev_info *dev = data;
@@ -3107,6 +3112,106 @@ static char *read_stored_data(bdaddr_t *local, bdaddr_t *peer,
 	return textfile_get(filename, key);
 }
 
+static void service_received(struct observer_watcher *obs, char *peer_addr,
+							struct svc_data *sdata)
+{
+	const char *paddr = peer_addr;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(obs->sender, obs->path,
+							"org.bluez.Observer",
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
+	g_dbus_send_message(connection, msg);
+}
+
+static void manufacturer_received(struct observer_watcher *obs,
+				char *peer_addr, struct manuf_data *mdata)
+{
+	const char *paddr = peer_addr;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(obs->sender, obs->path,
+							"org.bluez.Observer",
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
+	g_dbus_send_message(connection, msg);
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
+				bdaddr_t *bdaddr, struct eir_data *eir_data)
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
 					bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					int8_t rssi, uint8_t confirm_name,
@@ -3126,6 +3231,9 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
+	/* Send advertsing to observers */
+	adapter_broadcast_received(adapter, bdaddr, &eir_data);
+
 	dev_class = eir_data.dev_class[0] | (eir_data.dev_class[1] << 8) |
 						(eir_data.dev_class[2] << 16);
 	if (dev_class != 0)
-- 
1.7.9.5

