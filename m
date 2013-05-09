Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v5 1/8] core: Convert the pincode callback to an interable list.
Date: Wed,  8 May 2013 17:37:55 -0700
Message-Id: <1368059882-9986-2-git-send-email-deymo@chromium.org>
In-Reply-To: <1368059882-9986-1-git-send-email-deymo@chromium.org>
References: <1368059882-9986-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The current pincode callback list on the adapter keeps track of all the
pincode callbacks registered by a plugin for that adapter and calls each
one until one provides a pincode for the current bonding. This mechanism
forgets about what happened with previous bonding attempts and pushes the
status track to the plugin side.

This patch creates an iterator struct (struct pincb_iter) that keeps track
of the last function called and the number of times called. This will
allow to provide more information about the bonding status to the pincode
callback.
---
 src/adapter.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.h |  5 +++++
 src/device.c  | 14 ++++++++++++++
 src/device.h  |  1 +
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1252e74..b317d47 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -121,6 +121,12 @@ struct service_auth {
 	struct agent *agent;		/* NULL for queued auths */
 };
 
+struct btd_adapter_pin_cb_iter {
+	GSList *it;			/* current callback function */
+	unsigned int attempt;		/* numer of times it() was called */
+	/* When the iterator reaches the end, it is NULL and attempt is 0 */
+};
+
 struct btd_adapter {
 	int ref_count;
 
@@ -4755,22 +4761,50 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 		error("device_notify_passkey: %s", strerror(-err));
 }
 
-static ssize_t adapter_get_pin(struct btd_adapter *adapter,
-					struct btd_device *dev, char *pin_buf,
+struct btd_adapter_pin_cb_iter *btd_adapter_pin_cb_iter_new(
+						struct btd_adapter *adapter)
+{
+	struct btd_adapter_pin_cb_iter *iter =
+				g_new0(struct btd_adapter_pin_cb_iter, 1);
+
+	iter->it = adapter->pin_callbacks;
+	iter->attempt = 1;
+
+	return iter;
+}
+
+void btd_adapter_pin_cb_iter_free(struct btd_adapter_pin_cb_iter *iter)
+{
+	g_free(iter);
+}
+
+bool btd_adapter_pin_cb_iter_end(struct btd_adapter_pin_cb_iter *iter)
+{
+	return iter->it == NULL && iter->attempt == 0;
+}
+
+static ssize_t btd_adapter_pin_cb_iter_next(
+					struct btd_adapter_pin_cb_iter *iter,
+					struct btd_adapter *adapter,
+					struct btd_device *device,
+					char *pin_buf,
 					gboolean *display)
 {
 	btd_adapter_pin_cb_t cb;
 	ssize_t ret;
-	GSList *l;
 
-	for (l = adapter->pin_callbacks; l != NULL; l = g_slist_next(l)) {
-		cb = l->data;
-		ret = cb(adapter, dev, pin_buf, display);
+	while (iter->it != NULL) {
+		cb = iter->it->data;
+		ret = cb(adapter, device, pin_buf, display);
+		iter->attempt++;
 		if (ret > 0)
 			return ret;
+		iter->attempt = 1;
+		iter->it = g_slist_next(iter->it);
 	}
+	iter->attempt = 0;
 
-	return -1;
+	return 0;
 }
 
 static void pin_code_request_callback(uint16_t index, uint16_t length,
@@ -4784,6 +4818,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	ssize_t pinlen;
 	char addr[18];
 	int err;
+	struct btd_adapter_pin_cb_iter *iter;
 
 	if (length < sizeof(*ev)) {
 		error("Too small PIN code request event");
@@ -4801,7 +4836,14 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	}
 
 	memset(pin, 0, sizeof(pin));
-	pinlen = adapter_get_pin(adapter, device, pin, &display);
+
+	iter = device_bonding_iter(device);
+	if (iter == NULL)
+		pinlen = 0;
+	else
+		pinlen = btd_adapter_pin_cb_iter_next(iter, adapter, device,
+								pin, &display);
+
 	if (pinlen > 0 && (!ev->secure || pinlen == 16)) {
 		if (display && device_is_bonding(device, NULL)) {
 			err = device_notify_pincode(device, ev->secure, pin);
diff --git a/src/adapter.h b/src/adapter.h
index 6b6515a..425a11f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -138,6 +138,11 @@ void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
 						btd_adapter_pin_cb_t cb);
 
+struct btd_adapter_pin_cb_iter *btd_adapter_pin_cb_iter_new(
+						struct btd_adapter *adapter);
+void btd_adapter_pin_cb_iter_free(struct btd_adapter_pin_cb_iter *iter);
+bool btd_adapter_pin_cb_iter_end(struct btd_adapter_pin_cb_iter *iter);
+
 /* If TRUE, enables fast connectabe, i.e. reduces page scan interval and changes
  * type. If FALSE, disables fast connectable, i.e. sets page scan interval and
  * type to default values. Valid for both connectable and discoverable modes. */
diff --git a/src/device.c b/src/device.c
index ff4c553..005acb3 100644
--- a/src/device.c
+++ b/src/device.c
@@ -87,6 +87,7 @@ struct bonding_req {
 	guint listener_id;
 	struct btd_device *device;
 	struct agent *agent;
+	struct btd_adapter_pin_cb_iter *cb_iter;
 };
 
 typedef enum {
@@ -1488,6 +1489,8 @@ static struct bonding_req *bonding_request_new(DBusMessage *msg,
 
 	bonding->msg = dbus_message_ref(msg);
 
+	bonding->cb_iter = btd_adapter_pin_cb_iter_new(device->adapter);
+
 	if (agent)
 		bonding->agent = agent_ref(agent);
 
@@ -1613,6 +1616,9 @@ static void bonding_request_free(struct bonding_req *bonding)
 	if (bonding->msg)
 		dbus_message_unref(bonding->msg);
 
+	if (bonding->cb_iter)
+		g_free(bonding->cb_iter);
+
 	if (bonding->agent) {
 		agent_cancel(bonding->agent);
 		agent_unref(bonding->agent);
@@ -3819,6 +3825,14 @@ void device_bonding_failed(struct btd_device *device, uint8_t status)
 	bonding_request_free(bonding);
 }
 
+struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *device)
+{
+	if (device->bonding == NULL)
+		return NULL;
+
+	return device->bonding->cb_iter;
+}
+
 static void pincode_cb(struct agent *agent, DBusError *err, const char *pin,
 								void *data)
 {
diff --git a/src/device.h b/src/device.h
index 7cd11af..0869e22 100644
--- a/src/device.h
+++ b/src/device.h
@@ -77,6 +77,7 @@ gboolean device_is_connected(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
+struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *device);
 int device_request_pincode(struct btd_device *device, gboolean secure);
 int device_request_passkey(struct btd_device *device);
 int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-- 
1.8.2.1
