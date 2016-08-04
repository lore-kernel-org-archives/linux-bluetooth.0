Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 3/5] core/adapter: Add support for rebond consent
Date: Thu,  4 Aug 2016 15:28:37 +0200
Message-Id: <1470317319-3985-4-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
References: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device was disconnected with authentication failed error (result of
PIN or Key missing HCI error) send a rebond consent request to agent.
If agent confirms request, unpair device and start new pairing without
need to discover device again.
---
 src/adapter.c | 124 ++++++++++++++++++++++++++++++++++++++++++----------------
 src/agent.c   |  47 ++++++++++++++++++++++
 src/agent.h   |   4 ++
 3 files changed, 141 insertions(+), 34 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3742398..704844a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6643,6 +6643,69 @@ static void disconnect_notify(struct btd_device *dev, uint8_t reason)
 	}
 }
 
+static void remove_keys(struct btd_adapter *adapter,
+					struct btd_device *device, uint8_t type)
+{
+	char adapter_addr[18];
+	char device_addr[18];
+	char filename[PATH_MAX];
+	GKeyFile *key_file;
+	gsize length = 0;
+	char *str;
+
+	ba2str(btd_adapter_get_address(adapter), adapter_addr);
+	ba2str(device_get_address(device), device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
+								device_addr);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	if (type == BDADDR_BREDR) {
+		g_key_file_remove_group(key_file, "LinkKey", NULL);
+	} else {
+		g_key_file_remove_group(key_file, "LongTermKey", NULL);
+		g_key_file_remove_group(key_file, "LocalSignatureKey", NULL);
+		g_key_file_remove_group(key_file, "RemoteSignatureKey", NULL);
+		g_key_file_remove_group(key_file, "IdentityResolvingKey", NULL);
+	}
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
+struct rebond_consent_data {
+	struct btd_adapter *adapter;
+	bdaddr_t addr;
+	uint8_t addr_type;
+};
+
+static void rebond_consent_cb(struct agent *agent, DBusError *err,
+							void *user_data)
+{
+	struct rebond_consent_data *data = user_data;
+	struct btd_device *device;
+
+	if (err)
+		return;
+
+	device = btd_adapter_find_device(data->adapter, &data->addr,
+							data->addr_type);
+	if (device) {
+		btd_adapter_remove_bonding(data->adapter, &data->addr,
+							data->addr_type);
+
+		remove_keys(data->adapter, device, data->addr_type);
+		device_set_unpaired(device, data->addr_type);
+	}
+
+	adapter_create_bonding(data->adapter, &data->addr, data->addr_type,
+					agent_get_io_capability(agent));
+}
+
 static void dev_disconnected(struct btd_adapter *adapter,
 					const struct mgmt_addr_info *addr,
 					uint8_t reason)
@@ -6662,6 +6725,33 @@ static void dev_disconnected(struct btd_adapter *adapter,
 
 	bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
 						MGMT_STATUS_DISCONNECTED);
+
+	/* send re-bond consent only if lost bond */
+	if (reason != MGMT_DEV_DISCONN_AUTH_FAILURE)
+		return;
+
+	if (device && device_is_bonded(device, addr->type)) {
+		struct rebond_consent_data *data;
+		struct agent *agent;
+
+		info("Device %s lost bond", dst);
+
+		agent = agent_get(NULL);
+		if (!agent)
+			return;
+
+		data = new0(struct rebond_consent_data, 1);
+		data->adapter = adapter;
+		bacpy(&data->addr, &addr->bdaddr);
+		data->addr_type = addr->type;
+
+		if (agent_rebond_consent(agent, device,
+					rebond_consent_cb,
+					data, (GDestroyNotify)free) < 0)
+			free(data);
+
+		agent_unref(agent);
+	}
 }
 
 void btd_add_disconnect_cb(btd_disconnect_cb func)
@@ -7706,40 +7796,6 @@ static void connect_failed_callback(uint16_t index, uint16_t length,
 		btd_adapter_remove_device(adapter, device);
 }
 
