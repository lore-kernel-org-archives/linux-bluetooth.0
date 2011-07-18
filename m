Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 7/7] Release resources allocated when the thermometer plugin is stopped
Date: Mon, 18 Jul 2011 15:10:42 +0200
Message-Id: <1310994642-16375-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1310994642-16375-6-git-send-email-sancane@gmail.com>
References: <1310994642-16375-1-git-send-email-sancane@gmail.com>
 <1310994642-16375-2-git-send-email-sancane@gmail.com>
 <1310994642-16375-3-git-send-email-sancane@gmail.com>
 <1310994642-16375-4-git-send-email-sancane@gmail.com>
 <1310994642-16375-5-git-send-email-sancane@gmail.com>
 <1310994642-16375-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/manager.c     |    1 +
 thermometer/thermometer.c |    6 ++++++
 thermometer/thermometer.h |    4 +++-
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/thermometer/manager.c b/thermometer/manager.c
index b5fba4c..3ca8f5a 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -64,6 +64,7 @@ int thermometer_manager_init(DBusConnection *conn)
 void thermometer_manager_exit(void)
 {
 	btd_unregister_device_driver(&thermometer_device_driver);
+	thermometer_stop();
 
 	dbus_connection_unref(connection);
 	connection = NULL;
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index b8c0b82..56ba471 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -101,4 +101,10 @@ void thermometer_unregister(struct btd_device *device)
 	t = l->data;
 	thermometers = g_slist_remove(thermometers, t);
 	thermometer_unref(t);
+}
+
+void thermometer_stop()
+{
+	g_slist_free_full(thermometers, (GDestroyNotify) thermometer_unref);
+	thermometers = NULL;
 }
\ No newline at end of file
diff --git a/thermometer/thermometer.h b/thermometer/thermometer.h
index 28c9d18..f55f2c0 100644
--- a/thermometer/thermometer.h
+++ b/thermometer/thermometer.h
@@ -27,4 +27,6 @@
 #define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
 
 int thermometer_register(DBusConnection *connection, struct btd_device *device);
-void thermometer_unregister(struct btd_device *device);
\ No newline at end of file
+void thermometer_unregister(struct btd_device *device);
+
+void thermometer_stop();
\ No newline at end of file
-- 
1.7.6

