Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 3/4] core/advertising: Support more than one advertisement.
Date: Fri, 10 Apr 2015 12:06:07 -0700
Message-Id: <1428692768-31941-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
References: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the Read Advertising Features response to determine the maximum
number of advertisements, and limit the number of advertisements based
on this.
---
 src/advertising.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 8acd5b4..c3e9a72 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -47,6 +47,7 @@ struct btd_advertising {
 	struct mgmt *mgmt;
 	uint16_t mgmt_index;
 	uint8_t max_adv_len;
+	uint8_t max_ads;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -610,9 +611,8 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 	if (queue_find(manager->ads, match_advertisement_path, path))
 		return btd_error_already_exists(msg);
 
-	/* TODO: support more than one advertisement */
-	if (!queue_isempty(manager->ads))
-		return btd_error_failed(msg, "Already advertising");
+	if (queue_length(manager->ads) > manager->max_ads)
+		return btd_error_failed(msg, "Maximum advertisements reached");
 
 	dbus_message_iter_next(&args);
 
@@ -695,6 +695,7 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 	}
 
 	manager->max_adv_len = feat->max_adv_data_len;
+	manager->max_ads = feat->max_instances;
 }
 
 static struct btd_advertising *
-- 
2.2.0.rc0.207.ga3a616c

