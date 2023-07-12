Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351F6EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 19:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjGLTjG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGLTjF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 15:39:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C41FC3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:39:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8ad907ba4so39154135ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190742; x=1691782742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHqQlIjqOpoJZQVgo7C2eWiI3XEYDViMGpzIq4auRvQ=;
        b=pO7B7MwoV9Kz0sbvEPuaGuJEQT9Fvp8biM32KNomv52f7GBUG0iJyCVjQUBwHMKR7F
         S7n7fKpsQsQYTJtydEB2NWADWx+AmI4vurzM2I/ZkhWYZisp1s1AZZA8pUeczA2kqGEh
         9aJnl3yr7uI0BzY2660YjXLb+4fDCCrHLR29aIwMM+cQ9bE1sz0OaaS2M3F30JJ5LQPc
         tpQDC/vtz03X+dUPgfKCE7G8AoWE/S86lEwEt80aribxDHw6KG7gt6Nsdabw/5M35MQm
         yIfus6TjoJvqjnJRp8vrQBQeB215YM2eWIyVkeXCg9k3IdNyB4XESNFmfVMasuM4T7eI
         uw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190742; x=1691782742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHqQlIjqOpoJZQVgo7C2eWiI3XEYDViMGpzIq4auRvQ=;
        b=Hf/asolSF7q853FfdeFa3N+E5rdDWrTNe6fPYJivFCC93WOXzIj0yZHQIR8WdcVTwI
         H++7DOdmZIoK7fmrsRIWkvHLTa85Gin9eSZ/eZ92T5SDS9NQf7prmFkYC9lv02jwR6IJ
         6+hUYr1Yhe4YRircLOmVE3nSAKDCue2BvV5HJ25Up5DQnOMochs+JqecWh3Pu6e/0p3X
         pVODCI6wiub8UqVdZiVyuIrCeI1aXNjHbzkd5dim7T3IsIxjuNxc4RmP3Jd+oafwxRUe
         ycWfsFMgh8HGTHfSH5iiun+xunsbHxx9VoNVpw8K34+cKaJIjUk1TCS5fAZs5564lQDf
         c7pQ==
X-Gm-Message-State: ABy/qLZmkDVtXKbrahXEJNmME2qlfwk/QH4fhxMR1wsDFHayIKyTi5WM
        vb6ROsWLhkBT4VM2kGiJDX3uq1sgZBo=
X-Google-Smtp-Source: APBJJlFQGDXjikvR62abLvmNyPwoxp8sHZREdKtSxN6zXl3g3PE5hs4WnBBFHN5stmzXACe8B/QDqg==
X-Received: by 2002:a17:902:cec3:b0:1b7:e49f:1d with SMTP id d3-20020a170902cec300b001b7e49f001dmr18980887plg.62.1689190742167;
        Wed, 12 Jul 2023 12:39:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id ij12-20020a170902ab4c00b001b84cd8814bsm4413264plb.65.2023.07.12.12.39.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:39:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] shared/ad: Make use of util_iov_pull_* to parse data
Date:   Wed, 12 Jul 2023 12:38:53 -0700
Message-Id: <20230712193854.1862996-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712193854.1862996-1-luiz.dentz@gmail.com>
References: <20230712193854.1862996-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of util_iov_pull_* helpers to parse data.
---
 src/shared/ad.c | 266 ++++++++++++++++++++++++++++++++++++++++++++----
 src/shared/ad.h |  10 +-
 2 files changed, 253 insertions(+), 23 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index e8bebe70708e..951c56c604e6 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -14,6 +14,11 @@
 
 #define _GNU_SOURCE
 
+#include <ctype.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+
 #include "src/shared/ad.h"
 
 #include "src/eir.h"
