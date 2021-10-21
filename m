Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9AF6137F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 17:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhJURuu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhJURul (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 13:50:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93063C061226
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n11so946434plf.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SjIRrC7ic/vsPQiDiTqzWwz8nfW4impqpkTFLACRKus=;
        b=S73ZhkjenWfvrs7bMAO3prG+/I0fw37qyb4iZwWjeraU9uhVSwmpTVrb1quo4aLYKy
         lSHN0Z9sFpH9FxEUGLIZDgljt2sPXwV0avEG3ULs34ANrXdHLWg7qtmka80G+3s6IGRu
         ttdWirH9yfe/syX+C/ZKzC2xaOrjHWgqHFjpTB5/WbYcbeVKM1FbIqJQ7h2hEkmHrKIt
         emn2lI1nmvnVQoWKYZ8MpJH+zghPF6bmLhPl7x0O7CzBG01DKafYwLcGa/eB+WxxW4kK
         3Zw0MjyV0jJnVdyAVJmJ90d3KY1XHSLLHLmu+TVhS1HkbjaXqprL2TaaXR3NkaCmjZ5q
         eu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjIRrC7ic/vsPQiDiTqzWwz8nfW4impqpkTFLACRKus=;
        b=wOqSIAZMoYX+qgtGXa2B/U3iUNZzeniIg5uzPseb/39vkQmrS1EGSgD/7oaAQxt2jM
         cI6C9HuepKLc1ZFwaKPA010+OvpaKlTj5Yr4ck59wh4JA2kMZvXewqKdQ3H3Jgg+MfEV
         65dbmshVFVJH4KOB2ahYfYH9GwHqBPNqcrvkMzCxDWyYicbyDae+p7DV+vcTO6wJ3cfz
         AR0h1t6fHC88plTyys5c6VrjcaNwqGWY2Pm5cEdCWjm0LgHSuqqwnuklMAlfEY2Jar1c
         eOKoZB4U3bA8g6AHxJM/ISnOITGpHYAcjpVl2PyyQTTaNR/rh8h433Jm+w1+4wCQlJi6
         TQIg==
X-Gm-Message-State: AOAM532iL8jrvFbnFDeqxJYimDLVkl+1bI55HDTgpjo15o1bDCc+EHyB
        CFmdtpFlCmK4QyL09Ei3rV517V//KaHr1w==
X-Google-Smtp-Source: ABdhPJyNEwwcNIFe+Vd0rrRn8t+d9yRfJkwW3s+j1WXkEe52E1oiRXzUQ7PWpG9RukC5ozA6eBysCA==
X-Received: by 2002:a17:902:be0c:b0:13e:2b53:d3 with SMTP id r12-20020a170902be0c00b0013e2b5300d3mr6615421pls.86.1634838487920;
        Thu, 21 Oct 2021 10:48:07 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:e439:7541:94af:b362])
        by smtp.gmail.com with ESMTPSA id g4sm5732586pgs.42.2021.10.21.10.48.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:48:07 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v13 4/5] tools/mgmt-tester: Add support for experimental feature in setup
Date:   Thu, 21 Oct 2021 10:48:03 -0700
Message-Id: <20211021174804.340160-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021174804.340160-1-hj.tedd.an@gmail.com>
References: <20211021174804.340160-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support for experimental feature in setup_settings
options.
---
 tools/mgmt-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 64a5e1c3d..08fd16985 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -260,6 +260,7 @@ struct generic_data {
 	const uint16_t *setup_settings;
 	bool setup_nobredr;
 	bool setup_limited_discov;
+	const void *setup_exp_feat_param;
 	uint16_t setup_expect_hci_command;
 	const void *setup_expect_hci_param;
 	uint8_t setup_expect_hci_len;
@@ -7222,6 +7223,7 @@ proceed:
 		unsigned char privacy_param[] = { 0x01,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
+		unsigned char set_exp_feat_param[17] = { 0x00 };
 		unsigned char *param = simple_param;
 		size_t param_size = sizeof(simple_param);
 		mgmt_request_func_t func = NULL;
@@ -7250,14 +7252,30 @@ proceed:
 				memcpy(param, test->setup_discovery_param, 1);
 		}
 
+		if (*cmd == MGMT_OP_SET_EXP_FEATURE) {
+			if (test->setup_exp_feat_param) {
+				memcpy(set_exp_feat_param,
+				       test->setup_exp_feat_param, 17);
+				param_size = sizeof(set_exp_feat_param);
+				param = set_exp_feat_param;
+			}
+		}
+
 		if (*cmd == MGMT_OP_SET_LE && test->setup_nobredr) {
 			unsigned char off[] = { 0x00 };
+			tester_print("Setup sending %s (0x%04x)",
+							mgmt_opstr(*cmd), *cmd);
 			mgmt_send(data->mgmt, *cmd, data->mgmt_index,
 					param_size, param, NULL, NULL, NULL);
+			tester_print("Setup sending %s (0x%04x)",
+					mgmt_opstr(MGMT_OP_SET_BREDR),
+					MGMT_OP_SET_BREDR);
 			mgmt_send(data->mgmt, MGMT_OP_SET_BREDR,
 					data->mgmt_index, sizeof(off), off,
 					func, data, NULL);
 		} else {
+			tester_print("Setup sending %s (0x%04x)",
+							mgmt_opstr(*cmd), *cmd);
 			mgmt_send(data->mgmt, *cmd, data->mgmt_index,
 					param_size, param, func, data, NULL);
 		}
-- 
2.25.1

