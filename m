Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCH 1/2] plugin: add bonding complete and cancel callbacks with optional retry
Date: Fri, 20 Jan 2012 17:59:56 -0800
Message-Id: <1327111197-11446-2-git-send-email-scott@netsplit.com>
In-Reply-To: <1327111197-11446-1-git-send-email-scott@netsplit.com>
References: <1327111197-11446-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow plugins to register a device-level bonding complete callback
which, if it returns TRUE, specifies that a failed bonding attempt
should be retried after a short backoff period.

Since these will likely store state, require them to register a
bonding cancelled callback at the same time so they can clean up.
---
 src/adapter.c |    2 +-
 src/device.c  |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |   12 ++++++++
 3 files changed, 99 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a75a0c4..d489e50 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2975,7 +2975,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 	if (device_is_authenticating(device))
 		device_cancel_authentication(device, TRUE);
 
-	if (device_is_temporary(device)) {
+	if (device_is_temporary(device) && !device_is_retrying(device)) {
 		const char *path = device_get_path(device);
 
 		DBG("Removing temporary device %s", path);
diff --git a/src/device.c b/src/device.c
index 16855b1..50dfe8c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -86,6 +86,7 @@ struct bonding_req {
 	GIOChannel *io;
 	guint listener_id;
 	struct btd_device *device;
+	uint8_t capability;
 };
 
 struct authentication_req {
@@ -149,6 +150,10 @@ struct btd_device {
 	guint		auto_id;		/* Auto connect source id */
 
 	gboolean	connected;
+	GSList          *bonding_callbacks;
+	GSList          *bonding_cancel_callbacks;
+	uint8_t         bonding_retry_status;
+	guint           bonding_retry_timer;
 
 	sdp_list_t	*tmp_records;
 
@@ -232,6 +237,9 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 
+	g_slist_free(device->bonding_callbacks);
+	g_slist_free(device->bonding_cancel_callbacks);
+
 	g_attrib_unref(device->attrib);
 
 	if (device->tmp_records)
@@ -247,6 +255,9 @@ static void device_free(gpointer user_data)
 	if (device->auto_id)
 		g_source_remove(device->auto_id);
 
+	if (device->bonding_retry_timer)
+		g_source_remove(device->bonding_retry_timer);
+
 	DBG("%p", device);
 
 	g_free(device->authr);
@@ -2340,6 +2351,65 @@ static void device_auth_req_free(struct btd_device *device)
 	device->authr = NULL;
 }
 
+void btd_device_register_bonding_cb(struct btd_device *device,
+					btd_device_bonding_cb_t cb,
+					btd_device_bonding_cancel_cb_t ccb) {
+	device->bonding_callbacks = g_slist_prepend(
+					device->bonding_callbacks, cb);
+	device->bonding_cancel_callbacks = g_slist_prepend(
+					device->bonding_cancel_callbacks, ccb);
+}
+
+void btd_device_unregister_bonding_cb(struct btd_device *device,
+					btd_device_bonding_cb_t cb,
+					btd_device_bonding_cancel_cb_t ccb) {
+	device->bonding_callbacks = g_slist_remove(
+					device->bonding_callbacks, cb);
+	device->bonding_cancel_callbacks = g_slist_remove(
+					device->bonding_cancel_callbacks, ccb);
+}
+
+static gboolean device_bonding_retry(gpointer data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bonding_req *bonding = device->bonding;
+	int err;
+
+	DBG("retrying");
+	err = adapter_create_bonding(adapter, &device->bdaddr,
+							bonding->capability);
+	if (err < 0) {
+		DBG("retry failed");
+		device_bonding_complete(device, device->bonding_retry_status);
+	}
+
+	return FALSE;
+}
+
+static gboolean device_bonding_get_retry(struct btd_device *device,
+								uint8_t status)
+{
+	GSList *l;
+	btd_device_bonding_cb_t cb;
+	gboolean retry = FALSE;
+
+	for (l = device->bonding_callbacks; l != NULL; l = g_slist_next(l)) {
+		cb = l->data;
+		retry |= cb(device, status);
+	}
+
+	g_slist_free(device->bonding_callbacks);
+	device->bonding_callbacks = NULL;
+
+	return retry;
+}
+
+gboolean device_is_retrying(struct btd_device *device)
+{
+	return device->bonding_retry_timer != 0;
+}
+
 void device_bonding_complete(struct btd_device *device, uint8_t status)
 {
 	struct bonding_req *bonding = device->bonding;
@@ -2347,6 +2417,14 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
+	if (device_bonding_get_retry(device, status) && status) {
+		DBG("retrying in 3s");
+		device->bonding_retry_status = status;
+		device->bonding_retry_timer = g_timeout_add(3000,
+						device_bonding_retry, device);
+		return;
+	}
+
 	if (auth && auth->type == AUTH_TYPE_NOTIFY && auth->agent)
 		agent_cancel(auth->agent);
 
@@ -2437,6 +2515,8 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 	struct bonding_req *bonding = device->bonding;
 	DBusMessage *reply;
 	char addr[18];
+	GSList *l;
+	btd_device_bonding_cancel_cb_t ccb;
 
 	if (!bonding)
 		return;
@@ -2444,6 +2524,12 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 	ba2str(&device->bdaddr, addr);
 	DBG("Canceling bonding request for %s", addr);
 
+	for (l = device->bonding_cancel_callbacks; l != NULL;
+							l = g_slist_next(l)) {
+		ccb = l->data;
+		ccb(device);
+	}
+
 	if (device->authr)
 		device_cancel_authentication(device, FALSE);
 
diff --git a/src/device.h b/src/device.h
index 13005ae..4f7fd53 100644
--- a/src/device.h
+++ b/src/device.h
@@ -73,6 +73,7 @@ void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_auto_connect(struct btd_device *device, gboolean enable);
 gboolean device_is_connected(struct btd_device *device);
+gboolean device_is_retrying(struct btd_device *device);
 DBusMessage *device_create_bonding(struct btd_device *device,
 				DBusConnection *conn, DBusMessage *msg,
 				const char *agent_path, uint8_t capability);
@@ -100,6 +101,17 @@ guint device_add_disconnect_watch(struct btd_device *device,
 void device_remove_disconnect_watch(struct btd_device *device, guint id);
 void device_set_class(struct btd_device *device, uint32_t value);
 
+typedef gboolean (*btd_device_bonding_cb_t) (struct btd_device *device,
+								uint8_t status);
+typedef void (*btd_device_bonding_cancel_cb_t) (struct btd_device *device);
+
+void btd_device_register_bonding_cb(struct btd_device *dev,
+				btd_device_bonding_cb_t cb,
+				btd_device_bonding_cancel_cb_t ccb);
+void btd_device_unregister_bonding_cb(struct btd_device *dev, 
+				btd_device_bonding_cb_t cb,
+				btd_device_bonding_cancel_cb_t ccb);
+
 #define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
 
 struct btd_device_driver {
-- 
1.7.7.3

