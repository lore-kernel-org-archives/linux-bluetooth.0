Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1982CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 13:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbiBONg5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:36:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiBONg4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 08:36:56 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F896E8F6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i21so33437676pfd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21rCQRiXB46+PABuCyw+4bZoZw/a3puD6LYmvybmjdQ=;
        b=JR2odJ94fdopH+gQjWdTdqd8pIITZBp7KH6amMqBbyjMT6TkzjT+qBkrmnTDCIGfcU
         N8LjgQa+EyESx3Au80N87/AwtzKEVANE4cFyMphSXnJ3s6xgbydTTStQ1qqdC0ljPWcm
         7UpFwnS+PKv8eZChJofY9ULXiuXVIR6BKIxnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21rCQRiXB46+PABuCyw+4bZoZw/a3puD6LYmvybmjdQ=;
        b=rGsMZE1d+/2NOyFY3tisojJ5yv9L5hv/NtUEWJHOgj+x7EdL9dBNZ+dw55Bfrz+x5a
         7qajHZ2RhC7umed2nfFSw9c9pyxp22g9oA/9yIXJw2pXFEuaemi5QrGIVgWkxhMEglwa
         mk5gZd2MJowkqfBMqxue8Ta6DxbUpIEJPsVUSgTLjzN1UlgisHHnxtrORbGeEr3LatfA
         QZYGVtO965Up3G0q5QSe/cKEYx+klnPCmWOPf1wwKOk20LTJ0fMrhpj078GdO1CG2Y4u
         8+PO5K4wmRVl6IiXTjA0ygxEp9jDsryWF40Eu/mzIV+GxwYcw/dKMyqHHuFJXQTwhsrw
         FleQ==
X-Gm-Message-State: AOAM5312NUvrwI0RERLQNel9W45ylytk609kNC1u4G6U8fcyzSk6DAHw
        ElVyzXpE30X041EpuiuWofOe+J5OjHKRsw==
X-Google-Smtp-Source: ABdhPJzhoY5F+IwOupsE8AUgZ+b+6bfU9Ce7qf5wX9lxeQBI1Cg5AzHgksMssnKJIWXQoT7jqEbPPQ==
X-Received: by 2002:a63:b58:: with SMTP id a24mr3556904pgl.537.1644932206468;
        Tue, 15 Feb 2022 05:36:46 -0800 (PST)
Received: from localhost (208.158.221.35.bc.googleusercontent.com. [35.221.158.208])
        by smtp.gmail.com with UTF8SMTPSA id x6sm8940389pfo.152.2022.02.15.05.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:36:46 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v4 3/8] adapter: enable quality report via MGMT_OP_SET_QUALITY_REPORT
Date:   Tue, 15 Feb 2022 21:36:31 +0800
Message-Id: <20220215133636.2827039-3-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The quality report feature is now enabled through
MGMT_OP_SET_QUALITY_REPORT instead of through the experimental
features.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v4:
- Move forward this patch in the patch series so that this
  command patch is prior to the quality report event patches.

Changes in v3:
- This is a new patch that enables the quality report feature via
  MGMT_OP_SET_QUALITY_REPORT.

 src/adapter.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index eef50f67a..d988865f6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -120,13 +120,6 @@ static const struct mgmt_exp_uuid le_simult_central_peripheral_uuid = {
 	.str = "671b10b5-42c0-4696-9227-eb28d1b049d6"
 };
 
-/* 330859bc-7506-492d-9370-9a6f0614037f */
-static const struct mgmt_exp_uuid quality_report_uuid = {
-	.val = { 0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
-		0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33 },
-	.str = "330859bc-7506-492d-9370-9a6f0614037f"
-};
-
 /* 15c0a148-c273-11ea-b3de-0242ac130004 */
 static const struct mgmt_exp_uuid rpa_resolution_uuid = {
 	.val = { 0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
@@ -9600,12 +9593,6 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
 				(void *)le_simult_central_peripheral_uuid.val);
 }
 
-static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
-{
-	if (action)
-		queue_push_tail(adapter->exps, (void *)quality_report_uuid.val);
-}
-
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -9681,7 +9668,6 @@ static const struct exp_feat {
 	EXP_FEAT(&debug_uuid, exp_debug_func),
 	EXP_FEAT(&le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
-	EXP_FEAT(&quality_report_uuid, quality_report_func),
 	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
 	EXP_FEAT(&codec_offload_uuid, codec_offload_func),
 };
@@ -9755,6 +9741,11 @@ static void read_exp_features(struct btd_adapter *adapter)
 	btd_error(adapter->dev_id, "Failed to read exp features info");
 }
 
+bool is_quality_report_supported(struct btd_adapter *adapter)
+{
+	return !!(adapter->supported_settings & MGMT_SETTING_QUALITY_REPORT);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-- 
2.35.1.265.g69c8d7142f-goog

