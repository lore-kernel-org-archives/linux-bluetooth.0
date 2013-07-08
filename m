Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/20] audio/control: Remove dependency on struct audio_device
Date: Mon,  8 Jul 2013 17:10:16 +0300
Message-Id: <1373292626-3776-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/control.c | 80 +++++++++++++++++++++++++++++-------------------
 profiles/audio/control.h |  4 +--
 profiles/audio/manager.c |  4 +--
 3 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 9b614c3..35f1c35 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -46,14 +46,13 @@
 #include <gdbus/gdbus.h>
 
 #include "lib/uuid.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
-#include "../src/profile.h"
-#include "../src/service.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
 
 #include "log.h"
 #include "error.h"
-#include "device.h"
 #include "manager.h"
 #include "avctp.h"
 #include "control.h"
@@ -61,8 +60,10 @@
 #include "glib-helper.h"
 #include "dbus-common.h"
 
+static GSList *devices = NULL;
+
 struct control {
-	struct audio_device *dev;
+	struct btd_device *dev;
 	struct avctp *session;
 	struct btd_service *target;
 	struct btd_service *remote;
@@ -110,7 +111,7 @@ int control_connect(struct btd_service *service)
 	if (!control->target)
 		return -ENOTSUP;
 
-	control->session = avctp_connect(control->dev->btd_dev);
+	control->session = avctp_connect(control->dev);
 	if (!control->session)
 		return -EIO;
 
@@ -132,8 +133,7 @@ int control_disconnect(struct btd_service *service)
 static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
 						uint8_t op, void *data)
 {
-	struct audio_device *device = data;
-	struct control *control = btd_service_get_user_data(device->control);
+	struct control *control = data;
 	int err;
 
 	if (!control->session)
@@ -207,8 +207,7 @@ static gboolean control_property_get_connected(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	struct audio_device *device = data;
-	struct control *control = btd_service_get_user_data(device->control);
+	struct control *control = data;
 	dbus_bool_t value = (control->session != NULL);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
@@ -236,11 +235,10 @@ static const GDBusPropertyTable control_properties[] = {
 
 static void path_unregister(void *data)
 {
-	struct audio_device *dev = data;
-	struct control *control = btd_service_get_user_data(dev->control);
+	struct control *control = data;
 
-	DBG("Unregistered interface %s on path %s",
-		AUDIO_CONTROL_INTERFACE, device_get_path(dev->btd_dev));
+	DBG("Unregistered interface %s on path %s",  AUDIO_CONTROL_INTERFACE,
+						device_get_path(control->dev));
 
 	if (control->session)
 		avctp_disconnect(control->session);
@@ -253,8 +251,8 @@ static void path_unregister(void *data)
 	if (control->remote)
 		btd_service_unref(control->remote);
 
+	devices = g_slist_remove(devices, control);
 	g_free(control);
-	dev->control = NULL;
 }
 
 void control_unregister(struct btd_service *service)
@@ -266,38 +264,56 @@ void control_unregister(struct btd_service *service)
 						AUDIO_CONTROL_INTERFACE);
 }
 
-static struct control *control_init(struct audio_device *dev)
+static struct control *find_control(struct btd_device *dev)
+{
+	GSList *l;
+
+	for (l = devices; l; l = l->next) {
+		struct control *control = l->data;
+
+		if (control->dev == dev)
+			return control;
+	}
+
+	return NULL;
+}
+
+static struct control *control_init(struct btd_service *service)
 {
 	struct control *control;
+	struct btd_device *dev = btd_service_get_device(service);
 
-	if (dev->control != NULL)
-		return btd_service_get_user_data(dev->control);
+	control = find_control(dev);
+	if (control != NULL)
+		return control;
+
+	control = g_new0(struct control, 1);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					device_get_path(dev->btd_dev),
+					device_get_path(dev),
 					AUDIO_CONTROL_INTERFACE,
 					control_methods, NULL,
-					control_properties, dev,
-					path_unregister))
+					control_properties, control,
+					path_unregister)) {
+		g_free(control);
 		return NULL;
+	}
 
-	DBG("Registered interface %s on path %s",
-		AUDIO_CONTROL_INTERFACE, device_get_path(dev->btd_dev));
-
-	control = g_new0(struct control, 1);
+	DBG("Registered interface %s on path %s", AUDIO_CONTROL_INTERFACE,
+							device_get_path(dev));
 
 	control->dev = dev;
-	control->avctp_id = avctp_add_state_cb(dev->btd_dev, state_changed,
-								control);
+	control->avctp_id = avctp_add_state_cb(dev, state_changed, control);
+	devices = g_slist_prepend(devices, control);
 
 	return control;
 }
 
-int control_init_target(struct audio_device *dev, struct btd_service *service)
+int control_init_target(struct btd_service *service)
 {
 	struct control *control;
 
-	control = control_init(dev);
+	control = control_init(service);
 	if (control == NULL)
 		return -EINVAL;
 
@@ -308,11 +324,11 @@ int control_init_target(struct audio_device *dev, struct btd_service *service)
 	return 0;
 }
 
-int control_init_remote(struct audio_device *dev, struct btd_service *service)
+int control_init_remote(struct btd_service *service)
 {
 	struct control *control;
 
-	control = control_init(dev);
+	control = control_init(service);
 	if (control == NULL)
 		return -EINVAL;
 
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 5c59006..da8f16c 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -26,8 +26,8 @@
 
 struct btd_service;
 
-int control_init_target(struct audio_device *dev, struct btd_service *service);
-int control_init_remote(struct audio_device *dev, struct btd_service *service);
+int control_init_target(struct btd_service *service);
+int control_init_remote(struct btd_service *service);
 void control_unregister(struct btd_service *service);
 gboolean control_is_active(struct btd_service *service);
 
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 6b5e5d2..ca4b9d4 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -147,7 +147,7 @@ static int avrcp_target_probe(struct btd_service *service)
 		return -1;
 	}
 
-	err = control_init_target(audio_dev, service);
+	err = control_init_target(service);
 	if (err < 0)
 		return 0;
 
@@ -171,7 +171,7 @@ static int avrcp_remote_probe(struct btd_service *service)
 		return -1;
 	}
 
-	err = control_init_remote(audio_dev, service);
+	err = control_init_remote(service);
 	if (err < 0)
 		return err;
 
-- 
1.8.1.4

