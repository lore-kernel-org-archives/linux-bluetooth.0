Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B039EC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B352076E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWxAjTnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgJ1XGT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388347AbgJ1XGJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:06:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E322DC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:06:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o129so732223pfb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZyL80Vf01YjGguIPMYLL7Hfid6txaAgTHKwa+HBm2qc=;
        b=EWxAjTnq976TQG1olUEuiQPA3c/a2lTLVpqXCDm5U17/RaFx2yAyU1IVAIxfK1phIo
         vOiRGZ2FBA4SErAY9f2pq3PDq5NE9ILjMEAhz6T0ZcUOvHm1D2b/znYEq7/5YOHSiPmX
         uqoB+XteBGefXtfUitILrji9N4S40PwvZX0Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZyL80Vf01YjGguIPMYLL7Hfid6txaAgTHKwa+HBm2qc=;
        b=fSgMof7QlIblJgLhMs+VI+EH1Iy4r08SoIPeE8aTN0MEdge6FLSteY12ULxZEQ6VDE
         NrtPX/0fKStjIp6eQtdzG3qp+Xd09VExpC5BUomaG3Gvo/lZM9Sa7+8NcXpekbTmYqEc
         n6v1DCbZYgo8t13CFt59s6fujr3UVywBurgFIyjIMNtPRhAAGbkmA6Wz5XmiecBnoP5X
         Z9ixQhN9MDK+rxLxRcTYeD6nGFZpoCXLRmInaCfPBCFv/OzwPORU9j9EtbhqKBAJFmV3
         LCYUKzD37pk3mLacosyW6pciR7a6wdN9ZY6m8hdwVHIrqAihi/MNEMEHOEs6Dra00u/l
         bcIg==
X-Gm-Message-State: AOAM531ONrxCptNCl9A+vjwTb0DgM7NI15A6qANiLlFVdpcNE/si6veE
        3kDZBesU2xUOvf5YjfdcCEY2JTTTx8PKiA==
X-Google-Smtp-Source: ABdhPJxcBBNRGSMopOwqPDjxRBy7d7ThKYeG91nKBzZ7ZXQpFdc1t+z/IdLwPlai5dUD9kqaB6Fr5Q==
X-Received: by 2002:a17:90a:9d86:: with SMTP id k6mr1135814pjp.69.1603926367923;
        Wed, 28 Oct 2020 16:06:07 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id y137sm644134pfc.77.2020.10.28.16.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 16:06:07 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [BlueZ PATCH v7 2/7] shared/ad: Add support of bt_ad_pattern
Date:   Wed, 28 Oct 2020 16:05:28 -0700
Message-Id: <20201028160433.BlueZ.v7.2.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds struct bt_ad_pattern and helpers functions to facilitate
pattern matching.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

(no changes since v1)

 src/shared/ad.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h |  16 +++++
 2 files changed, 176 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index a34d7a147..5eadb4104 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -31,6 +31,12 @@ struct bt_ad {
 	struct queue *data;
 };
 
+struct pattern_match_info {
+	struct bt_ad *ad;
+	struct bt_ad_pattern *current_pattern;
+	struct bt_ad_pattern *matched_pattern;
+};
+
 struct bt_ad *bt_ad_new(void)
 {
 	struct bt_ad *ad;
@@ -46,6 +52,76 @@ struct bt_ad *bt_ad_new(void)
 	return bt_ad_ref(ad);
 }
 
