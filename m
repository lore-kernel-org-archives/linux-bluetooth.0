Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@holtmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 1/4] Add support for retrying a bonding
Date: Thu,  5 Apr 2012 15:40:50 -0700
Message-Id: <1333665653-30266-2-git-send-email-scott@netsplit.com>
In-Reply-To: <1333665653-30266-1-git-send-email-scott@netsplit.com>
References: <1333665653-30266-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to retry a bonding we need a timer that will perform the
retry, we need to stash the status and capability of the bonding
request so it can use them again, and in the case of a retrying
bonding attempt we need to not tear down the temporary D-Bus device
object on the adapter.
---
 src/adapter.c |    2 +-
 src/device.c  |   14 ++++++++++++++
 src/device.h  |    1 +
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d5c1a04..4ae926f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3004,7 +3004,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 	if (device_is_authenticating(device))
 		device_cancel_authentication(device, TRUE);
 
-	if (device_is_temporary(device)) {
+	if (device_is_temporary(device) && !device_is_retrying(device)) {
 		const char *path = device_get_path(device);
 
 		DBG("Removing temporary device %s", path);
diff --git a/src/device.c b/src/device.c
index df3fbac..feb330c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -88,6 +88,9 @@ struct bonding_req {
 	DBusMessage *msg;
 	guint listener_id;
 	struct btd_device *device;
+	uint8_t capability;
+	uint8_t status;
+	guint retry_timer;
 };
 
 struct authentication_req {
@@ -2364,6 +2367,9 @@ static void bonding_request_free(struct bonding_req *bonding)
 	if (bonding->conn)
 		dbus_connection_unref(bonding->conn);
 
+	if (bonding->retry_timer)
+		g_source_remove(bonding->retry_timer);
+
 	device = bonding->device;
 	g_free(bonding);
 
@@ -2436,6 +2442,7 @@ proceed:
 
 	bonding->conn = dbus_connection_ref(conn);
 	bonding->msg = dbus_message_ref(msg);
+	bonding->capability = capability;
 
 	return bonding;
 }
@@ -2535,6 +2542,13 @@ static void device_auth_req_free(struct btd_device *device)
 	device->authr = NULL;
 }
 
+gboolean device_is_retrying(struct btd_device *device)
+{
+	struct bonding_req *bonding = device->bonding;
+
+	return bonding && bonding->retry_timer != 0;
+}
+
 void device_bonding_complete(struct btd_device *device, uint8_t status)
 {
 	struct bonding_req *bonding = device->bonding;
diff --git a/src/device.h b/src/device.h
index f3d6c70..f06042c 100644
--- a/src/device.h
+++ b/src/device.h
@@ -75,6 +75,7 @@ void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_auto_connect(struct btd_device *device, gboolean enable);
 gboolean device_is_connected(struct btd_device *device);
+gboolean device_is_retrying(struct btd_device *device);
 DBusMessage *device_create_bonding(struct btd_device *device,
 				DBusConnection *conn, DBusMessage *msg,
 				const char *agent_path, uint8_t capability);
-- 
1.7.7.3

