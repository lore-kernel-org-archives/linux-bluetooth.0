Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 14/15] profile: Add object to represent device-profile
Date: Fri, 19 Oct 2012 17:39:31 +0200
Message-Id: <1350661172-18125-15-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

An instance of bdm_device_profile represents a profile that has been
probed for a given device, including the state of the connection.
---
 Makefile.am                |   1 +
 audio/manager.c            |  32 ++++++------
 profiles/input/device.c    |  21 ++++----
 profiles/input/device.h    |   8 +--
 profiles/network/manager.c |  57 ++++++++++-----------
 src/device-profile.c       | 124 +++++++++++++++++++++++++++++++++++++++++++++
 src/device-profile.h       |  42 +++++++++++++++
 src/device.c               | 107 +++++++++++++++++++++++++++-----------
 src/profile.c              |  45 +++++++++-------
 src/profile.h              |  11 ++--
 10 files changed, 334 insertions(+), 114 deletions(-)
 create mode 100644 src/device-profile.c
 create mode 100644 src/device-profile.h

diff --git a/Makefile.am b/Makefile.am
index 35b1520..4fa341e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -311,6 +311,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/manager.h src/manager.c \
 			src/adapter.h src/adapter.c \
 			src/profile.h src/profile.c \
+			src/device-profile.h src/device-profile.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/event.h src/event.c src/eir.h src/eir.c \
diff --git a/audio/manager.c b/audio/manager.c
index 77e3540..042d131 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -54,6 +54,7 @@
 #include "../src/manager.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/device-profile.h"
 
 #include "log.h"
 #include "device.h"
@@ -84,9 +85,8 @@ struct audio_adapter {
 };
 
 struct profile_req {
-	struct btd_device	*device;
-	struct btd_profile	*profile;
-	btd_profile_cb		cb;
+	struct btd_device_profile	*dp;
+	btd_device_profile_cb		cb;
 };
 
 static gboolean auto_connect = TRUE;
