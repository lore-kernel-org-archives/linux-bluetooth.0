Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v2 06/13] dbus: Add Device property to org.bluez.Service1
Date: Wed, 12 Jun 2013 09:06:48 +0200
Message-Id: <1371020815-22330-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1371020815-22330-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1371020815-22330-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Expose in D-Bus the object path of the device which the service belongs
to.
---
 src/service.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 0c9477d..3882b60 100644
--- a/src/service.c
+++ b/src/service.c
@@ -352,6 +352,22 @@ void btd_service_disconnecting_complete(struct btd_service *service, int err)
 		change_state(service, BTD_SERVICE_STATE_CONNECTED, err);
 }
 
+static gboolean service_get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_service *service = data;
+	const char *path = device_get_path(service->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable service_properties[] = {
+	{ "Device", "o", service_get_device },
+	{ }
+};
+
 static int service_register(struct btd_service *service, unsigned int id)
 {
 	DBusConnection *dbus_conn = btd_get_dbus_connection();
@@ -363,7 +379,7 @@ static int service_register(struct btd_service *service, unsigned int id)
 
 	if (g_dbus_register_interface(dbus_conn,
 					path, SERVICE_INTERFACE,
-					NULL, NULL, NULL, service,
+					NULL, NULL, service_properties, service,
 					NULL) == FALSE) {
 		g_free(path);
 		error("Unable to register service interface for %s",
-- 
1.8.1.4

