Return-Path: <SRS0=4lpm=EG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27351C388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDED208B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Oct 2020 00:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HbiX8TpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJaAxE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 20:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJaAxE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 20:53:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B90C0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:53:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a17so157127pju.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 17:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spIOXxEMAUaAi3lOJE/X7NHFHQM+sHFb8zQsSOCKb8k=;
        b=HbiX8TpWOGg9HTGYfSsYg6rLlPCFZN42eDXxmd11vnzQeg6tjeMJ/GGsBnd+tBIxnw
         XpUq4VfkCrOrs5VlUPRn6mdXGdJTI1DB105bsK3gHCLvDMswvbgrYKw7EOKvtuT+FhKu
         Nk0+kSnRY8Kv6GzbfWBsr79WAq6I0bqppdirY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spIOXxEMAUaAi3lOJE/X7NHFHQM+sHFb8zQsSOCKb8k=;
        b=mGQmRSshqyFjZWCL30NIPlID/3DPOrGbimxLunDYaTnWcW4QtJzkLoEmp9g/DKXfi+
         br4nXXevgyAwK3X8ggRTn+UlFKD4pQRJSyMhLdtkBlGL5jLtJ3oQ+FSUixQ2O+HhS9jZ
         ANVG4s5ywiVPBsd9RJcLMOX6aiPIu/zwoSnO2LD8NaQGbKXjFW0ypjFCCU0c4sRNMWRU
         CjFARDXYG6hMjwgbV9c2vz5vv4CY6qQlx2HWPy+9W1VU82ndh7w1sp1natZx4+j5+I4m
         ryjrU1ous6niICttu/gTXymDLWO2yzpley9qVqlKzIAzbsigIS98AEt2P+uXZb3vaUyq
         FtNA==
X-Gm-Message-State: AOAM533v3tDjQGsZOL2E2H61A1q11kpCNiU1HhsTmjosmusbw9rL9mn7
        dipRNvwWzz1Q4mYnqtLpkw4DnwUiAVaoCA==
X-Google-Smtp-Source: ABdhPJzsZPKMZFVv0FL5Q6B154ZYVHu8Ntc80aSbghTvp53XiSDCc7J2OrJ4iCE3KNLYe/r4PWxsLA==
X-Received: by 2002:a17:90a:341:: with SMTP id 1mr5913856pjf.189.1604105583053;
        Fri, 30 Oct 2020 17:53:03 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id p22sm4394292pju.48.2020.10.30.17.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 17:53:02 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [BlueZ PATCH v8 1/6] shared/ad: Add support of bt_ad_pattern
Date:   Fri, 30 Oct 2020 17:52:46 -0700
Message-Id: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds struct bt_ad_pattern and helpers functions to facilitate
pattern matching.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Howard Chung <howardchung@google.com>
---

Changes in v8:
- Modify signature of ad_replace_data() to avoid memory copy

 src/shared/ad.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/ad.h |  16 +++++
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index a34d7a147..23c8c34f4 100644
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
@@ -46,6 +52,65 @@ struct bt_ad *bt_ad_new(void)
 	return bt_ad_ref(ad);
 }
 
+static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
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
+
+	if (data == NULL || !len)
+		return NULL;
+
+	ad = bt_ad_new();
+	if (!ad)
+		return NULL;
+
+	while (parsed_len < len - 1) {
+		uint8_t d_len;
+		uint8_t d_type;
+		const uint8_t *d;
+		uint8_t field_len = data[0];
+
+		if (field_len == 0)
+			break;
+
+		parsed_len += field_len + 1;
+
+		if (parsed_len > len)
+			break;
+
+		d = &data[2];
+		d_type = data[1];
+		d_len = field_len - 1;
+
+		if (!ad_is_type_valid(d_type))
+			goto failed;
+
+		if (!ad_replace_data(ad, d_type, d, d_len))
+			goto failed;
+
+		data += field_len + 1;
+	}
+
+	return ad;
+
+failed:
+	bt_ad_unref(ad);
+	return NULL;
+}
+
 struct bt_ad *bt_ad_ref(struct bt_ad *ad)
 {
 	if (!ad)
@@ -126,7 +191,7 @@ static bool data_type_match(const void *data, const void *user_data)
 	return a->type == type;
 }
 
-static bool ad_replace_data(struct bt_ad *ad, uint8_t type, void *data,
+static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
 							size_t len)
 {
 	struct bt_ad_data *new_data;
@@ -994,3 +1059,87 @@ void bt_ad_clear_data(struct bt_ad *ad)
 
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