@@ -782,15 +782,13 @@ static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static struct profile_req *new_profile_request(struct btd_device *dev,
-						struct btd_profile *profile,
-						btd_profile_cb cb)
+static struct profile_req *new_profile_request(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
 	struct profile_req *req;
 
 	req  = g_new0(struct profile_req, 1);
-	req->device = dev;
-	req->profile = profile;
+	req->dp = dp;
 	req->cb = cb;
 
 	return req;
@@ -800,15 +798,15 @@ static void profile_cb(struct audio_device *dev, int err, void *data)
 {
 	struct profile_req *req = data;
 
-	req->cb(req->profile, req->device, err);
+	req->cb(req->dp, err);
 
 	g_free(req);
 }
 
-static int a2dp_source_connect(struct btd_device *dev,
-						struct btd_profile *profile,
-						btd_profile_cb cb)
+static int a2dp_source_connect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
+	struct btd_device *dev = device_profile_get_device(dp);
 	struct audio_device *audio_dev;
 	struct profile_req *req;
 	int err;
@@ -819,7 +817,7 @@ static int a2dp_source_connect(struct btd_device *dev,
 		return -1;
 	}
 
-	req = new_profile_request(dev, profile, cb);
+	req = new_profile_request(dp, cb);
 
 	err = source_connect(audio_dev, profile_cb, req);
 	if (err < 0) {
@@ -830,10 +828,10 @@ static int a2dp_source_connect(struct btd_device *dev,
 	return 0;
 }
 
-static int a2dp_source_disconnect(struct btd_device *dev,
-						struct btd_profile *profile,
-						btd_profile_cb cb)
+static int a2dp_source_disconnect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
+	struct btd_device *dev = device_profile_get_device(dp);
 	struct audio_device *audio_dev;
 	struct profile_req *req;
 	int err;
@@ -844,7 +842,7 @@ static int a2dp_source_disconnect(struct btd_device *dev,
 		return -1;
 	}
 
-	req = new_profile_request(dev, profile, cb);
+	req = new_profile_request(dp, cb);
 
 	err = source_disconnect(audio_dev, profile_cb, req);
 	if (err < 0) {
diff --git a/profiles/input/device.c b/profiles/input/device.c
index fbc3d6f..4867e34 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -45,6 +45,7 @@
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
+#include "../src/device-profile.h"
 #include "../src/storage.h"
 #include "../src/manager.h"
 #include "../src/dbus-common.h"
@@ -67,8 +68,8 @@ struct pending_connect {
 	bool local;
 	union {
 		struct {
-			struct btd_profile *profile;
-			btd_profile_cb cb;
+			struct btd_device_profile *dp;
+			btd_device_profile_cb cb;
 		} p;
 		DBusMessage *msg;
 	};
@@ -528,7 +529,7 @@ static void connect_reply(struct input_device *idev, int err,
 		error("%s", err_msg);
 
 	if (!pending->local) {
-		pending->p.cb(pending->p.profile, idev->device, err);
+		pending->p.cb(pending->p.dp, err);
 		g_free(pending);
 		return;
 	}
@@ -657,9 +658,10 @@ static int dev_connect(struct input_device *idev)
 	return -EIO;
 }
 
-int input_device_connect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+int input_device_connect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
+	struct btd_device *dev = device_profile_get_device(dp);
 	struct input_device *idev;
 
 	idev = find_device_by_path(devices, device_get_path(dev));
@@ -674,7 +676,7 @@ int input_device_connect(struct btd_device *dev, struct btd_profile *profile,
 
 	idev->pending = g_new0(struct pending_connect, 1);
 	idev->pending->local = false;
-	idev->pending->p.profile = profile;
+	idev->pending->p.dp = dp;
 	idev->pending->p.cb = cb;
 
 	return dev_connect(idev);
@@ -700,9 +702,10 @@ static DBusMessage *local_connect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+int input_device_disconnect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
+	struct btd_device *dev = device_profile_get_device(dp);
 	struct input_device *idev;
 	int err;
 
@@ -715,7 +718,7 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile,
 		return err;
 
 	if (cb)
-		cb(profile, dev, 0);
+		cb(dp, 0);
 
 	return 0;
 }
diff --git a/profiles/input/device.h b/profiles/input/device.h
index d68798c..18924a0 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -36,7 +36,7 @@ int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 							GIOChannel *io);
 int input_device_close_channels(const bdaddr_t *src, const bdaddr_t *dst);
 
-int input_device_connect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb);
-int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb);
+int input_device_connect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb);
+int input_device_disconnect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb);
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 87d263a..6917b5b 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -40,6 +40,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
+#include "device-profile.h"
 #include "manager.h"
 #include "common.h"
 #include "connection.h"
@@ -48,9 +49,8 @@
 static gboolean conf_security = TRUE;
 
 struct connect_req {
-	struct btd_device	*device;
-	struct btd_profile	*profile;
-	btd_profile_cb		cb;
+	struct btd_device_profile	*dp;
+	btd_device_profile_cb		cb;
 };
 
 static void read_config(const char *file)
@@ -84,22 +84,22 @@ static void connect_profile_cb(struct btd_device *device, int err,
 {
 	struct connect_req *req = data;
 
-	req->cb(req->profile, req->device, err);
+	req->cb(req->dp, err);
 
 	g_free(req);
 }
 
-static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
-						uint16_t id, btd_profile_cb cb)
+static int connect_profile(struct btd_device_profile *dp, uint16_t id,
+						btd_device_profile_cb cb)
 {
+	struct btd_device *dev = device_profile_get_device(dp);
 	struct connect_req *req;
 	int err;
 
 	DBG("path %s id %u", device_get_path(dev), id);
 
 	req  = g_new0(struct connect_req, 1);
-	req->device = dev;
-	req->profile = profile;
+	req->dp = dp;
 	req->cb = cb;
 
 	err = connection_connect(dev, BNEP_SVC_PANU, NULL, connect_profile_cb,
@@ -112,10 +112,10 @@ static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
 	return 0;
 }
 
-static int disconnect_profile(struct btd_device *dev,
-						struct btd_profile *profile,
-						uint16_t id, btd_profile_cb cb)
+static int disconnect_profile(struct btd_device_profile *dp, uint16_t id,
+						btd_device_profile_cb cb)
 {
+	struct btd_device *dev = device_profile_get_device(dp);
 	int err;
 
 	DBG("path %s id %u", device_get_path(dev), id);
@@ -125,7 +125,7 @@ static int disconnect_profile(struct btd_device *dev,
 		return err;
 
 	if (cb)
-		cb(profile, dev, 0);
+		cb(dp, 0);
 
 	return 0;
 }
@@ -145,16 +145,15 @@ static void network_remove(struct btd_profile *p, struct btd_device *device)
 	connection_unregister(device);
 }
 
-static int panu_connect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+static int panu_connect(struct btd_device_profile *dp, btd_device_profile_cb cb)
 {
-	return connect_profile(dev, profile, BNEP_SVC_PANU, cb);
+	return connect_profile(dp, BNEP_SVC_PANU, cb);
 }
 
-static int panu_disconnect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+static int panu_disconnect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
-	return disconnect_profile(dev, profile, BNEP_SVC_PANU, cb);
+	return disconnect_profile(dp, BNEP_SVC_PANU, cb);
 }
 
 static int panu_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
