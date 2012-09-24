Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 22/25] alert: Add support for ringer setting notification
Date: Mon, 24 Sep 2012 14:00:58 -0400
Message-Id: <1348509661-15967-23-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

When the agent reports a ringer setting change, a ringer setting
notification is sent to the peer device (if notification is enabled).
---
 profiles/alert/server.c |  156 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 2 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 58d7c5f..d14f98e 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -31,6 +31,7 @@
 #include <gdbus.h>
 #include <glib.h>
 #include <bluetooth/uuid.h>
+#include <stdlib.h>
 
 #include "dbus-common.h"
 #include "att.h"
@@ -45,6 +46,8 @@
 #include "server.h"
 #include "profile.h"
 #include "error.h"
+#include "textfile.h"
+#include "attio.h"
 
 #define PHONE_ALERT_STATUS_SVC_UUID		0x180E
 #define ALERT_NOTIF_SVC_UUID			0x1811
@@ -89,6 +92,11 @@ enum {
 	RINGER_NORMAL,
 };
 
+enum notify_type {
+	NOTIFY_RINGER_SETTING = 0,
+	NOTIFY_SIZE,
+};
+
 struct alert_data {
 	const char *category;
 	char *srv;
@@ -102,6 +110,21 @@ struct alert_adapter {
 	uint16_t supp_unread_alert_cat_handle;
 	uint16_t new_alert_handle;
 	uint16_t unread_alert_handle;
+	uint16_t hnd_ccc[NOTIFY_SIZE];
+	uint16_t hnd_value[NOTIFY_SIZE];
+};
+
+struct notify_data {
+	struct alert_adapter *al_adapter;
+	enum notify_type type;
+	uint8_t *value;
+	size_t len;
+};
+
+struct notify_callback {
+	struct notify_data *notify_data;
+	struct btd_device *device;
+	guint id;
 };
 
 static GSList *registered_alerts = NULL;
@@ -282,6 +305,125 @@ static void watcher_disconnect(DBusConnection *conn, void *user_data)
 	g_slist_foreach(alert_adapters, update_supported_categories, NULL);
 }
 
+static struct btd_device *get_notifiable_device(struct btd_adapter *adapter,
+						char *key, char *value,
+						uint16_t ccc)
+{
+	struct btd_device *device;
+	char addr[18];
+	uint16_t hnd, val;
+	uint8_t bdaddr_type;
+
+	sscanf(key, "%17s#%hhu#%04hX", addr, &bdaddr_type, &hnd);
+
+	if (hnd != ccc)
+		return NULL;
+
+	val = strtol(value, NULL, 16);
+	if (!(val & 0x0001))
+		return NULL;
+
+	device = adapter_find_device(adapter, addr);
+	if (device == NULL)
+		return NULL;
+
+	return btd_device_ref(device);
+}
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct notify_callback *cb = user_data;
+	struct notify_data *nd = cb->notify_data;
+	enum notify_type type = nd->type;
+	struct alert_adapter *al_adapter = nd->al_adapter;
+	uint8_t pdu[ATT_MAX_MTU];
+	size_t len = 0;
+
+	switch (type) {
+	case NOTIFY_RINGER_SETTING:
+		len = enc_notification(al_adapter->hnd_value[type],
+				&ringer_setting, sizeof(ringer_setting),
+				pdu, sizeof(pdu));
+		break;
+	default:
+		DBG("Unknown type, could not send notification");
+		goto end;
+	}
+
+	DBG("Send notification for handle: 0x%04x, ccc: 0x%04x",
+					al_adapter->hnd_value[type],
+					al_adapter->hnd_ccc[type]);
+
+	g_attrib_send(attrib, 0, ATT_OP_HANDLE_NOTIFY, pdu, len,
+							NULL, NULL, NULL);
+
+end:
+	btd_device_remove_attio_callback(cb->device, cb->id);
+	btd_device_unref(cb->device);
+	g_free(cb->notify_data->value);
+	g_free(cb->notify_data);
+	g_free(cb);
+}
+
+static void filter_devices_notify(char *key, char *value, void *user_data)
+{
+	struct notify_data *notify_data = user_data;
+	struct alert_adapter *al_adapter = notify_data->al_adapter;
+	enum notify_type type = notify_data->type;
+	struct btd_device *device;
+	struct notify_callback *cb;
+
+	device = get_notifiable_device(al_adapter->adapter, key, value,
+						al_adapter->hnd_ccc[type]);
+	if (device == NULL)
+		return;
+
+	cb = g_new0(struct notify_callback, 1);
+	cb->notify_data = notify_data;
+	cb->device = device;
+	cb->id = btd_device_add_attio_callback(device,
+						attio_connected_cb, NULL, cb);
+}
+
+static void create_filename(char *filename, struct btd_adapter *adapter)
+{
+	char srcaddr[18];
+	bdaddr_t src;
+
+	adapter_get_address(adapter, &src);
+	ba2str(&src, srcaddr);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "ccc");
+}
+
+static void notify_devices(struct alert_adapter *al_adapter,
+			enum notify_type type, uint8_t *value, size_t len)
+{
+	struct notify_data *notify_data;
+	char filename[PATH_MAX + 1];
+
+	notify_data = g_new0(struct notify_data, 1);
+	notify_data->al_adapter = al_adapter;
+	notify_data->type = type;
+	notify_data->value = g_memdup(value, len);
+	notify_data->len = len;
+
+	create_filename(filename, al_adapter->adapter);
+	textfile_foreach(filename, filter_devices_notify, notify_data);
+}
+
+static void pasp_notification(enum notify_type type)
+{
+	GSList *it;
+	struct alert_adapter *al_adapter;
+
+	for (it = alert_adapters; it; it = g_slist_next(it)) {
+		al_adapter = it->data;
+
+		notify_devices(al_adapter, type, NULL, 0);
+	}
+}
+
 static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -344,10 +486,15 @@ static void update_phone_alerts(const char *category, const char *description)
 	unsigned int i;
 
 	if (g_str_equal(category, "ringer")) {
-		if (g_str_equal(description, "enabled"))
+		if (g_str_equal(description, "enabled")) {
 			ringer_setting = RINGER_NORMAL;
-		else if (g_str_equal(description, "disabled"))
+			pasp_notification(NOTIFY_RINGER_SETTING);
+			return;
+		} else if (g_str_equal(description, "disabled")) {
 			ringer_setting = RINGER_SILENT;
+			pasp_notification(NOTIFY_RINGER_SETTING);
+			return;
+		}
 	}
 
 	for (i = 0; i < G_N_ELEMENTS(pasp_categories); i++) {
@@ -619,6 +766,10 @@ static void register_phone_alert_service(struct alert_adapter *al_adapter)
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			ringer_setting_read, al_adapter->adapter,
+			GATT_OPT_CCC_GET_HANDLE,
+			&al_adapter->hnd_ccc[NOTIFY_RINGER_SETTING],
+			GATT_OPT_CHR_VALUE_GET_HANDLE,
+			&al_adapter->hnd_value[NOTIFY_RINGER_SETTING],
 			GATT_OPT_INVALID);
 }
 
@@ -751,6 +902,7 @@ static void alert_server_remove(struct btd_adapter *adapter)
 
 	alert_adapters = g_slist_remove(alert_adapters, al_adapter);
 	btd_adapter_unref(al_adapter->adapter);
+
 	g_free(al_adapter);
 }
 
-- 
1.7.9.5

