Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA50C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681FE6101B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJ2ScB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJ2ScA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 14:32:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D4C061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 11:29:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b4so3610739pgh.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/FAL83tocLfRMIigxN3uatvf6Jyivl60CZmVMLFfss=;
        b=W8TX69NLp74tMBtBlhVIjJ6AZnQJGr1hZGsvRIS2DnovqMu4/Q0thUsrIqT7tC0e1S
         +yYBufSczy28VhiZPUuOJpJ6eWi+YGX3GZvwhqLgySEdPAwj3gDLHHjdFmn6FlwUKjWh
         au9WbASRIn/yHrCkhYXIaioA40kNFyGiaNh1LAgcEhRsIT3M2TgcvDJd3hEUt14SVzA/
         h2aVu5xPmfuS/f3EPjxr83FXHyfSFbJ6ar7slUTyjZdEPGsiD+TfQvTkhNP4KkNALRnI
         qO9c9s2OZJKptOoJa7ndICoobLpxQniUTI2nC8ZaeNo0fFB8p/OX1ycoR5k8Wd0gtbp6
         haCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/FAL83tocLfRMIigxN3uatvf6Jyivl60CZmVMLFfss=;
        b=gP+ClffM8Ejr0TAnHTvFrXPwrp35l5XxrdZQDfAcNTUpwH6D/WswxKVqZ5mQWhky77
         a2goZv1x2hw9QVSRpttbnU4GDv//k5OM3Yw3JGGDb4DRB2bC4IE7pI0PUdvw5kXBrAGY
         JUZ9XUJjbSuhMG/EGWbaoQ7PM0q/DA2w7hwk30knG1kz4Cj6S64oZlWYBeH87lNCGFm/
         G23gLVxet6QL4VaEe7t6y4Wsa6Tg7VdB2taj6eulM/Ip7u5tpp88AUc3f022TypR/vte
         hpY/LF97ks5u7lCE7PoDRlUfe3Lnn3xe/z5LHMp6ZYoH4cVpEjLy3EQkgDLm1gcgtqeg
         +bWg==
X-Gm-Message-State: AOAM532JXUkIoiT55dnPBeFozcoqcUs744/WV9wN6FLHIqdxbFFBXWCE
        ow94xrbJESrBlbBCFWGjCCKj39CmPrGYIA==
X-Google-Smtp-Source: ABdhPJz9D65TB6wPfu8f0NCImdbdMgHaMa2g6nAzSQlxXW9KUFGpr83eDKA5vRTFfvkbwXNjwJye/g==
X-Received: by 2002:a63:720d:: with SMTP id n13mr9426839pgc.470.1635532170876;
        Fri, 29 Oct 2021 11:29:30 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:11f1:754d:5bb:5f40])
        by smtp.gmail.com with ESMTPSA id c3sm11634149pji.0.2021.10.29.11.29.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 11:29:30 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v16 1/2] tools/mgmt-tester: Update the expected manufacturer of emulator
Date:   Fri, 29 Oct 2021 11:29:28 -0700
Message-Id: <20211029182929.705682-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the expected manufacturer of the emulator for the
following test cases:

> Read Ext Controller Info 1                           Failed
> Read Ext Controller Info 2                           Failed
> Read Ext Controller Info 3                           Failed
> Read Ext Controller Info 4                           Failed
> Read Ext Controller Info 5                           Failed
---
 tools/mgmt-tester.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1ccce0ad6..ab3c81530 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5669,7 +5669,7 @@ static const struct generic_data conn_central_adv_non_connectable_test = {
 static const char ext_ctrl_info1[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x00, 0x00, 0x00, /* current settings */
 	0x09, 0x00, /* eir length */
@@ -5714,7 +5714,7 @@ static const struct setup_mgmt_cmd set_dev_class_cmd_arr1[] = {
 static const char ext_ctrl_info2[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x0D, 0x00, /* eir length */
@@ -5745,7 +5745,7 @@ static const struct generic_data read_ext_ctrl_info2 = {
 static const char ext_ctrl_info3[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x16, 0x00, /* eir length */
@@ -5780,7 +5780,7 @@ static const struct generic_data read_ext_ctrl_info3 = {
 static const char ext_ctrl_info4[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir length */
@@ -5839,7 +5839,7 @@ static const struct setup_mgmt_cmd set_dev_class_cmd_arr2[] = {
 static const char ext_ctrl_info5[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
-	0x3f, 0x00, /* manufacturer */
+	0xf1, 0x05, /* manufacturer */
 	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir len */
-- 
2.25.1