@@ -184,16 +183,15 @@ static int gn_probe(struct btd_profile *p, struct btd_device *device,
 	return connection_register(device, BNEP_SVC_GN);
 }
 
-static int gn_connect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+static int gn_connect(struct btd_device_profile *dp, btd_device_profile_cb cb)
 {
-	return connect_profile(dev, profile, BNEP_SVC_GN, cb);
+	return connect_profile(dp, BNEP_SVC_GN, cb);
 }
 
-static int gn_disconnect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+static int gn_disconnect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
-	return disconnect_profile(dev, profile, BNEP_SVC_GN, cb);
+	return disconnect_profile(dp, BNEP_SVC_GN, cb);
 }
 
 static int gn_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
@@ -223,16 +221,15 @@ static int nap_probe(struct btd_profile *p, struct btd_device *device,
 	return connection_register(device, BNEP_SVC_NAP);
 }
 
-static int nap_connect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+static int nap_connect(struct btd_device_profile *dp, btd_device_profile_cb cb)
 {
-	return connect_profile(dev, profile, BNEP_SVC_NAP, cb);
+	return connect_profile(dp, BNEP_SVC_NAP, cb);
 }
 
-static int nap_disconnect(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+static int nap_disconnect(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
-	return disconnect_profile(dev, profile, BNEP_SVC_NAP, cb);
+	return disconnect_profile(dp, BNEP_SVC_NAP, cb);
 }
 
 static int nap_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
diff --git a/src/device-profile.c b/src/device-profile.c
new file mode 100644
index 0000000..ea796ac
--- /dev/null
+++ b/src/device-profile.c
@@ -0,0 +1,124 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  BMW Car IT GmbH
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
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+#include <bluetooth/mgmt.h>
+
+#include <glib.h>
+
+#include "log.h"
+
+#include "adapter.h"
+#include "device.h"
+#include "profile.h"
+#include "device-profile.h"
+
+struct btd_device_profile {
+	gint			ref;
+	struct btd_device	*device;
+	struct btd_profile	*profile;
+	profile_state_t		state;
+};
+
+static char *str_state[] = {
+	"PROFILE_STATE_DISCONNECTED",
+	"PROFILE_STATE_CONNECTING",
+	"PROFILE_STATE_CONNECTED",
+};
+
+struct btd_device *device_profile_get_device(struct btd_device_profile *dp)
+{
+	return dp->device;
+}
+
+struct btd_profile *device_profile_get_profile(struct btd_device_profile *dp)
+{
+	return dp->profile;
+}
+
+void device_profile_set_state(struct btd_device_profile *dp,
+							profile_state_t state)
+{
+	DBG("State changed %p: %s -> %s", dp, str_state[dp->state],
+							str_state[state]);
+
+	dp->state = state;
+}
+
+struct btd_device_profile *device_profile_create(struct btd_device *device,
+						struct btd_profile *profile)
+{
+	struct btd_device_profile *dp;
+
+	dp = g_try_new0(struct btd_device_profile, 1);
+	if (!dp) {
+		error("device_profile_create: failed to alloc memory");
+		return NULL;
+	}
+
+	dp->ref = 1;
+	dp->device = btd_device_ref(device);
+	dp->profile = profile;
+	dp->state = PROFILE_STATE_DISCONNECTED;
+
+	return dp;
+}
+
+struct btd_device_profile *device_profile_ref(struct btd_device_profile *dp)
+{
+	dp->ref++;
+
+	DBG("%p: ref=%d", dp, dp->ref);
+
+	return dp;
+}
+
+void device_profile_unref(struct btd_device_profile *dp)
+{
+	dp->ref--;
+
+	DBG("%p: ref=%d", dp, dp->ref);
+
+	if (dp->ref > 0)
+		return;
+
+	btd_device_unref(dp->device);
+
+	g_free(dp);
+}
diff --git a/src/device-profile.h b/src/device-profile.h
new file mode 100644
index 0000000..ef75d79
--- /dev/null
+++ b/src/device-profile.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  BMW Car IT GmbH
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
+typedef enum {
+	PROFILE_STATE_DISCONNECTED,
+	PROFILE_STATE_CONNECTING,
+	PROFILE_STATE_CONNECTED,
+} profile_state_t;
+
+struct btd_device_profile;
+
+struct btd_device_profile *device_profile_create(struct btd_device *device,
+						struct btd_profile *profile);
+
+struct btd_device_profile *device_profile_ref(struct btd_device_profile *dp);
+void device_profile_unref(struct btd_device_profile *dp);
+
+struct btd_device *device_profile_get_device(struct btd_device_profile *dp);
+struct btd_profile *device_profile_get_profile(struct btd_device_profile *dp);
+
+void device_profile_set_state(struct btd_device_profile *dp,
+							profile_state_t state);
diff --git a/src/device.c b/src/device.c
index bc7f8dd..37eddef 100644
--- a/src/device.c
+++ b/src/device.c
@@ -54,6 +54,7 @@
 #include "attio.h"
 #include "device.h"
 #include "profile.h"
+#include "device-profile.h"
 #include "dbus-common.h"
 #include "error.h"
 #include "glib-helper.h"
@@ -852,10 +853,14 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void profile_remove(struct btd_profile *profile,
-						struct btd_device *device)
+static void profile_remove(gpointer p)
 {
+	struct btd_device_profile *dp = p;
+	struct btd_device *device = device_profile_get_device(dp);
+	struct btd_profile *profile = device_profile_get_profile(dp);
+
 	profile->device_remove(profile, device);
+	device_profile_unref(dp);
 }
 
 static gboolean do_disconnect(gpointer user_data)
@@ -880,8 +885,7 @@ int device_block(struct btd_device *device, gboolean update_only)
 	if (device->connected)
 		do_disconnect(device);
 
-	g_slist_foreach(device->profiles, (GFunc) profile_remove, device);
-	g_slist_free(device->profiles);
+	g_slist_free_full(device->profiles, profile_remove);
 	device->profiles = NULL;
 
 	if (!update_only)
@@ -1100,13 +1104,15 @@ static void bonding_request_cancel(struct bonding_req *bonding)
 
 static void dev_disconn_profile(gpointer a, gpointer b)
 {
-	struct btd_profile *profile = a;
-	struct btd_device *dev = b;
+	struct btd_device_profile *dp = a;
+	struct btd_profile *profile = device_profile_get_profile(dp);
 
 	if (!profile->disconnect)
 		return;
 
-	profile->disconnect(dev, profile, NULL);
+	profile->disconnect(dp, NULL);
+
+	device_profile_set_state(dp, PROFILE_STATE_DISCONNECTED);
 }
 
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
@@ -1127,7 +1133,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		return;
 
 	if (device->profiles_connected)
-		g_slist_foreach(device->profiles, dev_disconn_profile, device);
+		g_slist_foreach(device->profiles, dev_disconn_profile, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -1170,32 +1176,42 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static int connect_next(struct btd_device *dev, btd_profile_cb cb)
+static int connect_next(struct btd_device *dev, btd_device_profile_cb cb)
 {
-	struct btd_profile *profile;
 	int err = -ENOENT;
 
 	while (dev->pending) {
+		struct btd_device_profile *dp;
+		struct btd_profile *profile;
 		int err;
 
-		profile = dev->pending->data;
+		dp = dev->pending->data;
+		profile = device_profile_get_profile(dp);
 
-		err = profile->connect(dev, profile, cb);
-		if (err == 0)
+		err = profile->connect(dp, cb);
+		if (err == 0) {
+			device_profile_set_state(dp, PROFILE_STATE_CONNECTING);
 			return 0;
+		}
 
 		error("Failed to connect %s: %s", profile->name,
 							strerror(-err));
-		dev->pending = g_slist_remove(dev->pending, profile);
+		dev->pending = g_slist_remove_link(dev->pending, dev->pending);
 	}
 
 	return err;
 }
 
-static void dev_profile_connected(struct btd_profile *profile,
-					struct btd_device *dev, int err)
+static void dev_profile_connected(struct btd_device_profile *dp, int err)
 {
-	dev->pending = g_slist_remove(dev->pending, profile);
+	struct btd_device *dev = device_profile_get_device(dp);
+
+	dev->pending = g_slist_remove(dev->pending, dp);
+
+	if (err == 0)
+		device_profile_set_state(dp, PROFILE_STATE_CONNECTED);
+	else
+		device_profile_set_state(dp, PROFILE_STATE_DISCONNECTED);
 
 	if (connect_next(dev, dev_profile_connected) == 0)
 		return;
@@ -1245,7 +1261,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct btd_device *dev = user_data;
-	struct btd_profile *p;
+	struct btd_device_profile *dp;
 	GSList *l;
 	int err;
 
@@ -1265,7 +1281,10 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	for (l = dev->profiles; l != NULL; l = g_slist_next(l)) {
-		p = l->data;
+		struct btd_profile *p;
+
+		dp = l->data;
+		p = device_profile_get_profile(dp);
 
 		if (p->auto_connect)
 			dev->pending = g_slist_append(dev->pending, p);
@@ -1731,7 +1750,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	}
 
 	if (device->profiles_connected)
-		g_slist_foreach(device->profiles, dev_disconn_profile, device);
+		g_slist_foreach(device->profiles, dev_disconn_profile, NULL);
 
 	g_slist_free(device->pending);
 	device->pending = NULL;
@@ -1742,8 +1761,7 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (remove_stored)
 		device_remove_stored(device);
 
-	g_slist_foreach(device->profiles, (GFunc) profile_remove, device);
-	g_slist_free(device->profiles);
+	g_slist_free_full(device->profiles, profile_remove);
 	device->profiles = NULL;
 
 	attrib_client_unregister(device->services);
@@ -1820,6 +1838,7 @@ struct probe_data {
 static void dev_probe(struct btd_profile *p, void *user_data)
 {
 	struct probe_data *d = user_data;
+	struct btd_device_profile *dp;
 	GSList *probe_uuids;
 	int err;
 
@@ -1837,7 +1856,9 @@ static void dev_probe(struct btd_profile *p, void *user_data)
 		return;
 	}
 
-	d->dev->profiles = g_slist_append(d->dev->profiles, p);
+	dp = device_profile_create(d->dev, p);
+
+	d->dev->profiles = g_slist_append(d->dev->profiles, dp);
 	g_slist_free(probe_uuids);
 }
 
@@ -1845,6 +1866,7 @@ void device_probe_profile(gpointer a, gpointer b)
 {
 	struct btd_device *device = a;
 	struct btd_profile *profile = b;
+	struct btd_device_profile *dp;
 	GSList *probe_uuids;
 	char addr[18];
 	int err;
@@ -1859,23 +1881,45 @@ void device_probe_profile(gpointer a, gpointer b)
 	ba2str(&device->bdaddr, addr);
 
 	err = profile->device_probe(profile, device, probe_uuids);
-	if (err < 0)
+	if (err < 0) {
 		error("%s profile probe failed for %s", profile->name, addr);
-	else
-		device->profiles = g_slist_append(device->profiles, profile);
+		g_slist_free(probe_uuids);
+		return;
+	}
+
+	dp = device_profile_create(device, profile);
 
+	device->profiles = g_slist_append(device->profiles, dp);
 	g_slist_free(probe_uuids);
 }
 
+static gint device_profile_cmp(gconstpointer a, gconstpointer b)
+{
+	struct btd_device_profile *dp = (gpointer) a;
+	const struct btd_profile *profile = b;
+
+	if (device_profile_get_profile(dp) == profile)
+		return 0;
+
+	return 1;
+}
+
 void device_remove_profile(gpointer a, gpointer b)
 {
 	struct btd_device *device = a;
 	struct btd_profile *profile = b;
+	struct btd_device_profile *dp;
+	GSList *l;
 
-	if (!g_slist_find(device->profiles, profile))
+	l = g_slist_find_custom(device->profiles, profile, device_profile_cmp);
+	if (l == NULL)
 		return;
 
-	device->profiles = g_slist_remove(device->profiles, profile);
+	dp = l->data;
+
+	device->profiles = g_slist_remove_link(device->profiles, l);
+
+	device_profile_unref(dp);
 
 	profile->device_remove(profile, device);
 }
@@ -1948,7 +1992,8 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
 
 	for (l = device->profiles; l != NULL; l = next) {
-		struct btd_profile *profile = l->data;
+		struct btd_device_profile *dp = l->data;
+		struct btd_profile *profile = device_profile_get_profile(dp);
 		GSList *probe_uuids;
 
 		next = l->next;
@@ -1960,7 +2005,9 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 		}
 
 		profile->device_remove(profile, device);
-		device->profiles = g_slist_remove(device->profiles, profile);
+		device->profiles = g_slist_remove_link(device->profiles, l);
+
+		device_profile_unref(dp);
 	}
 }
 
diff --git a/src/profile.c b/src/profile.c
index 7e7c945..cc78612 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -50,6 +50,7 @@
 #include "manager.h"
 #include "device.h"
 #include "profile.h"
+#include "device-profile.h"
 
 #define SPP_DEFAULT_CHANNEL	3
 
@@ -88,10 +89,10 @@ struct ext_io {
 	GIOChannel *io;
 	guint io_id;
 	struct btd_adapter *adapter;
-	struct btd_device *device;
+	struct btd_device_profile *dp;
 
 	bool resolving;
-	btd_profile_cb cb;
+	btd_device_profile_cb cb;
 	uint16_t rec_handle;
 
 	guint auth_id;
@@ -185,9 +186,13 @@ static void ext_io_destroy(gpointer p)
 		ext_cancel(ext);
 	}
 
-	if (ext_io->resolving)
+	if (ext_io->resolving) {
+		struct btd_device *device;
+
+		device = device_profile_get_device(ext_io->dp);
 		bt_cancel_discovery(adapter_get_address(ext_io->adapter),
-					device_get_address(ext_io->device));
+						device_get_address(device));
+	}
 
 	if (ext_io->rec_handle)
 		remove_record_from_server(ext_io->rec_handle);