@@ -80,7 +85,11 @@ static bool ad_is_type_valid(uint8_t type)
 struct bt_ad *bt_ad_new_with_data(size_t len, const uint8_t *data)
 {
 	struct bt_ad *ad;
-	uint16_t parsed_len = 0;
+	struct iovec iov = {
+		.iov_base = (void *)data,
+		.iov_len = len,
+	};
+	uint8_t elen;
 
 	if (data == NULL || !len)
 		return NULL;
@@ -89,31 +98,29 @@ struct bt_ad *bt_ad_new_with_data(size_t len, const uint8_t *data)
 	if (!ad)
 		return NULL;
 
-	while (parsed_len < len - 1) {
-		uint8_t d_len;
-		uint8_t d_type;
-		const uint8_t *d;
-		uint8_t field_len = data[0];
+	bt_ad_set_max_len(ad, len);
 
-		if (field_len == 0)
+	while (util_iov_pull_u8(&iov, &elen)) {
+		uint8_t type;
+		void *data;
+
+		if (elen == 0 || elen > iov.iov_len)
 			break;
 
-		parsed_len += field_len + 1;
-
-		if (parsed_len > len)
-			break;
-
-		d = &data[2];
-		d_type = data[1];
-		d_len = field_len - 1;
-
-		if (!ad_is_type_valid(d_type))
+		if (!util_iov_pull_u8(&iov, &type))
 			goto failed;
 
-		if (!ad_replace_data(ad, d_type, d, d_len))
+		elen--;
+
+		if (!ad_is_type_valid(type))
 			goto failed;
 
-		data += field_len + 1;
+		data = util_iov_pull_mem(&iov, elen);
+		if (!data)
+			goto failed;
+
+		if (!ad_replace_data(ad, type, data, elen))
+			goto failed;
 	}
 
 	return ad;
@@ -203,10 +210,181 @@ static bool data_type_match(const void *data, const void *user_data)
 	return a->type == type;
 }
 
+static bool ad_replace_uuid16(struct bt_ad *ad, struct iovec *iov)
+{
+	uint16_t value;
+
+	while ((util_iov_pull_le16(iov, &value))) {
+		bt_uuid_t uuid;
+
+		if (bt_uuid16_create(&uuid, value))
+			return false;
+
+		if (bt_ad_has_service_uuid(ad, &uuid))
+			continue;
+
+		if (!bt_ad_add_service_uuid(ad, &uuid))
+			return false;
+	}
+
+	return true;
+}
+
+static bool ad_replace_uuid32(struct bt_ad *ad, struct iovec *iov)
+{
+	uint32_t value;
+
+	while ((util_iov_pull_le32(iov, &value))) {
+		bt_uuid_t uuid;
+
+		if (bt_uuid32_create(&uuid, value))
+			return false;
+
+		if (bt_ad_has_service_uuid(ad, &uuid))
+			continue;
+
+		if (!bt_ad_add_service_uuid(ad, &uuid))
+			return false;
+	}
+
+	return true;
+}
+
+static bool ad_replace_uuid128(struct bt_ad *ad, struct iovec *iov)
+{
+	void *data;
+
+	while ((data = util_iov_pull_mem(iov, 16))) {
+		uint128_t value;
+		bt_uuid_t uuid;
+
+		bswap_128(data, &value);
+
+		if (bt_uuid128_create(&uuid, value))
+			return false;
+
+		if (bt_ad_has_service_uuid(ad, &uuid))
+			continue;
+
+		if (!bt_ad_add_service_uuid(ad, &uuid))
+			return false;
+	}
+
+	return true;
+}
+
+static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
+{
+	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
+	int i;
+
+	memset(utf8_name, 0, sizeof(utf8_name));
+	strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
+
+	if (strisutf8(utf8_name, iov->iov_len))
+		goto done;
+
+	/* Assume ASCII, and replace all non-ASCII with spaces */
+	for (i = 0; utf8_name[i] != '\0'; i++) {
+		if (!isascii(utf8_name[i]))
+			utf8_name[i] = ' ';
+	}
+
+	/* Remove leading and trailing whitespace characters */
+	strstrip(utf8_name);
+
+done:
+	return bt_ad_add_name(ad, utf8_name);
+}
+
+static bool ad_replace_uuid16_data(struct bt_ad *ad, struct iovec *iov)
+{
+	uint16_t value;
+	bt_uuid_t uuid;
+
+	if (!util_iov_pull_le16(iov, &value))
+		return false;
+
+	if (bt_uuid16_create(&uuid, value))
+		return false;
+
+	return bt_ad_add_service_data(ad, &uuid, iov->iov_base, iov->iov_len);
+}
+
+static bool ad_replace_uuid32_data(struct bt_ad *ad, struct iovec *iov)
+{
+	uint32_t value;
+	bt_uuid_t uuid;
+
+	if (!util_iov_pull_le32(iov, &value))
+		return false;
+
+	if (bt_uuid32_create(&uuid, value))
+		return false;
+
+	return bt_ad_add_service_data(ad, &uuid, iov->iov_base, iov->iov_len);
+}
+
+static bool ad_replace_uuid128_data(struct bt_ad *ad, struct iovec *iov)
+{
+	void *data;
+	uint128_t value;
+	bt_uuid_t uuid;
+
+	data = util_iov_pull_mem(iov, 16);
+	if (!data)
+		return false;
+
+	bswap_128(data, &value);
+
+	if (bt_uuid128_create(&uuid, value))
+		return false;
+
+	return bt_ad_add_service_data(ad, &uuid, iov->iov_base, iov->iov_len);
+}
+
+static bool ad_replace_manufacturer_data(struct bt_ad *ad, struct iovec *iov)
+{
+	uint16_t value;
+
+	if (!util_iov_pull_le16(iov, &value))
+		return false;
+
+	return bt_ad_add_manufacturer_data(ad, value, iov->iov_base,
+							iov->iov_len);
+}
+
 static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
 							size_t len)
 {
 	struct bt_ad_data *new_data;
+	struct iovec iov = {
+		.iov_base = (void *)data,
+		.iov_len = len,
+	};
+
+	switch (type) {
+	case BT_AD_UUID16_SOME:
+	case BT_AD_UUID16_ALL:
+		return ad_replace_uuid16(ad, &iov);
+	case BT_AD_UUID32_SOME:
+	case BT_AD_UUID32_ALL:
+		return ad_replace_uuid32(ad, &iov);
+	case BT_AD_UUID128_SOME:
+	case BT_AD_UUID128_ALL:
+		return ad_replace_uuid128(ad, &iov);
+	case BT_AD_NAME_SHORT:
+	case BT_AD_NAME_COMPLETE:
+		return ad_replace_name(ad, &iov);
+	case BT_AD_SERVICE_DATA16:
+		return ad_replace_uuid16_data(ad, &iov);
+	case BT_AD_SERVICE_DATA32:
+		return ad_replace_uuid32_data(ad, &iov);
+	case BT_AD_SERVICE_DATA128:
+		return ad_replace_uuid128_data(ad, &iov);
+	case BT_AD_MANUFACTURER_DATA:
+		return ad_replace_manufacturer_data(ad, &iov);
+	}
 
 	new_data = queue_find(ad->data, data_type_match, UINT_TO_PTR(type));
 	if (new_data) {
@@ -220,13 +398,12 @@ static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
 
 	new_data = new0(struct bt_ad_data, 1);
 	new_data->type = type;
-	new_data->data = malloc(len);
+	new_data->data = util_memdup(data, len);
 	if (!new_data->data) {
 		free(new_data);
 		return false;
 	}
 
-	memcpy(new_data->data, data, len);
 	new_data->len = len;
 
 	if (queue_push_tail(ad->data, new_data))
@@ -590,7 +767,7 @@ static bool uuid_match(const void *data, const void *elem)
 	const bt_uuid_t *match_uuid = data;
 	const bt_uuid_t *uuid = elem;
 
-	return bt_uuid_cmp(match_uuid, uuid);
+	return !bt_uuid_cmp(match_uuid, uuid);
 }
 
 static bool queue_remove_uuid(struct queue *queue, bt_uuid_t *uuid)
@@ -618,6 +795,14 @@ bool bt_ad_add_service_uuid(struct bt_ad *ad, const bt_uuid_t *uuid)
 	return queue_add_uuid(ad->service_uuids, uuid);
 }
 
