Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CCC0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 22:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGGWom (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGGWol (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 18:44:41 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C21EAF
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 15:44:39 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635d9e0aa6dso16927136d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688769878; x=1691361878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpLSwl04snW1yWSJjZV1KQKdbZR59341rse1foBpb18=;
        b=ia/6mXPTFytRQ5xbo/j1hWAFP/BrcYlLhBAkovWUaE2yWV4BeRqflUXIBYecfOJw+v
         oW3D6/e5wHo7Xfe5aHgJPky/mh36afSvJDG8Yx8/1KOyNnsNp9Xp9vmf1JGGHfGput07
         q4U84dOuk6lZ87OoMSi40KsG77qNoJuA7wGPTuq8miahwP9FcoJjRPNpE8JvGPie5huZ
         AA6uBhd/GyL8mfRZUrRU1dGlbDRUhoZfO/5GizazGwBt21okmwm2KSzbet4v/jjUL/zN
         I+cx1AN3yIo/6hKTmQ3tO+K1+hk2cib2OKKvyJ3b7b5dsYCq78Ip+fY5aia+4nzhQGnE
         Xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688769878; x=1691361878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpLSwl04snW1yWSJjZV1KQKdbZR59341rse1foBpb18=;
        b=RUNBWRDfZBIgF/G4Esc4ikiqQWkvPi79FxLjrUGMFf2t5K5DKm+xV6MhRf6I3YfnxA
         utUnazHGL5wMiguZEPS5h0wCCx980JDQCJ1bkb74jL/vc7LFLzDNLrWJ1+hD5ukkVtYj
         VHV6mCeDEZrs4OkS7JXYVEhGorlJSUdcYw6cUl468HgtN0nf8HTv+xdVN4PVi4eKmYxu
         i2w8P1iP1QaM3nW1y+Kse528J4jVld3WsSq09BS+k+EabPlf+Fmbj3uvW6Sj6nyRv4lX
         TnQ/FGAeEcHSYpOVqqXmyxJn7VJZ4CngnOgl/ZEURU+2QmryJ6PucDWJQGzEVBKpChip
         gL9A==
X-Gm-Message-State: ABy/qLYCZIaqlH09fIds9L1DJJKhh1lFgfR/Xj/LeqVGnet5MpMLj3C1
        toNWkcPPzgfALq8OSNq7A2hp+cr7OSI=
X-Google-Smtp-Source: APBJJlHjE7mKlpCmbZ0RzFdnA2DZj/yox/lOzZxm72Exvfmjl8mQUAETJZtW1jm8O7H2bN/tH/lqyA==
X-Received: by 2002:a0c:e449:0:b0:635:dd9a:ade4 with SMTP id d9-20020a0ce449000000b00635dd9aade4mr6134961qvm.16.1688769877957;
        Fri, 07 Jul 2023 15:44:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id z28-20020a05620a101c00b0076730d0b0b9sm2274482qkj.14.2023.07.07.15.44.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:44:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] shared/ad: Fix hardcoding maximum data length
Date:   Fri,  7 Jul 2023 15:44:32 -0700
Message-Id: <20230707224434.677627-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230707224434.677627-1-luiz.dentz@gmail.com>
References: <20230707224434.677627-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instances shall not assume BT_AD_MAX_DATA_LEN is always the maximum
length as they could be used with EA which supports bigger length.
---
 src/shared/ad.c | 56 ++++++++++++++++++++++++++++++-------------------
 src/shared/ad.h |  2 ++
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 7350aa206d1e..8b3fde2b1dcd 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -22,6 +22,7 @@
 
 struct bt_ad {
 	int ref_count;
+	uint8_t max_len;
 	char *name;
 	uint16_t appearance;
 	struct queue *service_uuids;
@@ -42,6 +43,7 @@ struct bt_ad *bt_ad_new(void)
 	struct bt_ad *ad;
 
 	ad = new0(struct bt_ad, 1);
+	ad->max_len = BT_AD_MAX_DATA_LEN;
 	ad->service_uuids = queue_new();
 	ad->manufacturer_data = queue_new();
 	ad->solicit_uuids = queue_new();
@@ -52,6 +54,16 @@ struct bt_ad *bt_ad_new(void)
 	return bt_ad_ref(ad);
 }
 
+bool bt_ad_set_max_len(struct bt_ad *ad, uint8_t len)
+{
+	if (!ad || len < BT_AD_MAX_DATA_LEN)
+		return false;
+
+	ad->max_len = len;
+
+	return true;
+}
+
 static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
 							size_t len);
 
@@ -298,17 +310,17 @@ static size_t uuid_data_length(struct queue *uuid_data)
 	return length;
 }
 
