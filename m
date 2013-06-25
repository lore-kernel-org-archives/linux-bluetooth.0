Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 07/16] thermometer: Use btd_server userdata
Date: Tue, 25 Jun 2013 18:24:40 +0200
Message-Id: <1372177489-6858-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Exploit the userdata pointer to avoid maintainig a list with instances
of struct thermometer_adapter.
---
 profiles/thermometer/thermometer.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 034e50b..f1aa9e0 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -119,8 +119,6 @@ struct tmp_interval_data {
 	uint16_t		interval;
 };
 
-static GSList *thermometer_adapters = NULL;
-
 static const char * const temp_type[] = {
 	"<reserved>",
 	"armpit",
@@ -191,17 +189,6 @@ static void destroy_thermometer_adapter(gpointer user_data)
 	g_free(tadapter);
 }
 
-static int cmp_adapter(gconstpointer a, gconstpointer b)
-{
-	const struct thermometer_adapter *tadapter = a;
-	const struct btd_adapter *adapter = b;
-
-	if (adapter == tadapter->adapter)
-		return 0;
-
-	return -1;
-}
-
 static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct thermometer *t = a;
@@ -229,12 +216,13 @@ static int cmp_watcher(gconstpointer a, gconstpointer b)
 static struct thermometer_adapter *
 find_thermometer_adapter(struct btd_adapter *adapter)
 {
-	GSList *l = g_slist_find_custom(thermometer_adapters, adapter,
-								cmp_adapter);
-	if (!l)
+	struct btd_server *server;
+
+	server = btd_adapter_get_server(adapter, HEALTH_THERMOMETER_UUID);
+	if (server == NULL)
 		return NULL;
 
-	return l->data;
+	return btd_server_get_user_data(server);
 }
 
 static void change_property(struct thermometer *t, const char *name,
@@ -1269,21 +1257,14 @@ static int thermometer_adapter_probe(struct btd_server *server)
 		return -EIO;
 	}
 
-	thermometer_adapters = g_slist_prepend(thermometer_adapters, tadapter);
+	btd_server_set_user_data(server, tadapter);
 
 	return 0;
 }
 
 static void thermometer_adapter_remove(struct btd_server *server)
 {
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	struct thermometer_adapter *tadapter;
-
-	tadapter = find_thermometer_adapter(adapter);
-	if (tadapter == NULL)
-		return;
-
-	thermometer_adapters = g_slist_remove(thermometer_adapters, tadapter);
+	struct thermometer_adapter *tadapter = btd_server_get_user_data(server);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 					adapter_get_path(tadapter->adapter),
@@ -1292,6 +1273,7 @@ static void thermometer_adapter_remove(struct btd_server *server)
 
 static struct btd_profile thermometer_profile = {
 	.name		= "Health Thermometer GATT driver",
+	.local_uuid	= HEALTH_THERMOMETER_UUID,
 	.remote_uuid	= HEALTH_THERMOMETER_UUID,
 	.device_probe	= thermometer_device_probe,
 	.device_remove	= thermometer_device_remove,
-- 
1.8.1.4

