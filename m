Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 05/13] dbus: Add new org.bluez.Service1
Date: Mon,  6 May 2013 10:43:22 +0200
Message-Id: <1367829810-8262-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a D-Bus interface to represent a service that is supported by a
device.
---
 src/device.c  |  8 ++++++--
 src/service.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/service.h |  2 +-
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index ff4c553..41e0e15 100644
--- a/src/device.c
+++ b/src/device.c
@@ -171,6 +171,7 @@ struct btd_device {
 	GSList		*uuids;
 	GSList		*primaries;		/* List of primary services */
 	GSList		*services;		/* List of btd_service */
+	unsigned int	service_id;
 	GSList		*pending;		/* Pending services */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
@@ -2074,6 +2075,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
+	device->service_id = 1;
 
 	return btd_device_ref(device);
 }
@@ -2414,11 +2416,12 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 
 	service = service_create(d->dev, p);
 
-	if (service_probe(service) < 0) {
+	if (service_probe(service, d->dev->service_id) < 0) {
 		btd_service_unref(service);
 		return;
 	}
 
+	d->dev->service_id++;
 	d->dev->services = g_slist_append(d->dev->services, service);
 }
 
@@ -2436,11 +2439,12 @@ void device_probe_profile(gpointer a, gpointer b)
 
 	service = service_create(device, profile);
 
-	if (service_probe(service) < 0) {
+	if (service_probe(service, device->service_id) < 0) {
 		btd_service_unref(service);
 		return;
 	}
 
+	device->service_id++;
 	device->services = g_slist_append(device->services, service);
 
 	if (!profile->auto_connect || !device->general_connect)
diff --git a/src/service.c b/src/service.c
index aef9502..7b9e271 100644
--- a/src/service.c
+++ b/src/service.c
@@ -38,6 +38,7 @@
 #include <bluetooth/bluetooth.h>
 
 #include <glib.h>
+#include <gdbus/gdbus.h>
 
 #include "log.h"
 
@@ -45,6 +46,10 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
+#include "dbus-common.h"
+#include "error.h"
+
+#define SERVICE_INTERFACE "org.bluez.Service1"
 
 struct btd_service {
 	int			ref;
@@ -53,6 +58,9 @@ struct btd_service {
 	void			*user_data;
 	btd_service_state_t	state;
 	int			err;
+	char			*path;
+	DBusMessage             *connect_msg;
+	DBusMessage             *disconnect_msg;
 };
 
 struct service_state_callback {
@@ -63,6 +71,9 @@ struct service_state_callback {
 
 static GSList *state_callbacks = NULL;
 
+static int service_register(struct btd_service *service, unsigned int id);
+static void service_unregister(struct btd_service *service);
+
 static const char *state2str(btd_service_state_t state)
 {
 	switch (state) {
@@ -149,7 +160,7 @@ struct btd_service *service_create(struct btd_device *device,
 	return service;
 }
 
-int service_probe(struct btd_service *service)
+int service_probe(struct btd_service *service, unsigned int id)
 {
 	char addr[18];
 	int err;
@@ -159,6 +170,7 @@ int service_probe(struct btd_service *service)
 	err = service->profile->device_probe(service);
 	if (err == 0) {
 		change_state(service, BTD_SERVICE_STATE_DISCONNECTED, 0);
+		service_register(service, id); /* Ignore errors */
 		return 0;
 	}
 
@@ -170,10 +182,12 @@ int service_probe(struct btd_service *service)
 
 void service_shutdown(struct btd_service *service)
 {
+	service_unregister(service);
 	change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
 	service->profile->device_remove(service);
 	service->device = NULL;
 	service->profile = NULL;
+	service_unregister(service);
 }
 
 int btd_service_connect(struct btd_service *service)
@@ -333,3 +347,41 @@ void btd_service_disconnecting_complete(struct btd_service *service, int err)
 	else /* If disconnect fails, we assume it remains connected */
 		change_state(service, BTD_SERVICE_STATE_CONNECTED, err);
 }
+
+static int service_register(struct btd_service *service, unsigned int id)
+{
+	DBusConnection *dbus_conn = btd_get_dbus_connection();
+	char *path;
+
+	path = g_strdup_printf("%s/service%u", device_get_path(service->device),
+									id);
+	g_strdelimit(path, "-", '_');
+
+	if (g_dbus_register_interface(dbus_conn,
+					path, SERVICE_INTERFACE,
+					NULL, NULL, NULL, service,
+					NULL) == FALSE) {
+		g_free(path);
+		error("Unable to register service interface for %s",
+								service->path);
+		return -EIO;
+	}
+
+	service->path = path;
+
+	return 0;
+}
+
+static void service_unregister(struct btd_service *service)
+{
+	DBusConnection *dbus_conn = btd_get_dbus_connection();
+
+	if (service->path == NULL)
+		return;
+
+	g_dbus_unregister_interface(dbus_conn, service->path,
+							SERVICE_INTERFACE);
+
+	g_free(service->path);
+	service->path = NULL;
+}
diff --git a/src/service.h b/src/service.h
index 6ee8f17..e709f34 100644
--- a/src/service.h
+++ b/src/service.h
@@ -45,7 +45,7 @@ void btd_service_unref(struct btd_service *service);
 struct btd_service *service_create(struct btd_device *device,
 						struct btd_profile *profile);
 
-int service_probe(struct btd_service *service);
+int service_probe(struct btd_service *service, unsigned int id);
 void service_shutdown(struct btd_service *service);
 
 /* Connection control API */
-- 
1.8.1.4

