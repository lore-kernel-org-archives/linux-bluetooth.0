Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC] core: Fix BR/EDR pairing for dual mode devices
Date: Fri, 21 Oct 2016 22:34:14 +0200
Message-Id: <1477082054-21423-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For dual mode devices we need to pass address type used in pairing
events to reply with correct one on agent reply. Otherwise reply for
BR/EDR pairing of dual mode device would use address type (which is
valid only for LE address) resulting in reply being ignored by kernel
and eventually pairing timeout.
---
 src/adapter.c |  7 ++++---
 src/device.c  | 31 +++++++++++++++++--------------
 src/device.h  | 10 +++++-----
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1abb5c0..4deb980 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6182,7 +6182,7 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	err = device_confirm_passkey(device, btohl(ev->value),
+	err = device_confirm_passkey(device, ev->addr.type, btohl(ev->value),
 							ev->confirm_hint);
 	if (err < 0) {
 		btd_error(adapter->dev_id,
@@ -6256,7 +6256,7 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	err = device_request_passkey(device);
+	err = device_request_passkey(device, ev->addr.type);
 	if (err < 0) {
 		btd_error(adapter->dev_id,
 				"device_request_passkey: %s", strerror(-err));
@@ -6295,7 +6295,8 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 
 	DBG("passkey %06u entered %u", passkey, ev->entered);
 
-	err = device_notify_passkey(device, passkey, ev->entered);
+	err = device_notify_passkey(device, ev->addr.type, passkey,
+								ev->entered);
 	if (err < 0)
 		btd_error(adapter->dev_id,
 				"device_notify_passkey: %s", strerror(-err));
diff --git a/src/device.c b/src/device.c
index d06b5bf..cc16f8d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -126,6 +126,7 @@ struct authentication_req {
 	auth_type_t type;
 	struct agent *agent;
 	struct btd_device *device;
+	uint8_t addr_type;
 	uint32_t passkey;
 	char *pincode;
 	gboolean secure;
@@ -5613,7 +5614,7 @@ static void confirm_cb(struct agent *agent, DBusError *err, void *data)
 		return;
 
 	btd_adapter_confirm_reply(device->adapter, &device->bdaddr,
-							device->bdaddr_type,
+							auth->addr_type,
 							err ? FALSE : TRUE);
 
 	agent_unref(device->authr->agent);
@@ -5634,7 +5635,7 @@ static void passkey_cb(struct agent *agent, DBusError *err,
 		passkey = INVALID_PASSKEY;
 
 	btd_adapter_passkey_reply(device->adapter, &device->bdaddr,
-						device->bdaddr_type, passkey);
+						auth->addr_type, passkey);
 
 	agent_unref(device->authr->agent);
 	device->authr->agent = NULL;
@@ -5652,7 +5653,9 @@ static void display_pincode_cb(struct agent *agent, DBusError *err, void *data)
 }
 
 static struct authentication_req *new_auth(struct btd_device *device,
-					auth_type_t type, gboolean secure)
+						uint8_t addr_type,
+						auth_type_t type,
+						gboolean secure)
 {
 	struct authentication_req *auth;
 	struct agent *agent;
@@ -5680,6 +5683,7 @@ static struct authentication_req *new_auth(struct btd_device *device,
 	auth->agent = agent;
 	auth->device = device;
 	auth->type = type;
+	auth->addr_type = addr_type;
 	auth->secure = secure;
 	device->authr = auth;
 
@@ -5691,7 +5695,7 @@ int device_request_pincode(struct btd_device *device, gboolean secure)
 	struct authentication_req *auth;
 	int err;
 
-	auth = new_auth(device, AUTH_TYPE_PINCODE, secure);
+	auth = new_auth(device, BDADDR_BREDR, AUTH_TYPE_PINCODE, secure);
 	if (!auth)
 		return -EPERM;
 
@@ -5705,12 +5709,12 @@ int device_request_pincode(struct btd_device *device, gboolean secure)
 	return err;
 }
 
-int device_request_passkey(struct btd_device *device)
+int device_request_passkey(struct btd_device *device, uint8_t type)
 {
 	struct authentication_req *auth;
 	int err;
 
-	auth = new_auth(device, AUTH_TYPE_PASSKEY, FALSE);
+	auth = new_auth(device, type, AUTH_TYPE_PASSKEY, FALSE);
 	if (!auth)
 		return -EPERM;
 
@@ -5724,14 +5728,13 @@ int device_request_passkey(struct btd_device *device)
 	return err;
 }
 
-int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-							uint8_t confirm_hint)
-
+int device_confirm_passkey(struct btd_device *device, uint8_t type,
+					int32_t passkey, uint8_t confirm_hint)
 {
 	struct authentication_req *auth;
 	int err;
 
-	auth = new_auth(device, AUTH_TYPE_CONFIRM, FALSE);
+	auth = new_auth(device, type, AUTH_TYPE_CONFIRM, FALSE);
 	if (!auth)
 		return -EPERM;
 
@@ -5752,8 +5755,8 @@ int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
 	return err;
 }
 
-int device_notify_passkey(struct btd_device *device, uint32_t passkey,
-							uint8_t entered)
+int device_notify_passkey(struct btd_device *device, uint8_t type,
+					uint32_t passkey, uint8_t entered)
 {
 	struct authentication_req *auth;
 	int err;
@@ -5763,7 +5766,7 @@ int device_notify_passkey(struct btd_device *device, uint32_t passkey,
 		if (auth->type != AUTH_TYPE_NOTIFY_PASSKEY)
 			return -EPERM;
 	} else {
-		auth = new_auth(device, AUTH_TYPE_NOTIFY_PASSKEY, FALSE);
+		auth = new_auth(device, type, AUTH_TYPE_NOTIFY_PASSKEY, FALSE);
 		if (!auth)
 			return -EPERM;
 	}
@@ -5783,7 +5786,7 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
 	struct authentication_req *auth;
 	int err;
 
-	auth = new_auth(device, AUTH_TYPE_NOTIFY_PINCODE, secure);
+	auth = new_auth(device, BDADDR_BREDR, AUTH_TYPE_NOTIFY_PINCODE, secure);
 	if (!auth)
 		return -EPERM;
 
diff --git a/src/device.h b/src/device.h
index 93a159a..3cab366 100644
--- a/src/device.h
+++ b/src/device.h
@@ -111,11 +111,11 @@ int device_bonding_attempt_retry(struct btd_device *device);
 long device_bonding_last_duration(struct btd_device *device);
 void device_bonding_restart_timer(struct btd_device *device);
 int device_request_pincode(struct btd_device *device, gboolean secure);
-int device_request_passkey(struct btd_device *device);
-int device_confirm_passkey(struct btd_device *device, uint32_t passkey,
-							uint8_t confirm_hint);
-int device_notify_passkey(struct btd_device *device, uint32_t passkey,
-							uint8_t entered);
+int device_request_passkey(struct btd_device *device, uint8_t type);
+int device_confirm_passkey(struct btd_device *device, uint8_t type,
+					int32_t passkey, uint8_t confirm_hint);
+int device_notify_passkey(struct btd_device *device, uint8_t type,
+					uint32_t passkey, uint8_t entered);
 int device_notify_pincode(struct btd_device *device, gboolean secure,
 							const char *pincode);
 void device_cancel_authentication(struct btd_device *device, gboolean aborted);
-- 
2.7.4

