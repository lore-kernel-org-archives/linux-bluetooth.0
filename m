Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 18/21] plugins/policy: Reword audio policy code in a simple plugin
Date: Tue,  9 Jul 2013 17:39:15 +0300
Message-Id: <1373380758-16489-22-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves audio device policy to a plugin and removes any dependency of
audio plugin to it.
---
 Makefile.plugins        |   4 +-
 plugins/policy.c        | 331 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/device.c | 280 ----------------------------------------
 profiles/audio/device.h |  40 ------
 4 files changed, 334 insertions(+), 321 deletions(-)
 create mode 100644 plugins/policy.c
 delete mode 100644 profiles/audio/device.c
 delete mode 100644 profiles/audio/device.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 3efe849..7fd9e2d 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -8,6 +8,9 @@ builtin_sources += plugins/wiimote.c
 builtin_modules += autopair
 builtin_sources += plugins/autopair.c
 
+builtin_modules += policy
+builtin_sources += plugins/policy.c
+
 if MAINTAINER_MODE
 builtin_modules += gatt_example
 builtin_sources += plugins/gatt-example.c
@@ -33,7 +36,6 @@ builtin_sources += profiles/audio/main.c \
 			profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
-			profiles/audio/device.h profiles/audio/device.c \
 			profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/sink.h profiles/audio/sink.c \
 			profiles/audio/a2dp.h profiles/audio/a2dp.c \
