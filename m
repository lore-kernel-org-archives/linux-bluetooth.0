Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E62C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6711A60E05
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKAWaE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhKAWaD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 18:30:03 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11521C061764
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 15:27:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x5so8625953pgk.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HRiyHnJLy+QfdMFxihQRDB+Uv4XHjGAkCBJSFX6qo/c=;
        b=Nfn9//2LSW/6cJuIhzPwByv0DYxSIPKjDbFe/kt0WvePxNg1zgC5eU+L1H5XxV0HrH
         QROayXW3k5qMxU6mm7Aq2ljHrhw4xkwlbRW/tTm653I/tvRrIy2DB3o6+v45GMOW85HW
         H5xzv0M0eLPwoW1W8PN5qViqjmKA/yZlVKw+XzMoQ6qJFisYX4LL/Th9pz6c9ztHnvNe
         5Hy7yzbqQpoQpq6axRNaFIeoGTJs89teqStUCQk6gaquXuPlCFDoy5Jx93va41RicSse
         Y+P6xLKNMxowxZQjJ1fGbrAutkWV/oG/lNHDkt0HbJGba9sdWOtkw68Zg1Jm27Jest+C
         c9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRiyHnJLy+QfdMFxihQRDB+Uv4XHjGAkCBJSFX6qo/c=;
        b=BHKW84VGRAGc++a3uxNUMJXiOBE8FIpGE8j0pDpt8AIdcv6lnvB2QjLrbt1VSf5WLw
         e/4+vpTwUbWxyk0WweJiIa1EipoPRcAp7ZQexOhUoYLkbw4Ls/594EURfgYpNUB+/n9N
         8BlORe+WpXZnn+Kv4mx/uc4orLuHphm3tRaimHRj3NXyBMXi28V6AFJgmBk8I4YJ5B37
         N8w4qohB1Ox07H7FTtnBqPkz8Kf8e3b6xNn2Eo9KlKk6/6RmZ0i1bl0jp8gF+JeE1vGv
         ugBPvOjgUs6VLcoeiXgFmKOKw1meGb3PCgwNmT01i79RAc6UQss5Agu1xDBOjrJOuB4r
         XMsA==
X-Gm-Message-State: AOAM5326tvT+Ivt68opSyKQM6gnaXLUSfpVjxT7lsC8cL7e7EloLwFZV
        Sl0CDhY1FOlibqlYOyXqHnQycmCkgns=
X-Google-Smtp-Source: ABdhPJxM5LJZ6Bg8J7wc2gMXk30K6FBcHXl1eACENs8b1DmypY9XMCw77HFV60x8O3vciX4fpxvbZQ==
X-Received: by 2002:a05:6a00:16cb:b0:44b:bd38:e068 with SMTP id l11-20020a056a0016cb00b0044bbd38e068mr31836012pfc.34.1635805647250;
        Mon, 01 Nov 2021 15:27:27 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x20sm387915pjp.48.2021.11.01.15.27.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:27:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-tester: Add test for Limited/Device Privacy
Date:   Mon,  1 Nov 2021 15:27:25 -0700
Message-Id: <20211101222725.2766736-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101222725.2766736-1-luiz.dentz@gmail.com>
References: <20211101222725.2766736-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a test for Limited/Device Privacy (0x02):

@ MGMT Command: Set Privacy (0x002f) plen 17
        Privacy: Limited (0x02)
        Key: 01020304050607080102030405060708
@ MGMT Event: Command Complete (0x0001) plen 7
      Set Privacy (0x002f) plen 4
        Status: Success (0x00)
        Current settings: 0x00002080
          BR/EDR
          Privacy
@ MGMT Event: New Settings (0x0006) plen 4
        Current settings: 0x00002080
          BR/EDR
          Privacy
---
 tools/mgmt-tester.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 207168291..e9fcb2602 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4136,15 +4136,29 @@ static const struct generic_data load_irks_not_supported_test = {
 	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
 };
 
-static const char set_privacy_valid_param[] = { 0x01,
+static const char set_privacy_1_valid_param[] = { 0x01,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 static const char set_privacy_settings_param[] = { 0x80, 0x20, 0x00, 0x00 };
 
-static const struct generic_data set_privacy_success_test = {
+static const struct generic_data set_privacy_success_1_test = {
 	.send_opcode = MGMT_OP_SET_PRIVACY,
-	.send_param = set_privacy_valid_param,
-	.send_len = sizeof(set_privacy_valid_param),
+	.send_param = set_privacy_1_valid_param,
+	.send_len = sizeof(set_privacy_1_valid_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_privacy_settings_param,
+	.expect_len = sizeof(set_privacy_settings_param),
+	.expect_settings_set = MGMT_SETTING_PRIVACY,
+};
+
+static const char set_privacy_2_valid_param[] = { 0x02,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+
+static const struct generic_data set_privacy_success_2_test = {
+	.send_opcode = MGMT_OP_SET_PRIVACY,
+	.send_param = set_privacy_2_valid_param,
+	.send_len = sizeof(set_privacy_2_valid_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = set_privacy_settings_param,
 	.expect_len = sizeof(set_privacy_settings_param),
@@ -4154,8 +4168,8 @@ static const struct generic_data set_privacy_success_test = {
 static const struct generic_data set_privacy_powered_test = {
 	.setup_settings = settings_powered,
 	.send_opcode = MGMT_OP_SET_PRIVACY,
-	.send_param = set_privacy_valid_param,
-	.send_len = sizeof(set_privacy_valid_param),
+	.send_param = set_privacy_1_valid_param,
+	.send_len = sizeof(set_privacy_1_valid_param),
 	.expect_status = MGMT_STATUS_REJECTED,
 };
 
@@ -13063,8 +13077,11 @@ int main(int argc, char *argv[])
 				&load_irks_not_supported_test,
 				NULL, test_command_generic);
 
-	test_bredrle("Set Privacy - Success",
-				&set_privacy_success_test,
+	test_bredrle("Set Privacy - Success 1",
+				&set_privacy_success_1_test,
+				NULL, test_command_generic);
+	test_bredrle("Set Privacy - Success 2 (Device Mode)",
+				&set_privacy_success_2_test,
 				NULL, test_command_generic);
 	test_bredrle("Set Privacy - Rejected",
 				&set_privacy_powered_test,
-- 
2.31.1