@@ -195,8 +200,8 @@ static void ext_io_destroy(gpointer p)
 	if (ext_io->adapter)
 		btd_adapter_unref(ext_io->adapter);
 
-	if (ext_io->device)
-		btd_device_unref(ext_io->device);
+	if (ext_io->dp)
+		device_profile_unref(ext_io->dp);
 
 	g_free(ext_io);
 }
@@ -244,7 +249,7 @@ static void new_conn_reply(DBusPendingCall *call, void *user_data)
 
 	if (!dbus_error_is_set(&err)) {
 		if (conn->cb) {
-			conn->cb(&ext->p, conn->device, 0);
+			conn->cb(conn->dp, 0);
 			conn->cb = NULL;
 		}
 		return;
@@ -254,7 +259,7 @@ static void new_conn_reply(DBusPendingCall *call, void *user_data)
 						err.name, err.message);
 
 	if (conn->cb) {
-		conn->cb(&ext->p, conn->device, -ECONNREFUSED);
+		conn->cb(conn->dp, -ECONNREFUSED);
 		conn->cb = NULL;
 	}
 
@@ -638,7 +643,7 @@ static void remove_connect(struct ext_profile *ext, struct btd_device *dev)
 		if (!conn->cb)
 			continue;
 
-		if (conn->device != dev)
+		if (device_profile_get_device(conn->dp) != dev)
 			continue;
 
 		ext->conns = g_slist_remove(ext->conns, conn);
