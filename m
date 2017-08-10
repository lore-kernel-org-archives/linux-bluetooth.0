Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 07/14] shared/ad: Add bt_ad_add_name and bt_ad_clear_name
Date: Thu, 10 Aug 2017 16:32:44 +0300
Message-Id: <20170810133251.23920-7-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds basically functionality to add and remove name to advertising
data.
---
 src/shared/ad.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h |  4 ++++
 2 files changed, 68 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 1bf013d5a..aca4e2381 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -31,6 +31,7 @@
 
 struct bt_ad {
 	int ref_count;
+	char *name;
 	struct queue *service_uuids;
 	struct queue *manufacturer_data;
 	struct queue *solicit_uuids;
@@ -107,6 +108,8 @@ void bt_ad_unref(struct bt_ad *ad)
 
 	queue_destroy(ad->service_data, uuid_destroy);
 
+	free(ad->name);
+
 	free(ad);
 }
 
@@ -183,6 +186,21 @@ static size_t uuid_data_length(struct queue *uuid_data)
 	return length;
 }
 
+static size_t name_length(const char *name, size_t *pos)
+{
+	size_t len;
+	
+	if (!name)
+		return 0;
+
+	len = 2 + strlen(name);
+
+	if (len > MAX_ADV_DATA_LEN - *pos)
+		len = MAX_ADV_DATA_LEN - *pos;
+
+	return len;
+}
+
 static size_t calculate_length(struct bt_ad *ad)
 {
 	size_t length = 0;
@@ -195,6 +213,8 @@ static size_t calculate_length(struct bt_ad *ad)
 
 	length += uuid_data_length(ad->service_data);
 
+	length += name_length(ad->name, &length);
+
 	return length;
 }
 
@@ -313,6 +333,27 @@ static void serialize_service_data(struct queue *service_data, uint8_t *buf,
 	}
 }
 
+static void serialize_name(const char *name, uint8_t *buf, uint8_t *pos)
+{
+	int len;
+	uint8_t type = EIR_NAME_COMPLETE;
+
+	if (!name)
+		return;
+
+	len = strlen(name);
+	if (len > MAX_ADV_DATA_LEN - (*pos + 2)) {
+		type = EIR_NAME_SHORT;
+		len = MAX_ADV_DATA_LEN - (*pos + 2);
+	}
+
+	buf[(*pos)++] = len + 1;
+	buf[(*pos)++] = type;
+
+	memcpy(buf + *pos, name, len);
+	*pos += len;
+}
+
 uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 {
 	uint8_t *adv_data;
@@ -338,6 +379,8 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 
 	serialize_service_data(ad->service_data, adv_data, &pos);
 
+	serialize_name(ad->name, adv_data, &pos);
+
 	return adv_data;
 }
 
@@ -656,3 +699,24 @@ void bt_ad_clear_service_data(struct bt_ad *ad)
 
 	queue_remove_all(ad->service_data, NULL, NULL, uuid_destroy);
 }
+
+bool bt_ad_add_name(struct bt_ad *ad, const char *name)
+{
+	if (!ad)
+		return false;
+
+	free(ad->name);
+
+	ad->name = strdup(name);
+
+	return true;
+}
+
+void bt_ad_clear_name(struct bt_ad *ad)
+{
+	if (!ad)
+		return;
+
+	free(ad->name);
+	ad->name = NULL;
+}
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 709563d3c..161602d6d 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -88,3 +88,7 @@ void bt_ad_foreach_service_data(struct bt_ad *ad, bt_ad_func_t func,
 bool bt_ad_remove_service_data(struct bt_ad *ad, bt_uuid_t *uuid);
 
 void bt_ad_clear_service_data(struct bt_ad *ad);
+
+bool bt_ad_add_name(struct bt_ad *ad, const char *name);
+
+void bt_ad_clear_name(struct bt_ad *ad);
-- 
2.13.4

