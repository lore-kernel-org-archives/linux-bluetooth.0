Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 15/15] profile: Add new org.bluez.Profile
Date: Fri, 19 Oct 2012 17:39:32 +0200
Message-Id: <1350661172-18125-16-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a D-Bus interface to represent a profile that is supported by a
device, moving the profile-specific API in org.bluez.Device and
additionally exposing state information.
---
 doc/device-api.txt   |  23 -------
 doc/profile-api.txt  |  48 +++++++++++++++
 src/device-profile.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/device-profile.h |   1 +
 src/device.c         |   3 +
 5 files changed, 217 insertions(+), 24 deletions(-)
 create mode 100644 doc/profile-api.txt

diff --git a/doc/device-api.txt b/doc/device-api.txt
index c1f2361..b0145e0 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -70,29 +70,6 @@ Methods		dict DiscoverServices(string pattern)
 
 			Possible errors: org.bluez.Error.NotConnected
 
-		void ConnectProfile(string uuid)
-
-			This method connects a specific profile of this
-			device. The profile needs to be registered client
-			profile.
-
-			Possible errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.AlreadyConnected
-					 org.bluez.Error.ConnectFailed
-
-		void DisconnectProfile(string uuid)
-
-			This method disconnects a specific profile of
-			this device. The profile needs to be registered
-			client profile.
-
-			There is no connection tracking for a profile, so
-			as long as the profile is registered this will always
-			succeed.
-
-			Possible errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.NotConnected
-
 		void Pair(object agent, string capability)
 
 			This method will connect to the remote device,
diff --git a/doc/profile-api.txt b/doc/profile-api.txt
new file mode 100644
index 0000000..9540b7a
--- /dev/null
+++ b/doc/profile-api.txt
@@ -0,0 +1,48 @@
+BlueZ D-Bus Profile API description
+***********************************
+
+Copyright (C) 2012  BMW Car IT GmbH. All rights reserved.
+
+
+Profile hierarchy
+=================
+
+Service		unique name
+Interface	org.bluez.Profile
+Object path	freely definable
+
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/
+								profileZZZ
+
+Methods		void Connect()
+
+			This method connects a specific profile of this
+			device. The profile needs to be registered client
+			profile.
+
+			Possible errors: org.bluez.Error.AlreadyConnected
+					 org.bluez.Error.ConnectFailed
+					 org.bluez.Error.Canceled
+					 org.bluez.Error.AgentNotAvailable
+
+		void Disconnect()
+
+			This method disconnects a specific profile of
+			this device. The profile needs to be registered
+			client profile.
+
+			There is no connection tracking for a profile, so
+			as long as the profile is registered this will always
+			succeed.
+
+			Possible errors: org.bluez.Error.NotConnected
+
+Properties	string State [readonly]
+
+			Indicates the state of the connection.  Possible
+			values are:
+				"disconnected": profile disconnected
+				"connecting": outgoing or incoming connection
+						attempt going on, including
+						local agent authorization
+				"connected": profile connected
diff --git a/src/device-profile.c b/src/device-profile.c
index ea796ac..d4b72d1 100644
--- a/src/device-profile.c
+++ b/src/device-profile.c
@@ -41,19 +41,27 @@
 #include <bluetooth/mgmt.h>
 
 #include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus.h>
 
 #include "log.h"
 
+#include "dbus-common.h"
+#include "error.h"
 #include "adapter.h"
 #include "device.h"
 #include "profile.h"
 #include "device-profile.h"
 