diff --git a/plugins/policy.c b/plugins/policy.c
new file mode 100644
index 0000000..e133c94
--- /dev/null
+++ b/plugins/policy.c
@@ -0,0 +1,331 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "lib/uuid.h"
+#include "src/log.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/service.h"
+#include "src/profile.h"
+
+#define CONTROL_CONNECT_TIMEOUT 2
+
+static unsigned int service_id = 0;
+static GSList *devices = NULL;
+
+struct policy_data {
+	struct btd_device *dev;
+
+	guint ct_timer;
+	guint tg_timer;
+};
+
+static void policy_connect(struct policy_data *data,
+						struct btd_service *service)
+{
+	struct btd_profile *profile = btd_service_get_profile(service);
+
+	DBG("%s profile %s", device_get_path(data->dev), profile->name);
+
+	btd_service_connect(service);
+}
+
+static void policy_disconnect(struct policy_data *data,
+						struct btd_service *service)
+{
+	struct btd_profile *profile = btd_service_get_profile(service);
+
+	DBG("%s profile %s", device_get_path(data->dev), profile->name);
+
+	btd_service_disconnect(service);
+}
+
+static gboolean policy_connect_ct(gpointer user_data)
+{
+	struct policy_data *data = user_data;
+	struct btd_service *service;
+
+	data->ct_timer = 0;
+
+	service = btd_device_get_service(data->dev, AVRCP_REMOTE_UUID);
+	if (service != NULL)
+		policy_connect(data, service);
+
+	return FALSE;
+}
+
+static void policy_set_ct_timer(struct policy_data *data)
+{
+	if (data->ct_timer > 0)
+		g_source_remove(data->ct_timer);
+
+	data->ct_timer = g_timeout_add_seconds(CONTROL_CONNECT_TIMEOUT,
+						policy_connect_ct, data);
+}
+
+static struct policy_data *find_data(struct btd_device *dev)
+{
+	GSList *l;
+
+	for (l = devices; l; l = l->next) {
+		struct policy_data *data = l->data;
+
+		if (data->dev == dev)
+			return data;
+	}
+
+	return NULL;
+}
+
+static void policy_remove(void *user_data)
+{
+	struct policy_data *data = user_data;
+
+	if (data->ct_timer > 0)
+		g_source_remove(data->ct_timer);
+
+	if (data->tg_timer > 0)
+		g_source_remove(data->tg_timer);
+
+	g_free(data);
+}
+
+static struct policy_data *policy_get_data(struct btd_device *dev)
+{
+	struct policy_data *data;
+
+	data = find_data(dev);
+	if (data != NULL)
+		return data;
+
+	data = g_new0(struct policy_data, 1);
+	data->dev = dev;
+
+	devices = g_slist_prepend(devices, data);
+
+	return data;
+}
+
+static void sink_cb(struct btd_device *dev, btd_service_state_t old_state,
+						btd_service_state_t new_state)
+{
+	struct policy_data *data;
+	struct btd_service *controller;
+
+	controller = btd_device_get_service(dev, AVRCP_REMOTE_UUID);
+	if (controller == NULL)
+		return;
+
+	data = policy_get_data(dev);
+
+	switch (new_state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		if (data->ct_timer > 0) {
+			g_source_remove(data->ct_timer);
+			data->ct_timer = 0;
+		} else if (btd_service_get_state(controller) !=
+						BTD_SERVICE_STATE_DISCONNECTED)
+			policy_disconnect(data, controller);
+		break;
+	case BTD_SERVICE_STATE_CONNECTING:
+		break;
+	case BTD_SERVICE_STATE_CONNECTED:
+		/* Check if service initiate the connection then proceed
+		 * immediatelly otherwise set timer
+		 */
+		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+			policy_connect(data, controller);
+		else if (btd_service_get_state(controller) !=
+						BTD_SERVICE_STATE_CONNECTED)
+			policy_set_ct_timer(data);
+		break;
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		break;
+	}
+}
+
+static gboolean policy_connect_tg(gpointer user_data)
+{
+	struct policy_data *data = user_data;
+	struct btd_service *service;
+
+	data->tg_timer = 0;
+
+	service = btd_device_get_service(data->dev, AVRCP_TARGET_UUID);
+	if (service != NULL)
+		policy_connect(data, service);
+
+	return FALSE;
+}
+
+static void policy_set_tg_timer(struct policy_data *data)
+{
+	if (data->tg_timer > 0)
+		g_source_remove(data->tg_timer);
+
+	data->tg_timer = g_timeout_add_seconds(CONTROL_CONNECT_TIMEOUT,
+							policy_connect_tg,
+							data);
+}
+
+static void source_cb(struct btd_device *dev, btd_service_state_t old_state,
+						btd_service_state_t new_state)
+{
+	struct policy_data *data;
+	struct btd_service *target;
+
+	target = btd_device_get_service(dev, AVRCP_TARGET_UUID);
+	if (target == NULL)
+		return;
+
+	data = policy_get_data(dev);
+
+	switch (new_state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		if (data->tg_timer > 0) {
+			g_source_remove(data->tg_timer);
+			data->tg_timer = 0;
+		} else if (btd_service_get_state(target) !=
+						BTD_SERVICE_STATE_DISCONNECTED)
+			policy_disconnect(data, target);
+		break;
+	case BTD_SERVICE_STATE_CONNECTING:
+		break;
+	case BTD_SERVICE_STATE_CONNECTED:
+		/* Check if service initiate the connection then proceed
+		 * immediatelly otherwise set timer
+		 */
+		if (old_state == BTD_SERVICE_STATE_CONNECTING)
+			policy_connect(data, target);
+		else if (btd_service_get_state(target) !=
+						BTD_SERVICE_STATE_CONNECTED)
+			policy_set_tg_timer(data);
+		break;
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		break;
+	}
+}
+
+static void controller_cb(struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	struct policy_data *data;
+
+	data = find_data(dev);
+	if (data == NULL)
+		return;
+
+	switch (new_state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		break;
+	case BTD_SERVICE_STATE_CONNECTING:
+		break;
+	case BTD_SERVICE_STATE_CONNECTED:
+		if (data->ct_timer > 0) {
+			g_source_remove(data->ct_timer);
+			data->ct_timer = 0;
+		}
+		break;
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		break;
+	}
+}
+
+static void target_cb(struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state)
+{
+	struct btd_device *dev = btd_service_get_device(service);
+	struct policy_data *data;
+
+	data = find_data(dev);
+	if (data == NULL)
+		return;
+
+	switch (new_state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		break;
+	case BTD_SERVICE_STATE_CONNECTING:
+		break;
+	case BTD_SERVICE_STATE_CONNECTED:
+		if (data->tg_timer > 0) {
+			g_source_remove(data->tg_timer);
+			data->tg_timer = 0;
+		}
+		break;
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		break;
+	}
+}
+
+static void service_cb(struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state,
+						void *user_data)
+{
+	struct btd_profile *profile = btd_service_get_profile(service);
+
+	if (g_str_equal(profile->remote_uuid, A2DP_SINK_UUID))
+		sink_cb(dev, old_state, new_state);
+	else if (g_str_equal(profile->remote_uuid, A2DP_SOURCE_UUID))
+		source_cb(dev, old_state, new_state);
+	else if (g_str_equal(profile->remote_uuid, AVRCP_REMOTE_UUID))
+		controller_cb(service, old_state, new_state);
+	else if (g_str_equal(profile->remote_uuid, AVRCP_TARGET_UUID))
+		target_cb(service, old_state, new_state);
+}
+
+static int policy_init(void)
+{
+	service_id = btd_service_add_state_cb(service_cb, NULL);
+
+	return 0;
+}
+
+static void policy_exit(void)
+{
+	g_slist_free_full(devices, policy_remove);
+
+	btd_service_remove_state_cb(service_id);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(policy, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+						policy_init, policy_exit)
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
deleted file mode 100644
index 9b2e393..0000000
--- a/profiles/audio/device.c
+++ /dev/null
@@ -1,280 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdbool.h>
-#include <sys/stat.h>
-#include <sys/param.h>
-#include <netinet/in.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <glib.h>
-#include <dbus/dbus.h>
-#include <gdbus/gdbus.h>
-
-#include "lib/uuid.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/service.h"
-
-#include "log.h"
-#include "error.h"
-#include "dbus-common.h"
-#include "device.h"
-#include "avdtp.h"
-#include "control.h"
-#include "avctp.h"
-#include "avrcp.h"
-#include "sink.h"
-#include "source.h"
-
-#define CONTROL_CONNECT_TIMEOUT 2
-#define AVDTP_CONNECT_TIMEOUT 1
-#define AVDTP_CONNECT_TIMEOUT_BOOST 1
-
-struct dev_priv {
-	btd_service_state_t sink_state;
-	avctp_state_t avctp_state;
-
-	guint control_timer;
-	guint dc_id;
-
-	gboolean disconnecting;
-
-	unsigned int service_cb_id;
-	unsigned int avdtp_callback_id;
-	unsigned int avctp_callback_id;
-};
-
-static void device_free(struct audio_device *dev)
-{
-	struct dev_priv *priv = dev->priv;
-
-	if (priv) {
-		if (priv->control_timer)
-			g_source_remove(priv->control_timer);
-		if (priv->dc_id)
-			device_remove_disconnect_watch(dev->btd_dev,
-							priv->dc_id);
-
-		avdtp_remove_state_cb(priv->avdtp_callback_id);
-		avctp_remove_state_cb(priv->avctp_callback_id);
-		btd_service_remove_state_cb(priv->service_cb_id);
-
-		g_free(priv);
-	}
-
-	btd_device_unref(dev->btd_dev);
-
-	g_free(dev);
-}
-
-static gboolean control_connect_timeout(gpointer user_data)
-{
-	struct audio_device *dev = user_data;
-
-	dev->priv->control_timer = 0;
-
-	if (dev->control)
-		avrcp_connect(dev->btd_dev);
-
-	return FALSE;
-}
-
-static gboolean device_set_control_timer(struct audio_device *dev)
-{
-	struct dev_priv *priv = dev->priv;
-
-	if (!dev->control)
-		return FALSE;
-
-	if (priv->control_timer)
-		return FALSE;
-
-	priv->control_timer = g_timeout_add_seconds(CONTROL_CONNECT_TIMEOUT,
-							control_connect_timeout,
-							dev);
-
-	return TRUE;
-}
-
-static void device_remove_control_timer(struct audio_device *dev)
-{
-	if (dev->priv->control_timer)
-		g_source_remove(dev->priv->control_timer);
-	dev->priv->control_timer = 0;
-}
-
-static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
-				void *user_data)
-{
-	struct audio_device *dev = user_data;
-	struct dev_priv *priv = dev->priv;
-	struct btd_service *sink;
-
-	if (priv->disconnecting)
-		return;
-
-	priv->disconnecting = TRUE;
-
-	device_remove_control_timer(dev);
-
-	if (dev->control && priv->avctp_state != AVCTP_STATE_DISCONNECTED)
-		avrcp_disconnect(dev->btd_dev);
-
-	sink = btd_device_get_service(btd_dev, A2DP_SINK_UUID);
-	if (sink)
-		sink_disconnect(sink, TRUE);
-	else
-		priv->disconnecting = FALSE;
-}
-
-static void device_avdtp_cb(struct btd_device *device, struct avdtp *session,
-				avdtp_session_state_t old_state,
-				avdtp_session_state_t new_state,
-				void *user_data)
-{
-	struct audio_device *dev = user_data;
-
-	if (!dev->control)
-		return;
-
-	if (new_state == AVDTP_SESSION_STATE_CONNECTED) {
-		if (avdtp_stream_setup_active(session))
-			device_set_control_timer(dev);
-		else
-			avrcp_connect(dev->btd_dev);
-	}
-}
-
-static void device_sink_cb(struct audio_device *dev,
-				btd_service_state_t old_state,
-				btd_service_state_t new_state)
-{
-	struct dev_priv *priv = dev->priv;
-
-	priv->sink_state = new_state;
-
-	switch (new_state) {
-	case BTD_SERVICE_STATE_UNAVAILABLE:
-	case BTD_SERVICE_STATE_DISCONNECTED:
-		if (dev->control) {
-			device_remove_control_timer(dev);
-			if (priv->avctp_state != AVCTP_STATE_DISCONNECTED)
-				avrcp_disconnect(dev->btd_dev);
-		}
-		break;
-	case BTD_SERVICE_STATE_CONNECTING:
-	case BTD_SERVICE_STATE_CONNECTED:
-	case BTD_SERVICE_STATE_DISCONNECTING:
-		break;
-	}
-}
-
-static void device_avctp_cb(struct btd_device *device, avctp_state_t old_state,
-				avctp_state_t new_state, void *user_data)
-{
-	struct audio_device *dev = user_data;
-
-	if (!dev->control)
-		return;
-
-	dev->priv->avctp_state = new_state;
-
-	switch (new_state) {
-	case AVCTP_STATE_DISCONNECTED:
-		break;
-	case AVCTP_STATE_CONNECTING:
-		device_remove_control_timer(dev);
-		break;
-	case AVCTP_STATE_CONNECTED:
-		break;
-	case AVCTP_STATE_BROWSING_CONNECTING:
-		break;
-	case AVCTP_STATE_BROWSING_CONNECTED:
-		break;
-	}
-}
-
-static void service_cb(struct btd_service *service,
-						btd_service_state_t old_state,
-						btd_service_state_t new_state,
-						void *user_data)
-{
-	struct audio_device *dev = user_data;
-
-	if (dev->btd_dev != btd_service_get_device(service))
-		return;
-
-	if (service == dev->sink)
-		device_sink_cb(dev, old_state, new_state);
-}
-
-struct audio_device *audio_device_register(struct btd_device *device)
-{
-	struct audio_device *dev;
-
-	DBG("%s", device_get_path(device));
-
-	dev = g_new0(struct audio_device, 1);
-
-	dev->btd_dev = btd_device_ref(device);
-	dev->priv = g_new0(struct dev_priv, 1);
-
-	dev->priv->dc_id = device_add_disconnect_watch(dev->btd_dev,
-							disconnect_cb, dev,
-							NULL);
-	dev->priv->service_cb_id = btd_service_add_state_cb(service_cb, dev);
-	dev->priv->avdtp_callback_id = avdtp_add_state_cb(device,
-							device_avdtp_cb, dev);
-	dev->priv->avctp_callback_id = avctp_add_state_cb(device,
-							device_avctp_cb, dev);
-
-	return dev;
-}
-
-void audio_device_unregister(struct audio_device *device)
-{
-	DBG("%s", device_get_path(device->btd_dev));
-
-	if (device->sink)
-		sink_unregister(device->sink);
-
-	if (device->source)
-		source_unregister(device->source);
-
-	if (device->control)
-		control_unregister(device->control);
-
-	device_free(device);
-}
diff --git a/profiles/audio/device.h b/profiles/audio/device.h
deleted file mode 100644
index 87fc067..0000000
--- a/profiles/audio/device.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-struct audio_device;
-struct dev_priv;
-
-struct audio_device {
-	struct btd_device *btd_dev;
-
-	struct btd_service *sink;
-	struct btd_service *source;
-	struct btd_service *control;
-
-	struct dev_priv *priv;
-};
-
-struct audio_device *audio_device_register(struct btd_device *device);
-
-void audio_device_unregister(struct audio_device *device);
-- 
1.8.1.4

