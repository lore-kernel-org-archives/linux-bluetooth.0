Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BB0C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19C460E09
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhFNRsq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbhFNRsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 13:48:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAFC061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 10:46:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e22so9228805pgv.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9H3B2LUKSQy09vfpNt+jBkq8nGOjtNWx26sB189hDNU=;
        b=YwS6+8nAp8tvcIhG3G/KnOh06VeXBQ772znRc+ZZMgn66MiYQe0EpoX090caKqxhyh
         C2NMjcendX1UuuZRlcac6EWRUkPq1C8FGsZjA48fbm/3v5MXQf/gP8lJ6HoCUjDNGF20
         3vL8232CheQk65BpxbJ2p9xWTS9H1f0/GwN12eUyCgaiIab/4SIVYPtWhQ26t4eYkeaf
         qJ1PazVmfdmdQXfP8RrhKcvtUoDWAreHztwOs3G4nLH5lGeY8ilL67qy3RNX9HEalT31
         knxQQngffJCte+1T6rgWqZLFDBkXvVwlSLhpQRDfevlZ4od4ZpKIODOfvpQH9elOf09J
         lixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9H3B2LUKSQy09vfpNt+jBkq8nGOjtNWx26sB189hDNU=;
        b=GqI02INXKSCa4w4+TeiNOuPVxDCkArW8cuJw978gAna6pjhZINgp0Fogiw0ifrMLTb
         VrOjKehH1VXd1sr5RVesPhobP6Ui9eDyfe0kI9T22WVc3Kf0TDmW3HtszkzWoY5A7+gI
         doIgsCKKo5G19wofF8yvflFuUktUJvTNy3ylM6Wh4eibZ4Eq9+rjm1nV2ZnZAeSzyPde
         9vItH1cu14wSOJQdDvGFioQK/tt8GKvwkXQHSkTt4WGe1fL7Jjqhzk7evP7OfXklHRsk
         NOrFYlALeiCTnDkNTMP0oyT8mHJaldGxB1kqDG7oy2IYr78F/xfydGlfC2MvbUh/m0uQ
         wn3A==
X-Gm-Message-State: AOAM530BR9nuV70sD1VgI5hS/U+dYgvM5KEnu21fJVQrQck+kSGRL9nE
        avAomNnUQQqrlhoG7gn30FnAkyQBgSy7yA==
X-Google-Smtp-Source: ABdhPJwEQDtXjdeUX/Tl1+4Ut7hosMYWHHjJiHIkJ9n/Q5y8HZonBFdvJ1J/1DvWfKMyPBY/fewCuw==
X-Received: by 2002:aa7:8b0d:0:b029:2e9:857e:c1d1 with SMTP id f13-20020aa78b0d0000b02902e9857ec1d1mr194625pfd.33.1623692786978;
        Mon, 14 Jun 2021 10:46:26 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c21sm13055479pfi.44.2021.06.14.10.46.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:46:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-tester: Enable Kernel Debug Experimental Feature
Date:   Mon, 14 Jun 2021 10:46:25 -0700
Message-Id: <20210614174625.1259675-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to enable Kernel Debug Experimental Feature if debug is
enabled.
---
 tools/mgmt-tester.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 52cd19a36..fe39506f6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -308,6 +308,32 @@ struct generic_data {
 	uint8_t adv_data_len;
 };
 
+static const uint8_t set_exp_feat_param_debug[] = {
+	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab, /* UUID - Debug */
+	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
+	0x01,						/* Action - enable */
+};
+
+static void debug_exp_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_print("Debug feature could not be enabled");
+		return;
+	}
+
+	tester_print("Debug feature is enabled");
+}
+
+static void debup_exp_feature(struct test_data *data)
+{
+	tester_print("Enabling Debug feature");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+		sizeof(set_exp_feat_param_debug), set_exp_feat_param_debug,
+		debug_exp_callback, NULL, NULL);
+}
+
 static void read_index_list_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -365,6 +391,7 @@ static void test_pre_setup(const void *test_data)
 	if (tester_use_debug()) {
 		mgmt_set_debug(data->mgmt, print_debug, "mgmt: ", NULL);
 		mgmt_set_debug(data->mgmt_alt, print_debug, "mgmt-alt: ", NULL);
+		debup_exp_feature(data);
 	}
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_VERSION, MGMT_INDEX_NONE, 0, NULL,
-- 
2.31.1