@@ -716,6 +721,7 @@ static uint16_t get_goep_l2cap_psm(sdp_record_t *rec)
 static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct ext_io *conn = user_data;
+	struct btd_device *device = device_profile_get_device(conn->dp);
 	struct ext_profile *ext = conn->ext;
 	sdp_list_t *r;
 
@@ -769,7 +775,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	}
 
 	err = connect_io(conn, adapter_get_address(conn->adapter),
-					device_get_address(conn->device));
+						device_get_address(device));
 	if (err < 0) {
 		error("Connecting %s failed: %s", ext->name, strerror(-err));
 		goto failed;
@@ -778,7 +784,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	return;
 
 failed:
-	conn->cb(&ext->p, conn->device, err);
+	conn->cb(conn->dp, err);
 	ext->conns = g_slist_remove(ext->conns, conn);
 	ext_io_destroy(conn);
 }
@@ -799,10 +805,12 @@ static int resolve_service(struct ext_io *conn, const bdaddr_t *src,
 	return err;
 }
 
-static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile,
-							btd_profile_cb cb)
+static int ext_connect_dev(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
 	struct btd_adapter *adapter;
+	struct btd_device *dev = device_profile_get_device(dp);
+	struct btd_profile *profile = device_profile_get_profile(dp);
 	struct ext_io *conn;
 	struct ext_profile *ext;
 	int err;
@@ -827,7 +835,7 @@ static int ext_connect_dev(struct btd_device *dev, struct btd_profile *profile,
 		goto failed;
 
 	conn->adapter = btd_adapter_ref(adapter);
-	conn->device = btd_device_ref(dev);
+	conn->dp = device_profile_ref(dp);
 	conn->cb = cb;
 
 	ext->conns = g_slist_append(ext->conns, conn);
@@ -839,17 +847,16 @@ failed:
 	return err;
 }
 
-static int ext_disconnect_dev(struct btd_device *dev,
-						struct btd_profile *profile,
-						btd_profile_cb cb)
+static int ext_disconnect_dev(struct btd_device_profile *dp,
+						btd_device_profile_cb cb)
 {
 	struct ext_profile *ext;
 
-	ext = find_ext(profile);
+	ext = find_ext(device_profile_get_profile(dp));
 	if (!ext)
 		return -ENOENT;
 
-	remove_connect(ext, dev);
+	remove_connect(ext, device_profile_get_device(dp));
 
 	return 0;
 }
diff --git a/src/profile.h b/src/profile.h
index e20b383..2ee90a7 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -24,9 +24,11 @@
 #define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
 
 struct btd_profile;
+struct btd_device_profile;
 
 typedef void (*btd_profile_cb)(struct btd_profile *profile,
 					struct btd_device *device, int err);
+typedef void (*btd_device_profile_cb)(struct btd_device_profile *dp, int err);
 
 struct btd_profile {
 	const char *name;
@@ -41,11 +43,10 @@ struct btd_profile {
 	void (*device_remove) (struct btd_profile *p,
 						struct btd_device *device);
 
-	int (*connect) (struct btd_device *device, struct btd_profile *profile,
-							btd_profile_cb cb);
-	int (*disconnect) (struct btd_device *device,
-						struct btd_profile *profile,
-						btd_profile_cb cb);
+	int (*connect) (struct btd_device_profile *dp,
+						btd_device_profile_cb cb);
+	int (*disconnect) (struct btd_device_profile *dp,
+						btd_device_profile_cb cb);
 
 	int (*adapter_probe) (struct btd_profile *p,
 						struct btd_adapter *adapter);
-- 
1.7.11.7

