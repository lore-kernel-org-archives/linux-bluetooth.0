Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CCDC07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 09:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFFA611AB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jul 2021 09:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbhGOJx1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbhGOJx1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jul 2021 05:53:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9730C06175F
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 02:50:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b12so2930108plh.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jul 2021 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whc/h2AnaZIw79+lN4bFG18HQ7WpjRMgY/yaAC/GAeI=;
        b=YEXvoc3BoH7RzG/3ZbFLXyuSY50UFDw2kjHZw3MJPfUN7dtacVrpubdzuhaXLwE7Nk
         VcCQ4LM6Y27Kv/6we67KFy7N2QEgJj6AKbWkIBWixGi9/6mO/RGHRfTResf2jKXqLsTM
         /Ek7p9oEfWf3hlGAIhAlVUtkJGKcGh1Afl9RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whc/h2AnaZIw79+lN4bFG18HQ7WpjRMgY/yaAC/GAeI=;
        b=bUjn1mhC54RcnxpZ5MGxs3E6XMft61zt2oJc0bA6URUXIrlJXV1E8I/lNc1NRqcU5l
         ilmXiLrEdEZvR2DqPVxw+CwoCNVVTRmCAwLgo8buB5Vns5GmcDtsTrV3WUMu9CJ4uJqQ
         5V/OyAJYMl21BpVwXt9jGSzL03jLsKkI1vwjXQUyQ8VLk/8RJwBMp9srzRBUnd+fij9X
         Rd7DGBPyuZJh0z+HHxDpzB0Rzz3Tz8InLZGjfTMiVJpZAOh3MSfliftL+tq/eemGKQtC
         1HD4VpyKe0qtMfwPczubvrDxpxplG5SVGSga3dswvngmno0uK195myFF0qyf5DqG0YIj
         wfng==
X-Gm-Message-State: AOAM531lk552/185U4VmHfIwEaCCaYHVVN+Usc0CiaYERZ3cL/2rJaxH
        loUxbzx6B4/4qvYVDoq+h8kutGMOzQf7uQ==
X-Google-Smtp-Source: ABdhPJxNtNXUwZ+xxw1QcWuur8qBS2RVJMks1mOZNocyNfVaUCflUJWjMbMwa5BRbQg6j6U3GExbHg==
X-Received: by 2002:a17:90a:a511:: with SMTP id a17mr9435910pjq.69.1626342633109;
        Thu, 15 Jul 2021 02:50:33 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:5e6b:4f03:a90f:28af])
        by smtp.gmail.com with ESMTPSA id e18sm5892160pfc.85.2021.07.15.02.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:50:32 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v6 2/3] adapter: read quality report feature
Date:   Thu, 15 Jul 2021 17:50:17 +0800
Message-Id: <20210715174945.BlueZ.v6.2.I7d16f055bc51ac86915c114c671743f49a1fc226@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210715174945.BlueZ.v6.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210715174945.BlueZ.v6.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
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

Changes in v6:
- Add support for decoding the new bqr UUID on src/shared/util.c.

 src/adapter.c     | 16 ++++++++++++++++
 src/shared/util.c |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 84bc5a1b0..12e4ff5c0 100644
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
@@ -9277,6 +9284,14 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
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
@@ -9315,6 +9330,7 @@ static const struct exp_feat {
 	EXP_FEAT(debug_uuid, exp_debug_func),
 	EXP_FEAT(le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
+	EXP_FEAT(quality_report_uuid, quality_report_func),
 	EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
 };
 
diff --git a/src/shared/util.c b/src/shared/util.c
index 8c216f936..854b48d38 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1025,6 +1025,8 @@ static const struct {
 		"BlueZ Experimental Simultaneous Central and Peripheral" },
 	{ "15c0a148-c273-11ea-b3de-0242ac130004",
 		"BlueZ Experimental LL privacy" },
+	{ "330859bc-7506-492d-9370-9a6f0614037f",
+		"BlueZ Experimental Bluetooth Quality Report" },
 	{ }
 };
 
-- 
2.32.0.93.g670b81a890-goog

