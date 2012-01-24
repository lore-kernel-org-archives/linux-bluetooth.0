Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 1/4] Add support for retrying a bonding
Date: Tue, 24 Jan 2012 10:47:55 -0800
Message-Id: <1327430878-23913-2-git-send-email-scott@netsplit.com>
In-Reply-To: <1327430878-23913-1-git-send-email-scott@netsplit.com>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
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
index d5075db..a606174 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3072,7 +3072,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 	if (device_is_authenticating(device))
 		device_cancel_authentication(device, TRUE);
 
-	if (device_is_temporary(device)) {
+	if (device_is_temporary(device) && !device_is_retrying(device)) {
 		const char *path = device_get_path(device);
 
 		DBG("Removing temporary device %s", path);
diff --git a/src/device.c b/src/device.c
index c19acd4..278ad4b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -86,6 +86,9 @@ struct bonding_req {
 	GIOChannel *io;
 	guint listener_id;
 	struct btd_device *device;
+	uint8_t capability;
+	uint8_t status;
+	guint retry_timer;
 };
 
 struct authentication_req {
@@ -2176,6 +2179,9 @@ static void bonding_request_free(struct bonding_req *bonding)
 	if (bonding->io)
 		g_io_channel_unref(bonding->io);
 
+	if (bonding->retry_timer)
+		g_source_remove(bonding->retry_timer);
+
 	device = bonding->device;
 	g_free(bonding);
 
@@ -2247,6 +2253,7 @@ proceed:
 
 	bonding->conn = dbus_connection_ref(conn);
 	bonding->msg = dbus_message_ref(msg);
+	bonding->capability = capability;
 
 	return bonding;
 }
@@ -2330,6 +2337,13 @@ static void device_auth_req_free(struct btd_device *device)
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
index 13005ae..5b1152b 100644
--- a/src/device.h
+++ b/src/device.h
@@ -73,6 +73,7 @@ void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_auto_connect(struct btd_device *device, gboolean enable);
 gboolean device_is_connected(struct btd_device *device);
+gboolean device_is_retrying(struct btd_device *device);
 DBusMessage *device_create_bonding(struct btd_device *device,
 				DBusConnection *conn, DBusMessage *msg,
 				const char *agent_path, uint8_t capability);
-- 
1.7.7.3

