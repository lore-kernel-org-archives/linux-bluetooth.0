Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 10/16] heartrate: Use btd_server userdata
Date: Tue, 25 Jun 2013 18:24:43 +0200
Message-Id: <1372177489-6858-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Exploit the userdata pointer to avoid maintainig a list with instances
of struct heartrate_adapter.
---
 profiles/heartrate/heartrate.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 81ca2a8..99721352f 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -94,8 +94,6 @@ struct measurement {
 	uint16_t		*interval;
 };
 
-static GSList *heartrate_adapters = NULL;
-
 static const char * const location_enum[] = {
 	"other",
 	"chest",
@@ -116,17 +114,6 @@ static const char *location2str(uint8_t value)
 	return NULL;
 }
 
-static int cmp_adapter(gconstpointer a, gconstpointer b)
-{
-	const struct heartrate_adapter *hradapter = a;
-	const struct btd_adapter *adapter = b;
-
-	if (adapter == hradapter->adapter)
-		return 0;
-
-	return -1;
-}
-
 static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct heartrate *hr = a;
@@ -154,12 +141,13 @@ static int cmp_watcher(gconstpointer a, gconstpointer b)
 static struct heartrate_adapter *
 find_heartrate_adapter(struct btd_adapter *adapter)
 {
-	GSList *l = g_slist_find_custom(heartrate_adapters, adapter,
-								cmp_adapter);
-	if (!l)
+	struct btd_server *server;
+
+	server = btd_adapter_get_server(adapter, HEART_RATE_UUID);
+	if (server == NULL)
 		return NULL;
 
-	return l->data;
+	return btd_server_get_user_data(server);
 }
 
 static void destroy_watcher(gpointer user_data)
@@ -744,21 +732,14 @@ static int heartrate_adapter_probe(struct btd_server *server)
 		return -EIO;
 	}
 
-	heartrate_adapters = g_slist_prepend(heartrate_adapters, hradapter);
+	btd_server_set_user_data(server, hradapter);
 
 	return 0;
 }
 
 static void heartrate_adapter_remove(struct btd_server *server)
 {
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	struct heartrate_adapter *hradapter;
-
-	hradapter = find_heartrate_adapter(adapter);
-	if (hradapter == NULL)
-		return;
-
-	heartrate_adapters = g_slist_remove(heartrate_adapters, hradapter);
+	struct heartrate_adapter *hradapter = btd_server_get_user_data(server);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 					adapter_get_path(hradapter->adapter),
@@ -854,6 +835,7 @@ static void heartrate_device_remove(struct btd_service *service)
 
 static struct btd_profile hrp_profile = {
 	.name		= "Heart Rate GATT Driver",
+	.local_uuid	= HEART_RATE_UUID,
 	.remote_uuid	= HEART_RATE_UUID,
 
 	.device_probe	= heartrate_device_probe,
-- 
1.8.1.4

