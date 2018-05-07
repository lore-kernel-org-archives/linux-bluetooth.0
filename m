Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/ad: Add bt_ad_add_flags and bt_ad_clear_flags
Date: Mon,  7 May 2018 19:14:00 +0300
Message-Id: <20180507161403.14181-2-luiz.dentz@gmail.com>
In-Reply-To: <20180507161403.14181-1-luiz.dentz@gmail.com>
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds basically functionality to add and remove AD flags.
---
 src/shared/ad.c | 92 +++++++++++++++++++++++++++++++++++++--------------------
 src/shared/ad.h |  4 +++
 2 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index f0e62cef1..102fe0e13 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -127,6 +127,48 @@ void bt_ad_unref(struct bt_ad *ad)
 	free(ad);
 }
 
+static bool data_type_match(const void *data, const void *user_data)
+{
+	const struct bt_ad_data *a = data;
+	const uint8_t type = PTR_TO_UINT(user_data);
+
+	return a->type == type;
+}
+
+static bool ad_replace_data(struct bt_ad *ad, uint8_t type, void *data,
+							size_t len)
+{
+	struct bt_ad_data *new_data;
+
+	new_data = queue_find(ad->data, data_type_match, UINT_TO_PTR(type));
+	if (new_data) {
+		if (new_data->len == len && !memcmp(new_data->data, data, len))
+			return false;
+		new_data->data = realloc(new_data->data, len);
+		memcpy(new_data->data, data, len);
+		new_data->len = len;
+		return true;
+	}
+
+	new_data = new0(struct bt_ad_data, 1);
+	new_data->type = type;
+	new_data->data = malloc(len);
+	if (!new_data->data) {
+		free(new_data);
+		return false;
+	}
+
+	memcpy(new_data->data, data, len);
+	new_data->len = len;
+
+	if (queue_push_tail(ad->data, new_data))
+		return true;
+
+	data_destroy(new_data);
+
+	return false;
+}
+
 static size_t uuid_list_length(struct queue *uuid_queue)
 {
 	bool uuid16_included = false;
@@ -809,12 +851,25 @@ void bt_ad_clear_appearance(struct bt_ad *ad)
 	ad->appearance = UINT16_MAX;
 }
 
-static bool data_type_match(const void *data, const void *user_data)
+bool bt_ad_add_flags(struct bt_ad *ad, uint8_t *flags, size_t len)
 {
-	const struct bt_ad_data *a = data;
-	const uint8_t type = PTR_TO_UINT(user_data);
+	if (!ad)
+		return false;
 
-	return a->type == type;
+	/* TODO: Add table to check other flags */
+	if (len > 1 || flags[0] & 0xe0)
+		return false;
+
+	return ad_replace_data(ad, BT_AD_FLAGS, flags, len);
+}
+
+void bt_ad_clear_flags(struct bt_ad *ad)
+{
+	if (!ad)
+		return;
+
+	queue_remove_all(ad->data, data_type_match, UINT_TO_PTR(BT_AD_FLAGS),
+							data_destroy);
 }
 
 static uint8_t type_blacklist[] = {
@@ -862,7 +917,6 @@ static uint8_t type_blacklist[] = {
 
 bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
 {
-	struct bt_ad_data *new_data;
 	size_t i;
 
 	if (!ad)
@@ -871,38 +925,12 @@ bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
 	if (len > (MAX_ADV_DATA_LEN - 2))
 		return false;
 
-	new_data = queue_find(ad->data, data_type_match, UINT_TO_PTR(type));
-	if (new_data) {
-		if (new_data->len == len && !memcmp(new_data->data, data, len))
-			return false;
-		new_data->data = realloc(new_data->data, len);
-		memcpy(new_data->data, data, len);
-		new_data->len = len;
-		return true;
-	}
-
 	for (i = 0; i < sizeof(type_blacklist); i++) {
 		if (type == type_blacklist[i])
 			return false;
 	}
 
-	new_data = new0(struct bt_ad_data, 1);
-	new_data->type = type;
-	new_data->data = malloc(len);
-	if (!new_data->data) {
-		free(new_data);
-		return false;
-	}
-
-	memcpy(new_data->data, data, len);
-	new_data->len = len;
-
-	if (queue_push_tail(ad->data, new_data))
-		return true;
-
-	data_destroy(new_data);
-
-	return false;
+	return ad_replace_data(ad, type, data, len);
 }
 
 static bool data_match(const void *data, const void *user_data)
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 8d705323b..0e30cdca9 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -147,6 +147,10 @@ bool bt_ad_add_appearance(struct bt_ad *ad, uint16_t appearance);
 
 void bt_ad_clear_appearance(struct bt_ad *ad);
 
+bool bt_ad_add_flags(struct bt_ad *ad, uint8_t *flags, size_t len);
+
+void bt_ad_clear_flags(struct bt_ad *ad);
+
 bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len);
 
 bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data);
-- 
2.14.3

