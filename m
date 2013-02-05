Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0] core: Fix racy D-Bus service name request
Date: Tue,  5 Feb 2013 16:00:55 +0100
Message-Id: <1360076455-32716-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The ObjectManager interface should already be ready by the time the
D-Bus service name is owned. Hence, use g_dbus_request_name() explicitly
once g_dbus_attach_object_manager() has finished.

Without this patch, clients relying on the presence of the ObjectManager
could potentially face a race condition.
---
 src/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 1e40ebc..12ae3d9 100644
--- a/src/main.c
+++ b/src/main.c
@@ -424,7 +424,7 @@ static int connect_dbus(void)
 
 	dbus_error_init(&err);
 
-	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
+	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
 	if (!conn) {
 		if (dbus_error_is_set(&err)) {
 			g_printerr("D-Bus setup failed: %s\n", err.message);
@@ -439,6 +439,12 @@ static int connect_dbus(void)
 	g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
 	g_dbus_attach_object_manager(conn);
 
+	if (!g_dbus_request_name(conn, BLUEZ_NAME, &err)) {
+		g_printerr("D-Bus service name request failed: %s\n",
+								err.message);
+		return -EIO;
+	}
+
 	return 0;
 }
 
-- 
1.8.1

