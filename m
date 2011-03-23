Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Remove unnecessary btd_driver_data struct
Date: Wed, 23 Mar 2011 09:20:23 -0300
Message-Id: <1300882823-671-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <AANLkTin6PCLVm5H1o0gBFhX_XipETYCxia4ASdqjPNpL@mail.gmail.com>
References: <AANLkTin6PCLVm5H1o0gBFhX_XipETYCxia4ASdqjPNpL@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   29 ++++++-----------------------
 1 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/src/device.c b/src/device.c
index e9d9e65..b4d13f2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -67,12 +67,6 @@
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
 
-struct btd_driver_data {
-	guint id;
-	struct btd_device_driver *driver;
-	void *priv;
-};
-
 struct btd_disconnect_data {
 	guint id;
 	disconnect_watch watch;
@@ -120,7 +114,7 @@ struct btd_device {
 	GSList		*uuids;
 	GSList		*services;		/* Primary services path */
 	GSList		*primaries;		/* List of primary services */
-	GSList		*drivers;		/* List of driver_data */
+	GSList		*drivers;		/* List of device drivers */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
 	struct agent	*agent;
@@ -413,15 +407,12 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static void driver_remove(struct btd_driver_data *driver_data,
+static void driver_remove(struct btd_device_driver *driver,
 						struct btd_device *device)
 {
-	struct btd_device_driver *driver = driver_data->driver;
-
 	driver->remove(device);
 
-	device->drivers = g_slist_remove(device->drivers, driver_data);
-	g_free(driver_data);
+	device->drivers = g_slist_remove(device->drivers, driver);
 }
 
 static gboolean do_disconnect(gpointer user_data)
@@ -1145,26 +1136,21 @@ void device_probe_drivers(struct btd_device *device, GSList *profiles)
 	for (list = device_drivers; list; list = list->next) {
 		struct btd_device_driver *driver = list->data;
 		GSList *probe_uuids;
-		struct btd_driver_data *driver_data;
 
 		probe_uuids = device_match_driver(device, driver, profiles);
 
 		if (!probe_uuids)
 			continue;
 
-		driver_data = g_new0(struct btd_driver_data, 1);
-
 		err = driver->probe(device, probe_uuids);
 		if (err < 0) {
 			error("%s driver probe failed for device %s",
 							driver->name, addr);
-			g_free(driver_data);
 			g_slist_free(probe_uuids);
 			continue;
 		}
 
-		driver_data->driver = driver;
-		device->drivers = g_slist_append(device->drivers, driver_data);
+		device->drivers = g_slist_append(device->drivers, driver);
 		g_slist_free(probe_uuids);
 	}
 
@@ -1198,8 +1184,7 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 	DBG("Removing drivers for %s", dstaddr);
 
 	for (list = device->drivers; list; list = next) {
-		struct btd_driver_data *driver_data = list->data;
-		struct btd_device_driver *driver = driver_data->driver;
+		struct btd_device_driver *driver = list->data;
 		const char **uuid;
 
 		next = list->next;
@@ -1214,9 +1199,7 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 
 			driver->remove(device);
 			device->drivers = g_slist_remove(device->drivers,
-								driver_data);
-			g_free(driver_data);
-
+								driver);
 			break;
 		}
 	}
-- 
1.7.4.1

