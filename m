Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Remove bt_discover_services function from glib-helper
Date: Mon, 20 Dec 2010 18:06:02 -0500
Message-Id: <1292886362-19755-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reference in the code for this function. SDP discovery in
the bluetoothd core and plugins are now using bt_search_service only.
---
 src/glib-helper.c |   10 ----------
 src/glib-helper.h |    3 ---
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/src/glib-helper.c b/src/glib-helper.c
index aa7f2c7..ec016a8 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -363,16 +363,6 @@ int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 	return 0;
 }
 
-int bt_discover_services(const bdaddr_t *src, const bdaddr_t *dst,
-		bt_callback_t cb, void *user_data, bt_destroy_t destroy)
-{
-	uuid_t uuid;
-
-	sdp_uuid16_create(&uuid, PUBLIC_BROWSE_GROUP);
-
-	return bt_search_service(src, dst, &uuid, cb, user_data, destroy);
-}
-
 static gint find_by_bdaddr(gconstpointer data, gconstpointer user_data)
 {
 	const struct search_context *ctxt = data, *search = user_data;
diff --git a/src/glib-helper.h b/src/glib-helper.h
index 9cac915..a191be0 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -25,9 +25,6 @@ typedef void (*bt_callback_t) (sdp_list_t *recs, int err, gpointer user_data);
 typedef void (*bt_primary_t) (GSList *l, int err, gpointer user_data);
 typedef void (*bt_destroy_t) (gpointer user_data);
 
-int bt_discover_services(const bdaddr_t *src, const bdaddr_t *dst,
-		bt_callback_t cb, void *user_data, bt_destroy_t destroy);
-
 int bt_search_service(const bdaddr_t *src, const bdaddr_t *dst,
 			uuid_t *uuid, bt_callback_t cb, void *user_data,
 			bt_destroy_t destroy);
-- 
1.7.3.2

