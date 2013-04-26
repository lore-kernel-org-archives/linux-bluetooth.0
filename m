Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 14/27] core: Add connect/disconnect API to btd_service
Date: Fri, 26 Apr 2013 08:17:10 +0200
Message-Id: <1366957043-2383-15-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make use of the btd_profile connect/disconnect callbacks directly within
service.c instead of doing it inside device.c.
---
 src/device.c  | 39 ++++++++++++++++++++++++---------------
 src/service.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/service.h |  4 ++++
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0ae921e..abdd3af 100644
--- a/src/device.c
+++ b/src/device.c
@@ -990,11 +990,12 @@ static void dev_disconn_profile(gpointer a, gpointer b)
 {
 	struct btd_profile *profile = a;
 	struct btd_device *dev = b;
+	struct btd_service *service;
+	GSList *l;
 
-	if (!profile->disconnect)
-		return;
-
-	profile->disconnect(dev, profile);
+	l = find_service_with_profile(dev->services, profile);
+	service = l->data;
+	btd_service_disconnect(service);
 }
 
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
@@ -1071,17 +1072,20 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 static int connect_next(struct btd_device *dev)
 {
 	struct btd_profile *profile;
+	struct btd_service *service;
 	int err = -ENOENT;
 
 	while (dev->pending) {
+		GSList *l;
+
 		profile = dev->pending->data;
 
-		err = profile->connect(dev, profile);
-		if (err == 0)
+		l = find_service_with_profile(dev->services, profile);
+		service = l->data;
+
+		if (btd_service_connect(service) == 0)
 			return 0;
 
-		error("Failed to connect %s: %s", profile->name,
-							strerror(-err));
 		dev->pending = g_slist_remove(dev->pending, profile);
 	}
 
@@ -1328,6 +1332,8 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 {
 	struct btd_device *dev = user_data;
 	struct btd_profile *p;
+	struct btd_service *service;
+	GSList *l;
 	const char *pattern;
 	char *uuid;
 	int err;
@@ -1346,16 +1352,19 @@ static DBusMessage *disconnect_profile(DBusConnection *conn, DBusMessage *msg,
 	if (!p)
 		return btd_error_invalid_args(msg);
 
-	if (!p->disconnect)
-		return btd_error_not_supported(msg);
+	l = find_service_with_profile(dev->services, p);
+	service = l->data;
 
-	err = p->disconnect(dev, p);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+	err = btd_service_disconnect(service);
+	if (err == 0) {
+		dev->disconnect = dbus_message_ref(msg);
+		return NULL;
+	}
 
-	dev->disconnect = dbus_message_ref(msg);
+	if (err == -ENOTSUP)
+		return btd_error_not_supported(msg);
 
-	return NULL;
+	return btd_error_failed(msg, strerror(-err));
 }
 
 static void device_svc_resolved(struct btd_device *dev, int err)
diff --git a/src/service.c b/src/service.c
index 39a58d9..378dd2d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -113,6 +113,46 @@ void service_shutdown(struct btd_service *service)
 	service->profile = NULL;
 }
 
+int btd_service_connect(struct btd_service *service)
+{
+	struct btd_profile *profile = service->profile;
+	char addr[18];
+	int err;
+
+	if (!profile->connect)
+		return -ENOTSUP;
+
+	err = profile->connect(service->device, service->profile);
+	if (err == 0)
+		return 0;
+
+	ba2str(device_get_address(service->device), addr);
+	error("%s profile connect failed for %s: %s", profile->name, addr,
+								strerror(-err));
+
+	return err;
+}
+
+int btd_service_disconnect(struct btd_service *service)
+{
+	struct btd_profile *profile = service->profile;
+	char addr[18];
+	int err;
+
+	if (!profile->disconnect)
+		return -ENOTSUP;
+
+	err = profile->disconnect(service->device, service->profile);
+	if (err == 0)
+		return 0;
+
+	ba2str(device_get_address(service->device), addr);
+	error("%s profile disconnect failed for %s: %s", profile->name, addr,
+								strerror(-err));
+
+	return err;
+}
+
 struct btd_device *btd_service_get_device(const struct btd_service *service)
 {
 	return service->device;
diff --git a/src/service.h b/src/service.h
index 4a69571..f242f2f 100644
--- a/src/service.h
+++ b/src/service.h
@@ -35,6 +35,10 @@ struct btd_service *service_create(struct btd_device *device,
 int service_probe(struct btd_service *service);
 void service_shutdown(struct btd_service *service);
 
+/* Connection control API */
+int btd_service_connect(struct btd_service *service);
+int btd_service_disconnect(struct btd_service *service);
+
 /* Public member access */
 struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
-- 
1.8.1.4

