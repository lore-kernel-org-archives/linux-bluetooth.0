Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCH 2/3] agent: add DisplayPinCode method
Date: Fri, 20 Jan 2012 15:05:43 -0800
Message-Id: <1327100744-28782-3-git-send-email-scott@netsplit.com>
In-Reply-To: <1327100744-28782-1-git-send-email-scott@netsplit.com>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a second notification type that requests the agent displays a
string PinCode rather than the numeric Passkey.
---
 doc/agent-api.txt |   12 ++++++++++++
 src/agent.c       |   27 +++++++++++++++++++++++++++
 src/agent.h       |    2 ++
 src/device.c      |   24 ++++++++++++++++--------
 src/device.h      |    5 +++--
 src/event.c       |   10 +++++-----
 test/simple-agent |    5 +++++
 7 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 9ab2063..0b32d70 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -61,6 +61,18 @@ Methods		void Release()
 			so the display should be zero-padded at the start if
 			the value contains less than 6 digits.
 
+		void DisplayPinCode(object device, string pincode)
+
+			This method gets called when the service daemon
+			needs to display a pincode for an authentication.
+
+			An empty reply should be returned. When the pincode
+			needs no longer to be displayed, the Cancel method
+			of the agent will be called.
+
+			During the pairing process this method might be
+			called multiple times to update the entered value.
+
 		void RequestConfirmation(object device, uint32 passkey)
 
 			This method gets called when the service daemon
diff --git a/src/agent.c b/src/agent.c
index 9b942e8..7866ed0 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -699,6 +699,33 @@ int agent_display_passkey(struct agent *agent, struct btd_device *device,
 	return 0;
 }
 
+int agent_display_pincode(struct agent *agent, struct btd_device *device,
+				const char *pincode)
+{
+	DBusMessage *message;
+	const gchar *dev_path = device_get_path(device);
+
+	message = dbus_message_new_method_call(agent->name, agent->path,
+				"org.bluez.Agent", "DisplayPinCode");
+	if (!message) {
+		error("Couldn't allocate D-Bus message");
+		return -1;
+	}
+
+	dbus_message_append_args(message,
+				DBUS_TYPE_OBJECT_PATH, &dev_path,
+				DBUS_TYPE_STRING, &pincode,
+				DBUS_TYPE_INVALID);
+
+	if (!g_dbus_send_message(connection, message)) {
+		error("D-Bus send failed");
+		dbus_message_unref(message);
+		return -1;
+	}
+
+	return 0;
+}
+
 uint8_t agent_get_io_capability(struct agent *agent)
 {
 	return agent->capability;
diff --git a/src/agent.h b/src/agent.h
index f62bf3b..838180d 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -63,6 +63,8 @@ int agent_request_confirmation(struct agent *agent, struct btd_device *device,
 
 int agent_display_passkey(struct agent *agent, struct btd_device *device,
 				uint32_t passkey);
+int agent_display_pincode(struct agent *agent, struct btd_device *device,
+				const char *pincode);
 
 int agent_cancel(struct agent *agent);
 
diff --git a/src/device.c b/src/device.c
index 16855b1..df58b06 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2330,7 +2330,8 @@ void device_simple_pairing_complete(struct btd_device *device, uint8_t status)
 {
 	struct authentication_req *auth = device->authr;
 
-	if (auth && auth->type == AUTH_TYPE_NOTIFY && auth->agent)
+	if (auth && (auth->type == AUTH_TYPE_NOTIFY_PASSKEY
+		     || auth->type == AUTH_TYPE_NOTIFY_PINCODE) && auth->agent)
 		agent_cancel(auth->agent);
 }
 
@@ -2347,7 +2348,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
-	if (auth && auth->type == AUTH_TYPE_NOTIFY && auth->agent)
+	if (auth && (auth->type == AUTH_TYPE_NOTIFY_PASSKEY
+		     || auth->type == AUTH_TYPE_NOTIFY_PINCODE) && auth->agent)
 		agent_cancel(auth->agent);
 
 	if (status) {
@@ -2554,7 +2556,7 @@ done:
 }
 
 int device_request_authentication(struct btd_device *device, auth_type_t type,
-				uint32_t passkey, gboolean secure, void *cb)
+				void *data, gboolean secure, void *cb)
 {
 	struct authentication_req *auth;
 	struct agent *agent;
@@ -2580,7 +2582,7 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 	auth->device = device;
 	auth->cb = cb;
 	auth->type = type;
-	auth->passkey = passkey;
+	auth->passkey = data ? *(uint32_t *)data : 0;
 	auth->secure = secure;
 	device->authr = auth;
 
@@ -2594,11 +2596,14 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 								auth, NULL);
 		break;
 	case AUTH_TYPE_CONFIRM:
-		err = agent_request_confirmation(agent, device, passkey,
+		err = agent_request_confirmation(agent, device, auth->passkey,
 						confirm_cb, auth, NULL);
 		break;
-	case AUTH_TYPE_NOTIFY:
-		err = agent_display_passkey(agent, device, passkey);
+	case AUTH_TYPE_NOTIFY_PASSKEY:
+		err = agent_display_passkey(agent, device, auth->passkey);
+		break;
+	case AUTH_TYPE_NOTIFY_PINCODE:
+		err = agent_display_pincode(agent, device, (const char *)data);
 		break;
 	default:
 		err = -EINVAL;
@@ -2637,7 +2642,10 @@ static void cancel_authentication(struct authentication_req *auth)
 	case AUTH_TYPE_PASSKEY:
 		((agent_passkey_cb) auth->cb)(agent, &err, 0, device);
 		break;
-	case AUTH_TYPE_NOTIFY:
+	case AUTH_TYPE_NOTIFY_PASSKEY:
+		/* User Notify doesn't require any reply */
+		break;
+	case AUTH_TYPE_NOTIFY_PINCODE:
 		/* User Notify doesn't require any reply */
 		break;
 	}
diff --git a/src/device.h b/src/device.h
index 13005ae..b355a6e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -30,7 +30,8 @@ typedef enum {
 	AUTH_TYPE_PINCODE,
 	AUTH_TYPE_PASSKEY,
 	AUTH_TYPE_CONFIRM,
-	AUTH_TYPE_NOTIFY,
+	AUTH_TYPE_NOTIFY_PASSKEY,
+	AUTH_TYPE_NOTIFY_PINCODE,
 } auth_type_t;
 
 struct btd_device *device_create(DBusConnection *conn,
@@ -82,7 +83,7 @@ gboolean device_is_creating(struct btd_device *device, const char *sender);
 gboolean device_is_bonding(struct btd_device *device, const char *sender);
 void device_cancel_bonding(struct btd_device *device, uint8_t status);
 int device_request_authentication(struct btd_device *device, auth_type_t type,
-				uint32_t passkey, gboolean secure, void *cb);
+				void *data, gboolean secure, void *cb);
 void device_cancel_authentication(struct btd_device *device, gboolean aborted);
 gboolean device_is_authenticating(struct btd_device *device);
 gboolean device_is_authorizing(struct btd_device *device);
diff --git a/src/event.c b/src/event.c
index 0783b47..5aa5ef9 100644
--- a/src/event.c
+++ b/src/event.c
@@ -130,7 +130,7 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba, gboolean secure)
 		return 0;
 	}
 
