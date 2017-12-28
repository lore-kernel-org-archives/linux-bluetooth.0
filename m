Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 6/8] client: Use g_dbus_proxy_path_lookup()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Message-ID: <0e91c3c1-5913-3969-7055-a4815563a51e@jp.fujitsu.com>
Date: Thu, 28 Dec 2017 14:44:18 +0900
MIME-Version: 1.0
In-Reply-To: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/gatt.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 3d0222e63..4d51e053c 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -445,28 +445,13 @@ GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *arg)
 
 static char *attribute_generator(const char *text, int state, GList *source)
 {
-	static int index, len;
-	GList *list;
+	static int index;
 
 	if (!state) {
 		index = 0;
-		len = strlen(text);
 	}
 
-	for (list = g_list_nth(source, index); list;
-						list = g_list_next(list)) {
-		GDBusProxy *proxy = list->data;
-		const char *path;
-
-		index++;
-
-		path = g_dbus_proxy_get_path(proxy);
-
-		if (!strncmp(path, text, len))
-			return strdup(path);
-        }
-
-	return NULL;
+	return g_dbus_proxy_path_lookup(source, &index, text);
 }
 
 char *gatt_attribute_generator(const char *text, int state)
-- 
2.14.1

