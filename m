Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/13] alert: Use ccc file from device storage
Date: Mon, 17 Dec 2012 16:09:43 +0100
Message-Id: <1355756994-18953-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |   69 +++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 3f7b37e..3736a0b 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -322,29 +322,41 @@ static void watcher_disconnect(DBusConnection *conn, void *user_data)
 	g_slist_foreach(alert_adapters, update_supported_categories, NULL);
 }
 
-static struct btd_device *get_notifiable_device(struct btd_adapter *adapter,
-						char *key, char *value,
-						uint16_t ccc)
+static gboolean is_notifiable_device(struct btd_device *device, uint16_t ccc)
 {
-	struct btd_device *device;
-	char addr[18];
-	uint16_t hnd, val;
-	uint8_t bdaddr_type;
+	char *filename;
+	GKeyFile *key_file;
+	char handle[6];
+	char *str;
+	uint16_t val;
+	gboolean result;
+
+	sprintf(handle, "%hu", ccc);
 
-	sscanf(key, "%17s#%hhu#%04hX", addr, &bdaddr_type, &hnd);
+	filename = btd_device_get_storage_path(device, "ccc");
 
-	if (hnd != ccc)
-		return NULL;
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	val = strtol(value, NULL, 16);
-	if (!(val & 0x0001))
-		return NULL;
+	str = g_key_file_get_string(key_file, handle, "Value", NULL);
+	if (!str) {
+		result = FALSE;
+		goto end;
+	}
+
+	val = strtol(str, NULL, 16);
+	if (!(val & 0x0001)) {
+		result = FALSE;
+		goto end;
+	}
 
-	device = adapter_find_device(adapter, addr);
-	if (device == NULL)
-		return NULL;
+	result = TRUE;
+end:
+	g_free(str);
+	g_free(filename);
+	g_key_file_free(key_file);
 
-	return btd_device_ref(device);
+	return result;
 }
 
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
@@ -392,40 +404,27 @@ end:
 	g_free(cb);
 }
 
-static void filter_devices_notify(char *key, char *value, void *user_data)
+static void filter_devices_notify(struct btd_device *device, void *user_data)
 {
 	struct notify_data *notify_data = user_data;
 	struct alert_adapter *al_adapter = notify_data->al_adapter;
 	enum notify_type type = notify_data->type;
-	struct btd_device *device;
 	struct notify_callback *cb;
 
-	device = get_notifiable_device(al_adapter->adapter, key, value,
-						al_adapter->hnd_ccc[type]);
-	if (device == NULL)
+	if (!is_notifiable_device(device, al_adapter->hnd_ccc[type]))
 		return;
 
 	cb = g_new0(struct notify_callback, 1);
 	cb->notify_data = notify_data;
-	cb->device = device;
+	cb->device = btd_device_ref(device);
 	cb->id = btd_device_add_attio_callback(device,
 						attio_connected_cb, NULL, cb);
 }
 
-static void create_filename(char *filename, struct btd_adapter *adapter)
-{
-	char srcaddr[18];
-
-	ba2str(adapter_get_address(adapter), srcaddr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "ccc");
-}
-
 static void notify_devices(struct alert_adapter *al_adapter,
 			enum notify_type type, uint8_t *value, size_t len)
 {
 	struct notify_data *notify_data;
-	char filename[PATH_MAX + 1];
 
 	notify_data = g_new0(struct notify_data, 1);
 	notify_data->al_adapter = al_adapter;
@@ -433,8 +432,8 @@ static void notify_devices(struct alert_adapter *al_adapter,
 	notify_data->value = g_memdup(value, len);
 	notify_data->len = len;
 
-	create_filename(filename, al_adapter->adapter);
-	textfile_foreach(filename, filter_devices_notify, notify_data);
+	btd_adapter_for_each_device(al_adapter->adapter, filter_devices_notify,
+					notify_data);
 }
 
 static void pasp_notification(enum notify_type type)
-- 
1.7.9.5

