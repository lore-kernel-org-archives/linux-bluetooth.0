Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v5 3/3] profile: Use btd_service for connect/disconnect
Date: Fri, 26 Apr 2013 11:46:25 +0200
Message-Id: <1366969585-28654-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366969585-28654-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366969585-28654-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Change the btd_profile connect/disconnect callbacks to receive a
btd_service pointer. This should make it possible to handle multiple
instances of the same profile in a specific device.

The patch strongly influences how the profiles should interact with the
core. The state transitions, previously reported using the device.h API
(device_profile_connected() and device_profile_disconnected()), have
now been replaced by the btd_service API.

The transitions will then be propagated to device.c by means of the
conventional state-changed callback mechanism.
---
 Makefile.plugins              |  4 +--
 profiles/audio/control.c      | 20 +++--------
 profiles/audio/manager.c      | 44 +++++++-----------------
 profiles/audio/manager.h      |  5 ---
 profiles/audio/sink.c         | 18 +++++-----
 profiles/audio/source.c       | 18 +++++-----
 profiles/input/device.c       | 21 +++++-------
 profiles/input/device.h       |  5 ++-
 profiles/input/manager.c      | 11 ------
 profiles/input/manager.h      | 25 --------------
 profiles/network/connection.c | 39 ++++++---------------
 profiles/network/connection.h |  4 +--
 profiles/network/manager.c    | 79 ++++---------------------------------------
 profiles/network/manager.h    | 25 --------------
 src/device.c                  | 33 +++++++++++-------
 src/device.h                  |  7 ----
 src/profile.c                 | 29 ++++++++++------
 src/profile.h                 |  6 ++--
 src/service.c                 |  4 +--
 19 files changed, 108 insertions(+), 289 deletions(-)
 delete mode 100644 profiles/input/manager.h
 delete mode 100644 profiles/network/manager.h

diff --git a/Makefile.plugins b/Makefile.plugins
index f497782..44e6eca 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -41,14 +41,14 @@ builtin_sources += profiles/audio/main.c \
 			profiles/audio/a2dp-codecs.h
 
 builtin_modules += network
-builtin_sources += profiles/network/manager.h profiles/network/manager.c \
+builtin_sources += profiles/network/manager.c \
 			profiles/network/common.h profiles/network/common.c \
 			profiles/network/server.h profiles/network/server.c \
 			profiles/network/connection.h \
 			profiles/network/connection.c
 
 builtin_modules += input
-builtin_sources += profiles/input/manager.h profiles/input/manager.c \
+builtin_sources += profiles/input/manager.c \
 			profiles/input/server.h profiles/input/server.c \
 			profiles/input/device.h profiles/input/device.c
 
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index bb3f812..cdba385 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -70,34 +70,22 @@ struct control {
 
 void control_target_connected(struct control *control, int err)
 {
-	struct btd_device *device = btd_service_get_device(control->target);
-	struct btd_profile *profile = btd_service_get_profile(control->target);
-
-	device_profile_connected(device, profile, err);
+	btd_service_connecting_complete(control->target, err);
 }
 
 void control_target_disconnected(struct control *control, int err)
 {
-	struct btd_device *device = btd_service_get_device(control->target);
-	struct btd_profile *profile = btd_service_get_profile(control->target);
-
-	device_profile_disconnected(device, profile, err);
+	btd_service_disconnecting_complete(control->target, err);
 }
 
 void control_remote_connected(struct control *control, int err)
 {
-	struct btd_device *device = btd_service_get_device(control->remote);
-	struct btd_profile *profile = btd_service_get_profile(control->remote);
-
-	device_profile_connected(device, profile, err);
+	btd_service_connecting_complete(control->remote, err);
 }
 
 void control_remote_disconnected(struct control *control, int err)
 {
-	struct btd_device *device = btd_service_get_device(control->remote);
-	struct btd_profile *profile = btd_service_get_profile(control->remote);
-
-	device_profile_disconnected(device, profile, err);
+	btd_service_disconnecting_complete(control->remote, err);
 }
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 901f94f..15226e4 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -157,9 +157,9 @@ static int avrcp_probe(struct btd_service *service)
 	return 0;
 }
 
