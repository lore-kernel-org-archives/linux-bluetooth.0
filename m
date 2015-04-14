Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 1/6] core/advertising: Fix dbus object matching
Date: Tue, 14 Apr 2015 15:06:56 -0700
Message-Id: <1429049221-21984-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
References: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Objects should be matched on both their path and the sending
application.
---
 src/advertising.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2f8e539..78178f2 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -63,12 +63,23 @@ struct advertisement {
 	uint8_t instance;
 };
 
-static bool match_advertisement_path(const void *a, const void *b)
+struct dbus_obj_match {
+	const char *owner;
+	const char *path;
+};
+
+static bool match_advertisement(const void *a, const void *b)
 {
 	const struct advertisement *ad = a;
-	const char *path = b;
+	const struct dbus_obj_match *match = b;
+
+	if (match->owner && !g_strcmp0(ad->owner, match->owner))
+		return false;
+
+	if (match->path && !g_strcmp0(ad->path, match->path))
+		return false;
 
-	return g_strcmp0(ad->path, path);
+	return true;
 }
 
 static void advertisement_free(void *data)
@@ -547,8 +558,8 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 {
 	struct btd_advertising *manager = user_data;
 	DBusMessageIter args;
-	const char *path;
 	struct advertisement *ad;
+	struct dbus_obj_match match;
 
 	DBG("RegisterAdvertisement");
 
@@ -558,9 +569,11 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
 		return btd_error_invalid_args(msg);
 
-	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_get_basic(&args, &match.path);
 
-	if (queue_find(manager->ads, match_advertisement_path, path))
+	match.owner = dbus_message_get_sender(msg);
+
+	if (queue_find(manager->ads, match_advertisement, &match))
 		return btd_error_already_exists(msg);
 
 	/* TODO: support more than one advertisement */
@@ -572,12 +585,12 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
 		return btd_error_invalid_args(msg);
 
-	ad = advertisement_create(conn, msg, path);
+	ad = advertisement_create(conn, msg, match.path);
 	if (!ad)
 		return btd_error_failed(msg,
 					"Failed to register advertisement");
 
-	DBG("Registered advertisement at path %s", path);
+	DBG("Registered advertisement at path %s", match.path);
 
 	ad->manager = manager;
 	queue_push_tail(manager->ads, ad);
@@ -591,8 +604,8 @@ static DBusMessage *unregister_advertisement(DBusConnection *conn,
 {
 	struct btd_advertising *manager = user_data;
 	DBusMessageIter args;
-	const char *path;
 	struct advertisement *ad;
+	struct dbus_obj_match match;
 
 	DBG("UnregisterAdvertisement");
 
@@ -602,9 +615,11 @@ static DBusMessage *unregister_advertisement(DBusConnection *conn,
 	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
 		return btd_error_invalid_args(msg);
 
-	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_get_basic(&args, &match.path);
+
+	match.owner = dbus_message_get_sender(msg);
 
-	ad = queue_find(manager->ads, match_advertisement_path, path);
+	ad = queue_find(manager->ads, match_advertisement, &match);
 	if (!ad)
 		return btd_error_does_not_exist(msg);
 
-- 
2.2.0.rc0.207.ga3a616c

