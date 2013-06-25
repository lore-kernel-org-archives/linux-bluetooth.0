Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 08/16] cyclingspeed: Use btd_server userdata
Date: Tue, 25 Jun 2013 18:24:41 +0200
Message-Id: <1372177489-6858-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Exploit the userdata pointer to avoid maintainig a list with instances
of struct csc_adapter.
---
 profiles/cyclingspeed/cyclingspeed.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 14c2df7..8b7e2e1 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -138,8 +138,6 @@ struct characteristic {
 	char		uuid[MAX_LEN_UUID_STR + 1];
 };
 
-static GSList *csc_adapters = NULL;
-
 static const char * const location_enum[] = {
 	"other", "top-of-shoe", "in-shoe", "hip", "front-wheel", "left-crank",
 	"right-crank", "left-pedal", "right-pedal", "front-hub",
@@ -167,17 +165,6 @@ static int str2location(const char *location)
 	return -1;
 }
 
-static int cmp_adapter(gconstpointer a, gconstpointer b)
-{
-	const struct csc_adapter *cadapter = a;
-	const struct btd_adapter *adapter = b;
-
-	if (adapter == cadapter->adapter)
-		return 0;
-
-	return -1;
-}
-
 static int cmp_device(gconstpointer a, gconstpointer b)
 {
 	const struct csc *csc = a;
@@ -204,12 +191,13 @@ static int cmp_watcher(gconstpointer a, gconstpointer b)
 
 static struct csc_adapter *find_csc_adapter(struct btd_adapter *adapter)
 {
-	GSList *l = g_slist_find_custom(csc_adapters, adapter, cmp_adapter);
+	struct btd_server *server;
 
-	if (!l)
+	server = btd_adapter_get_server(adapter, CYCLING_SC_UUID);
+	if (server == NULL)
 		return NULL;
 
-	return l->data;
+	return btd_server_get_user_data(server);
 }
 
 static void destroy_watcher(gpointer user_data)
@@ -978,21 +966,14 @@ static int csc_adapter_probe(struct btd_server *server)
 		return -EIO;
 	}
 
-	csc_adapters = g_slist_prepend(csc_adapters, cadapter);
+	btd_server_set_user_data(server, cadapter);
 
 	return 0;
 }
 
 static void csc_adapter_remove(struct btd_server *server)
 {
-	struct btd_adapter *adapter = btd_server_get_adapter(server);
-	struct csc_adapter *cadapter;
-
-	cadapter = find_csc_adapter(adapter);
-	if (cadapter == NULL)
-		return;
-
-	csc_adapters = g_slist_remove(csc_adapters, cadapter);
+	struct csc_adapter *cadapter = btd_server_get_user_data(server);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 					adapter_get_path(cadapter->adapter),
@@ -1259,6 +1240,7 @@ static void csc_device_remove(struct btd_service *service)
 
 static struct btd_profile cscp_profile = {
 	.name		= "Cycling Speed and Cadence GATT Driver",
+	.local_uuid	= CYCLING_SC_UUID,
 	.remote_uuid	= CYCLING_SC_UUID,
 
 	.adapter_probe	= csc_adapter_probe,
-- 
1.8.1.4