-	return device_request_authentication(device, AUTH_TYPE_PINCODE, 0,
+	return device_request_authentication(device, AUTH_TYPE_PINCODE, NULL,
 							secure, pincode_cb);
 }
 
@@ -177,7 +177,7 @@ int btd_event_user_confirm(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 		return -ENODEV;
 
 	return device_request_authentication(device, AUTH_TYPE_CONFIRM,
-						passkey, FALSE, confirm_cb);
+						&passkey, FALSE, confirm_cb);
 }
 
 int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba)
@@ -188,7 +188,7 @@ int btd_event_user_passkey(bdaddr_t *sba, bdaddr_t *dba)
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
 		return -ENODEV;
 
-	return device_request_authentication(device, AUTH_TYPE_PASSKEY, 0,
+	return device_request_authentication(device, AUTH_TYPE_PASSKEY, NULL,
 							FALSE, passkey_cb);
 }
 
@@ -200,8 +200,8 @@ int btd_event_user_notify(bdaddr_t *sba, bdaddr_t *dba, uint32_t passkey)
 	if (!get_adapter_and_device(sba, dba, &adapter, &device, TRUE))
 		return -ENODEV;
 
-	return device_request_authentication(device, AUTH_TYPE_NOTIFY, passkey,
-								FALSE, NULL);
+	return device_request_authentication(device, AUTH_TYPE_NOTIFY_PASSKEY,
+							&passkey, FALSE, NULL);
 }
 
 void btd_event_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
diff --git a/test/simple-agent b/test/simple-agent
index 8d65860..4416adb 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -52,6 +52,11 @@ class Agent(dbus.service.Object):
 		print "DisplayPasskey (%s, %d)" % (device, passkey)
 
 	@dbus.service.method("org.bluez.Agent",
+					in_signature="os", out_signature="")
+	def DisplayPinCode(self, device, pincode):
+		print "DisplayPinCode (%s, %s)" % (device, pincode)
+
+	@dbus.service.method("org.bluez.Agent",
 					in_signature="ou", out_signature="")
 	def RequestConfirmation(self, device, passkey):
 		print "RequestConfirmation (%s, %d)" % (device, passkey)
-- 
1.7.7.3