+bool bt_ad_has_service_uuid(struct bt_ad *ad, const bt_uuid_t *uuid)
+{
+	if (!ad)
+		return false;
+
+	return queue_find(ad->service_uuids, uuid_match, uuid);
+}
+
 bool bt_ad_remove_service_uuid(struct bt_ad *ad, bt_uuid_t *uuid)
 {
 	if (!ad)
@@ -894,6 +1079,14 @@ bool bt_ad_add_name(struct bt_ad *ad, const char *name)
 	return true;
 }
 
+const char *bt_ad_get_name(struct bt_ad *ad)
+{
+	if (!ad)
+		return false;
+
+	return ad->name;
+}
+
 void bt_ad_clear_name(struct bt_ad *ad)
 {
 	if (!ad)
@@ -933,6 +1126,20 @@ bool bt_ad_add_flags(struct bt_ad *ad, uint8_t *flags, size_t len)
 	return ad_replace_data(ad, BT_AD_FLAGS, flags, len);
 }
 
+uint8_t bt_ad_get_flags(struct bt_ad *ad)
+{
+	struct bt_ad_data *data;
+
+	if (!ad)
+		return 0;
+
+	data = queue_find(ad->data, data_type_match, UINT_TO_PTR(BT_AD_FLAGS));
+	if (!data || data->len != 1)
+		return 0;
+
+	return data->data[0];
+}
+
 bool bt_ad_has_flags(struct bt_ad *ad)
 {
 	struct bt_ad_data *data;
@@ -1077,6 +1284,21 @@ void bt_ad_clear_data(struct bt_ad *ad)
 	queue_remove_all(ad->data, NULL, NULL, data_destroy);
 }
 
