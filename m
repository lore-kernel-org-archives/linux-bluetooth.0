Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] device: Don't use device_get_adapter to access device adapter
Date: Fri, 5 Oct 2012 14:54:35 +0200
Message-ID: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use struct btd_device directly to access adapter member.

---
 src/device.c |   34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1c65b68..b2285dd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1451,15 +1451,15 @@ add_uuids:
 
 static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 {
-	struct btd_adapter *adapter = device_get_adapter(device);
 	char srcaddr[18], dstaddr[18];
 	sdp_list_t *records;
 	GSList *l, *next;
 
-	ba2str(adapter_get_address(adapter), srcaddr);
+	ba2str(adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
-	records = read_records(adapter_get_address(adapter), &device->bdaddr);
+	records = read_records(adapter_get_address(device->adapter),
+							&device->bdaddr);
 
 	DBG("Removing profiles for %s", dstaddr);
 
@@ -1527,12 +1527,11 @@ static int rec_cmp(const void *a, const void *b)
 static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 {
 	struct btd_device *device = req->device;
-	struct btd_adapter *adapter = device_get_adapter(device);
 	sdp_list_t *seq;
 	char srcaddr[18], dstaddr[18];
 	uint8_t dst_type;
 
-	ba2str(adapter_get_address(adapter), srcaddr);
+	ba2str(adapter_get_address(device->adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	for (seq = recs; seq; seq = seq->next) {
@@ -1933,7 +1932,7 @@ static gboolean attrib_disconnected_cb(GIOChannel *io, GIOCondition cond,
 	 * initiated disconnection.
 	 */
 	if (err == ETIMEDOUT || err == ECONNRESET || err == ECONNABORTED)
-		adapter_connect_list_add(device_get_adapter(device), device);
+		adapter_connect_list_add(device->adapter, device);
 
 done:
 	attio_cleanup(device);
@@ -2083,7 +2082,7 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
 	if (device->auto_connect == FALSE)
 		return;
 
-	adapter_connect_list_add(device_get_adapter(device), device);
+	adapter_connect_list_add(device->adapter, device);
 	DBG("Enabling automatic connections");
 }
 
@@ -2367,7 +2366,7 @@ void device_set_temporary(struct btd_device *device, gboolean temporary)
 	DBG("temporary %d", temporary);
 
 	if (temporary)
-		adapter_connect_list_remove(device_get_adapter(device), device);
+		adapter_connect_list_remove(device->adapter, device);
 
 	device->temporary = temporary;
 }
@@ -2384,7 +2383,6 @@ void device_set_bonded(struct btd_device *device, gboolean bonded)
 
 void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
-	struct btd_adapter *adapter = device_get_adapter(device);
 	char addr[18];
 
 	if (!device)
@@ -2398,7 +2396,7 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 
 	/* Disabling auto connect */
 	if (enable == FALSE) {
-		adapter_connect_list_remove(adapter, device);
+		adapter_connect_list_remove(device->adapter, device);
 		return;
 	}
 
@@ -2411,7 +2409,7 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 		return;
 
 	/* Enabling auto connect */
-	adapter_connect_list_add(adapter, device);
+	adapter_connect_list_add(device->adapter, device);
 }
 
 static gboolean start_discovery(gpointer user_data)
@@ -2714,8 +2712,7 @@ static void pincode_cb(struct agent *agent, DBusError *err,
 {
 	struct authentication_req *auth = data;
 	struct btd_device *device = auth->device;
-	struct btd_adapter *adapter = device_get_adapter(device);
-	struct agent *adapter_agent = adapter_get_agent(adapter);
+	struct agent *adapter_agent = adapter_get_agent(device->adapter);
 
 	if (err && (g_str_equal(DBUS_ERROR_UNKNOWN_METHOD, err->name) ||
 				g_str_equal(DBUS_ERROR_NO_REPLY, err->name))) {
@@ -2746,8 +2743,7 @@ static void confirm_cb(struct agent *agent, DBusError *err, void *data)
 {
 	struct authentication_req *auth = data;
 	struct btd_device *device = auth->device;
-	struct btd_adapter *adapter = device_get_adapter(device);
-	struct agent *adapter_agent = adapter_get_agent(adapter);
+	struct agent *adapter_agent = adapter_get_agent(device->adapter);
 
 	if (err && (g_str_equal(DBUS_ERROR_UNKNOWN_METHOD, err->name) ||
 				g_str_equal(DBUS_ERROR_NO_REPLY, err->name))) {
@@ -2780,8 +2776,7 @@ static void passkey_cb(struct agent *agent, DBusError *err,
 {
 	struct authentication_req *auth = data;
 	struct btd_device *device = auth->device;
-	struct btd_adapter *adapter = device_get_adapter(device);
-	struct agent *adapter_agent = adapter_get_agent(adapter);
+	struct agent *adapter_agent = adapter_get_agent(device->adapter);
 
 	if (err && (g_str_equal(DBUS_ERROR_UNKNOWN_METHOD, err->name) ||
 				g_str_equal(DBUS_ERROR_NO_REPLY, err->name))) {
@@ -2812,8 +2807,7 @@ static void display_pincode_cb(struct agent *agent, DBusError *err, void *data)
 {
 	struct authentication_req *auth = data;
 	struct btd_device *device = auth->device;
-	struct btd_adapter *adapter = device_get_adapter(device);
-	struct agent *adapter_agent = adapter_get_agent(adapter);
+	struct agent *adapter_agent = adapter_get_agent(device->adapter);
 
 	if (err && (g_str_equal(DBUS_ERROR_UNKNOWN_METHOD, err->name) ||
 				g_str_equal(DBUS_ERROR_NO_REPLY, err->name))) {
@@ -3235,7 +3229,7 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 
 	device->attios = g_slist_append(device->attios, attio);
 
-	adapter_connect_list_add(device_get_adapter(device), device);
+	adapter_connect_list_add(device->adapter, device);
 
 	return attio->id;
 }
-- 
1.7.9.5

