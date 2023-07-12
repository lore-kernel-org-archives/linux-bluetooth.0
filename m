Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1378EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 19:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjGLTjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjGLTi7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 15:38:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0763B1FC7
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:38:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89d47ffb6so39106825ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190736; x=1691782736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0E2E/APImMxF1i4xMgrl3zQnLPKzmkgdmDUSKO/iY=;
        b=HXcwkboJTT5DhvG/ypMvTPKiXkC8Xn1EGv0hPxUZ6GfYhM7NmDA0fbmDhUE9i1LMvB
         O0/U1tva/GDN6tfwL9COFoUx39hnCiIWj1zbzJQGL42gh5C/vn5RUAxVajr4YU57321A
         X12/jIgsloa8NwVZU8P+U3LzrBiXvnxWh6FZlv+YwMvYIKWjRnNzMlE5QF2cZ1KCU423
         ZAkCnr4Qz5E5RXe3JOVYl3m9cPOmacDuSxB9GjvdhdGRnmOJVttX4K0TUdTn54X+cDW/
         N4i5q+NUOtJN8opzmFh10cAZqGZ14ySJetEoXU1I9oBzXHYbt6b74dmM+IfMEBx//Oue
         pRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190736; x=1691782736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wB0E2E/APImMxF1i4xMgrl3zQnLPKzmkgdmDUSKO/iY=;
        b=eNN6iqUzCKftx9Uv5jAQ8oaDY20hEcc14YDXp9/VBDCVs7UfDnxhVOqAV/FLW690hQ
         Yplm6ESHcI+lYd1xDrIVrn0mmk9xphlGvLBckfrWkTWJMg2qE+bwTXqmpSXfN5VuINQz
         JJoHdW5INPbFfY4bH69sjDoidDQqWBzogDbK3FFt+kw3nrHlVAqSrUdvlDPuravfQyyC
         2pYEP31Gz4znzxYjYikHRLTGPcnOsaWKUVkps8aLemLHBqIWmAaoEIqh2ytFIs35nS0L
         5OkJqO0a0U0SbiA39jRF8NRdHuTQ7wJYmwqUHDZGmL3TTiJ5T0wvfZZSoc+So9T/KIiZ
         Ll7A==
X-Gm-Message-State: ABy/qLbc3T15Fpj8C3pUPCpmd6hf8251FnvOwmP8E/7PPvSPgc0vG0aK
        JRPI/u8xBJf/YReblkxb4rhzFGxyus0=
X-Google-Smtp-Source: APBJJlF/8LTZGELKbbRlb25knzr75OSW6pChERBH0A46oSDL504Xlueuo3DAar16VXB8ynToYLdOSg==
X-Received: by 2002:a17:903:41d2:b0:1b8:ab0d:cd5 with SMTP id u18-20020a17090341d200b001b8ab0d0cd5mr19678026ple.49.1689190736210;
        Wed, 12 Jul 2023 12:38:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id ij12-20020a170902ab4c00b001b84cd8814bsm4413264plb.65.2023.07.12.12.38.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:38:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/ad: Use util_iov_push_* helpers to generate data
