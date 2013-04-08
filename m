Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 2/6] gdbus: Use gcc builtin instead of g_atomic
Date: Mon,  8 Apr 2013 17:56:18 -0300
Message-Id: <1365454582-12781-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1365454582-12781-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1365454582-12781-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_atomic_* end up using G_STATIC_ASSERT, causing gcc 4.8 to yell due to
-Wunused-local-typedefs.

gdbus/client.c: In function ‘g_dbus_client_ref’:
/usr/include/glib-2.0/glib/gmacros.h:162:53: error: typedef ‘_GStaticAssertCompileTimeAssertion_2’ locally defined but not used [-Werror=unused-local-typedefs]
 #define G_STATIC_ASSERT(expr) typedef char G_PASTE (_GStaticAssertCompileTimeAssertion_, __COUNTER__)[(expr) ? 1 : -1]
---
 gdbus/client.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 2a7d2e1..c2d2346 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -33,7 +33,7 @@
 #define METHOD_CALL_TIMEOUT (300 * 1000)
 
 struct GDBusClient {
-	gint ref_count;
+	int ref_count;
 	DBusConnection *dbus_conn;
 	char *service_name;
 	char *unique_name;
@@ -54,7 +54,7 @@ struct GDBusClient {
 };
 
 struct GDBusProxy {
-	gint ref_count;
+	int ref_count;
 	GDBusClient *client;
 	char *obj_path;
 	char *interface;
@@ -444,7 +444,7 @@ GDBusProxy *g_dbus_proxy_ref(GDBusProxy *proxy)
 	if (proxy == NULL)
 		return NULL;
 
-	g_atomic_int_inc(&proxy->ref_count);
+	__sync_fetch_and_add(&proxy->ref_count, 1);
 
 	return proxy;
 }
@@ -454,7 +454,7 @@ void g_dbus_proxy_unref(GDBusProxy *proxy)
 	if (proxy == NULL)
 		return;
 
-	if (g_atomic_int_dec_and_test(&proxy->ref_count) == FALSE)
+	if (__sync_sub_and_fetch(&proxy->ref_count, 1) > 0)
 		return;
 
 	g_hash_table_destroy(proxy->prop_list);
@@ -1265,7 +1265,7 @@ GDBusClient *g_dbus_client_ref(GDBusClient *client)
 	if (client == NULL)
 		return NULL;
 
-	g_atomic_int_inc(&client->ref_count);
+	__sync_fetch_and_add(&client->ref_count, 1);
 
 	return client;
 }
@@ -1277,7 +1277,7 @@ void g_dbus_client_unref(GDBusClient *client)
 	if (client == NULL)
 		return;
 
-	if (g_atomic_int_dec_and_test(&client->ref_count) == FALSE)
+	if (__sync_sub_and_fetch(&client->ref_count, 1) > 0)
 		return;
 
 	if (client->pending_call != NULL) {
-- 
1.8.2.1

