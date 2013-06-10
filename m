Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/15] core: Fix not been able to cancel Device.Connect with Device.Disconnect
Date: Mon, 10 Jun 2013 13:37:06 +0300
Message-Id: <1370860630-30359-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device.Disconnect should be able to interrupt the connection attempt
started by Device.Connect.
---
 src/device.c  | 18 ++++++++++++------
 src/service.c |  5 +++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/src/device.c b/src/device.c
index d4c1e23..5cb5460 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1082,7 +1082,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		device->connect = NULL;
 	}
 
-	if (msg)
+	if (device->connected && msg)
 		device->disconnects = g_slist_append(device->disconnects,
 						dbus_message_ref(msg));
 
@@ -1110,18 +1110,20 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 		g_free(data);
 	}
 
+	if (!device->connected) {
+		g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
+		return;
+	}
+
 	device->disconn_timer = g_timeout_add_seconds(DISCONNECT_TIMER,
 						do_disconnect, device);
 }
 
-static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
+static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct btd_device *device = user_data;
 
-	if (!device->connected)
-		return btd_error_not_connected(msg);
-
 	/*
 	 * Disable connections through passive scanning until
 	 * Device1.Connect is called
@@ -1723,7 +1725,7 @@ static DBusMessage *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, disconnect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
 	{ GDBUS_ASYNC_METHOD("ConnectProfile", GDBUS_ARGS({ "UUID", "s" }),
 						NULL, connect_profile) },
@@ -4508,6 +4510,10 @@ static void service_state_changed(struct btd_service *service,
 	struct btd_device *device = btd_service_get_device(service);
 	int err = btd_service_get_error(service);
 
+	if (new_state == BTD_SERVICE_STATE_CONNECTING ||
+				new_state == BTD_SERVICE_STATE_DISCONNECTING)
+		return;
+
 	if (old_state == BTD_SERVICE_STATE_CONNECTING)
 		device_profile_connected(device, profile, err);
 	else if (old_state == BTD_SERVICE_STATE_DISCONNECTING)
diff --git a/src/service.c b/src/service.c
index aef9502..83e1c1a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -238,6 +238,11 @@ int btd_service_disconnect(struct btd_service *service)
 	if (err == 0)
 		return 0;
 
+	if (err == -ENOTCONN) {
+		btd_service_disconnecting_complete(service, 0);
+		return 0;
+	}
+
 	ba2str(device_get_address(service->device), addr);
 	error("%s profile disconnect failed for %s: %s", profile->name, addr,
 								strerror(-err));
-- 
1.8.1.4