Date:   Wed, 12 Jul 2023 12:38:50 -0700
Message-Id: <20230712193854.1862996-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of util_iov_push_* helpers to generate the data.
---
 src/shared/ad.c | 163 ++++++++++++++++++++++--------------------------
 1 file changed, 74 insertions(+), 89 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 8b3fde2b1dcd..e8bebe70708e 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -365,84 +365,80 @@ static size_t calculate_length(struct bt_ad *ad)
 }
 
 static void serialize_uuids(struct queue *uuids, uint8_t uuid_type,
-						uint8_t ad_type, uint8_t *buf,
-						uint8_t *pos)
+				uint8_t ad_type, struct iovec *iov)
 {
 	const struct queue_entry *entry = queue_get_entries(uuids);
-	bool added = false;
-	uint8_t length_pos = 0;
+	uint8_t *len = NULL;
 
 	while (entry) {
 		bt_uuid_t *uuid = entry->data;
 
 		if (uuid->type == uuid_type) {
-			if (!added) {
-				length_pos = (*pos)++;
-				buf[(*pos)++] = ad_type;
-				added = true;
+			if (!len) {
+				len = iov->iov_base + iov->iov_len;
+				util_iov_push_u8(iov, 1);
+				util_iov_push_u8(iov, ad_type);
 			}
 
-			if (uuid_type != BT_UUID32)
-				bt_uuid_to_le(uuid, buf + *pos);
-			else
-				bt_put_le32(uuid->value.u32, buf + *pos);
-
-			*pos += bt_uuid_len(uuid);
+			switch (uuid->type) {
+			case BT_UUID16:
+				util_iov_push_le16(iov, uuid->value.u16);
+				*len += 2;
+				break;
+			case BT_UUID32:
+				util_iov_push_le32(iov, uuid->value.u32);
+				*len += 4;
+				break;
+			case BT_UUID128:
+				bt_uuid_to_le(uuid, util_iov_push(iov, 16));
+				*len += 16;
+				break;
+			case BT_UUID_UNSPEC:
+				break;
+			}
 		}
 
 		entry = entry->next;
 	}
-
-	if (added)
-		buf[length_pos] = *pos - length_pos - 1;
 }
 
-static void serialize_service_uuids(struct queue *uuids, uint8_t *buf,
-								uint8_t *pos)
+static void serialize_service_uuids(struct queue *uuids, struct iovec *iov)
 {
-	serialize_uuids(uuids, BT_UUID16, BT_AD_UUID16_ALL, buf, pos);
+	serialize_uuids(uuids, BT_UUID16, BT_AD_UUID16_ALL, iov);
 
-	serialize_uuids(uuids, BT_UUID32, BT_AD_UUID32_ALL, buf, pos);
+	serialize_uuids(uuids, BT_UUID32, BT_AD_UUID32_ALL, iov);
 
-	serialize_uuids(uuids, BT_UUID128, BT_AD_UUID128_ALL, buf, pos);
+	serialize_uuids(uuids, BT_UUID128, BT_AD_UUID128_ALL, iov);
 }
 
-static void serialize_solicit_uuids(struct queue *uuids, uint8_t *buf,
-								uint8_t *pos)
+static void serialize_solicit_uuids(struct queue *uuids, struct iovec *iov)
 {
-	serialize_uuids(uuids, BT_UUID16, BT_AD_SOLICIT16, buf, pos);
+	serialize_uuids(uuids, BT_UUID16, BT_AD_SOLICIT16, iov);
 
-	serialize_uuids(uuids, BT_UUID32, BT_AD_SOLICIT32, buf, pos);
+	serialize_uuids(uuids, BT_UUID32, BT_AD_SOLICIT32, iov);
 
-	serialize_uuids(uuids, BT_UUID128, BT_AD_SOLICIT128, buf, pos);
+	serialize_uuids(uuids, BT_UUID128, BT_AD_SOLICIT128, iov);
 }
 
-static void serialize_manuf_data(struct queue *manuf_data, uint8_t *buf,
-								uint8_t *pos)
+static void serialize_manuf_data(struct queue *manuf_data, struct iovec *iov)
 {
 	const struct queue_entry *entry = queue_get_entries(manuf_data);
 
 	while (entry) {
 		struct bt_ad_manufacturer_data *data = entry->data;
 
-		buf[(*pos)++] = data->len + 2 + 1;
+		util_iov_push_u8(iov, data->len + 2 + 1);
+		util_iov_push_u8(iov, BT_AD_MANUFACTURER_DATA);
 
-		buf[(*pos)++] = BT_AD_MANUFACTURER_DATA;
-
-		bt_put_le16(data->manufacturer_id, buf + (*pos));
-
-		*pos += 2;
-
-		memcpy(buf + *pos, data->data, data->len);
-
-		*pos += data->len;
+		util_iov_push_le16(iov, data->manufacturer_id);
+		util_iov_push_mem(iov, data->len, data->data);
 
 		entry = entry->next;
 	}
 }
 
-static void serialize_service_data(struct queue *service_data, uint8_t *buf,
-								uint8_t *pos)
+static void serialize_service_data(struct queue *service_data,
+					struct iovec *iov)
 {
 	const struct queue_entry *entry = queue_get_entries(service_data);
 
@@ -450,81 +446,69 @@ static void serialize_service_data(struct queue *service_data, uint8_t *buf,
 		struct bt_ad_service_data *data = entry->data;
 		int uuid_len = bt_uuid_len(&data->uuid);
 
-		buf[(*pos)++] =  uuid_len + data->len + 1;
+		util_iov_push_u8(iov, data->len + uuid_len + 1);
 
 		switch (uuid_len) {
 		case 2:
-			buf[(*pos)++] = BT_AD_SERVICE_DATA16;
+			util_iov_push_u8(iov, BT_AD_SERVICE_DATA16);
+			util_iov_push_le16(iov, data->uuid.value.u16);
 			break;
 		case 4:
-			buf[(*pos)++] = BT_AD_SERVICE_DATA32;
+			util_iov_push_u8(iov, BT_AD_SERVICE_DATA32);
+			util_iov_push_le32(iov, data->uuid.value.u32);
 			break;
 		case 16:
-			buf[(*pos)++] = BT_AD_SERVICE_DATA128;
+			util_iov_push_u8(iov, BT_AD_SERVICE_DATA128);
+			bt_uuid_to_le(&data->uuid,
+					util_iov_push(iov, uuid_len));
 			break;
 		}
 
-		if (uuid_len != 4)
-			bt_uuid_to_le(&data->uuid, buf + *pos);
-		else
-			bt_put_le32(data->uuid.value.u32, buf + *pos);
-
-		*pos += uuid_len;
-
-		memcpy(buf + *pos, data->data, data->len);
-
-		*pos += data->len;
+		util_iov_push_mem(iov, data->len, data->data);
 
 		entry = entry->next;
 	}
 }
 
-static void serialize_name(struct bt_ad *ad, uint8_t *buf, uint8_t *pos)
+static void serialize_name(struct bt_ad *ad, struct iovec *iov)
 {
-	int len;
+	size_t len;
 	uint8_t type = BT_AD_NAME_COMPLETE;
 
 	if (!ad->name)
 		return;
 
 	len = strlen(ad->name);
-	if (len > ad->max_len - (*pos + 2)) {
+	if (len > ad->max_len - (iov->iov_len + 2)) {
 		type = BT_AD_NAME_SHORT;
-		len = ad->max_len - (*pos + 2);
+		len = ad->max_len - (iov->iov_len + 2);
 	}
 
-	buf[(*pos)++] = len + 1;
-	buf[(*pos)++] = type;
-
-	memcpy(buf + *pos, ad->name, len);
-	*pos += len;
+	util_iov_push_u8(iov, len + 1);
+	util_iov_push_u8(iov, type);
+	util_iov_push_mem(iov, len, ad->name);
 }
 
-static void serialize_appearance(struct bt_ad *ad, uint8_t *buf, uint8_t *pos)
+static void serialize_appearance(struct bt_ad *ad, struct iovec *iov)
 {
 	if (ad->appearance == UINT16_MAX)
 		return;
 
-	buf[(*pos)++] = sizeof(ad->appearance) + 1;
-	buf[(*pos)++] = BT_AD_GAP_APPEARANCE;
-
-	bt_put_le16(ad->appearance, buf + (*pos));
-	*pos += 2;
+	util_iov_push_u8(iov, sizeof(ad->appearance) + 1);
+	util_iov_push_u8(iov, BT_AD_GAP_APPEARANCE);
+	util_iov_push_le16(iov, ad->appearance);
 }
 
-static void serialize_data(struct queue *queue, uint8_t *buf, uint8_t *pos)
+static void serialize_data(struct queue *queue, struct iovec *iov)
 {
 	const struct queue_entry *entry = queue_get_entries(queue);
 
 	while (entry) {
 		struct bt_ad_data *data = entry->data;
 
-		buf[(*pos)++] = data->len + 1;
-		buf[(*pos)++] = data->type;
-
-		memcpy(buf + *pos, data->data, data->len);
-
-		*pos += data->len;
+		util_iov_push_u8(iov, data->len + 1);
+		util_iov_push_u8(iov, data->type);
+		util_iov_push_mem(iov, data->len, data->data);
 
 		entry = entry->next;
 	}
@@ -532,8 +516,7 @@ static void serialize_data(struct queue *queue, uint8_t *buf, uint8_t *pos)
 
 uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 {
-	uint8_t *adv_data;
-	uint8_t pos = 0;
+	struct iovec iov;
 
 	if (!ad)
 		return NULL;
@@ -543,25 +526,27 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 	if (*length > ad->max_len)
 		return NULL;
 
-	adv_data = malloc0(*length);
-	if (!adv_data)
+	iov.iov_base = malloc0(*length);
+	if (!iov.iov_base)
 		return NULL;
 
-	serialize_service_uuids(ad->service_uuids, adv_data, &pos);
+	iov.iov_len = 0;
 
-	serialize_solicit_uuids(ad->solicit_uuids, adv_data, &pos);
+	serialize_service_uuids(ad->service_uuids, &iov);
 
-	serialize_manuf_data(ad->manufacturer_data, adv_data, &pos);
+	serialize_solicit_uuids(ad->solicit_uuids, &iov);
 
-	serialize_service_data(ad->service_data, adv_data, &pos);
+	serialize_manuf_data(ad->manufacturer_data, &iov);
 
-	serialize_name(ad, adv_data, &pos);
+	serialize_service_data(ad->service_data, &iov);
 
-	serialize_appearance(ad, adv_data, &pos);
+	serialize_name(ad, &iov);
 
-	serialize_data(ad->data, adv_data, &pos);
+	serialize_appearance(ad, &iov);
 
-	return adv_data;
+	serialize_data(ad->data, &iov);
+
+	return iov.iov_base;
 }
 
 bool bt_ad_is_empty(struct bt_ad *ad)
-- 
2.40.1

