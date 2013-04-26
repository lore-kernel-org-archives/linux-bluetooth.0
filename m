Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 15/27] core: Add a state enum to btd_service
Date: Fri, 26 Apr 2013 08:17:11 +0200
Message-Id: <1366957043-2383-16-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a state to btd_service in order to distinguish which operations are
allowed in a certain point in time.
---
 src/service.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/service.h |  13 +++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 378dd2d..298d600 100644
--- a/src/service.c
+++ b/src/service.c
@@ -50,8 +50,47 @@ struct btd_service {
 	gint			ref;
 	struct btd_device	*device;
 	struct btd_profile	*profile;
+	btd_service_state_t	state;
 };
 
+static const char *state2str(btd_service_state_t state)
+{
+	switch (state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+		return "unavailable";
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		return "disconnected";
+	case BTD_SERVICE_STATE_CONNECTING:
+		return "connecting";
+	case BTD_SERVICE_STATE_CONNECTED:
+		return "connected";
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		return "disconnecting";
+	}
+
+	return NULL;
+}
+
+static void change_state(struct btd_service *service, btd_service_state_t state,
+									int err)
+{
+	btd_service_state_t old = service->state;
+	char addr[18];
+
+	if (state == old)
+		return;
+
+	assert(service->device != NULL);
+	assert(service->profile != NULL);
+
+	service->state = state;
+
+	ba2str(device_get_address(service->device), addr);
+	DBG("%p: device %s profile %s state changed: %s -> %s (%d)", service,
+					addr, service->profile->name,
+					state2str(old), state2str(state), err);
+}
+
 struct btd_service *btd_service_ref(struct btd_service *service)
 {
 	service->ref++;
@@ -87,6 +126,7 @@ struct btd_service *service_create(struct btd_device *device,
 	service->ref = 1;
 	service->device = device; /* Weak ref */
 	service->profile = profile;
+	service->state = BTD_SERVICE_STATE_UNAVAILABLE;
 
 	return service;
 }
@@ -96,9 +136,13 @@ int service_probe(struct btd_service *service)
 	char addr[18];
 	int err;
 
+	assert(service->state == BTD_SERVICE_STATE_UNAVAILABLE);
+
 	err = service->profile->device_probe(service->profile, service->device);
-	if (err == 0)
+	if (err == 0) {
+		change_state(service, BTD_SERVICE_STATE_DISCONNECTED, 0);
 		return 0;
+	}
 
 	ba2str(device_get_address(service->device), addr);
 	error("%s profile probe failed for %s", service->profile->name, addr);
@@ -108,6 +152,7 @@ int service_probe(struct btd_service *service)
 
 void service_shutdown(struct btd_service *service)
 {
+	change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
 	service->profile->device_remove(service->profile, service->device);
 	service->device = NULL;
 	service->profile = NULL;
@@ -122,6 +167,20 @@ int btd_service_connect(struct btd_service *service)
 	if (!profile->connect)
 		return -ENOTSUP;
 
+	switch (service->state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+		return -EINVAL;
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		break;
+	case BTD_SERVICE_STATE_CONNECTING:
+	case BTD_SERVICE_STATE_CONNECTED:
+		return -EALREADY;
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		return -EBUSY;
+	}
+
+	change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
+
 	err = profile->connect(service->device, service->profile);
 	if (err == 0)
 		return 0;
@@ -130,6 +189,8 @@ int btd_service_connect(struct btd_service *service)
 	error("%s profile connect failed for %s: %s", profile->name, addr,
 								strerror(-err));
 
+	btd_service_connecting_complete(service, err);
+
 	return err;
 }
 
@@ -142,6 +203,19 @@ int btd_service_disconnect(struct btd_service *service)
 	if (!profile->disconnect)
 		return -ENOTSUP;
 
+	switch (service->state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+		return -EINVAL;
+	case BTD_SERVICE_STATE_DISCONNECTED:
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		return -EALREADY;
+	case BTD_SERVICE_STATE_CONNECTING:
+	case BTD_SERVICE_STATE_CONNECTED:
+		break;
+	}
+
+	change_state(service, BTD_SERVICE_STATE_DISCONNECTING, 0);
+
 	err = profile->disconnect(service->device, service->profile);
 	if (err == 0)
 		return 0;
@@ -150,6 +224,8 @@ int btd_service_disconnect(struct btd_service *service)
 	error("%s profile disconnect failed for %s: %s", profile->name, addr,
 								strerror(-err));
 
+	btd_service_disconnecting_complete(service, err);
+
 	return err;
 }
 
@@ -162,3 +238,32 @@ struct btd_profile *btd_service_get_profile(const struct btd_service *service)
 {
 	return service->profile;
 }
+
+btd_service_state_t btd_service_get_state(const struct btd_service *service)
+{
+	return service->state;
+}
+
+void btd_service_connecting_complete(struct btd_service *service, int err)
+{
+	if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
+				service->state != BTD_SERVICE_STATE_CONNECTING)
+		return;
+
+	if (err == 0)
+		change_state(service, BTD_SERVICE_STATE_CONNECTED, 0);
+	else
+		change_state(service, BTD_SERVICE_STATE_DISCONNECTED, err);
+}
+
+void btd_service_disconnecting_complete(struct btd_service *service, int err)
+{
+	if (service->state != BTD_SERVICE_STATE_CONNECTED &&
+			service->state != BTD_SERVICE_STATE_DISCONNECTING)
+		return;
+
+	if (err == 0)
+		change_state(service, BTD_SERVICE_STATE_DISCONNECTED, 0);
+	else /* If disconnect fails, we assume it remains connected */
+		change_state(service, BTD_SERVICE_STATE_CONNECTED, err);
+}
diff --git a/src/service.h b/src/service.h
index f242f2f..8fb1ed5 100644
--- a/src/service.h
+++ b/src/service.h
@@ -21,6 +21,14 @@
  *
  */
 
+typedef enum {
+	BTD_SERVICE_STATE_UNAVAILABLE, /* Not probed */
+	BTD_SERVICE_STATE_DISCONNECTED,
+	BTD_SERVICE_STATE_CONNECTING,
+	BTD_SERVICE_STATE_CONNECTED,
+	BTD_SERVICE_STATE_DISCONNECTING,
+} btd_service_state_t;
+
 struct btd_service;
 struct btd_device;
 struct btd_profile;
@@ -42,3 +50,8 @@ int btd_service_disconnect(struct btd_service *service);
 /* Public member access */
 struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
+btd_service_state_t btd_service_get_state(const struct btd_service *service);
+
+/* Functions used by profile implementation */
+void btd_service_connecting_complete(struct btd_service *service, int err);
+void btd_service_disconnecting_complete(struct btd_service *service, int err);
-- 
1.8.1.4

