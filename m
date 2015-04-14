Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 4/6] core/advertising: Support more than one advertisement.
Date: Tue, 14 Apr 2015 15:06:59 -0700
Message-Id: <1429049221-21984-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
References: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the Read Advertising Features response to determine the maximum
number of advertisements, and limit the number of advertisements based
on this.
---
 src/advertising.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 8e803cb..46de9b4 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -47,6 +47,8 @@ struct btd_advertising {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	uint8_t max_adv_len;
+	uint8_t max_ads;
+	unsigned int next_instance_id;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -570,8 +572,6 @@ static struct advertisement *advertisement_create(DBusConnection *conn,
 	if (!ad)
 		return NULL;
 
-	ad->instance = 1;
-
 	ad->client = g_dbus_client_new_full(conn, sender, path, path);
 	if (!ad->client)
 		goto fail;
@@ -629,9 +629,8 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 	if (queue_find(manager->ads, match_advertisement, &match))
 		return btd_error_already_exists(msg);
 
-	/* TODO: support more than one advertisement */
-	if (!queue_isempty(manager->ads))
-		return btd_error_failed(msg, "Already advertising");
+	if (queue_length(manager->ads) >= manager->max_ads)
+		return btd_error_failed(msg, "Maximum advertisements reached");
 
 	dbus_message_iter_next(&args);
 
@@ -645,7 +644,9 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 
 	DBG("Registered advertisement at path %s", match.path);
 
+	ad->instance = manager->next_instance_id++;
 	ad->manager = manager;
+
 	queue_push_tail(manager->ads, ad);
 
 	return NULL;
@@ -722,6 +723,7 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 	}
 
 	manager->max_adv_len = feat->max_adv_data_len;
+	manager->max_ads = feat->max_instances;
 }
 
 static struct btd_advertising *
@@ -765,6 +767,8 @@ advertising_manager_create(struct btd_adapter *adapter)
 
 	manager->ads = queue_new();
 
+	manager->next_instance_id = 1;
+
 	return manager;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