-static int a2dp_source_connect(struct btd_device *dev,
-						struct btd_profile *profile)
+static int a2dp_source_connect(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
 	struct audio_device *audio_dev;
 
@@ -174,9 +174,9 @@ static int a2dp_source_connect(struct btd_device *dev,
 	return source_connect(audio_dev);
 }
 
-static int a2dp_source_disconnect(struct btd_device *dev,
-						struct btd_profile *profile)
+static int a2dp_source_disconnect(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
 	struct audio_device *audio_dev;
 
@@ -191,9 +191,9 @@ static int a2dp_source_disconnect(struct btd_device *dev,
 	return source_disconnect(audio_dev, FALSE);
 }
 
-static int a2dp_sink_connect(struct btd_device *dev,
-						struct btd_profile *profile)
+static int a2dp_sink_connect(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
 	struct audio_device *audio_dev;
 
@@ -208,9 +208,9 @@ static int a2dp_sink_connect(struct btd_device *dev,
 	return sink_connect(audio_dev);
 }
 
-static int a2dp_sink_disconnect(struct btd_device *dev,
-						struct btd_profile *profile)
+static int a2dp_sink_disconnect(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
 	struct audio_device *audio_dev;
 
@@ -225,9 +225,9 @@ static int a2dp_sink_disconnect(struct btd_device *dev,
 	return sink_disconnect(audio_dev, FALSE);
 }
 
-static int avrcp_target_connect(struct btd_device *dev,
-						struct btd_profile *profile)
+static int avrcp_target_connect(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
 	struct audio_device *audio_dev;
 
@@ -242,9 +242,9 @@ static int avrcp_target_connect(struct btd_device *dev,
 	return control_connect(audio_dev);
 }
 
-static int avrcp_target_disconnect(struct btd_device *dev,
-						struct btd_profile *profile)
+static int avrcp_target_disconnect(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
 	struct audio_device *audio_dev;
 
@@ -401,26 +401,6 @@ static struct btd_adapter_driver media_driver = {
 	.remove	= media_server_remove,
 };
 
-void audio_sink_connected(struct btd_device *dev, int err)
-{
-	device_profile_connected(dev, &a2dp_sink_profile, err);
-}
-
-void audio_sink_disconnected(struct btd_device *dev, int err)
-{
-	device_profile_disconnected(dev, &a2dp_sink_profile, err);
-}
-
-void audio_source_connected(struct btd_device *dev, int err)
-{
-	device_profile_connected(dev, &a2dp_source_profile, err);
-}
-
-void audio_source_disconnected(struct btd_device *dev, int err)
-{
-	device_profile_disconnected(dev, &a2dp_source_profile, err);
-}
-
 int audio_manager_init(GKeyFile *conf)
 {
 	if (conf)
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index 2567e46..b8d8ef7 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -29,11 +29,6 @@ struct enabled_interfaces {
 	gboolean media_player;
 };
 
-void audio_sink_connected(struct btd_device *dev, int err);
-void audio_sink_disconnected(struct btd_device *dev, int err);
-void audio_source_connected(struct btd_device *dev, int err);
-void audio_source_disconnected(struct btd_device *dev, int err);
-
 int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 9f1a2d9..3969417 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -149,7 +149,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 
 	switch (new_state) {
 	case AVDTP_STATE_IDLE:
-		audio_sink_disconnected(dev->btd_dev, 0);
+		btd_service_disconnecting_complete(sink->service, 0);
 
 		if (sink->disconnect_id > 0) {
 			a2dp_cancel(dev, sink->disconnect_id);
@@ -194,7 +194,7 @@ static gboolean stream_setup_retry(gpointer user_data)
 		err = -EIO;
 	}
 
-	audio_sink_connected(sink->dev->btd_dev, err);
+	btd_service_connecting_complete(sink->service, err);
 
 	if (sink->connect_id > 0) {
 		a2dp_cancel(sink->dev, sink->connect_id);
@@ -214,7 +214,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	if (stream) {
 		DBG("Stream successfully created");
-		audio_sink_connected(sink->dev->btd_dev, 0);
+		btd_service_connecting_complete(sink->service, 0);
 		return;
 	}
 
@@ -228,7 +228,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 							sink);
 	} else {
 		DBG("Stream setup failed : %s", avdtp_strerror(err));
-		audio_sink_connected(sink->dev->btd_dev, -EIO);
+		btd_service_connecting_complete(sink->service, -EIO);
 	}
 }
 
@@ -248,7 +248,7 @@ static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
 	return;
 
 failed:
-	audio_sink_connected(sink->dev->btd_dev, -EIO);
+	btd_service_connecting_complete(sink->service, -EIO);
 
 	avdtp_unref(sink->session);
 	sink->session = NULL;
@@ -286,7 +286,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	return;
 
 failed:
-	audio_sink_connected(sink->dev->btd_dev, -EIO);
+	btd_service_connecting_complete(sink->service, -EIO);
 	avdtp_unref(sink->session);
 	sink->session = NULL;
 }
@@ -348,13 +348,13 @@ static void sink_free(struct audio_device *dev)
 		avdtp_unref(sink->session);
 
 	if (sink->connect_id > 0) {
-		audio_sink_connected(dev->btd_dev, -ECANCELED);
+		btd_service_connecting_complete(sink->service, -ECANCELED);
 		a2dp_cancel(dev, sink->connect_id);
 		sink->connect_id = 0;
 	}
 
 	if (sink->disconnect_id > 0) {
-		audio_sink_disconnected(dev->btd_dev, -ECANCELED);
+		btd_service_disconnecting_complete(sink->service, -ECANCELED);
 		a2dp_cancel(dev, sink->disconnect_id);
 		sink->disconnect_id = 0;
 	}
@@ -434,7 +434,7 @@ int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 	if (sink->connect_id > 0) {
 		a2dp_cancel(dev, sink->connect_id);
 		sink->connect_id = 0;
-		audio_sink_connected(dev->btd_dev, -ECANCELED);
+		btd_service_connecting_complete(sink->service, -ECANCELED);
 
 		avdtp_unref(sink->session);
 		sink->session = NULL;
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 20fd412..226c372 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -150,7 +150,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 
 	switch (new_state) {
 	case AVDTP_STATE_IDLE:
-		audio_source_disconnected(dev->btd_dev, 0);
+		btd_service_disconnecting_complete(source->service, 0);
 
 		if (source->disconnect_id > 0) {
 			a2dp_cancel(dev, source->disconnect_id);
@@ -195,7 +195,7 @@ static gboolean stream_setup_retry(gpointer user_data)
 		err = -EIO;
 	}
 
-	audio_source_connected(source->dev->btd_dev, err);
+	btd_service_connecting_complete(source->service, err);
 
 	if (source->connect_id > 0) {
 		a2dp_cancel(source->dev, source->connect_id);
@@ -215,7 +215,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	if (stream) {
 		DBG("Stream successfully created");
-		audio_source_connected(source->dev->btd_dev, 0);
+		btd_service_connecting_complete(source->service, 0);
 		return;
 	}
 
@@ -229,7 +229,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 							source);
 	} else {
 		DBG("Stream setup failed : %s", avdtp_strerror(err));
-		audio_source_connected(source->dev->btd_dev, -EIO);
+		btd_service_connecting_complete(source->service, -EIO);
 	}
 }
 
@@ -252,7 +252,7 @@ static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
 	return;
 
 failed:
-	audio_source_connected(source->dev->btd_dev, -EIO);
+	btd_service_connecting_complete(source->service, -EIO);
 
 	avdtp_unref(source->session);
 	source->session = NULL;
@@ -290,7 +290,7 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 	return;
 
 failed:
-	audio_source_connected(source->dev->btd_dev, -EIO);
+	btd_service_connecting_complete(source->service, -EIO);
 	avdtp_unref(source->session);
 	source->session = NULL;
 }
@@ -352,13 +352,13 @@ static void source_free(struct audio_device *dev)
 		avdtp_unref(source->session);
 
 	if (source->connect_id > 0) {
-		audio_source_connected(dev->btd_dev, -ECANCELED);
+		btd_service_connecting_complete(source->service, -ECANCELED);
 		a2dp_cancel(dev, source->connect_id);
 		source->connect_id = 0;
 	}
 
 	if (source->disconnect_id > 0) {
-		audio_source_disconnected(dev->btd_dev, -ECANCELED);
+		btd_service_disconnecting_complete(source->service, -ECANCELED);
 		a2dp_cancel(dev, source->disconnect_id);
 		source->disconnect_id = 0;
 	}
@@ -431,7 +431,7 @@ int source_disconnect(struct audio_device *dev, gboolean shutdown)
 	if (source->connect_id > 0) {
 		a2dp_cancel(dev, source->connect_id);
 		source->connect_id = 0;
-		audio_source_connected(dev->btd_dev, -ECANCELED);
+		btd_service_connecting_complete(source->service, -ECANCELED);
 
 		avdtp_unref(source->session);
 		source->session = NULL;
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 53f46be..498c226 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -48,7 +48,6 @@
 #include "../src/storage.h"
 #include "../src/dbus-common.h"
 
-#include "manager.h"
 #include "device.h"
 #include "error.h"
 #include <btio/btio.h>
@@ -559,7 +558,7 @@ static int input_device_connected(struct input_device *idev)
 	idev->dc_id = device_add_disconnect_watch(idev->device, disconnect_cb,
 							idev, NULL);
 
-	input_manager_device_connected(idev->device, 0);
+	btd_service_connecting_complete(idev->service, 0);
 
 	return 0;
 }
@@ -586,7 +585,7 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	return;
 
 failed:
-	input_manager_device_connected(idev->device, err);
+	btd_service_connecting_complete(idev->service, err);
 
 	/* So we guarantee the interrupt channel is closed before the
 	 * control channel (if we only do unref GLib will close it only
@@ -638,7 +637,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 	return;
 
 failed:
-	input_manager_device_connected(idev->device, -EIO);
+	btd_service_connecting_complete(idev->service, -EIO);
 	g_io_channel_unref(idev->ctrl_io);
 	idev->ctrl_io = NULL;
 }
@@ -737,13 +736,11 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
 
 }
 
-int input_device_connect(struct btd_device *dev, struct btd_profile *profile)
+int input_device_connect(struct btd_service *service)
 {
 	struct input_device *idev;
 
-	idev = find_device_by_path(devices, device_get_path(dev));
-	if (!idev)
-		return -ENOENT;
+	idev = btd_service_get_user_data(service);
 
 	if (idev->ctrl_io)
 		return -EBUSY;
@@ -754,20 +751,18 @@ int input_device_connect(struct btd_device *dev, struct btd_profile *profile)
 	return dev_connect(idev);
 }
 
-int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile)
+int input_device_disconnect(struct btd_service *service)
 {
 	struct input_device *idev;
 	int err;
 
-	idev = find_device_by_path(devices, device_get_path(dev));
-	if (!idev)
-		return -ENOENT;
+	idev = btd_service_get_user_data(service);
 
 	err = connection_disconnect(idev, 0);
 	if (err < 0)
 		return err;
 
-	device_profile_disconnected(dev, profile, 0);
+	btd_service_disconnecting_complete(service, 0);
 
 	return 0;
 }
diff --git a/profiles/input/device.h b/profiles/input/device.h
index fd7f847..39c642d 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -36,6 +36,5 @@ int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
 int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst);
 
-int input_device_connect(struct btd_device *dev, struct btd_profile *profile);
-int input_device_disconnect(struct btd_device *dev,
-						struct btd_profile *profile);
+int input_device_connect(struct btd_service *service);
+int input_device_disconnect(struct btd_service *service);
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index dc771a6..689ccdd 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -43,7 +43,6 @@
 
 #include "device.h"
 #include "server.h"
-#include "manager.h"
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
@@ -72,16 +71,6 @@ static struct btd_profile input_profile = {
 	.adapter_remove = hid_server_remove,
 };
 
-void input_manager_device_connected(struct btd_device *dev, int err)
-{
-	device_profile_connected(dev, &input_profile, err);
-}
-
-void input_manager_device_disconnected(struct btd_device *dev, int err)
-{
-	device_profile_disconnected(dev, &input_profile, err);
-}
-
 static GKeyFile *load_config_file(const char *file)
 {
 	GKeyFile *keyfile;
diff --git a/profiles/input/manager.h b/profiles/input/manager.h
deleted file mode 100644
index 3a05094..0000000
--- a/profiles/input/manager.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
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
-void input_manager_device_connected(struct btd_device *dev, int err);
-void input_manager_device_disconnected(struct btd_device *dev, int err);
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 8fbde14..2d6c363 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -48,7 +48,6 @@
 
 #include "error.h"
 #include "common.h"
-#include "manager.h"
 #include "connection.h"
 
 #define NETWORK_PEER_INTERFACE "org.bluez.Network1"
@@ -144,7 +143,7 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 	device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
 	nc->dc_id = 0;
 
-	network_disconnected(nc->peer->device, nc->id, 0);
+	btd_service_disconnecting_complete(nc->service, 0);
 
 	info("%s disconnected", nc->dev);
 
@@ -181,7 +180,7 @@ static void cancel_connection(struct network_conn *nc, int err)
 		nc->timeout_source = 0;
 	}
 
-	network_connected(nc->peer->device, nc->id, err);
+	btd_service_connecting_complete(nc->service, err);
 	if (nc->connect)
 		local_connect_cb(nc, err);
 
@@ -289,7 +288,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 
 	bnep_if_up(nc->dev);
 
-	network_connected(nc->peer->device, nc->id, 0);
+	btd_service_connecting_complete(nc->service, 0);
 	if (nc->connect)
 		local_connect_cb(nc, 0);
 
@@ -430,7 +429,7 @@ static DBusMessage *local_connect(DBusConnection *conn,
 	if (nc && nc->connect)
 		return btd_error_busy(msg);
 
-	err = connection_connect(peer->device, id);
+	err = connection_connect(nc->service);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -444,24 +443,17 @@ static DBusMessage *local_connect(DBusConnection *conn,
 }
 
 /* Connect and initiate BNEP session */
-int connection_connect(struct btd_device *device, uint16_t id)
+int connection_connect(struct btd_service *service)
 {
-	struct network_peer *peer;
-	struct network_conn *nc;
+	struct network_conn *nc = btd_service_get_user_data(service);
+	struct network_peer *peer = nc->peer;
+	uint16_t id = get_service_id(service);
 	GError *err = NULL;
 	const bdaddr_t *src;
 	const bdaddr_t *dst;
 
 	DBG("id %u", id);
 
-	peer = find_peer(peers, device);
-	if (!peer)
-		return -ENOENT;
-
-	nc = find_connection(peer->connections, id);
-	if (!nc)
-		return -ENOTSUP;
-
 	if (nc->state != DISCONNECTED)
 		return -EALREADY;
 
@@ -485,18 +477,9 @@ int connection_connect(struct btd_device *device, uint16_t id)
 	return 0;
 }
 
-int connection_disconnect(struct btd_device *device, uint16_t id)
+int connection_disconnect(struct btd_service *service)
 {
-	struct network_peer *peer;
-	struct network_conn *nc;
-
-	peer = find_peer(peers, device);
-	if (!peer)
-		return -ENOENT;
-
-	nc = find_connection(peer->connections, id);
-	if (!nc)
-		return -ENOTSUP;
+	struct network_conn *nc = btd_service_get_user_data(service);
 
 	if (nc->state == DISCONNECTED)
 		return 0;
@@ -519,7 +502,7 @@ static DBusMessage *local_disconnect(DBusConnection *conn,
 		if (nc->state == DISCONNECTED)
 			continue;
 
-		err = connection_disconnect(peer->device, nc->id);
+		err = connection_disconnect(nc->service);
 		if (err < 0)
 			return btd_error_failed(msg, strerror(-err));
 
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index 1e7eedb..4a8b43b 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -23,5 +23,5 @@
 
 int connection_register(struct btd_service *service);
 void connection_unregister(struct btd_service *service);
-int connection_connect(struct btd_device *device, uint16_t id);
-int connection_disconnect(struct btd_device *device, uint16_t id);
+int connection_connect(struct btd_service *service);
+int connection_disconnect(struct btd_service *service);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index f37954a..03b1b3d 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -42,7 +42,6 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
-#include "manager.h"
 #include "common.h"
 #include "connection.h"
 #include "server.h"
@@ -75,16 +74,6 @@ done:
 				conf_security ? "true" : "false");
 }
 
-static int panu_connect(struct btd_device *dev, struct btd_profile *profile)
-{
-	return connection_connect(dev, BNEP_SVC_PANU);
-}
-
-static int panu_disconnect(struct btd_device *dev, struct btd_profile *profile)
-{
-	return connection_disconnect(dev, BNEP_SVC_PANU);
-}
-
 static int panu_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
@@ -104,16 +93,6 @@ static void panu_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_PANU);
 }
 
-static int gn_connect(struct btd_device *dev, struct btd_profile *profile)
-{
-	return connection_connect(dev, BNEP_SVC_GN);
-}
-
-static int gn_disconnect(struct btd_device *dev, struct btd_profile *profile)
-{
-	return connection_disconnect(dev, BNEP_SVC_GN);
-}
-
 static int gn_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
@@ -133,16 +112,6 @@ static void gn_server_remove(struct btd_profile *p,
 	server_unregister(adapter, BNEP_SVC_GN);
 }
 
-static int nap_connect(struct btd_device *dev, struct btd_profile *profile)
-{
-	return connection_connect(dev, BNEP_SVC_NAP);
-}
-
-static int nap_disconnect(struct btd_device *dev, struct btd_profile *profile)
-{
-	return connection_disconnect(dev, BNEP_SVC_NAP);
-}
-
 static int nap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
@@ -168,8 +137,8 @@ static struct btd_profile panu_profile = {
 	.remote_uuid	= PANU_UUID,
 	.device_probe	= connection_register,
 	.device_remove	= connection_unregister,
-	.connect	= panu_connect,
-	.disconnect	= panu_disconnect,
+	.connect	= connection_connect,
+	.disconnect	= connection_disconnect,
 	.adapter_probe	= panu_server_probe,
 	.adapter_remove	= panu_server_remove,
 };
@@ -180,8 +149,8 @@ static struct btd_profile gn_profile = {
 	.remote_uuid	= GN_UUID,
 	.device_probe	= connection_register,
 	.device_remove	= connection_unregister,
-	.connect	= gn_connect,
-	.disconnect	= gn_disconnect,
+	.connect	= connection_connect,
+	.disconnect	= connection_disconnect,
 	.adapter_probe	= gn_server_probe,
 	.adapter_remove	= gn_server_remove,
 };
@@ -192,48 +161,12 @@ static struct btd_profile nap_profile = {
 	.remote_uuid	= NAP_UUID,
 	.device_probe	= connection_register,
 	.device_remove	= connection_unregister,
-	.connect	= nap_connect,
-	.disconnect	= nap_disconnect,
+	.connect	= connection_connect,
+	.disconnect	= connection_disconnect,
 	.adapter_probe	= nap_server_probe,
 	.adapter_remove	= nap_server_remove,
 };
 
-void network_connected(struct btd_device *dev, int id, int err)
-{
-	switch (id) {
-	case BNEP_SVC_PANU:
-		device_profile_connected(dev, &panu_profile, err);
-		break;
-	case BNEP_SVC_GN:
-		device_profile_connected(dev, &gn_profile, err);
-		break;
-	case BNEP_SVC_NAP:
-		device_profile_connected(dev, &nap_profile, err);
-		break;
-	default:
-		error("Invalid id %d passed to network_connected", id);
-		break;
-	}
-}
-
-void network_disconnected(struct btd_device *dev, int id, int err)
-{
-	switch (id) {
-	case BNEP_SVC_PANU:
-		device_profile_disconnected(dev, &panu_profile, err);
-		break;
-	case BNEP_SVC_GN:
-		device_profile_disconnected(dev, &gn_profile, err);
-		break;
-	case BNEP_SVC_NAP:
-		device_profile_disconnected(dev, &gn_profile, err);
-		break;
-	default:
-		error("Invalid id %d passed to network_disconnected", id);
-		break;
-	}
-}
-
 static int network_init(void)
 {
 	read_config(CONFIGDIR "/network.conf");
diff --git a/profiles/network/manager.h b/profiles/network/manager.h
deleted file mode 100644
index 8a8c065..0000000
--- a/profiles/network/manager.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
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
-void network_connected(struct btd_device *dev, int id, int err);
-void network_disconnected(struct btd_device *dev, int id, int err);
diff --git a/src/device.c b/src/device.c
index 91fcd89..dd137ed 100644
--- a/src/device.c
+++ b/src/device.c
@@ -73,6 +73,7 @@
 #define DISCOVERY_TIMER		1
 
 static DBusConnection *dbus_conn = NULL;
+unsigned service_state_cb_id;
 
 struct btd_disconnect_data {
 	guint id;
@@ -1092,7 +1093,7 @@ static int connect_next(struct btd_device *dev)
 	return err;
 }
 
-void device_profile_connected(struct btd_device *dev,
+static void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
 	struct btd_service *pending;
@@ -1108,10 +1109,6 @@ void device_profile_connected(struct btd_device *dev,
 	if (l != NULL)
 		dev->pending = g_slist_delete_link(dev->pending, l);
 
-	l = find_service_with_profile(dev->services, profile);
-	if (l != NULL)
-		btd_service_connecting_complete(l->data, err);
-
 	/* Only continue connecting the next profile if it matches the first
 	 * pending, otherwise it will trigger another connect to the same
 	 * profile
@@ -1312,15 +1309,9 @@ static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-void device_profile_disconnected(struct btd_device *dev,
+static void device_profile_disconnected(struct btd_device *dev,
 					struct btd_profile *profile, int err)
 {
-	GSList *l;
-
-	l = find_service_with_profile(dev->services, profile);
-	if (l != NULL)
-		btd_service_disconnecting_complete(l->data, err);
-
 	if (!dev->disconnect)
 		return;
 
@@ -4307,11 +4298,29 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 	store_device_info(device);
 }
 
+static void service_state_changed(struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state,
+						void *user_data)
+{
+	struct btd_profile *profile = btd_service_get_profile(service);
+	struct btd_device *device = btd_service_get_device(service);
+	int err = btd_service_get_error(service);
+
+	if (old_state == BTD_SERVICE_STATE_CONNECTING)
+		device_profile_connected(device, profile, err);
+	else if (old_state == BTD_SERVICE_STATE_DISCONNECTING)
+		device_profile_disconnected(device, profile, err);
+}
+
 void btd_device_init(void)
 {
 	dbus_conn = btd_get_dbus_connection();
+	service_state_cb_id = btd_service_add_state_cb(
+						service_state_changed, NULL);
 }
 
 void btd_device_cleanup(void)
 {
+	btd_service_remove_state_cb(service_state_cb_id);
 }
diff --git a/src/device.h b/src/device.h
index d072015..f467fa6 100644
--- a/src/device.h
+++ b/src/device.h
@@ -120,12 +120,5 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
 bool device_remove_svc_complete_callback(struct btd_device *dev,
 							unsigned int id);
 
-struct btd_profile;
-
-void device_profile_connected(struct btd_device *dev,
-					struct btd_profile *profile, int err);
-void device_profile_disconnected(struct btd_device *dev,
-					struct btd_profile *profile, int err);
-
 void btd_device_init(void);
 void btd_device_cleanup(void);
diff --git a/src/profile.c b/src/profile.c
index b2c5ebf..0500983 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -591,6 +591,7 @@ struct ext_io {
 	guint io_id;
 	struct btd_adapter *adapter;
 	struct btd_device *device;
+	struct btd_service *service;
 
 	bool resolving;
 	bool connected;
@@ -722,6 +723,9 @@ static void ext_io_destroy(gpointer p)
 	if (ext_io->device)
 		btd_device_unref(ext_io->device);
 
+	if (ext_io->service)
+		btd_service_unref(ext_io->service);
+
 	g_free(ext_io);
 }
 
@@ -746,7 +750,7 @@ static gboolean ext_io_disconnected(GIOChannel *io, GIOCondition cond,
 
 	DBG("%s disconnected from %s", ext->name, addr);
 drop:
-	device_profile_disconnected(conn->device, &ext->p, 0);
+	btd_service_disconnecting_complete(conn->service, 0);
 	ext->conns = g_slist_remove(ext->conns, conn);
 	ext_io_destroy(conn);
 	return FALSE;
@@ -768,7 +772,7 @@ static void new_conn_reply(DBusPendingCall *call, void *user_data)
 	conn->pending = NULL;
 
 	if (!dbus_error_is_set(&err)) {
-		device_profile_connected(conn->device, &ext->p, 0);
+		btd_service_connecting_complete(conn->service, 0);
 		conn->connected = true;
 		return;
 	}
@@ -776,7 +780,7 @@ static void new_conn_reply(DBusPendingCall *call, void *user_data)
 	error("%s replied with an error: %s, %s", ext->name,
 						err.name, err.message);
 
-	device_profile_connected(conn->device, &ext->p, -ECONNREFUSED);
+	btd_service_connecting_complete(conn->service, -ECONNREFUSED);
 
 	if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY))
 		ext_cancel(ext);
@@ -803,14 +807,14 @@ static void disconn_reply(DBusPendingCall *call, void *user_data)
 	conn->pending = NULL;
 
 	if (!dbus_error_is_set(&err)) {
-		device_profile_disconnected(conn->device, &ext->p, 0);
+		btd_service_disconnecting_complete(conn->service, 0);
 		goto disconnect;
 	}
 
 	error("%s replied with an error: %s, %s", ext->name,
 						err.name, err.message);
 
-	device_profile_disconnected(conn->device, &ext->p, -ECONNREFUSED);
+	btd_service_disconnecting_complete(conn->service, -ECONNREFUSED);
 
 	if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY))
 		ext_cancel(ext);
@@ -986,8 +990,7 @@ static void ext_connect(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 
 drop:
-	device_profile_connected(conn->device, &ext->p,
-						err ? -err->code : -EIO);
+	btd_service_connecting_complete(conn->service, err ? -err->code : -EIO);
 	if (io_err)
 		g_error_free(io_err);
 	ext->conns = g_slist_remove(ext->conns, conn);
@@ -1569,7 +1572,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	return;
 
 failed:
-	device_profile_connected(conn->device, &ext->p, err);
+	btd_service_connecting_complete(conn->service, err);
 	ext->conns = g_slist_remove(ext->conns, conn);
 	ext_io_destroy(conn);
 }
@@ -1591,8 +1594,10 @@ static int resolve_service(struct ext_io *conn, const bdaddr_t *src,
 	return err;
 }
 
-static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile)
+static int ext_connect_dev(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
+	struct btd_profile *profile = btd_service_get_profile(service);
 	struct btd_adapter *adapter;
 	struct ext_io *conn;
 	struct ext_profile *ext;
@@ -1626,6 +1631,7 @@ static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile)
 
 	conn->adapter = btd_adapter_ref(adapter);
 	conn->device = btd_device_ref(dev);
+	conn->service = btd_service_ref(service);
 
 	ext->conns = g_slist_append(ext->conns, conn);
 
@@ -1668,9 +1674,10 @@ static int send_disconn_req(struct ext_profile *ext, struct ext_io *conn)
 	return 0;
 }
 
-static int ext_disconnect_dev(struct btd_device *dev,
-						struct btd_profile *profile)
+static int ext_disconnect_dev(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
+	struct btd_profile *profile = btd_service_get_profile(service);
 	struct ext_profile *ext;
 	struct ext_io *conn;
 	int err;
diff --git a/src/profile.h b/src/profile.h
index 8daa358..9aec27e 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -39,10 +39,8 @@ struct btd_profile {
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
-	int (*connect) (struct btd_device *device,
-						struct btd_profile *profile);
-	int (*disconnect) (struct btd_device *device,
-						struct btd_profile *profile);
+	int (*connect) (struct btd_service *service);
+	int (*disconnect) (struct btd_service *service);
 
 	int (*adapter_probe) (struct btd_profile *p,
 						struct btd_adapter *adapter);
diff --git a/src/service.c b/src/service.c
index c1bf40e..0e66c58 100644
--- a/src/service.c
+++ b/src/service.c
@@ -199,7 +199,7 @@ int btd_service_connect(struct btd_service *service)
 
 	change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
 
-	err = profile->connect(service->device, service->profile);
+	err = profile->connect(service);
 	if (err == 0)
 		return 0;
 
@@ -234,7 +234,7 @@ int btd_service_disconnect(struct btd_service *service)
 
 	change_state(service, BTD_SERVICE_STATE_DISCONNECTING, 0);
 
-	err = profile->disconnect(service->device, service->profile);
+	err = profile->disconnect(service);
 	if (err == 0)
 		return 0;
 
-- 
1.8.1.4