+int8_t bt_ad_get_tx_power(struct bt_ad *ad)
+{
+	struct bt_ad_data *data;
+
+	if (!ad)
+		return 0;
+
+	data = queue_find(ad->data, data_type_match,
+					UINT_TO_PTR(BT_AD_TX_POWER));
+	if (!data || data->len != 1)
+		return 127;
+
+	return data->data[0];
+}
+
 struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset, size_t len,
 							const uint8_t *data)
 {
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 93ba1b6cfa0b..87b3401a389d 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -112,11 +112,13 @@ bool bt_ad_is_empty(struct bt_ad *ad);
 
 bool bt_ad_add_service_uuid(struct bt_ad *ad, const bt_uuid_t *uuid);
 
+bool bt_ad_has_service_uuid(struct bt_ad *ad, const bt_uuid_t *uuid);
+
 bool bt_ad_remove_service_uuid(struct bt_ad *ad, bt_uuid_t *uuid);
 
 void bt_ad_clear_service_uuid(struct bt_ad *ad);
 
-bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_data,
+bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t id,
 						void *data, size_t len);
 
 bool bt_ad_has_manufacturer_data(struct bt_ad *ad,
@@ -150,6 +152,8 @@ void bt_ad_clear_service_data(struct bt_ad *ad);
 
 bool bt_ad_add_name(struct bt_ad *ad, const char *name);
 
+const char *bt_ad_get_name(struct bt_ad *ad);
+
 void bt_ad_clear_name(struct bt_ad *ad);
 
 bool bt_ad_add_appearance(struct bt_ad *ad, uint16_t appearance);
@@ -160,6 +164,8 @@ bool bt_ad_add_flags(struct bt_ad *ad, uint8_t *flags, size_t len);
 
 bool bt_ad_has_flags(struct bt_ad *ad);
 
+uint8_t bt_ad_get_flags(struct bt_ad *ad);
+
 void bt_ad_clear_flags(struct bt_ad *ad);
 
 bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len);
@@ -172,6 +178,8 @@ bool bt_ad_remove_data(struct bt_ad *ad, uint8_t type);
 
 void bt_ad_clear_data(struct bt_ad *ad);
 
+int8_t bt_ad_get_tx_power(struct bt_ad *ad);
+
 struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset,
 					size_t len, const uint8_t *data);
 
-- 
2.40.1

