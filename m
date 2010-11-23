Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv4 5/7] Add request for accepting incoming pairing requests with OOB mechanism
Date: Tue, 23 Nov 2010 11:53:10 +0100
Message-ID: <1290509592-9262-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/hciops.c |   41 ++++++++++++++++++++++++++++---------
 src/adapter.c    |    7 ++++++
 src/adapter.h    |    4 +++
 src/agent.c      |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/agent.h      |    3 ++
 src/device.c     |   22 ++++++++++++++++++++
 src/device.h     |    1 +
 src/event.c      |   36 ++++++++++++++++++++++++++++++++
 src/event.h      |    1 +
 9 files changed, 163 insertions(+), 11 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index c62ac51..e54f706 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -663,15 +663,8 @@ static void remote_oob_data_request(int index, void *ptr)
 	adapter = manager_find_adapter(&BDADDR(index));
 	device = adapter_find_device(adapter, da);
 
-	if (!device_get_oob_data(device, NULL, NULL) {
-		remote_oob_data_reply_cp cp;
-
-		bacpy(&cp.bdaddr, dba);
-		device_get_oob_data(device,cp.hash,cp.randomizer);
-
-		hci_send_cmd(SK(index), OGF_LINK_CTL, OCF_REMOTE_OOB_DATA_REPLY,
-				REMOTE_OOB_DATA_REPLY_CP_SIZE, &cp);
-	} else
+	if (!device_get_oob_data(device, NULL, NULL) ||
+				btd_event_user_pairing(&BDADDR(index), dba))
 		hci_send_cmd(SK(index),
 				OGF_LINK_CTL, OCF_REMOTE_OOB_DATA_NEG_REPLY, 6,
 				ptr);
@@ -2463,6 +2456,34 @@ static int hciops_passkey_reply(int index, bdaddr_t *bdaddr, uint32_t passkey)
 	return err;
 }
 
+static int hciops_pairing_reply(int index, struct btd_device *device,
+					gboolean approved)
+{
+	int err;
+
+	if (approved) {
+		remote_oob_data_reply_cp cp;
+
+		device_get_address(device, &cp.bdaddr);
+		device_get_oob_data(device,cp.hash,cp.randomizer);
+
+		err = hci_send_cmd(SK(index), OGF_LINK_CTL,
+					OCF_REMOTE_OOB_DATA_REPLY,
+					REMOTE_OOB_DATA_REPLY_CP_SIZE, &cp);
+	} else {
+		bdaddr_t bdaddr;
+
+		device_get_address(device, &bdaddr);
+		err = hci_send_cmd(SK(index), OGF_LINK_CTL,
+				OCF_REMOTE_OOB_DATA_NEG_REPLY, 6, &bdaddr);
+	}
+
+	if (err < 0)
+		err = -errno;
+
+	return err;
+}
+
 static int hciops_get_auth_info(int index, bdaddr_t *bdaddr, uint8_t *auth)
 {
 	struct hci_auth_info_req req;
@@ -2571,7 +2592,6 @@ static void hciops_io_capa_request_reply(int index, struct btd_device *device)
 					IO_CAPABILITY_REPLY_CP_SIZE, &cp);
 }
 
-
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -2607,6 +2627,7 @@ static struct btd_adapter_ops hci_ops = {
 	.pincode_reply = hciops_pincode_reply,
 	.confirm_reply = hciops_confirm_reply,
 	.passkey_reply = hciops_passkey_reply,
+	.pairing_reply = hciops_pairing_reply,
 	.get_auth_info = hciops_get_auth_info,
 	.read_scan_enable = hciops_read_scan_enable,
 	.write_le_host = hciops_write_le_host,
diff --git a/src/adapter.c b/src/adapter.c
index f0c2dad..78b5ce3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3673,6 +3673,13 @@ int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	return adapter_ops->passkey_reply(adapter->dev_id, bdaddr, passkey);
 }
 
