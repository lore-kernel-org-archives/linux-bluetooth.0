Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] core: Fix registering '/org/bluez' path before '/'
Date: Thu, 15 Nov 2012 16:05:21 +0200
Message-Id: <1352988325-10782-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This cause problems with ObjectManager being exported in both paths
---
 src/manager.c | 13 ++++++++-----
 src/manager.h |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 07f9482..3088dd9 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -181,14 +181,17 @@ static const GDBusPropertyTable manager_properties[] = {
 	{ }
 };
 
-dbus_bool_t manager_init(const char *path)
+bool manager_init(const char *path)
 {
-	btd_profile_init();
-
-	return g_dbus_register_interface(btd_get_dbus_connection(),
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					"/", MANAGER_INTERFACE,
 					manager_methods, manager_signals,
-					manager_properties, NULL, NULL);
+					manager_properties, NULL, NULL))
+		return false;
+
+	btd_profile_init();
+
+	return true;
 }
 
 static void manager_set_default_adapter(int id)
diff --git a/src/manager.h b/src/manager.h
index 0bb8b2c..4d094b6 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -29,7 +29,7 @@
 
 typedef void (*adapter_cb) (struct btd_adapter *adapter, gpointer user_data);
 
-dbus_bool_t manager_init(const char *path);
+bool manager_init(const char *path);
 void manager_cleanup(const char *path);
 
 const char *manager_get_base_path(void);
-- 
1.7.11.7

