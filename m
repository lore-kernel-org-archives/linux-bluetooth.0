Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 02/11] Add set auto connect in device
Date: Mon, 26 Sep 2011 14:48:19 -0300
Message-Id: <1317059308-20038-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Skeleton of automatic connections driven by platform/user event.
Two layers will manage connections: Profiles can request on demand
connections registering ATTIO connection callbacks(one attempt) for
a given device and platform/user action can trigger automatic
connections for devices with ATTIO callbacks registered.
---
 src/adapter.c |   17 +++++++++++++++++
 src/adapter.h |    1 +
 src/device.c  |   15 +++++++++++++++
 src/device.h  |    1 +
 4 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b3622cb..605a9f2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3417,6 +3417,23 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	return 0;
 }
 
+static void set_auto_connect(gpointer data, gpointer user_data)
+{
+	struct btd_device *device = data;
+
+	device_set_auto_connect(device, TRUE);
+}
+
+void btd_adapter_enable_auto_connect(struct btd_adapter *adapter)
+{
+	if (!adapter->up)
+		return;
+
+	DBG("Enabling automatic connections");
+
+	g_slist_foreach(adapter->devices, set_auto_connect, NULL);
+}
+
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 							btd_adapter_pin_cb_t cb)
 {
diff --git a/src/adapter.h b/src/adapter.h
index 7ef0af0..d30e82a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -163,6 +163,7 @@ gboolean adapter_powering_down(struct btd_adapter *adapter);
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
 int btd_adapter_switch_online(struct btd_adapter *adapter);
 int btd_adapter_switch_offline(struct btd_adapter *adapter);
+void btd_adapter_enable_auto_connect(struct btd_adapter *adapter);
 
 typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
 					struct btd_device *dev, char *out);
diff --git a/src/device.c b/src/device.c
index 07409af..410cf4c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -148,6 +148,7 @@ struct btd_device {
 	gboolean	paired;
 	gboolean	blocked;
 	gboolean	bonded;
+	gboolean	auto_connect;
 
 	gboolean	authorizing;
 	gint		ref;
@@ -1919,6 +1920,20 @@ void device_set_bonded(struct btd_device *device, gboolean bonded)
 	device->bonded = bonded;
 }
 
+void device_set_auto_connect(struct btd_device *device, gboolean enable)
+{
+	char addr[18];
+
+	if (!device)
+		return;
+
+	ba2str(&device->bdaddr, addr);
+
+	DBG("%s auto connect: %d", addr, enable);
+
+	device->auto_connect = enable;
+}
+
 void device_set_type(struct btd_device *device, device_type_t type)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index b6349bc..e38393a 100644
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
1.7.6.1

