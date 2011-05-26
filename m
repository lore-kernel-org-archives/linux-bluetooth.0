Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2] Add support of secure pin code in mgmt code
Date: Thu, 26 May 2011 11:15:15 +0200
Message-ID: <1306401315-10948-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use secure pin code parameter received from the kernel in
MGMT_EV_PIN_CODE_REQUEST event and propagate this to agent
code.

The secure flag is saved in the device structure not to change
common interface for all authentication types. Secure flag is
specific for the pin code request only.
---
 plugins/hciops.c  |    2 +-
 plugins/mgmtops.c |    2 +-
 src/agent.c       |   10 ++++++++--
 src/device.c      |   17 +++++++++++++++++
 src/device.h      |    2 ++
 src/event.c       |   16 +++++++++++++---
 src/event.h       |    2 +-
 7 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9b1225c..70c0919 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1344,7 +1344,7 @@ static void pin_code_request(int index, bdaddr_t *dba)
 		goto reject;
 	}
 
-	err = btd_event_request_pin(&dev->bdaddr, dba);
+	err = btd_event_request_pin(&dev->bdaddr, dba, 0);
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
index 40495bf..cca1463 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -424,10 +424,13 @@ done:
 }
 
 static int pincode_request_new(struct agent_request *req, const char *device_path,
-				dbus_bool_t numeric)
+				uint8_t secure)
 {
 	struct agent *agent = req->agent;
 
+	/* TODO: Add a new method or a new param to Agent interface to request
+		secure pin. */
+
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
 					"org.bluez.Agent", "RequestPinCode");
 	if (req->msg == NULL) {
@@ -455,14 +458,17 @@ int agent_request_pincode(struct agent *agent, struct btd_device *device,
 	struct agent_request *req;
 	const gchar *dev_path = device_get_path(device);
 	int err;
+	uint8_t secure;
 
 	if (agent->request)
 		return -EBUSY;
 
+	secure = device_get_secure_pin(device);
+
 	req = agent_request_new(agent, AGENT_REQUEST_PINCODE, cb,
 							user_data, destroy);
 
-	err = pincode_request_new(req, dev_path, FALSE);
+	err = pincode_request_new(req, dev_path, secure);
 	if (err < 0)
 		goto failed;
 
diff --git a/src/device.c b/src/device.c
index 4ffc124..f4fb5c7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -133,6 +133,8 @@ struct btd_device {
 	gboolean	paired;
 	gboolean	blocked;
 
+	uint8_t		secure_pin;
+
 	gboolean	authorizing;
 	gint		ref;
 };
@@ -1773,6 +1775,21 @@ struct agent *device_get_agent(struct btd_device *device)
 	return adapter_get_agent(device->adapter);
 }
 
+uint8_t device_get_secure_pin(struct btd_device *device)
+{
+	return device->secure_pin;
+}
+
+void device_set_secure_pin(struct btd_device *device, uint8_t secure)
+{
+	if (!device)
+		return;
+
+	DBG("secure pin %d", secure);
+
+	device->secure_pin = secure;
+}
+
 gboolean device_is_busy(struct btd_device *device)
 {
 	return device->browse ? TRUE : FALSE;
diff --git a/src/device.h b/src/device.h
index ad7350a..d3b159f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -65,6 +65,8 @@ struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr);
 const gchar *device_get_path(struct btd_device *device);
 struct agent *device_get_agent(struct btd_device *device);
+uint8_t device_get_secure_pin(struct btd_device *device);
+void device_set_secure_pin(struct btd_device *device, uint8_t secure);
 gboolean device_is_busy(struct btd_device *device);
 gboolean device_is_temporary(struct btd_device *device);
 gboolean device_is_paired(struct btd_device *device);
diff --git a/src/event.c b/src/event.c
index 6be7ea2..0f8243b 100644
--- a/src/event.c
+++ b/src/event.c
@@ -128,6 +128,7 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	bdaddr_t dba;
+	uint8_t secure;
 	int err;
 	size_t len;
 	char rawpin[16];
@@ -142,7 +143,14 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 		return;
 	}
 
-	err = btd_adapter_pincode_reply(adapter, &dba, rawpin, len);
+	secure  = device_get_secure_pin(device);
+	if (secure && len != 16) {
+		err = btd_adapter_pincode_reply(adapter, &dba, NULL, 0);
+		if (err < 0)
+			goto fail;
+	}
+
+	err = btd_adapter_pincode_reply(adapter, &dba, pincode, len);
 	if (err < 0)
 		goto fail;
 
@@ -152,7 +160,7 @@ fail:
 	error("Sending PIN code reply failed: %s (%d)", strerror(-err), -err);
 }
 
-int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
+int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, uint8_t secure)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -164,11 +172,13 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
 
 	memset(pin, 0, sizeof(pin));
 	pinlen = read_pin_code(sba, dba, pin);
-	if (pinlen > 0) {
+	if (pinlen > 0 && (secure && pinlen == 16)) {
 		btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
 		return 0;
 	}
 
+	device_set_secure_pin(device, secure);
+
 	return device_request_authentication(device, AUTH_TYPE_PINCODE, 0,
 								pincode_cb);
 }
diff --git a/src/event.h b/src/event.h
index 22c199e..14029ed 100644
--- a/src/event.h
+++ b/src/event.h
@@ -22,7 +22,7 @@
  *
  */
 
-int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba);
+int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, uint8_t secure);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 						int8_t rssi, uint8_t *data);
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer, gboolean legacy);
-- 
1.7.1

