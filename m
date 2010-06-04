Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 28/32] Changed HEALTH_MANAGER_INTERFACE to HEALTH_MANAGER
Date: Fri,  4 Jun 2010 10:30:21 +0200
Message-Id: <1275640225-4186-29-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-28-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-15-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-16-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-17-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-18-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-21-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-26-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-27-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-28-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |    6 +++---
 health/hdp_types.h |    7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index bb03ffa..58d0394 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -964,11 +964,11 @@ int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 	adapter = g_new0(struct hdp_adapter, 1);
 
 	DBG("HDP init");
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

