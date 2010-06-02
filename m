Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 28/32] Changed HEALTH_MANAGER_INTERFACE to HEALTH_MANAGER
Date: Wed,  2 Jun 2010 15:19:24 +0200
Message-Id: <1275484768-25838-29-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-28-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-27-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-28-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |    6 +++---
 health/hdp_types.h |    7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index cd344d0..e99e00a 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -964,11 +964,11 @@ int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 	adapter = g_new0(struct hdp_adapter, 1);
 
 	debug("HDP init");
-	if (!g_dbus_register_interface(conn, path, HEALTH_MANAGER_INTERFACE,
+	if (!g_dbus_register_interface(conn, path, HEALTH_MANAGER,
 					hdp_methods, NULL, NULL,
 					adapter, hdp_path_unregister)) {
 		error("Failed to register %s interface to %s",
-						HEALTH_MANAGER_INTERFACE, path);
+						HEALTH_MANAGER, path);
 		g_free(adapter);
 		return -1;
 	}
@@ -988,7 +988,7 @@ void hdp_adapter_unregister(struct btd_adapter *btd_adapter)
 
 	g_dbus_unregister_interface(adapter->conn,
 			adapter_get_path(btd_adapter),
-			HEALTH_MANAGER_INTERFACE);
+			HEALTH_MANAGER);
 	dbus_connection_unref(adapter->conn);
 	btd_adapter_unref(adapter->btd_adapter);
 	adapters = g_slist_remove(adapters, adapter);
diff --git a/health/hdp_types.h b/health/hdp_types.h
index abbfbf3..aff116e 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -42,9 +42,10 @@
 
 #define HDP_ERROR		g_quark_from_static_string("hdp-error-quark")
 
-#define HEALTH_MANAGER_INTERFACE	"org.bluez.HealthAdapter"
-#define HEALTH_DEVICE			"org.bluez.HealthDevice"
-#define HEALTH_LINK			"org.bluez.HealthLink"
+#define HEALTH_MANAGER		"org.bluez.HealthAdapter"
+#define HEALTH_DEVICE		"org.bluez.HealthDevice"
+#define HEALTH_LINK		"org.bluez.HealthLink"
+#define HEALTH_AGENT		"org.bluez.HealthAgent"
 
 #define HDP_NO_PREFERENCE_DC	0x00
 #define HDP_RELIABLE_DC		0x01
-- 
1.6.3.3