+static bool ad_replace_data(struct bt_ad *ad, uint8_t type, void *data,
+							size_t len);
+
+static bool ad_is_type_valid(uint8_t type)
+{
+	if (type > BT_AD_3D_INFO_DATA && type != BT_AD_MANUFACTURER_DATA)
+		return false;
+	if (type < BT_AD_FLAGS)
+		return false;
+
+	return true;
+}
+
+struct bt_ad *bt_ad_new_with_data(size_t len, const uint8_t *data)
+{
+	struct bt_ad *ad;
+	uint16_t parsed_len = 0;
+	uint8_t *data_copy = NULL;
+
+	if (data == NULL || !len)
+		return NULL;
+
+	data_copy = malloc(len);
+	if (!data_copy)
+		return NULL;
+
+	memcpy(data_copy, data, len);
+
+	ad = bt_ad_new();
+	if (!ad)
+		goto cleanup;
+
+	while (parsed_len < len - 1) {
+		uint8_t d_len;
+		uint8_t d_type;
+		uint8_t *d;
+		uint8_t field_len = data_copy[0];
+
+		if (field_len == 0)
+			break;
+
+		parsed_len += field_len + 1;
+
+		if (parsed_len > len)
+			break;
+
+		d = &data_copy[2];
+		d_type = data_copy[1];
+		d_len = field_len - 1;
+
+		if (!ad_is_type_valid(d_type))
+			goto failed;
+
+		if (!ad_replace_data(ad, d_type, d, d_len))
+			goto failed;
+
+		data_copy += field_len + 1;
+	}
+
+	free(data_copy);
+	return ad;
+
+failed:
+	bt_ad_unref(ad);
+
+cleanup:
+	free(data_copy);
+	return NULL;
+}
+
 struct bt_ad *bt_ad_ref(struct bt_ad *ad)
 {
 	if (!ad)
@@ -994,3 +1070,87 @@ void bt_ad_clear_data(struct bt_ad *ad)
 
 	queue_remove_all(ad->data, NULL, NULL, data_destroy);
 }
+
+struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset, size_t len,
+							const uint8_t *data)
+{
+	struct bt_ad_pattern *pattern;
+
+	if (!data || !len || offset >= BT_AD_MAX_DATA_LEN ||
+		len > BT_AD_MAX_DATA_LEN || offset + len > BT_AD_MAX_DATA_LEN) {
+		return NULL;
+	}
+
+	if (!ad_is_type_valid(type))
+		return NULL;
+
+	pattern = new0(struct bt_ad_pattern, 1);
+	if (!pattern)
+		return NULL;
+
+	pattern->len = len;
+	pattern->type = type;
+	pattern->offset = offset;
+	memcpy(pattern->data, data, len);
+
+	return pattern;
+}
+
+static void pattern_ad_data_match(void *data, void *user_data)
+{
+	struct bt_ad_data *ad_data = data;
+	struct pattern_match_info *info = user_data;
+	struct bt_ad_pattern *pattern;
+
+	if (!ad_data || !info)
+		return;
+
+	if (info->matched_pattern)
+		return;
+
+	pattern = info->current_pattern;
+
+	if (!pattern || ad_data->type != pattern->type)
+		return;
+
+	if (ad_data->len < pattern->offset + pattern->len)
+		return;
+
+	if (!memcmp(ad_data->data + pattern->offset, pattern->data,
+								pattern->len)) {
+		info->matched_pattern = pattern;
+	}
+}
+
+static void pattern_match(void *data, void *user_data)
+{
+	struct bt_ad_pattern *pattern = data;
+	struct pattern_match_info *info = user_data;
+
+	if (!pattern || !info)
+		return;
+
+	if (info->matched_pattern)
+		return;
+
+	info->current_pattern = pattern;
+
+	bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);
+}
+
+struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,
+							struct queue *patterns)
+{
+	struct pattern_match_info info;
+
+	if (!ad || queue_isempty(patterns))
+		return NULL;
+
+	info.ad = ad;
+	info.matched_pattern = NULL;
+	info.current_pattern = NULL;
+
+	queue_foreach(patterns, pattern_match, &info);
+
+	return info.matched_pattern;
+}
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 83eacab66..13adcb406 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -68,6 +68,7 @@
 typedef void (*bt_ad_func_t)(void *data, void *user_data);
 
 struct bt_ad;
+struct queue;
 
 struct bt_ad_manufacturer_data {
 	uint16_t manufacturer_id;
@@ -87,8 +88,17 @@ struct bt_ad_data {
 	size_t len;
 };
 
+struct bt_ad_pattern {
+	uint8_t type;
+	uint8_t offset;
+	uint8_t len;
+	uint8_t data[BT_AD_MAX_DATA_LEN];
+};
+
 struct bt_ad *bt_ad_new(void);
 
+struct bt_ad *bt_ad_new_with_data(size_t len, const uint8_t *data);
+
 struct bt_ad *bt_ad_ref(struct bt_ad *ad);
 
 void bt_ad_unref(struct bt_ad *ad);
@@ -156,3 +166,9 @@ void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_data);
 bool bt_ad_remove_data(struct bt_ad *ad, uint8_t type);
 
 void bt_ad_clear_data(struct bt_ad *ad);
+
+struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset,
+					size_t len, const uint8_t *data);
+
+struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,
+							struct queue *patterns);
-- 
2.26.2

