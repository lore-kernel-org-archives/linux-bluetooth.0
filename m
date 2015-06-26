Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/advertising: Fix using wrong instance id
Date: Fri, 26 Jun 2015 15:00:03 +0300
Message-Id: <1435320003-14720-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The instance id shall be limited to the number of instance the kernel
support, and since this will probably be quite small the ids should be
reused once the client unregistered.
---
 src/advertising.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index ab5c6fc..d56b7a2 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -48,7 +48,7 @@ struct btd_advertising {
 	uint16_t mgmt_index;
 	uint8_t max_adv_len;
 	uint8_t max_ads;
-	unsigned int next_instance_id;
+	unsigned int instance_bitmap;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -155,6 +155,8 @@ static void advertisement_remove(void *data)
 
 	queue_remove(ad->manager->ads, ad);
 
+	util_clear_uid(&ad->manager->instance_bitmap, ad->instance);
+
 	g_idle_add(advertisement_free_idle_cb, ad);
 }
 
@@ -633,6 +635,7 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 	DBusMessageIter args;
 	struct advertisement *ad;
 	struct dbus_obj_match match;
+	uint8_t instance;
 
 	DBG("RegisterAdvertisement");
 
@@ -649,7 +652,8 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 	if (queue_find(manager->ads, match_advertisement, &match))
 		return btd_error_already_exists(msg);
 
-	if (queue_length(manager->ads) >= manager->max_ads)
+	instance = util_get_uid(&manager->instance_bitmap, manager->max_ads);
+	if (!instance)
 		return btd_error_failed(msg, "Maximum advertisements reached");
 
 	dbus_message_iter_next(&args);
@@ -664,7 +668,7 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 
 	DBG("Registered advertisement at path %s", match.path);
 
-	ad->instance = manager->next_instance_id++;
+	ad->instance = instance;
 	ad->manager = manager;
 
 	queue_push_tail(manager->ads, ad);
@@ -786,8 +790,6 @@ advertising_manager_create(struct btd_adapter *adapter)
 
 	manager->ads = queue_new();
 
-	manager->next_instance_id = 1;
-
 	return manager;
 }
 
-- 
2.1.0

