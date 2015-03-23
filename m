Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v4 08/15] advertising-manager: implement UnregisterAdvertisement
Date: Mon, 23 Mar 2015 08:11:00 -0700
Message-Id: <1427123467-13445-9-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
References: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement the UnregisterAdvertisement method of the
LEAdvertisingManager1 interface.
---
 src/advertising-manager.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index 958177c..3737995 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -125,6 +125,8 @@ static void advertisement_remove(void *data)
 
 	g_dbus_client_set_disconnect_watch(ad->client, NULL, NULL);
 
+	/* TODO: mgmt API call to remove advert */
+
 	queue_remove(ad->manager->adverts, ad);
 
 	g_idle_add(advertisement_free_idle_cb, ad);
@@ -303,10 +305,28 @@ static DBusMessage *unregister_advertisement(DBusConnection *conn,
 						DBusMessage *msg,
 						void *user_data)
 {
+	struct btd_advertising_manager *manager = user_data;
+	DBusMessageIter args;
+	const char *path;
+	struct advertisement *ad;
+
 	DBG("UnregisterAdvertisement");
 
-	/* TODO */
-	return NULL;
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	ad = queue_find(manager->adverts, match_advertisement_path, path);
+	if (!ad)
+		return btd_error_does_not_exist(msg);
+
+	advertisement_remove(ad);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static const GDBusMethodTable methods[] = {
-- 
2.2.0.rc0.207.ga3a616c

