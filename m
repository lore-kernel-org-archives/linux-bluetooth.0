Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/11] shared/ad: Add bt_ad_has_service_data
Date: Wed, 15 Apr 2015 14:44:26 +0300
Message-Id: <1429098268-9695-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
References: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_ad_has_service_data function that can be used to
verify if data exists or in case of NULL if any data has been added.
---
 src/shared/ad.c | 31 +++++++++++++++++++++++++++++++
 src/shared/ad.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 7eb74ab..83f01e4 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -583,6 +583,11 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 
 	new_data->len = len;
 
+	if (bt_ad_has_service_data(ad, new_data)) {
+		uuid_destroy(new_data);
+		return false;
+	}
+
 	if (queue_push_tail(ad->service_data, new_data))
 		return true;
 
@@ -591,6 +596,32 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	return false;
 }
 
+static bool service_data_match(const void *data, const void *user_data)
+{
+	const struct bt_ad_service_data *s1 = data;
+	const struct bt_ad_service_data *s2 = data;
+
+	if (bt_uuid_cmp(&s1->uuid, &s2->uuid))
+		return false;
+
+	if (s1->len != s2->len)
+		return false;
+
+	return !memcmp(s1->data, s2->data, s1->len);
+}
+
+bool bt_ad_has_service_data(struct bt_ad *ad,
+					const struct bt_ad_service_data *data)
+{
+	if (!ad)
+		return false;
+
+	if (!data)
+		return !queue_isempty(ad->service_data);
+
+	return queue_find(ad->service_data, service_data_match, data);
+}
+
 void bt_ad_foreach_service_data(struct bt_ad *ad, bt_ad_func_t func,
 							void *user_data)
 {
diff --git a/src/shared/ad.h b/src/shared/ad.h
index c31a040..4b313ab 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -75,6 +75,9 @@ void bt_ad_clear_solicit_uuid(struct bt_ad *ad);
 bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 								size_t len);
 
+bool bt_ad_has_service_data(struct bt_ad *ad,
+					const struct bt_ad_service_data *data);
+
 void bt_ad_foreach_service_data(struct bt_ad *ad, bt_ad_func_t func,
 							void *user_data);
 
-- 
2.1.0