+int btd_adapter_pairing_reply(struct btd_adapter *adapter,
+				struct btd_device *device, gboolean approve)
+{
+	DBG("reply %u", approve);
+	return adapter_ops->pairing_reply(adapter->dev_id, device, approve);
+}
+
 int btd_adapter_get_auth_info(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 								uint8_t *auth)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 16b7f67..e2bd94a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -225,6 +225,8 @@ struct btd_adapter_ops {
 	int (*pincode_reply) (int index, bdaddr_t *bdaddr, const char *pin);
 	int (*confirm_reply) (int index, bdaddr_t *bdaddr, gboolean success);
 	int (*passkey_reply) (int index, bdaddr_t *bdaddr, uint32_t passkey);
+	int (*pairing_reply) (int index, struct btd_device *device,
+						gboolean success);
 	int (*get_auth_info) (int index, bdaddr_t *bdaddr, uint8_t *auth);
 	int (*read_scan_enable) (int index);
 	int (*write_le_host) (int index, uint8_t le, uint8_t simul);
@@ -276,6 +278,8 @@ int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							gboolean success);
 int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 							uint32_t passkey);
+int btd_adapter_pairing_reply(struct btd_adapter *adapter,
+				struct btd_device *device, gboolean approve);
 
 int btd_adapter_get_auth_info(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 								uint8_t *auth);
diff --git a/src/agent.c b/src/agent.c
index 2ddfd6e..7dd969e 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -55,7 +55,8 @@ typedef enum {
 	AGENT_REQUEST_CONFIRMATION,
 	AGENT_REQUEST_PINCODE,
 	AGENT_REQUEST_AUTHORIZE,
-	AGENT_REQUEST_CONFIRM_MODE
+	AGENT_REQUEST_CONFIRM_MODE,
+	AGENT_REQUEST_PAIRING
 } agent_request_type_t;
 
 struct agent {
@@ -693,6 +694,62 @@ failed:
 	return err;
 }
 
