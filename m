Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <keybuk@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Scott James Remnant <keybuk@chromium.org>
Subject: [PATCH 1/2] Pass length of PIN through callbacks.
Date: Fri, 13 Jan 2012 17:52:35 -0800
Message-Id: <1326505957-27555-1-git-send-email-keybuk@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In HCI, the PIN is a sequence of octets always accompanied by a length,
which means that a NULL byte is valid within a PIN. Indeed, some devices
use their BD_ADDR (or the host's) as a PIN, and these do have 0x00 bytes.

Adjust the pincode callbacks to always pass a length with the PIN, so we
use the initially calculated length from the D-Bus String rather than
calculating separately later.
---
 src/agent.c  |   10 +++++-----
 src/agent.h  |    2 +-
 src/device.c |    6 +++---
 src/event.c  |    6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 9b942e8..4477210 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -160,7 +160,7 @@ void agent_free(struct agent *agent)
 		switch (agent->request->type) {
 		case AGENT_REQUEST_PINCODE:
 			pincode_cb = agent->request->cb;
-			pincode_cb(agent, &err, NULL, agent->request->user_data);
+			pincode_cb(agent, &err, NULL, 0, agent->request->user_data);
 			break;
 		default:
 			cb = agent->request->cb;
@@ -367,7 +367,7 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 		error("Agent %s replied with an error: %s, %s",
 				agent->path, err.name, err.message);
 
-		cb(agent, &err, NULL, req->user_data);
+		cb(agent, &err, NULL, 0, req->user_data);
 		dbus_error_free(&err);
 		goto done;
 	}
@@ -377,7 +377,7 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 				DBUS_TYPE_STRING, &pin,
 				DBUS_TYPE_INVALID)) {
 		error("Wrong passkey reply signature: %s", err.message);
-		cb(agent, &err, NULL, req->user_data);
+		cb(agent, &err, NULL, 0, req->user_data);
 		dbus_error_free(&err);
 		goto done;
 	}
@@ -389,12 +389,12 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 		error("Invalid PIN length (%zu) from agent", len);
 		dbus_set_error_const(&err, "org.bluez.Error.InvalidArgs",
 					"Invalid passkey length");
-		cb(agent, &err, NULL, req->user_data);
+		cb(agent, &err, NULL, 0, req->user_data);
 		dbus_error_free(&err);
 		goto done;
 	}
 
-	cb(agent, NULL, pin, req->user_data);
+	cb(agent, NULL, pin, len, req->user_data);
 
 done:
 	if (message)
diff --git a/src/agent.h b/src/agent.h
index f62bf3b..42d90e6 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -28,7 +28,7 @@ typedef void (*agent_cb) (struct agent *agent, DBusError *err,
 				void *user_data);
 
 typedef void (*agent_pincode_cb) (struct agent *agent, DBusError *err,
-					const char *pincode, void *user_data);
+					const char *pincode, ssize_t pinlen, void *user_data);
 
 typedef void (*agent_passkey_cb) (struct agent *agent, DBusError *err,
 					uint32_t passkey, void *user_data);
diff --git a/src/device.c b/src/device.c
index 16855b1..3745119 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2455,7 +2455,7 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 }
 
 static void pincode_cb(struct agent *agent, DBusError *err,
-					const char *pincode, void *data)
+				const char *pincode, ssize_t pinlen, void *data)
 {
 	struct authentication_req *auth = data;
 	struct btd_device *device = auth->device;
@@ -2481,7 +2481,7 @@ done:
 	if (auth->cb == NULL)
 		return;
 
-	((agent_pincode_cb) auth->cb)(agent, err, pincode, device);
+	((agent_pincode_cb) auth->cb)(agent, err, pincode, pinlen, device);
 
 	device->authr->cb = NULL;
 	device->authr->agent = NULL;
@@ -2629,7 +2629,7 @@ static void cancel_authentication(struct authentication_req *auth)
 
 	switch (auth->type) {
 	case AUTH_TYPE_PINCODE:
-		((agent_pincode_cb) auth->cb)(agent, &err, NULL, device);
+		((agent_pincode_cb) auth->cb)(agent, &err, NULL, 0, device);
 		break;
 	case AUTH_TYPE_CONFIRM:
 		((agent_cb) auth->cb)(agent, &err, device);
diff --git a/src/event.c b/src/event.c
index 6854990..906b1c5 100644
--- a/src/event.c
+++ b/src/event.c
@@ -87,7 +87,8 @@ static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
  *****************************************************************/
 
 static void pincode_cb(struct agent *agent, DBusError *derr,
-				const char *pincode, struct btd_device *device)
+			const char *pincode, ssize_t pinlen,
+			struct btd_device *device)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	bdaddr_t dba;
@@ -102,8 +103,7 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
 		return;
 	}
 
-	err = btd_adapter_pincode_reply(adapter, &dba, pincode,
-						pincode ? strlen(pincode) : 0);
+	err = btd_adapter_pincode_reply(adapter, &dba, pincode, pinlen);
 	if (err < 0)
 		goto fail;
 
-- 
1.7.7.3

