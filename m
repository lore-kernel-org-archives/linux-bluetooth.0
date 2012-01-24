Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 5/8] Add AUTH_TYPE_NOTIFY_PASSKEY to device_request_authentication
Date: Mon, 23 Jan 2012 16:27:49 -0800
Message-Id: <1327364872-32313-6-git-send-email-scott@netsplit.com>
In-Reply-To: <1327364872-32313-1-git-send-email-scott@netsplit.com>
References: <1327364872-32313-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This new authentication type accepts a pincode and calls the
DisplayPinCode agent method, a fallback is provided so that if the
method is not implemented the older RequestPinCode method is used
instead.

Due to this fallback, the agent_pincode_cb is used and calling
functions should send the pincode passed to the callback to the
adapter, which may differ from that generated.
---
 src/device.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/device.h |    1 +
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 82afbbe..89d961c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -94,6 +94,7 @@ struct authentication_req {
 	struct agent *agent;
 	struct btd_device *device;
 	uint32_t passkey;
+	char *pincode;
 	gboolean secure;
 };
 
@@ -249,6 +250,8 @@ static void device_free(gpointer user_data)
 
 	DBG("%p", device);
 
+	if (device->authr)
+		g_free(device->authr->pincode);
 	g_free(device->authr);
 	g_free(device->path);
 	g_free(device->alias);
@@ -2320,12 +2323,15 @@ void device_simple_pairing_complete(struct btd_device *device, uint8_t status)
 {
 	struct authentication_req *auth = device->authr;
 
-	if (auth && auth->type == AUTH_TYPE_NOTIFY_PASSKEY && auth->agent)
+	if (auth && (auth->type == AUTH_TYPE_NOTIFY_PASSKEY
+		     || auth->type == AUTH_TYPE_NOTIFY_PINCODE) && auth->agent)
 		agent_cancel(auth->agent);
 }
 
 static void device_auth_req_free(struct btd_device *device)
 {
+	if (device->authr)
+		g_free(device->authr->pincode);
 	g_free(device->authr);
 	device->authr = NULL;
 }
@@ -2337,7 +2343,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
-	if (auth && auth->type == AUTH_TYPE_NOTIFY_PASSKEY && auth->agent)
+	if (auth && (auth->type == AUTH_TYPE_NOTIFY_PASSKEY
+		     || auth->type == AUTH_TYPE_NOTIFY_PINCODE) && auth->agent)
 		agent_cancel(auth->agent);
 
 	if (status) {
@@ -2543,6 +2550,46 @@ done:
 	device->authr->agent = NULL;
 }
 
+static void display_pincode_cb(struct agent *agent, DBusError *err, void *data)
+{
+	struct authentication_req *auth = data;
+	struct btd_device *device = auth->device;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct agent *adapter_agent = adapter_get_agent(adapter);
+
+	if (err && (g_str_equal(DBUS_ERROR_UNKNOWN_METHOD, err->name) ||
+				g_str_equal(DBUS_ERROR_NO_REPLY, err->name))) {
+
+		/* Request a pincode if we fail to display one */
+		if (auth->agent == adapter_agent || adapter_agent == NULL) {
+			if (agent_request_pincode(agent, device, pincode_cb,
+						auth->secure, auth, NULL) < 0)
+				goto done;
+			return;
+		}
+
+		if (agent_display_pincode(adapter_agent, device, auth->pincode,
+					display_pincode_cb, auth, NULL) < 0)
+			goto done;
+
+		auth->agent = adapter_agent;
+		return;
+	}
+
+done:
+	/* No need to reply anything if the authentication already failed */
+	if (auth->cb == NULL)
+		return;
+
+	((agent_pincode_cb) auth->cb)(agent, err, auth->pincode, device);
+
+	g_free(device->authr->pincode);
+	device->authr->pincode = NULL;
+	device->authr->cb = NULL;
+	device->authr->agent = NULL;
+}
+
+
 int device_request_authentication(struct btd_device *device, auth_type_t type,
 					void *data, gboolean secure, void *cb)
 {
@@ -2591,6 +2638,11 @@ int device_request_authentication(struct btd_device *device, auth_type_t type,
 		auth->passkey = *(uint32_t *)data;
 		err = agent_display_passkey(agent, device, auth->passkey);
 		break;
+	case AUTH_TYPE_NOTIFY_PINCODE:
+		auth->pincode = g_strdup((const char *)data);
+		err = agent_display_pincode(agent, device, auth->pincode,
+						display_pincode_cb, auth, NULL);
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -2631,6 +2683,9 @@ static void cancel_authentication(struct authentication_req *auth)
 	case AUTH_TYPE_NOTIFY_PASSKEY:
 		/* User Notify doesn't require any reply */
 		break;
+	case AUTH_TYPE_NOTIFY_PINCODE:
+		((agent_pincode_cb) auth->cb)(agent, &err, NULL, device);
+		break;
 	}
 
 	dbus_error_free(&err);
diff --git a/src/device.h b/src/device.h
index 925155c..1be2aca 100644
--- a/src/device.h
+++ b/src/device.h
@@ -31,6 +31,7 @@ typedef enum {
 	AUTH_TYPE_PASSKEY,
 	AUTH_TYPE_CONFIRM,
 	AUTH_TYPE_NOTIFY_PASSKEY,
+	AUTH_TYPE_NOTIFY_PINCODE,
 } auth_type_t;
 
 struct btd_device *device_create(DBusConnection *conn,
-- 
1.7.7.3

