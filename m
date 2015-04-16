Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 03/13] shared/ad: Add bt_ad_has_manufacturer_data
Date: Thu, 16 Apr 2015 17:41:05 +0300
Message-Id: <1429195275-19635-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
References: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_ad_has_manufacturer_data function that can be used to
verify if data exists or in case of NULL if any data has been added.
---
 src/shared/ad.c | 31 +++++++++++++++++++++++++++++++
 src/shared/ad.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index d8b124d..90d27e3 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -464,6 +464,11 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 
 	new_data->len = len;
 
+	if (bt_ad_has_manufacturer_data(ad, new_data)) {
+		manuf_destroy(new_data);
+		return false;
+	}
+
 	if (queue_push_tail(ad->manufacturer_data, new_data))
 		return true;
 
@@ -472,6 +477,32 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	return false;
 }
 
+static bool manufacturer_data_match(const void *data, const void *user_data)
+{
+	const struct bt_ad_manufacturer_data *m1 = data;
+	const struct bt_ad_manufacturer_data *m2 = data;
+
+	if (m1->manufacturer_id != m2->manufacturer_id)
+		return false;
+
+	if (m1->len != m2->len)
+		return false;
+
+	return !memcmp(m1->data, m2->data, m1->len);
+}
+
+bool bt_ad_has_manufacturer_data(struct bt_ad *ad,
+				const struct bt_ad_manufacturer_data *data)
+{
+	if (!ad)
+		return false;
+
+	if (!data)
+		return !queue_isempty(ad->manufacturer_data);
+
+	return queue_find(ad->manufacturer_data, manufacturer_data_match, data);
+}
+
 void bt_ad_foreach_manufacturer_data(struct bt_ad *ad, bt_ad_func_t func,
 							void *user_data)
 {
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 6e916a3..b7d9ade 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -50,6 +50,9 @@ void bt_ad_clear_service_uuid(struct bt_ad *ad);
 bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_data,
 						void *data, size_t len);
 
+bool bt_ad_has_manufacturer_data(struct bt_ad *ad,
+				const struct bt_ad_manufacturer_data *data);
+
 void bt_ad_foreach_manufacturer_data(struct bt_ad *ad, bt_ad_func_t func,
 							void *user_data);
 
-- 
2.1.0

