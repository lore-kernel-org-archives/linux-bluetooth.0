Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Don't register GATT related SDP records if attrib server is disabled
Date: Wed, 23 Feb 2011 15:15:13 -0300
Message-Id: <1298484913-21415-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT related SDP records should not be added if "AttributeServer" option
is false in the configuration file. Problem happens only when attribute
plugin is enabled.
---
 attrib/manager.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/attrib/manager.c b/attrib/manager.c
index f991f8e..a5a7de4 100644
--- a/attrib/manager.c
+++ b/attrib/manager.c
@@ -32,6 +32,7 @@
 
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "hcid.h"
 
 #include "manager.h"
 #include "client.h"
@@ -84,19 +85,20 @@ int attrib_manager_init(DBusConnection *conn)
 
 	btd_register_device_driver(&client_driver);
 
-	/*
-	 * FIXME: Add config file option to allow
-	 * enable/disable the GATT server and client.
-	 */
 
-	return server_example_init();
+	if (main_opts.attrib_server)
+		return server_example_init();
+
+	return 0;
 }
 
 void attrib_manager_exit(void)
 {
 	btd_unregister_device_driver(&client_driver);
 
-	server_example_exit();
+	if (main_opts.attrib_server)
+		server_example_exit();
+
 	attrib_client_exit();
 
 	dbus_connection_unref(connection);
-- 
1.7.4.1

