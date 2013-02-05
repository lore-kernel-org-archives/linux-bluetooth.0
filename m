Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH 1/2] hostname: Fallback to static hostname if pretty hostname is not set
Date: Tue,  5 Feb 2013 22:10:55 +0100
Message-Id: <1360098656-12488-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If pretty hostname is not set fallback to static hostname (if it is
set). If static or pretty hostname is not set appropriate properties
are empty strings not NULLs. This behaviour is recomended by hostnamed.

Also fix setting adapter name to empty string if pretty hostname was
not set.
---
 plugins/hostname.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index 0b75fac..92a71e0 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -53,22 +53,43 @@ static uint8_t major_class = MAJOR_CLASS_MISCELLANEOUS;
 static uint8_t minor_class = MINOR_CLASS_UNCATEGORIZED;
 
 static char *pretty_hostname = NULL;
+static char *static_hostname = NULL;
+
+/*
+ * Fallback to static hostname only if empty pretty hostname was already
+ * received.
+ */
+static const char *get_hostname(void)
+{
+	if (pretty_hostname) {
+		if (g_str_equal(pretty_hostname, "") == FALSE)
+			return pretty_hostname;
+
+		if (static_hostname &&
+				g_str_equal(static_hostname, "") == FALSE)
+			return static_hostname;
+	}
+
+	return NULL;
+}
 
 static void update_name(struct btd_adapter *adapter, gpointer user_data)
 {
-	if (pretty_hostname == NULL)
+	const char *hostname = get_hostname();
+
+	if (hostname == NULL)
 		return;
 
 	if (btd_adapter_is_default(adapter)) {
-		DBG("name: %s", pretty_hostname);
+		DBG("name: %s", hostname);
 
-		adapter_set_name(adapter, pretty_hostname);
+		adapter_set_name(adapter, hostname);
 	} else {
 		uint16_t index = btd_adapter_get_index(adapter);
 		char *str;
 
 		/* Avoid "some device #0" names, start at #1 */
-		str = g_strdup_printf("%s #%u", pretty_hostname, index + 1);
+		str = g_strdup_printf("%s #%u", hostname, index + 1);
 
 		DBG("name: %s", str);
 
@@ -122,6 +143,24 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 			adapter_foreach(update_name, NULL);
 		}
+	} else if (g_str_equal(name, "StaticHostname") == TRUE) {
+		if (iter == NULL) {
+			g_dbus_proxy_refresh_property(proxy, name);
+			return;
+		}
+
+		if (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_STRING) {
+			const char *str;
+
+			dbus_message_iter_get_basic(iter, &str);
+
+			DBG("static hostname: %s", str);
+
+			g_free(static_hostname);
+			static_hostname = g_strdup(str);
+
+			adapter_foreach(update_name, NULL);
+		}
 	} else if (g_str_equal(name, "Chassis") == TRUE) {
 		if (iter == NULL) {
 			g_dbus_proxy_refresh_property(proxy, name);
@@ -277,6 +316,7 @@ static void hostname_exit(void)
 	}
 
 	g_free(pretty_hostname);
+	g_free(static_hostname);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(hostname, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
1.8.1.2

