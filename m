Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 13/27] core: Add probe API to btd_service
Date: Fri, 26 Apr 2013 08:17:09 +0200
Message-Id: <1366957043-2383-14-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make use of the btd_profile callbacks directly within service.c instead
of doing it inside device.c.
---
 src/device.c  | 17 +++--------------
 src/service.c | 22 ++++++++++++++++++++++
 src/service.h |  3 +++
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/src/device.c b/src/device.c
index 81a06fd..0ae921e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -892,10 +892,8 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 static void remove_service(gpointer data)
 {
 	struct btd_service *service = data;
-	struct btd_profile *profile = btd_service_get_profile(service);
-	struct btd_device *device = btd_service_get_device(service);
 
-	profile->device_remove(profile, device);
+	service_shutdown(service);
 	btd_service_unref(service);
 }
 
@@ -2349,7 +2347,6 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 {
 	struct probe_data *d = user_data;
 	struct btd_service *service;
-	int err;
 
 	if (p->device_probe == NULL)
 		return;
@@ -2359,9 +2356,7 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 
 	service = service_create(d->dev, p);
 
-	err = p->device_probe(p, d->dev);
-	if (err < 0) {
-		error("%s profile probe failed for %s", p->name, d->addr);
+	if (service_probe(service) < 0) {
 		btd_service_unref(service);
 		return;
 	}
@@ -2374,8 +2369,6 @@ void device_probe_profile(gpointer a, gpointer b)
 	struct btd_device *device = a;
 	struct btd_profile *profile = b;
 	struct btd_service *service;
-	char addr[18];
-	int err;
 
 	if (profile->device_probe == NULL)
 		return;
@@ -2383,13 +2376,9 @@ void device_probe_profile(gpointer a, gpointer b)
 	if (!device_match_profile(device, profile, device->uuids))
 		return;
 
-	ba2str(&device->bdaddr, addr);
-
 	service = service_create(device, profile);
 
-	err = profile->device_probe(profile, device);
-	if (err < 0) {
-		error("%s profile probe failed for %s", profile->name, addr);
+	if (service_probe(service) < 0) {
 		btd_service_unref(service);
 		return;
 	}
diff --git a/src/service.c b/src/service.c
index 4b69cba..39a58d9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -91,6 +91,28 @@ struct btd_service *service_create(struct btd_device *device,
 	return service;
 }
 
+int service_probe(struct btd_service *service)
+{
+	char addr[18];
+	int err;
+
+	err = service->profile->device_probe(service->profile, service->device);
+	if (err == 0)
+		return 0;
+
+	ba2str(device_get_address(service->device), addr);
+	error("%s profile probe failed for %s", service->profile->name, addr);
+
+	return err;
+}
+
+void service_shutdown(struct btd_service *service)
+{
+	service->profile->device_remove(service->profile, service->device);
+	service->device = NULL;
+	service->profile = NULL;
+}
+
 struct btd_device *btd_service_get_device(const struct btd_service *service)
 {
 	return service->device;
diff --git a/src/service.h b/src/service.h
index 4f83387..4a69571 100644
--- a/src/service.h
+++ b/src/service.h
@@ -32,6 +32,9 @@ void btd_service_unref(struct btd_service *service);
 struct btd_service *service_create(struct btd_device *device,
 						struct btd_profile *profile);
 
+int service_probe(struct btd_service *service);
+void service_shutdown(struct btd_service *service);
+
 /* Public member access */
 struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
-- 
1.8.1.4

