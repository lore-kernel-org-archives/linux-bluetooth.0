Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FC5C11F67
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 07:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667AD61DD1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 07:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhF2HuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhF2HuG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jun 2021 03:50:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A5C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 00:47:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f11so225047plg.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVlFgFCxaWRw37gYpSX+JcptxmlyyJYMOHEGZTzQPAM=;
        b=TwLYjahBWFYBTmDHLIbZsTlRip3CcqXuUG/WUeG+OwvzC6ZFk8KTcA7TmxtIoQqBNb
         QerhM7wFdIrLZEl4nOm8q5duzi2yx4efQSK79ZnwOQ20HeGr7pc6tgJ+F/BE8CjUzDzr
         lgcaNanNYjsLAuujmgIxshV25E8rDYHUCJPtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVlFgFCxaWRw37gYpSX+JcptxmlyyJYMOHEGZTzQPAM=;
        b=WHvK4tCWRzgmZHZEYW+EtNqHGSIPgoNIX4/jYNx5Z/nrROih01kWTBI5CjgMODr4b4
         CwdSpIOY1nyVCINICtXc8KlWNWroHU8HLTl79zcG7a8d7x9fYBGSEbyp7En5M2ua5940
         n0m24vkg7IwJfRLOl9apw+7GMX8DohRxnXrV0dfRAka9fZrlB3aWArUDbBhSUV+U40lK
         xDrXn+diig+grzBcyzsCmt2pGqnNnmxVqUGzmLoo/oFYZEs6NlKSicBH3Sl6FFt2pchK
         giIc69qc6IWlGdfiaivnE9mkxWPP1whnY9tF/ew4m6BJn87dlph85wwe4c+C/oINc6VK
         rMfA==
X-Gm-Message-State: AOAM533lLRll51B+xXo68xbLYDjVw6ZWzz5hwYdxfZW4zBNhBMlrHTME
        Ai2iJZe0lpIFlOHsPzNvnA/oKdqIkgo+SA==
X-Google-Smtp-Source: ABdhPJwnGBLHHD3DejInG80ihAZVWTTVk3q8J/7DGV9XLJWzD/enmMA2e3Mds4pZjIrHIVSw+BXvrA==
X-Received: by 2002:a17:90b:911:: with SMTP id bo17mr8410681pjb.28.1624952858435;
        Tue, 29 Jun 2021 00:47:38 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:1fca:2281:244f])
        by smtp.gmail.com with ESMTPSA id s7sm17454289pjr.11.2021.06.29.00.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 00:47:38 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 2/3] adapter: read quality report feature
Date:   Tue, 29 Jun 2021 15:47:23 +0800
Message-Id: <20210629154652.BlueZ.v5.2.I7d16f055bc51ac86915c114c671743f49a1fc226@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a new UUID for the quality report experimental
feature. When reading the experimental features, it checks if
the new feature is supported by the controller and stores the
value in the quality_report_supported flag of the adapter.

The quality_report_supported flag could be used by the bluetoothd
to determine if the quality report feature can be enabled.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 src/adapter.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 98fc78f1e..e2873de46 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -284,6 +284,7 @@ struct btd_adapter {
 	bool is_default;		/* true if adapter is default one */
 
 	bool le_simult_roles_supported;
+	bool quality_report_supported;
 };
 
 typedef enum {
@@ -9234,6 +9235,12 @@ static const uint8_t le_simult_central_peripheral_uuid[16] = {
 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
 };
 
+/* 330859bc-7506-492d-9370-9a6f0614037f */
+static const uint8_t quality_report_uuid[16] = {
+	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
+	0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
+};
+
 /* 15c0a148-c273-11ea-b3de-0242ac130004 */
 static const uint8_t rpa_resolution_uuid[16] = {
 	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
@@ -9276,6 +9283,14 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
 	adapter->le_simult_roles_supported = flags & 0x01;
 }
 
+static void quality_report_func(struct btd_adapter *adapter, uint32_t flags)
+{
+	adapter->quality_report_supported = le32_to_cpu(flags) & 0x01;
+
+	btd_info(adapter->dev_id, "quality_report_supported %d",
+			adapter->quality_report_supported);
+}
+
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -9313,6 +9328,7 @@ static const struct exp_feat {
 	EXP_FEAT(debug_uuid, exp_debug_func),
 	EXP_FEAT(le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
+	EXP_FEAT(quality_report_uuid, quality_report_func),
 	EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
 };
 
-- 
2.32.0.93.g670b81a890-goog