-static size_t name_length(const char *name, size_t *pos)
+static size_t name_length(struct bt_ad *ad, size_t *pos)
 {
 	size_t len;
 
-	if (!name)
+	if (!ad->name)
 		return 0;
 
-	len = 2 + strlen(name);
+	len = 2 + strlen(ad->name);
 
-	if (len > BT_AD_MAX_DATA_LEN - *pos)
-		len = BT_AD_MAX_DATA_LEN - *pos;
+	if (len > ad->max_len - (*pos))
+		len = ad->max_len - (*pos);
 
 	return len;
 }
@@ -343,7 +355,7 @@ static size_t calculate_length(struct bt_ad *ad)
 
 	length += uuid_data_length(ad->service_data);
 
-	length += name_length(ad->name, &length);
+	length += name_length(ad, &length);
 
 	length += ad->appearance != UINT16_MAX ? 4 : 0;
 
@@ -467,36 +479,36 @@ static void serialize_service_data(struct queue *service_data, uint8_t *buf,
 	}
 }
 
-static void serialize_name(const char *name, uint8_t *buf, uint8_t *pos)
+static void serialize_name(struct bt_ad *ad, uint8_t *buf, uint8_t *pos)
 {
 	int len;
 	uint8_t type = BT_AD_NAME_COMPLETE;
 
-	if (!name)
+	if (!ad->name)
 		return;
 
-	len = strlen(name);
-	if (len > BT_AD_MAX_DATA_LEN - (*pos + 2)) {
+	len = strlen(ad->name);
+	if (len > ad->max_len - (*pos + 2)) {
 		type = BT_AD_NAME_SHORT;
-		len = BT_AD_MAX_DATA_LEN - (*pos + 2);
+		len = ad->max_len - (*pos + 2);
 	}
 
 	buf[(*pos)++] = len + 1;
 	buf[(*pos)++] = type;
 
-	memcpy(buf + *pos, name, len);
+	memcpy(buf + *pos, ad->name, len);
 	*pos += len;
 }
 
-static void serialize_appearance(uint16_t value, uint8_t *buf, uint8_t *pos)
+static void serialize_appearance(struct bt_ad *ad, uint8_t *buf, uint8_t *pos)
 {
-	if (value == UINT16_MAX)
+	if (ad->appearance == UINT16_MAX)
 		return;
 
-	buf[(*pos)++] = sizeof(value) + 1;
+	buf[(*pos)++] = sizeof(ad->appearance) + 1;
 	buf[(*pos)++] = BT_AD_GAP_APPEARANCE;
 
-	bt_put_le16(value, buf + (*pos));
+	bt_put_le16(ad->appearance, buf + (*pos));
 	*pos += 2;
 }
 
@@ -528,7 +540,7 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 
 	*length = calculate_length(ad);
 
-	if (*length > BT_AD_MAX_DATA_LEN)
+	if (*length > ad->max_len)
 		return NULL;
 
 	adv_data = malloc0(*length);
@@ -543,9 +555,9 @@ uint8_t *bt_ad_generate(struct bt_ad *ad, size_t *length)
 
 	serialize_service_data(ad->service_data, adv_data, &pos);
 
-	serialize_name(ad->name, adv_data, &pos);
+	serialize_name(ad, adv_data, &pos);
 
-	serialize_appearance(ad->appearance, adv_data, &pos);
+	serialize_appearance(ad, adv_data, &pos);
 
 	serialize_data(ad->data, adv_data, &pos);
 
@@ -653,7 +665,7 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 	if (!ad)
 		return false;
 
-	if (len > (BT_AD_MAX_DATA_LEN - 2 - sizeof(uint16_t)))
+	if (len > (ad->max_len - 2 - sizeof(uint16_t)))
 		return false;
 
 	new_data = queue_find(ad->manufacturer_data, manufacturer_id_data_match,
@@ -790,7 +802,7 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 	if (!ad)
 		return false;
 
-	if (len > (BT_AD_MAX_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
+	if (len > (ad->max_len - 2 - (size_t)bt_uuid_len(uuid)))
 		return false;
 
 	new_data = queue_find(ad->service_data, service_uuid_match, uuid);
@@ -1009,7 +1021,7 @@ bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
 	if (!ad)
 		return false;
 
-	if (len > (BT_AD_MAX_DATA_LEN - 2))
+	if (len > (size_t)(ad->max_len - 2))
 		return false;
 
 	for (i = 0; i < sizeof(type_reject_list); i++) {
diff --git a/src/shared/ad.h b/src/shared/ad.h
index b100a6796109..93ba1b6cfa0b 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -98,6 +98,8 @@ struct bt_ad_pattern {
 
 struct bt_ad *bt_ad_new(void);
 
+bool bt_ad_set_max_len(struct bt_ad *ad, uint8_t len);
+
 struct bt_ad *bt_ad_new_with_data(size_t len, const uint8_t *data);
 
 struct bt_ad *bt_ad_ref(struct bt_ad *ad);
-- 
2.40.1

