Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/4] device: Fix NULL pointer dereference during GATT service discovery
Date: Tue, 14 Feb 2012 12:06:01 -0400
Message-Id: <1329235564-12471-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If reverse service discovery for GATT is triggered,
device_browse_primary() is called with a NULL "conn" parameter. This fix
is based on similar code found in device_browse_sdp().

This fixes errors like:

process 871: arguments to dbus_connection_ref() were incorrect,
assertion "connection != NULL" failed in file dbus-connection.c line
2549.
This is normally a bug in some application using the D-Bus library.
process 871: arguments to dbus_connection_get_object_path_data() were
incorrect, assertion "connection != NULL" failed in file
dbus-connection.c line 5639.
This is normally a bug in some application using the D-Bus library.
process 871: arguments to dbus_connection_register_object_path() were
incorrect, assertion "connection != NULL" failed in file
dbus-connection.c line 5461.
This is normally a bug in some application using the D-Bus library.
---
 src/device.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index ca7b15b..50ab339 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2011,8 +2011,10 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 	}
 
 done:
-	if (conn)
-		req->conn = dbus_connection_ref(conn);
+	if (conn == NULL)
+		conn = get_dbus_connection();
+
+	req->conn = dbus_connection_ref(conn);
 
 	if (msg) {
 		const char *sender = dbus_message_get_sender(msg);
-- 
1.7.5.4