+static int pairing_request_new(struct agent_request *req,
+					const char *device_path)
+{
+	struct agent *agent = req->agent;
+
+	req->msg = dbus_message_new_method_call(agent->name, agent->path,
+				"org.bluez.Agent", "RequestPairing");
+	if (req->msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return -ENOMEM;
+	}
+
+	dbus_message_append_args(req->msg,
+				DBUS_TYPE_OBJECT_PATH, &device_path,
+				DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(connection, req->msg,
+				&req->call, REQUEST_TIMEOUT) == FALSE) {
+		error("D-Bus send failed");
+		return -EIO;
+	}
+
+	dbus_pending_call_set_notify(req->call, simple_agent_reply, req, NULL);
+
+	return 0;
+}
+
+int agent_request_pairing (struct agent *agent, struct btd_device *device,
+			agent_cb cb, void *user_data, GDestroyNotify destroy)
+{
+	struct agent_request *req;
+	const gchar *dev_path = device_get_path(device);
+	int err;
+
+	if (agent->request)
+		return -EBUSY;
+
+	DBG("Calling Agent.RequestPairing: name=%s, path=%s", agent->name,
+								agent->path);
+
+	req = agent_request_new(agent, AGENT_REQUEST_PAIRING, cb,
+							user_data, destroy);
+
+	err = pairing_request_new(req, dev_path);
+	if (err < 0)
+		goto failed;
+
+	agent->request = req;
+
+	return 0;
+
+failed:
+	agent_request_free(req, FALSE);
+	return err;
+}
+
 static int request_fallback(struct agent_request *req,
 				DBusPendingCallNotifyFunction function)
 {
diff --git a/src/agent.h b/src/agent.h
index e184250..5aa2702 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -64,6 +64,9 @@ int agent_request_confirmation(struct agent *agent, struct btd_device *device,
 int agent_display_passkey(struct agent *agent, struct btd_device *device,
 				uint32_t passkey);
 
+int agent_request_pairing (struct agent *agent, struct btd_device *device,
+			agent_cb cb, void *user_data, GDestroyNotify destroy);
+
 int agent_cancel(struct agent *agent);
 
 gboolean agent_is_busy(struct agent *agent, void *user_data);
diff --git a/src/device.c b/src/device.c
index fd3c3b3..c1a3bfe 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2243,6 +2243,21 @@ static void passkey_cb(struct agent *agent, DBusError *err,
 	device->authr->agent = NULL;
 }
 
+static void pairing_cb(struct agent *agent, DBusError *err, void *data)
+{
+	struct authentication_req *auth = data;
+	struct btd_device *device = auth->device;
+
+	/* No need to reply anything if the authentication already failed */
+	if (auth->cb == NULL)
+		return;
+
+	((agent_cb) auth->cb)(agent, err, device);
+
+	device->authr->cb = NULL;
+	device->authr->agent = NULL;
+}
+
 int device_request_authentication(struct btd_device *device, auth_type_t type,
 						uint32_t passkey, void *cb)
 {
@@ -2281,6 +2296,10 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 	case AUTH_TYPE_NOTIFY:
 		err = agent_display_passkey(agent, device, passkey);
 		break;
+	case AUTH_TYPE_PAIRING:
+		err = agent_request_pairing (agent, device, pairing_cb, auth,
+									NULL);
+		break;
 	case AUTH_TYPE_AUTO:
 		err = 0;
 		break;
@@ -2322,6 +2341,9 @@ static void cancel_authentication(struct authentication_req *auth)
 	case AUTH_TYPE_PASSKEY:
 		((agent_passkey_cb) auth->cb)(agent, &err, 0, device);
 		break;
+	case AUTH_TYPE_PAIRING:
+		((agent_cb) auth->cb)(agent, &err, device);
+		break;
 	case AUTH_TYPE_NOTIFY:
 	case AUTH_TYPE_AUTO:
 		/* User Notify/Auto doesn't require any reply */
diff --git a/src/device.h b/src/device.h
index 1823f65..5e673d0 100644
--- a/src/device.h
+++ b/src/device.h
@@ -33,6 +33,7 @@ typedef enum {
 	AUTH_TYPE_CONFIRM,
 	AUTH_TYPE_NOTIFY,
 	AUTH_TYPE_AUTO,
+	AUTH_TYPE_PAIRING
 } auth_type_t;
 
 struct btd_device *device_create(DBusConnection *conn, struct btd_adapter *adapter,
diff --git a/src/event.c b/src/event.c
index a88a8f5..316273a 100644
--- a/src/event.c
+++ b/src/event.c
@@ -175,6 +175,15 @@ static void passkey_cb(struct agent *agent, DBusError *err, uint32_t passkey,
 	btd_adapter_passkey_reply(adapter, &bdaddr, passkey);
 }
 
+static void pairing_cb(struct agent *agent, DBusError *err, void *user_data)
+{
+	struct btd_device *device = user_data;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	gboolean approve = (err == NULL) ? TRUE : FALSE;
+
+	btd_adapter_pairing_reply(adapter, device, approve);
+}
+
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 {
 	struct btd_adapter *adapter;
@@ -264,6 +273,33 @@ int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 								passkey, NULL);
 }
 
+int btd_event_user_pairing(bdaddr_t *sba, bdaddr_t *dba)
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	struct agent *agent;
+	uint8_t cap;
+
+	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
+		return -ENODEV;
+
+	agent = device_get_agent(device);
+	if (!agent)
+		return -ENODEV;
+
+	cap = agent_get_io_capability(agent);
+
+	/* If initiator or agent has no input capability allow pairing
+	 * immediately. */
+	if (device_is_bonding(device, NULL) || cap == 0x00 || cap == 0x03) {
+		btd_adapter_pairing_reply(adapter, device, TRUE);
+		return 0;
+	}
+
+	return device_request_authentication(device, AUTH_TYPE_PAIRING, 0,
+								pairing_cb);
+}
+
 void btd_event_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer,
 								uint8_t status)
 {
diff --git a/src/event.h b/src/event.h
index 5c122ea..3fde56b 100644
--- a/src/event.h
+++ b/src/event.h
@@ -41,6 +41,7 @@ int btd_event_set_io_cap(bdaddr_t *local, bdaddr_t *remote,
 int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
 int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba);
 int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey);
+int btd_event_user_pairing(bdaddr_t *sba, bdaddr_t *dba);
 int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 				uint8_t *key, uint8_t key_type,
 				int pin_length, uint8_t old_key_type);
-- 
1.7.1

