Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 08/14] shared/ad: Add bt_ad_add_appearance and bt_ad_clear_appearance
Date: Thu, 10 Aug 2017 16:32:45 +0300
Message-Id: <20170810133251.23920-8-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds basically functionality to add and remove GAP appearance to
advertising data.
---
 src/shared/ad.c | 36 ++++++++++++++++++++++++++++++++++++
 src/shared/ad.h |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index aca4e2381..255794dc4 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -32,6 +32,7 @@
 struct bt_ad {
 	int ref_count;
 	char *name;
+	uint16_t appearance;
 	struct queue *service_uuids;
 	struct queue *manufacturer_data;
 	struct queue *solicit_uuids;
@@ -47,6 +48,7 @@ struct bt_ad *bt_ad_new(void)
 	ad->manufacturer_data = queue_new();
 	ad->solicit_uuids = queue_new();
 	ad->service_data = queue_new();
+	ad->appearance = UINT16_MAX;
 
 	return bt_ad_ref(ad);
 }
@@ -215,6 +217,8 @@ static size_t calculate_length(struct bt_ad *ad)
 
 	length += name_length(ad->name, &length);
 
+	length += ad->appearance != UINT16_MAX ? 4 : 0;
+
 	return length;
 }
 
@@ -354,6 +358,18 @@ static void serialize_name(const char *name, uint8_t *buf, uint8_t *pos)
 	*pos += len;
 }
 
+static void serialize_appearance(uint16_t value, uint8_t *buf, uint8_t *pos)
+{
+	if (value == UINT16_MAX)
+		return;
+
+	buf[(*pos)++] = sizeof(value) + 1;
+	buf[(*pos)++] = EIR_GAP_APPEARANCE;
+
+	bt_put_le16(value, buf + (*pos));
+	*pos += 2;
+}
+
 uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 {
 	uint8_t *adv_data;
@@ -381,6 +397,8 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 
 	serialize_name(ad->name, adv_data, &pos);
 
+	serialize_appearance(ad->appearance, adv_data, &pos);
+
 	return adv_data;
 }
 
@@ -720,3 +738,21 @@ void bt_ad_clear_name(struct bt_ad *ad)
 	free(ad->name);
 	ad->name = NULL;
 }
+
+bool bt_ad_add_appearance(struct bt_ad *ad, uint16_t appearance)
+{
+	if (!ad)
+		return false;
+
+	ad->appearance = appearance;
+
+	return true;
+}
+
+void bt_ad_clear_appearance(struct bt_ad *ad)
+{
+	if (!ad)
+		return;
+
+	ad->appearance = UINT16_MAX;
+}
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 161602d6d..f0e3b8127 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -92,3 +92,7 @@ void bt_ad_clear_service_data(struct bt_ad *ad);
 bool bt_ad_add_name(struct bt_ad *ad, const char *name);
 
 void bt_ad_clear_name(struct bt_ad *ad);
+
+bool bt_ad_add_appearance(struct bt_ad *ad, uint16_t appearance);
+
+void bt_ad_clear_appearance(struct bt_ad *ad);
-- 
2.13.4

