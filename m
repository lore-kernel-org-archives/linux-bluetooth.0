Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 6/8] client: Use g_dbus_proxy_path_lookup()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Message-ID: <93d4cf2f-484d-7729-896f-76679046989d@jp.fujitsu.com>
Date: Fri, 22 Dec 2017 16:35:55 +0900
MIME-Version: 1.0
In-Reply-To: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/gatt.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index cdf14363c..c0f789c34 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -444,28 +444,13 @@ GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *arg)
 
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