+#define DEVICE_PROFILE_INTERFACE "org.bluez.Profile"
+
 struct btd_device_profile {
 	gint			ref;
 	struct btd_device	*device;
 	struct btd_profile	*profile;
+	gchar			*path;
 	profile_state_t		state;
+	DBusMessage		*msg;
 };
 
 static char *str_state[] = {
@@ -62,6 +70,20 @@ static char *str_state[] = {
 	"PROFILE_STATE_CONNECTED",
 };
 
+static const char *state2str(profile_state_t state)
+{
+	switch (state) {
+	case PROFILE_STATE_DISCONNECTED:
+		return "disconnected";
+	case PROFILE_STATE_CONNECTING:
+		return "connecting";
+	case PROFILE_STATE_CONNECTED:
+		return "connected";
+	}
+
+	return NULL;
+}
+
 struct btd_device *device_profile_get_device(struct btd_device_profile *dp)
 {
 	return dp->device;
@@ -75,12 +97,131 @@ struct btd_profile *device_profile_get_profile(struct btd_device_profile *dp)
 void device_profile_set_state(struct btd_device_profile *dp,
 							profile_state_t state)
 {
-	DBG("State changed %p: %s -> %s", dp, str_state[dp->state],
+	DBG("State changed %s: %s -> %s", dp->path, str_state[dp->state],
 							str_state[state]);
 
 	dp->state = state;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					dp->path, DEVICE_PROFILE_INTERFACE,
+					"State");
+}
+
+static void connect_cb(struct btd_device_profile *dp, int err)
+{
+	DBusMessage *msg = dp->msg;
+	DBusMessage *reply;
+
+	if (err == 0) {
+		reply = dbus_message_new_method_return(msg);
+		device_profile_set_state(dp, PROFILE_STATE_CONNECTED);
+	} else {
+		reply = btd_error_failed(msg, strerror(-err));
+		device_profile_set_state(dp, PROFILE_STATE_DISCONNECTED);
+	}
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(msg);
+	dp->msg = NULL;
+}
+
+static DBusMessage *dp_connect(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct btd_device_profile *dp = user_data;
+	int err;
+
+	if (dp->state != PROFILE_STATE_DISCONNECTED)
+		return btd_error_already_connected(msg);
+
+	if (dp->msg != NULL)
+		return btd_error_busy(msg);
+
+	err = dp->profile->connect(dp, connect_cb);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	dp->msg = dbus_message_ref(msg);
+	device_profile_set_state(dp, PROFILE_STATE_CONNECTING);
+
+	return NULL;
+}
+
+static gboolean disconnect_cb_continue(gpointer user_data)
+{
+	struct btd_device_profile *dp = user_data;
+
+	g_dbus_send_message(btd_get_dbus_connection(), dp->msg);
+	dbus_message_unref(dp->msg);
+	dp->msg = NULL;
+
+	return FALSE;
+}
+
+static void disconnect_cb(struct btd_device_profile *dp, int err)
+{
+	DBusMessage *msg = dp->msg;
+	DBusMessage *reply;
+
+	if (err == 0) {
+		reply = dbus_message_new_method_return(msg);
+		device_profile_set_state(dp, PROFILE_STATE_DISCONNECTED);
+	} else
+		reply = btd_error_failed(msg, strerror(-err));
+
+	dbus_message_unref(msg);
+	dp->msg = reply;
+
+	g_idle_add(disconnect_cb_continue, dp);
 }
 
+static DBusMessage *dp_disconnect(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct btd_device_profile *dp = user_data;
+	int err;
+
+	if (dp->state == PROFILE_STATE_DISCONNECTED)
+		return btd_error_not_connected(msg);
+
+	if (dp->msg != NULL)
+		return btd_error_busy(msg);
+
+	dp->msg = dbus_message_ref(msg);
+
+	err = dp->profile->disconnect(dp, disconnect_cb);
+	if (err < 0) {
+		dbus_message_unref(dp->msg);
+		dp->msg = NULL;
+		return btd_error_failed(msg, strerror(-err));
+	}
+
+	return NULL;
+}
+
+static gboolean dp_property_get_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device_profile *dp = data;
+	const char *state = state2str(dp->state);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &state);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable device_profile_methods[] = {
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dp_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dp_disconnect) },
+	{ }
+};
+
+static const GDBusPropertyTable device_profile_properties[] = {
+	{ "State", "s", dp_property_get_state },
+	{ }
+};
+
 struct btd_device_profile *device_profile_create(struct btd_device *device,
 						struct btd_profile *profile)
 {
@@ -96,10 +237,29 @@ struct btd_device_profile *device_profile_create(struct btd_device *device,
 	dp->device = btd_device_ref(device);
 	dp->profile = profile;
 	dp->state = PROFILE_STATE_DISCONNECTED;
+	dp->path = g_strdup_printf("%s/%s", device_get_path(device),
+								profile->name);
+	g_strdelimit(dp->path, "-", '_');
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					dp->path, DEVICE_PROFILE_INTERFACE,
+					device_profile_methods, NULL,
+					device_profile_properties, dp,
+					NULL)) {
+		error("Device profile init failed on path %s", dp->path);
+		device_profile_unref(dp);
+		return NULL;
+	}
 
 	return dp;
 }
 
+void device_profile_unregister(struct btd_device_profile *dp)
+{
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					dp->path, DEVICE_PROFILE_INTERFACE);
+}
+
 struct btd_device_profile *device_profile_ref(struct btd_device_profile *dp)
 {
 	dp->ref++;
@@ -120,5 +280,9 @@ void device_profile_unref(struct btd_device_profile *dp)
 
 	btd_device_unref(dp->device);
 
+	if (dp->msg)
+		dbus_message_unref(dp->msg);
+
+	g_free(dp->path);
 	g_free(dp);
 }
diff --git a/src/device-profile.h b/src/device-profile.h
index ef75d79..db03d79 100644
--- a/src/device-profile.h
+++ b/src/device-profile.h
@@ -31,6 +31,7 @@ struct btd_device_profile;
 
 struct btd_device_profile *device_profile_create(struct btd_device *device,
 						struct btd_profile *profile);
+void device_profile_unregister(struct btd_device_profile *dp);
 
 struct btd_device_profile *device_profile_ref(struct btd_device_profile *dp);
 void device_profile_unref(struct btd_device_profile *dp);
diff --git a/src/device.c b/src/device.c
index 37eddef..2a73f2f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -860,6 +860,7 @@ static void profile_remove(gpointer p)
 	struct btd_profile *profile = device_profile_get_profile(dp);
 
 	profile->device_remove(profile, device);
+	device_profile_unregister(dp);
 	device_profile_unref(dp);
 }
 
@@ -1919,6 +1920,7 @@ void device_remove_profile(gpointer a, gpointer b)
 
 	device->profiles = g_slist_remove_link(device->profiles, l);
 
+	device_profile_unregister(dp);
 	device_profile_unref(dp);
 
 	profile->device_remove(profile, device);
@@ -2007,6 +2009,7 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 		profile->device_remove(profile, device);
 		device->profiles = g_slist_remove_link(device->profiles, l);
 
+		device_profile_unregister(dp);
 		device_profile_unref(dp);
 	}
 }
-- 
1.7.11.7