-static void remove_keys(struct btd_adapter *adapter,
-					struct btd_device *device, uint8_t type)
-{
-	char adapter_addr[18];
-	char device_addr[18];
-	char filename[PATH_MAX];
-	GKeyFile *key_file;
-	gsize length = 0;
-	char *str;
-
-	ba2str(btd_adapter_get_address(adapter), adapter_addr);
-	ba2str(device_get_address(device), device_addr);
-
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", adapter_addr,
-								device_addr);
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
-
-	if (type == BDADDR_BREDR) {
-		g_key_file_remove_group(key_file, "LinkKey", NULL);
-	} else {
-		g_key_file_remove_group(key_file, "LongTermKey", NULL);
-		g_key_file_remove_group(key_file, "LocalSignatureKey", NULL);
-		g_key_file_remove_group(key_file, "RemoteSignatureKey", NULL);
-		g_key_file_remove_group(key_file, "IdentityResolvingKey", NULL);
-	}
-
-	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(filename, str, length, NULL);
-	g_free(str);
-
-	g_key_file_free(key_file);
-}
-
 static void unpaired_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
diff --git a/src/agent.c b/src/agent.c
index ff44d57..4d441b5 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -70,6 +70,7 @@ typedef enum {
 	AGENT_REQUEST_PINCODE,
 	AGENT_REQUEST_AUTHORIZE_SERVICE,
 	AGENT_REQUEST_DISPLAY_PINCODE,
+	AGENT_REQUEST_REBOND_CONSENT,
 } agent_request_type_t;
 
 struct agent {
@@ -247,6 +248,7 @@ void agent_unref(struct agent *agent)
 		case AGENT_REQUEST_AUTHORIZATION:
 		case AGENT_REQUEST_AUTHORIZE_SERVICE:
 		case AGENT_REQUEST_DISPLAY_PINCODE:
+		case AGENT_REQUEST_REBOND_CONSENT:
 		default:
 			cb = agent->request->cb;
 			cb(agent, &err, agent->request->user_data);
@@ -899,6 +901,51 @@ failed:
 	return err;
 }
 
+int agent_rebond_consent(struct agent *agent, struct btd_device *device,
+						agent_cb cb, void *user_data,
+						GDestroyNotify destroy)
+{
+	struct agent_request *req;
+	const char *dev_path = device_get_path(device);
+	int err;
+
+	if (agent->request)
+		return -EBUSY;
+
+	req = agent_request_new(agent, AGENT_REQUEST_REBOND_CONSENT, cb,
+				user_data, destroy);
+
+
+	req->msg = dbus_message_new_method_call(agent->owner, agent->path,
+					AGENT_INTERFACE, "RebondConsent");
+	if (req->msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	dbus_message_append_args(req->msg,
+				DBUS_TYPE_OBJECT_PATH, &dev_path,
+				DBUS_TYPE_INVALID);
+
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
+				&req->call, REQUEST_TIMEOUT) == FALSE) {
+		error("D-Bus send failed");
+		err = -EIO;
+		goto failed;
+	}
+
+	dbus_pending_call_set_notify(req->call, simple_agent_reply, req, NULL);
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
 uint8_t agent_get_io_capability(struct agent *agent)
 {
 	return agent->capability;
diff --git a/src/agent.h b/src/agent.h
index 1e46920..3b15453 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -65,6 +65,10 @@ int agent_display_pincode(struct agent *agent, struct btd_device *device,
 				const char *pincode, agent_cb cb,
 				void *user_data, GDestroyNotify destroy);
 
+int agent_rebond_consent(struct agent *agent, struct btd_device *device,
+						agent_cb cb, void *user_data,
+						GDestroyNotify destroy);
+
 int agent_cancel(struct agent *agent);
 
 uint8_t agent_get_io_capability(struct agent *agent);
-- 
2.7.4

