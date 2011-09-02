Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 02/11] Add set auto connect in device
Date: Fri,  2 Sep 2011 18:38:32 -0300
Message-Id: <1314999521-11261-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Skeleton of automatic connections driven by platform/user event.
Two layers will manage connections: Profiles can request on demand
connections registering ATTIO connection callbacks(one attempt) for
a given device and platform/user action can trigger automatic
connections for all bonded devices with ATTIO callbacks registered.
---
 src/adapter.c |   20 ++++++++++++++++++++
 src/adapter.h |    1 +
 src/device.c  |   11 +++++++++++
 src/device.h  |    1 +
 4 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2eeeab5..eec721c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3538,6 +3538,26 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	return 0;
 }
 
+static void set_auto_connect(gpointer data, gpointer user_data)
+{
+	struct btd_device *device = data;
+
+	if (device_is_bonded(device) == FALSE)
+		return;
+
+	device_set_auto_connect(device, TRUE);
+}
+
+void btd_adapter_system_unlocked(struct btd_adapter *adapter)
+{
+	if (!adapter->up)
+		return;
+
+	DBG("Unlocked");
+
+	g_slist_foreach(adapter->devices, set_auto_connect, NULL);
+}
+
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 							btd_adapter_pin_cb_t cb)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 4e6d7eb..eeac448 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -171,6 +171,7 @@ gboolean adapter_powering_down(struct btd_adapter *adapter);
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
 int btd_adapter_switch_online(struct btd_adapter *adapter);
 int btd_adapter_switch_offline(struct btd_adapter *adapter);
+void btd_adapter_system_unlocked(struct btd_adapter *adapter);
 
 typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
 					struct btd_device *dev, char *out);
diff --git a/src/device.c b/src/device.c
index b35e3d4..4af6c1d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -146,6 +146,7 @@ struct btd_device {
 	gboolean	paired;
 	gboolean	blocked;
 	gboolean	bonded;
+	gboolean	auto_connect;
 
 	gboolean	authorizing;
 	gint		ref;
@@ -1919,6 +1920,16 @@ void device_set_bonded(struct btd_device *device, gboolean bonded)
 	device->bonded = bonded;
 }
 
+void device_set_auto_connect(struct btd_device *device, gboolean enable)
+{
+	if (!device)
+		return;
+
+	DBG("auto connect: %d", enable);
+
+	device->auto_connect = enable;
+}
+
 void device_set_type(struct btd_device *device, device_type_t type)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index 6efcf63..59355aa 100644
--- a/src/device.h
+++ b/src/device.h
@@ -74,6 +74,7 @@ void device_set_paired(struct btd_device *device, gboolean paired);
 void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_type(struct btd_device *device, device_type_t type);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
+void device_set_auto_connect(struct btd_device *device, gboolean enable);
 gboolean device_is_connected(struct btd_device *device);
 DBusMessage *device_create_bonding(struct btd_device *device,
 				DBusConnection *conn, DBusMessage *msg,
-- 
1.7.6

