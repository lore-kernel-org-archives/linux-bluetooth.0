Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ACAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 21:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D48A611EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 21:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbhI2VCe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343814AbhI2VCd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 17:02:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520EC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 14:00:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w11so2389940plz.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzKnUbJLEtIxJxBQ5JMYJw53EF0/m/XWsmFL0tbv1yo=;
        b=n58SZt1Iay6E9b0/C2OUIh0rH2a6ulV+L4mGSjt6AzGDfm8QDZ1PjsHuNWIRd4sYiR
         KzcUjeOO+3M08PUGNXkfNbsOZkl/r+lfuJRO7N2S6ffgGuk7ajmkvOFY4nFf3mclBiHI
         kqqPRyAubk17gkTvoz+jbISD0sPSQEftCbdOGaqvpas8oTPTb0j5CKWxiNBBAnTq8rWh
         cIcSk6n3wW5PvhJiPfiAthARmfy/LfUU6hzwM+ZQD8JPFsmEdeVKfdCvV94lEHkt6lO3
         gzuFg1MYWtz8KJcqEjE7fL7ohy2V5+GlSfrPwtAWKdWHzmFIQsuI6oTAmM/EmJr8d7Iy
         GyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzKnUbJLEtIxJxBQ5JMYJw53EF0/m/XWsmFL0tbv1yo=;
        b=v1WNcBOmEV6LUT2/Bc5Gr495y2tGbY/HwejJyjUyWMdzu9HUbdgLLzm/RJus7L1FVZ
         1hTYUTYPWTP1q6E7TukKriD6Iwkpfqfnr9Cd6iWDL0GOS06APqQEkK9eaPmAG8YtDh8m
         rpA8BV7Ob8cWOPruX2+JWdsLkvz5rE5cxPZdbmqGvVEwHAYffJPZGaL9r0HV4LNuNLGe
         QMfRCHUb0ehu0U2QSeNlbkEF7juVDrNMc7KtM2WQlO+iURu9Mnh4tFl7b/gbigZY1r5s
         72+GpN1t8BMM5l7KY7YS5TC2ulgzg1vE6ULUi6yF1mpUUrVEY0in4WY+vIdIBZzcQvYV
         j+aQ==
X-Gm-Message-State: AOAM5304vbxZNuGpmzIDmy0US/3a6QLwWsOQrT6FHlkHEgoy+Hx0V2rI
        cK4BkE7ybi6h7dicEoAIWh0LJfKp+Kc=
X-Google-Smtp-Source: ABdhPJwbQucaJSV1WL6ndOvy8R5DhTnloza6uoSWZg72c/QWvCeG014VpOADKf/1RG6sLzHDKBUb3g==
X-Received: by 2002:a17:90a:67c1:: with SMTP id g1mr2142673pjm.177.1632949250675;
        Wed, 29 Sep 2021 14:00:50 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:27f1:f058:546c:19eb])
        by smtp.gmail.com with ESMTPSA id gk14sm2732689pjb.35.2021.09.29.14.00.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:00:50 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Fix Read Experiemental Feature test case
Date:   Wed, 29 Sep 2021 14:00:49 -0700
Message-Id: <20210929210049.35597-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The quality report feature is supported only if the device support it.
Current emulator/btdev doesn't support it yet.

This patch updates the supported experimental feature list to align with
the current btdev implementation.
---
 tools/mgmt-tester.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 9c5b26c9a..e62c4dcdc 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9334,7 +9334,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x04, 0x00,				/* Feature Count */
+	0x03, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9343,14 +9343,10 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
 	0x48, 0xa1, 0xc0, 0x15,
 	0x02, 0x00, 0x00, 0x00,			/* Flags */
-	0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a,	/* UUID - Quality Report */
-	0x70, 0x93, 0x2d, 0x49, 0x06, 0x75,
-	0xbc, 0x59, 0x08, 0x33,
-	0x00, 0x00, 0x00, 0x00,			/* Flags */
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
 	0xce, 0x5a, 0x69, 0xa6,
-	0x01, 0x00, 0x00, 0x00			/* Flags */
+	0x00, 0x00, 0x00, 0x00			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
-- 
2.25.1

