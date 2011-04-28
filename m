Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 2/2] Add support of secure pin code in mgmt code
Date: Thu, 28 Apr 2011 12:50:47 +0200
Message-ID: <1303987847-6878-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
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
 plugins/hciops.c  |    5 ++++-
 plugins/mgmtops.c |    2 +-
 src/agent.c       |   10 ++++++++--
 src/device.c      |   17 +++++++++++++++++
 src/device.h      |    2 ++
 src/event.c       |   17 +++++++++++++++--
 src/event.h       |    2 +-
 7 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 2b9be3f..a9296be 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1244,6 +1244,7 @@ static void pin_code_request(int index, bdaddr_t *dba)
 	struct bt_conn *conn;
 	char addr[18];
 	int err;
+	uint8_t secure = 0;
 
 	ba2str(dba, addr);
 	DBG("hci%d PIN request for %s", index, addr);
@@ -1259,7 +1260,9 @@ static void pin_code_request(int index, bdaddr_t *dba)
 		goto reject;
 	}
 
-	err = btd_event_request_pin(&dev->bdaddr, dba);
+	/*TODO check if we need secure pin */
+
+	err = btd_event_request_pin(&dev->bdaddr, dba, secure);
 	if (err < 0) {
 		error("PIN code negative reply: %s", strerror(-err));
 		goto reject;
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index bb53e82..869ffd2 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -565,7 +565,7 @@ static void mgmt_pin_code_request(int sk, uint16_t index, void *buf, size_t len)
 
 	info = &controllers[index];
 
-	err = btd_event_request_pin(&info->bdaddr, &ev->bdaddr);
+	err = btd_event_request_pin(&info->bdaddr, &ev->bdaddr, ev->secure);
 	if (err < 0) {
 		error("btd_event_request_pin: %s", strerror(-err));
 		mgmt_pincode_reply(index, &ev->bdaddr, NULL);
diff --git a/src/agent.c b/src/agent.c
index f87f253..d7b5f46 100644
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
index b0a6542..dc872ca 100644
--- a/src/device.c
+++ b/src/device.c
@@ -136,6 +136,8 @@ struct btd_device {
 	gboolean	paired;
 	gboolean	blocked;
 
+	uint8_t		secure_pin;
+
 	gboolean	authorizing;
 	gint		ref;
 };
@@ -1776,6 +1778,21 @@ struct agent *device_get_agent(struct btd_device *device)
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
index d59b8eb..5e70379 100644
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
index 5373e33..d6185a6 100644
--- a/src/event.c
+++ b/src/event.c
@@ -106,6 +106,8 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	bdaddr_t dba;
+	size_t pin_len;
+	uint8_t secure;
 	int err;
 
 	device_get_address(device, &dba);
@@ -117,6 +119,15 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 		return;
 	}
 
+	pin_len = strlen(pincode);
+	secure  = device_get_secure_pin(device);
+
+	if (secure && pin_len != 16) {
+		err = btd_adapter_pincode_reply(adapter, &dba, NULL);
+		if (err < 0)
+			goto fail;
+	}
+
 	err = btd_adapter_pincode_reply(adapter, &dba, pincode);
 	if (err < 0)
 		goto fail;
@@ -127,7 +138,7 @@ fail:
 	error("Sending PIN code reply failed: %s (%d)", strerror(-err), -err);
 }
 
-int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
+int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, uint8_t secure)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
@@ -139,11 +150,13 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
 
 	memset(pin, 0, sizeof(pin));
 	pinlen = read_pin_code(sba, dba, pin);
-	if (pinlen > 0) {
+	if (pinlen > 0 && (secure && pinlen == 16)) {
 		btd_adapter_pincode_reply(adapter, dba, pin);
 		return 0;
 	}
 
+	device_set_secure_pin(device, secure);
+
 	return device_request_authentication(device, AUTH_TYPE_PINCODE, 0,
 								pincode_cb);
 }
diff --git a/src/event.h b/src/event.h
index 765390a..865da63 100644
--- a/src/event.h
+++ b/src/event.h
@@ -22,7 +22,7 @@
  *
  */
 
-int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba);
+int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, uint8_t secure);
 void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info);
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 						int8_t rssi, uint8_t *data);
-- 
1.7.1

