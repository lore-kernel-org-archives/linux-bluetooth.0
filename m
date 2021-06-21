Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96965C48BC2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810AF61003
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUKZ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFUKZw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 06:25:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF8C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 03:23:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h1so8303642plt.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5yo8lG+Do235WwjNMJgzgzaMevn8nVw65qjgMaDKrs=;
        b=YslD9akHnyMm01F9fi1XZmuZOzWfLDnQ48XG9NwVnHlFQJ20/4c/gAxDFMX+jJjf8I
         ihF3JKThdrwrsvQuHkENwv35IZtr4CynLmbLtrOYMdJnMuhSUMB6IVMaXZ/I5elinWeu
         Q5QtVo5WvBp1PEPoc8IFlQmuxNYa0nYKOYLVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5yo8lG+Do235WwjNMJgzgzaMevn8nVw65qjgMaDKrs=;
        b=XiYvodMIGcFKODaqRESaaH1VzjwyYTN10M/eNCQRO4IMIq2EZ9yKk9gJRZPeVz+QLw
         qosdhv+U9b9uAWPVPbyIdfMBDpP/A1sZQG8l1ogmOXgkD3WSDOUnMDZ5ViQEcMOAAgzF
         MjJdna0TFYqFMo+AypLNgTji2DW7KePjSM5qP9aqjYi+9LpC8GmAwpD5pup0vgEQmC6J
         G4i/hNPIHVsFwDRA3DjJDdxpP3wI0JQVnSsryN6JarAjVNXvxO0opJdxqfdX7T/PjdhP
         VTAPQukRJwF3Z38XUSgFh5NCUxU+xE1jrn3CNoASs+m3j+V+TZShETLuW5Rw3St4TzTo
         ggqw==
X-Gm-Message-State: AOAM533RG0gzcoZc9XubIxGvEhXHx9F/1W18wk1XGzfB721LzoO2a/tW
        L+LJRvHYnoXfakNx05+oheNyho8SIKPwtQ==
X-Google-Smtp-Source: ABdhPJyTBPNgc0RV6p9UZDYOpbeZONcXGtae4QsRFZ7AiBrJbcQ09JakRGtuMpdVFNgd0/PBr7e5Pg==
X-Received: by 2002:a17:90b:247:: with SMTP id fz7mr37405662pjb.137.1624271012928;
        Mon, 21 Jun 2021 03:23:32 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:1c86:d28:c4ad:7497])
        by smtp.gmail.com with ESMTPSA id j10sm15375153pjb.36.2021.06.21.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:23:32 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2 2/3] adapter: read quality report feature
Date:   Mon, 21 Jun 2021 18:23:00 +0800
Message-Id: <20210621182149.BlueZ.v2.2.I7d16f055bc51ac86915c114c671743f49a1fc226@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
References: <20210621182149.BlueZ.v2.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
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
2.32.0.288.g62a8d224e6-goog

