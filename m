Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v3 1/8] core: Convert the pincode callback to an interable list.
Date: Tue, 23 Apr 2013 11:04:00 -0700
Message-Id: <1366740247-368-2-git-send-email-deymo@chromium.org>
In-Reply-To: <1366740247-368-1-git-send-email-deymo@chromium.org>
References: <1366740247-368-1-git-send-email-deymo@chromium.org>
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
 src/adapter.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.h |  4 ++++
 src/device.c  | 14 ++++++++++++++
 src/device.h  |  1 +
 4 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6255da6..4a6b882 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -121,6 +121,12 @@ struct service_auth {
 	struct agent *agent;		/* NULL for queued auths */
 };
 
+struct pincb_iter {
+	GSList *it;			/* current callback function */
+	uint32_t attempt;		/* numer of times it() was called */
+	/* When the iterator reaches the end, it is NULL and attempt is 0 */
+};
+
 struct btd_adapter {
 	int ref_count;
 
@@ -4769,22 +4775,47 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 		error("device_notify_passkey: %s", strerror(-err));
 }
 
-static ssize_t adapter_get_pin(struct btd_adapter *adapter,
-					struct btd_device *dev, char *pin_buf,
+struct pincb_iter *pincb_iter_new(struct btd_adapter *adapter)
+{
+	struct pincb_iter *iter = g_new0(struct pincb_iter, 1);
+
+	iter->it = adapter->pin_callbacks;
+	iter->attempt = 1;
+
+	return iter;
+}
+
+void pincb_iter_free(struct pincb_iter *iter)
+{
+	g_free(iter);
+}
+
+gboolean pincb_iter_end(struct pincb_iter *iter)
+{
+	return iter->it == NULL && iter->attempt == 0;
+}
+
+static ssize_t pincb_iter_next(struct pincb_iter *iter,
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
@@ -4798,6 +4829,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	ssize_t pinlen;
 	char addr[18];
 	int err;
+	struct pincb_iter *iter;
 
 	if (length < sizeof(*ev)) {
 		error("Too small PIN code request event");
@@ -4815,7 +4847,14 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	}
 
 	memset(pin, 0, sizeof(pin));
-	pinlen = adapter_get_pin(adapter, device, pin, &display);
+
+	iter = device_bonding_iter(device);
+
+	if (iter == NULL)
+		pinlen = 0;
+	else
+		pinlen = pincb_iter_next(iter, adapter, device, pin, &display);
+
 	if (pinlen > 0 && (!ev->secure || pinlen == 16)) {
 		if (display && device_is_bonding(device, NULL)) {
 			err = device_notify_pincode(device, ev->secure, pin);
diff --git a/src/adapter.h b/src/adapter.h
index 8d23a64..d158334 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -138,6 +138,10 @@ void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 void btd_adapter_unregister_pin_cb(struct btd_adapter *adapter,
 						btd_adapter_pin_cb_t cb);
 
+struct pincb_iter *pincb_iter_new(struct btd_adapter *adapter);
+void pincb_iter_free(struct pincb_iter *iter);
+gboolean pincb_iter_end(struct pincb_iter *iter);
+
 /* If TRUE, enables fast connectabe, i.e. reduces page scan interval and changes
  * type. If FALSE, disables fast connectable, i.e. sets page scan interval and
  * type to default values. Valid for both connectable and discoverable modes. */
diff --git a/src/device.c b/src/device.c
index ee17514..5686443 100644
--- a/src/device.c
+++ b/src/device.c
@@ -85,6 +85,7 @@ struct bonding_req {
 	guint listener_id;
 	struct btd_device *device;
 	struct agent *agent;
+	struct pincb_iter *cb_iter;
 };
 
 typedef enum {
@@ -1411,6 +1412,8 @@ static struct bonding_req *bonding_request_new(DBusMessage *msg,
 
 	bonding->msg = dbus_message_ref(msg);
 
+	bonding->cb_iter = pincb_iter_new(device->adapter);
+
 	if (agent)
 		bonding->agent = agent_ref(agent);
 
@@ -1536,6 +1539,9 @@ static void bonding_request_free(struct bonding_req *bonding)
 	if (bonding->msg)
 		dbus_message_unref(bonding->msg);
 
+	if (bonding->cb_iter)
+		g_free(bonding->cb_iter);
+
 	if (bonding->agent) {
 		agent_cancel(bonding->agent);
 		agent_unref(bonding->agent);
@@ -3740,6 +3746,14 @@ void device_bonding_failed(struct btd_device *device, uint8_t status)
 	bonding_request_free(bonding);
 }
 
+struct pincb_iter *device_bonding_iter(struct btd_device *device)
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
index d072015..725bd7a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -76,6 +76,7 @@ gboolean device_is_connected(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
 void device_bonding_failed(struct btd_device *device, uint8_t status);
+struct pincb_iter *device_bonding_iter(struct btd_device *device);
 int device_request_pincode(struct btd_device *device, gboolean secure);
 int device_request_passkey(struct btd_device *device);
 int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-- 
1.8.2.1
