Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53138C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EDC60FF2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 17:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhJ2R0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJ2R0A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 13:26:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5EC061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 10:23:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j9so2372087pgh.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/FAL83tocLfRMIigxN3uatvf6Jyivl60CZmVMLFfss=;
        b=dSEu/uCa5ZAUrY8jZbmb8jgcNaU9SdgWcnGkL0c/qSQySIR/AoMwbLSfHZYKMde5lG
         XHmDs5hDiiqyL+F8gMbqNhm2e/7UQUR5+lUYEd6EPmOlOO8h8A9WmqeUzLP/B2IbJe+M
         x6oaT5H/dW4YOBc5SWgYLn5JA5W9CqnS/hASKElvQHWqEnL4NXCujnvvYrVmR3i+9d0v
         C2jVi8Dn2FmeafWmm8Z6h5HcM+I/dzzT0bFweaQZ5hY5qlpWHThud/k0nrrleUw6WFMU
         yySS5alzFfhGfZ5ga+MBUMcKav4O7qU6fZ6VtvudmnVSOpVJ1CZ6jjojvqag/cx6cgSA
         Xvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/FAL83tocLfRMIigxN3uatvf6Jyivl60CZmVMLFfss=;
        b=0Lakb6Y+9Z8AbOjZ4UlwH9ZxMiT5fE3MMWb5kGhPi9q7R7jUVuojupKDF/OkkDljFp
         C8g03t4PlsPHvZIJGmbnN9L/c24bcEXg5LdLPw4rM7RQI5N/0znlP+kXU30cTuI70AjB
         G3ULnCcDwpPCi/bSoWZJEQQnvUXWsW9EFE+fG/O3b4mfsb50XXGVeV4GRbZs6442lxjj
         fVBjL8D7ys6prg9WsdvCnzqq07681WFa0DcFajmL5GFwliSQRwQ9l4NV/6lUnBfU5l0T
         3F7kvNEpbWA+Ko2Nooy8xxfMASp29p2yYnczLjsfJWVh+YqJY8cHUps7wUjIX8/Nj1Zo
         M8fg==
X-Gm-Message-State: AOAM533YFc86hsseUgH3lte0O5a2Bf7yY2PNGkpo5mLsfauEA7iyrBYP
        n7zDLtCJH0QgVQnykyN601bsl+4hHBGmvw==
X-Google-Smtp-Source: ABdhPJzeF0xxkLLq1WEVMgxeX+Kte/ciB+eQumfX2kK5jpyZrjfVOWoxRjnuWCdJZs087dsaNRAnWg==
X-Received: by 2002:a05:6a00:14c2:b0:47c:2c90:df4f with SMTP id w2-20020a056a0014c200b0047c2c90df4fmr12044131pfu.63.1635528210759;
        Fri, 29 Oct 2021 10:23:30 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:11f1:754d:5bb:5f40])
        by smtp.gmail.com with ESMTPSA id ne7sm2160743pjb.36.2021.10.29.10.23.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 10:23:29 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v15 1/2] tools/mgmt-tester: Update the expected manufacturer of emulator
Date:   Fri, 29 Oct 2021 10:23:27 -0700
Message-Id: <20211029172328.703752-1-hj.tedd.an@gmail.com>
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

