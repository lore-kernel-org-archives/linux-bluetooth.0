Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD60C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF70061C31
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 08:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhF1IYa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhF1IY3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 04:24:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE9C061766
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:22:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b5so957982plg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jun 2021 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVlFgFCxaWRw37gYpSX+JcptxmlyyJYMOHEGZTzQPAM=;
        b=mhA74HqZVcZliRrJVQSIuaINHbDFLklRNtR8gx5hsVhx25KGaUoc2WKcrnsUsduTtk
         Rnzj1xw6x64XLpQMe8TulVSUbJkkrSI13Tw+YFEs7Kz7tmdwpOZpuTsRArb0ORNDtsIN
         ylbwPrus3yCmARPr+vlzETfanv3sgFDVnQ3bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVlFgFCxaWRw37gYpSX+JcptxmlyyJYMOHEGZTzQPAM=;
        b=cvawIUJKuqlCbwAE74JDMey57NOYXVV83w/fiN2Mz0RHgRNV8HY8IDLEvUINWuxB6q
         n8U/Z59UwbJQjZVEY31SIYH1tSoRV9WmA4PDVmffGm9ojOgmW/sH47lQpGIJVbpvjekI
         asGf+6JjPE3yUWlGv+eNO8y05rQd6GqqKsl87x8S3YS0WZTDri6HtHFVb09yl3+pve6Y
         XdKTt5PuaB4DvbLpexbyk/v3UzumU8x5WPE6zavTy41r8h0IYdkKkZkPLuweBZwYr1Hz
         liuSqCHTmKQ2jYlKUfBr3Ux6vsrdOKX8l5FeTwcbByaKfAdJ/eKpcuWgi+pREWPyKVLA
         hi7Q==
X-Gm-Message-State: AOAM531cev50ikaI4iU3+IYyWRp776L+NcZjUwlDEOIBnOy5gbn1kCCa
        PnoYnMVmzDVbRpzw/cPzlRixxAwu706DVQ==
X-Google-Smtp-Source: ABdhPJw6hZrnIagzf7NFoTxW2g8oIZpUSTpIrw/vkxc5LWiSngui6oZsh9aU4OLcopJ75N8DKi7MxA==
X-Received: by 2002:a17:903:18d:b029:128:d71a:4773 with SMTP id z13-20020a170903018db0290128d71a4773mr4776543plg.76.1624868524198;
        Mon, 28 Jun 2021 01:22:04 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:d73e:91da:d7c7:57a])
        by smtp.gmail.com with ESMTPSA id b22sm5381125pfp.20.2021.06.28.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:22:03 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3 2/3] adapter: read quality report feature
Date:   Mon, 28 Jun 2021 16:21:49 +0800
Message-Id: <20210628162107.BlueZ.v3.2.I7d16f055bc51ac86915c114c671743f49a1fc226@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210628162107.BlueZ.v3.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210628162107.BlueZ.v3.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
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

