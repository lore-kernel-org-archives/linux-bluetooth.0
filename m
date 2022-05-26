Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiEZLZI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbiEZLZH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:25:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A33615D
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a13so1193590plh.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUESNDl6X0iga2wqExoggP3CT/Fg2GAGSlYdR/L7PPU=;
        b=AuEgW2X1oL6qxd6Yr2rJb6jbWDqK0J+gVs5/hfXDQJ2IODkOyEEccwn9ssYCTsDHEC
         v4X5czhGiFxVFKfldkrLWKs440E5HYzyyeu1KApmPqucUBPvyzQz/TaCeFmYkhS2TNdA
         V4tSoDNw/CQc46TJaUhdffuuyLFK55xR8ncQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUESNDl6X0iga2wqExoggP3CT/Fg2GAGSlYdR/L7PPU=;
        b=drTpQ4nyKA+0vQch4JFLlewVqqOzUsNl3BoNiU/lDm+yR/aUdM8rW/x3kbfxMUGgzo
         dwiBwNgfE9okuPBP3YgZTSdtQ8sbb/+UOTAroq0aBpatXWTwkxZZ4KuGL0mgPrLGo+WF
         v2plh+vJCHC4P4xwVOu+QnV1Q1GTQVOCaP3HfHkJd90ANKCO2ATLgsVgZTsC35BNgp3+
         jVWJksAiPCdQRKHjQg/6vJAfqzmdq1eLxTsAayQhr807pmA1Q9ocx0vjaG9ga4QGfbf1
         L2Xl7gSAUaJ8j7bdWM60JFGsnFzgc/3D+7WDEHzjDl0NvyF0tEaZEGEb8+HXfcp/2Dfl
         Y4WA==
X-Gm-Message-State: AOAM531xR6RpFwUEY8zYg++pq/vJsN0M8glJNn8NcrCWdwlUkf+RQ9mx
        /SF6zt9pCW36arg4zkA35V9/UN9kyq7vNw==
X-Google-Smtp-Source: ABdhPJwFZZNCKdsO2FFPbFBDy5xCusaDFGYO8bNYJwl5kI8CgkzVGYRvbZsabUNassUoldq0Irnovw==
X-Received: by 2002:a17:90a:5c84:b0:1dc:9b42:f2cf with SMTP id r4-20020a17090a5c8400b001dc9b42f2cfmr2114638pji.123.1653564306183;
        Thu, 26 May 2022 04:25:06 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id e3-20020a17090301c300b0016188a3efb9sm1337489plh.89.2022.05.26.04.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:25:05 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v6 3/8] adapter: remove quality report from experimental features
Date:   Thu, 26 May 2022 19:24:51 +0800
Message-Id: <20220526112456.2488536-3-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220526112456.2488536-1-josephsih@chromium.org>
References: <20220526112456.2488536-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The quality report feature is now enabled through
MGMT_OP_SET_QUALITY_REPORT instead of through the experimental
features.

---

Changes in v6:
- Fixed a patch conflict.

Changes in v5:
- Move is_quality_report_supported() implementation to next patch.
  The function does not belong to this patch.

Changes in v4:
- Move forward this patch in the patch series so that this
  command patch is prior to the quality report event patches.

Changes in v3:
- This is a new patch that enables the quality report feature via
  MGMT_OP_SET_QUALITY_REPORT.

 src/adapter.c | 14 --------------
 src/adapter.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f7faaa263..2ceea6e1c 100644
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
@@ -9621,12 +9614,6 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
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
@@ -9703,7 +9690,6 @@ static const struct exp_feat {
 	EXP_FEAT(EXP_FEAT_DEBUG, &debug_uuid, exp_debug_func),
 	EXP_FEAT(EXP_FEAT_LE_SIMULT_ROLES, &le_simult_central_peripheral_uuid,
 		 le_simult_central_peripheral_func),
-	EXP_FEAT(EXP_FEAT_BQR, &quality_report_uuid, quality_report_func),
 	EXP_FEAT(EXP_FEAT_RPA_RESOLUTION, &rpa_resolution_uuid,
 		rpa_resolution_func),
 	EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
diff --git a/src/adapter.h b/src/adapter.h
index 688ed51c6..3d53a962d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -257,7 +257,6 @@ bool btd_le_connect_before_pairing(void);
 enum experimental_features {
 	EXP_FEAT_DEBUG			= 1 << 0,
 	EXP_FEAT_LE_SIMULT_ROLES	= 1 << 1,
-	EXP_FEAT_BQR			= 1 << 2,
 	EXP_FEAT_RPA_RESOLUTION		= 1 << 3,
 	EXP_FEAT_CODEC_OFFLOAD		= 1 << 4,
 };
-- 
2.36.1.124.g0e6072fb45-goog

