Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3] Add support of secure pin code in mgmt code
Date: Wed, 1 Jun 2011 17:32:00 +0200
Message-ID: <1306942320-12400-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use secure pin code parameter received from the kernel in
MGMT_EV_PIN_CODE_REQUEST event and propagate this to agent
code.

Secure flag is specific for the pin code request only.
---
 plugins/hciops.c  |    2 +-
 plugins/mgmtops.c |    2 +-
 src/agent.c       |   11 +++++++----
 src/agent.h       |    4 ++--
 src/device.c      |    4 ++--
 src/device.h      |    2 +-
 src/event.c       |   14 +++++++-------
 src/event.h       |    2 +-
 8 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9b1225c..6ce0e27 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1344,7 +1344,7 @@ static void pin_code_request(int index, bdaddr_t *dba)
 		goto reject;
 	}
 
-	err = btd_event_request_pin(&dev->bdaddr, dba);
+	err = btd_event_request_pin(&dev->bdaddr, dba, FALSE);
 	if (err < 0) {
 		error("PIN code negative reply: %s", strerror(-err));
 		goto reject;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 95de3d1..4302813 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -563,7 +563,7 @@ static void mgmt_pin_code_request(int sk, uint16_t index, void *buf, size_t len)
 
 	info = &controllers[index];
 
-	err = btd_event_request_pin(&info->bdaddr, &ev->bdaddr);
+	err = btd_event_request_pin(&info->bdaddr, &ev->bdaddr, ev->secure);
 	if (err < 0) {
 		error("btd_event_request_pin: %s", strerror(-err));
 		mgmt_pincode_reply(index, &ev->bdaddr, NULL, 0);
diff --git a/src/agent.c b/src/agent.c
index f87f253..7bba849 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -424,10 +424,13 @@ done:
 }
 
 static int pincode_request_new(struct agent_request *req, const char *device_path,
-				dbus_bool_t numeric)
+				dbus_bool_t secure)
 {
 	struct agent *agent = req->agent;
 
+	/* TODO: Add a new method or a new param to Agent interface to request
+		secure pin. */
+
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
 					"org.bluez.Agent", "RequestPinCode");
 	if (req->msg == NULL) {
@@ -449,8 +452,8 @@ static int pincode_request_new(struct agent_request *req, const char *device_pat
 }
 
 int agent_request_pincode(struct agent *agent, struct btd_device *device,
-				agent_pincode_cb cb, void *user_data,
-				GDestroyNotify destroy)
+				agent_pincode_cb cb, gboolean secure,
+				void *user_data, GDestroyNotify destroy)
 {
 	struct agent_request *req;
 	const gchar *dev_path = device_get_path(device);
@@ -462,7 +465,7 @@ int agent_request_pincode(struct agent *agent, struct btd_device *device,
 	req = agent_request_new(agent, AGENT_REQUEST_PINCODE, cb,
 							user_data, destroy);
 
-	err = pincode_request_new(req, dev_path, FALSE);
+	err = pincode_request_new(req, dev_path, secure);
 	if (err < 0)
 		goto failed;
 
diff --git a/src/agent.h b/src/agent.h
index e184250..f62bf3b 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -46,8 +46,8 @@ int agent_authorize(struct agent *agent, const char *path,
 			GDestroyNotify destroy);
 
 int agent_request_pincode(struct agent *agent, struct btd_device *device,
-				agent_pincode_cb cb, void *user_data,
-				GDestroyNotify destroy);
+				agent_pincode_cb cb, gboolean secure,
+				void *user_data, GDestroyNotify destroy);
 
 int agent_confirm_mode_change(struct agent *agent, const char *new_mode,
 				agent_cb cb, void *user_data,
diff --git a/src/device.c b/src/device.c
index 4ffc124..770e89a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2214,7 +2214,7 @@ static void passkey_cb(struct agent *agent, DBusError *err,
 }
 
 int device_request_authentication(struct btd_device *device, auth_type_t type,
-						uint32_t passkey, void *cb)
+				uint32_t passkey, gboolean secure, void *cb)
 {
 	struct authentication_req *auth;
 	struct agent *agent;
@@ -2244,7 +2244,7 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 
 	switch (type) {
 	case AUTH_TYPE_PINCODE:
-		err = agent_request_pincode(agent, device, pincode_cb,
+		err = agent_request_pincode(agent, device, pincode_cb, secure,
 								auth, NULL);
 		break;
 	case AUTH_TYPE_PASSKEY:
diff --git a/src/device.h b/src/device.h
index ad7350a..bd8a431 100644
--- a/src/device.h
+++ b/src/device.h
@@ -83,7 +83,7 @@ gboolean device_is_creating(struct btd_device *device, const char *sender);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
 void device_cancel_bonding(struct btd_device *device, uint8_t status);
 int device_request_authentication(struct btd_device *device, auth_type_t type,
-				uint32_t passkey, void *cb);
+				uint32_t passkey, gboolean secure, void *cb);
 void device_cancel_authentication(struct btd_device *device, gboolean aborted);
 gboolean device_is_authenticating(struct btd_device *device);
 gboolean device_is_authorizing(struct btd_device *device);
diff --git a/src/event.c b/src/event.c
index 0b43884..1d35562 100644
--- a/src/event.c
+++ b/src/event.c
@@ -123,7 +123,7 @@ fail:
 	error("Sending PIN code reply failed: %s (%d)", strerror(-err), -err);
 }
 
-int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
+int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -135,13 +135,13 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
 
 	memset(pin, 0, sizeof(pin));
 	pinlen = read_pin_code(sba, dba, pin);
-	if (pinlen > 0) {
+	if (pinlen > 0 && (secure && pinlen == 16)) {
 		btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
 		return 0;
 	}
 
 	return device_request_authentication(device, AUTH_TYPE_PINCODE, 0,
-								pincode_cb);
+							secure, pincode_cb);
 }
 
 static int confirm_reply(struct btd_adapter *adapter,
@@ -187,7 +187,7 @@ int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 		return -ENODEV;
 
 	return device_request_authentication(device, AUTH_TYPE_CONFIRM,
-							passkey, confirm_cb);
+						passkey, FALSE, confirm_cb);
 }
 
 int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba)
@@ -199,7 +199,7 @@ int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba)
 		return -ENODEV;
 
 	return device_request_authentication(device, AUTH_TYPE_PASSKEY, 0,
-								passkey_cb);
+							FALSE, passkey_cb);
 }
 
 int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
@@ -210,8 +210,8 @@ int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
 		return -ENODEV;
 
-	return device_request_authentication(device, AUTH_TYPE_NOTIFY,
-								passkey, NULL);
+	return device_request_authentication(device, AUTH_TYPE_NOTIFY, passkey,
+								FALSE, NULL);
 }
 
 void btd_event_bonding_complete(bdaddr_t *local, bdaddr_t *peer,
diff --git a/src/event.h b/src/event.h
index 22c199e..1268edf 100644
--- a/src/event.h
+++ b/src/event.h
@@ -22,7 +22,7 @@
  *
  */
 
-int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba);
+int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 						int8_t rssi, uint8_t *data);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
-- 
1.7.4.1

