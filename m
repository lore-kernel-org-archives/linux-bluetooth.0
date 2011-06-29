Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] Make use of g_slist_free_full on attrib
Date: Wed, 29 Jun 2011 11:52:49 +0300
Message-Id: <1309337573-8295-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
References: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 attrib/client.c |    6 ++----
 attrib/gatt.c   |    3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 71df532..c9629c4 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -140,8 +140,7 @@ static void primary_free(void *user_data)
 		g_dbus_remove_watch(prim->gatt->conn, watcher->id);
 	}
 
-	g_slist_foreach(prim->chars, (GFunc) characteristic_free, NULL);
-	g_slist_free(prim->chars);
+	g_slist_free_full(prim->chars, characteristic_free);
 	g_free(prim->path);
 	g_free(prim);
 }
@@ -150,8 +149,7 @@ static void gatt_service_free(void *user_data)
 {
 	struct gatt_service *gatt = user_data;
 
-	g_slist_foreach(gatt->primary, (GFunc) primary_free, NULL);
-	g_slist_free(gatt->primary);
+	g_slist_free_full(gatt->primary, primary_free);
 	g_attrib_unref(gatt->attrib);
 	g_free(gatt->path);
 	btd_device_unref(gatt->dev);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 1ed78ec..a27d1af 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -59,8 +59,7 @@ static void discover_primary_free(struct discover_primary *dp)
 
 static void discover_char_free(struct discover_char *dc)
 {
-	g_slist_foreach(dc->characteristics, (GFunc) g_free, NULL);
-	g_slist_free(dc->characteristics);
+	g_slist_free_full(dc->characteristics, g_free);
 	g_attrib_unref(dc->attrib);
 	g_free(dc->uuid);
 	g_free(dc);
-- 
1.7.5.4

