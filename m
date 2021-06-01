Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30090C4708F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1536E61360
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhFAUvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbhFAUvD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 16:51:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5BC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 13:49:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so2149610pjp.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1EWCPV4DBX0R9NeNAi6mS30JMox8jCDnYHn9+qJ9crE=;
        b=kijAzY5pngM3GFhLby4316+hdRQIi5WdR0kujvvmkTi8uZc6Pfp8EObKLqoiJm3mEZ
         k/TmFO2UJW+Q2w5Fzqz3QMDxonn4hliEau3mX4hAi0ozwdYygG6HA+r7MAhUj7JrXkGr
         2QyAIQTA1Vv1Dt6zRRF0Qqt0isZ8B9189Ql4Q6juRC4p0l8g8kt3HpFox2ptAsSXUlqo
         sOOAy3sNQ6JsaMYWiI1SJ33vRjTvjZJ8EIcHsG2Vbn4b0vXvgLn/R26KqzBbw4dTgwSG
         QSf+MT+g9GXe9/U93BdcIoh1ZXhuE7L7JdMZWNtr1pVs5K0HIJ55GRlDyUU6uwZiQ4ZZ
         TSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EWCPV4DBX0R9NeNAi6mS30JMox8jCDnYHn9+qJ9crE=;
        b=ATF+cvqJimdb2p4WUnJRITz40mflXvQuIgpzU7XrMJfNFGR5zlAxLhS3dFOrRycHUc
         VzYPVel2VfAe7Pr/zZIrDtrrdcJ31vApacjT56xZl0RUlg/zYy5NdLrRca66DJm0/6hY
         3TD3kViyBYoS7nLWY4iukZ1jP3yWbaKYMb7Y51F2He3SWA92/Cts8CQr3a/sRfo48Hk8
         e8GhmXyAxHv8ID0I3ATztltq0HvzILFulibDeuiLS4AK1wtNzWyzF9l3v5h0RMbE0tvg
         ePCHS6xDANevRft8p1P9J+8umMIsRWndzuDu7rxTT66LkeBaInmYnY1K3ZPjjeuz+TBZ
         m4Sw==
X-Gm-Message-State: AOAM5318X/C3KMPQQATFDNgHh/0WE/QkGbL3GUq/+3d3QWobCpaQrONt
        SmKOSdlsCjbGBXGf3hoBOMbGQ2RYplI=
X-Google-Smtp-Source: ABdhPJzCE6vrtJkkHu88SrKigSqGTFRsJurSSt5JA6zKs1H4s7aPkh5z0MQxMnXREGnvUd944D3V0g==
X-Received: by 2002:a17:90b:4d11:: with SMTP id mw17mr1741713pjb.229.1622580561300;
        Tue, 01 Jun 2021 13:49:21 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id t20sm11435396pjs.11.2021.06.01.13.49.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:49:21 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH V2 2/3] tools/mgmt-tester: Add tests for experimental feature command
Date:   Tue,  1 Jun 2021 13:49:17 -0700
Message-Id: <20210601204918.903327-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210601204918.903327-1-hj.tedd.an@gmail.com>
References: <20210601204918.903327-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds test cases for Read/Set Experimenal Feature commands.
---
 tools/mgmt-tester.c | 137 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4550d6e9c..c0faf6efc 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9124,6 +9124,100 @@ static const struct generic_data set_dev_flags_fail_3 = {
 	.expect_len = sizeof(set_dev_flags_rsp_param_fail_3),
 };
 
+static const uint8_t read_exp_feat_param_success[] = {
+	0x02, 0x00,				/* Feature Count */
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
+	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
+	0xb5, 0x10, 0x1b, 0x67,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
+	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
+	0x48, 0xa1, 0xc0, 0x15,
+	0x02, 0x00, 0x00, 0x00,			/* Flags */
+};
+
+static const struct generic_data read_exp_feat_success = {
+	.send_opcode = MGMT_OP_READ_EXP_FEATURES_INFO,
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = read_exp_feat_param_success,
+	.expect_len = sizeof(read_exp_feat_param_success),
+};
+
+static uint16_t settings_powered_le_privacy[] = { MGMT_OP_SET_LE,
+						MGMT_OP_SET_PRIVACY,
+						MGMT_OP_SET_POWERED, 0 };
+
+static const uint8_t set_exp_feat_param_ll_privacy[] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
+	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
+	0x48, 0xa1, 0xc0, 0x15,
+	0x01,					/* Action - enable */
+};
+
+static const uint8_t set_exp_feat_rsp_param_ll_privacy[] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
+	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
+	0x48, 0xa1, 0xc0, 0x15,
+	0x03, 0x00, 0x00, 0x00,			/* Action - enable */
+};
+
+static const struct generic_data set_exp_feat_enable_ll_privacy = {
+	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
+	.send_param = set_exp_feat_param_ll_privacy,
+	.send_len = sizeof(set_exp_feat_param_ll_privacy),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_exp_feat_rsp_param_ll_privacy,
+	.expect_len = sizeof(set_exp_feat_rsp_param_ll_privacy),
+};
+
+static const uint8_t set_exp_feat_param_disable[17] = { 0x00 };
+static const uint8_t set_exp_feat_rsp_param_disable[20] = { 0x00 };
+
+static const struct generic_data set_exp_feat_disable = {
+	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
+	.send_param = set_exp_feat_param_disable,
+	.send_len = sizeof(set_exp_feat_param_disable),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_exp_feat_rsp_param_disable,
+	.expect_len = sizeof(set_exp_feat_rsp_param_disable),
+};
+
+static const struct generic_data set_exp_feat_rejected = {
+	.setup_settings = settings_powered_le_privacy,
+	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
+	.send_param = set_exp_feat_param_ll_privacy,
+	.send_len = sizeof(set_exp_feat_param_ll_privacy),
+	.expect_status = MGMT_STATUS_REJECTED,
+};
+
+static const uint8_t set_exp_feat_param_invalid[] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02,	/* UUID - LL Privacy */
+	0xde, 0xb3, 0xea, 0x11, 0x73, 0xc2,
+	0x48, 0xa1, 0xc0, 0x15,
+	0xff,					/* Action - invalid */
+};
+
+static const struct generic_data set_exp_feat_invalid = {
+	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
+	.send_param = set_exp_feat_param_invalid,
+	.send_len = sizeof(set_exp_feat_param_invalid),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const uint8_t set_exp_feat_param_unknown[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff,	/* UUID - Unknown */
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff,
+	0x01,					/* Action - enable */
+};
+
+static const struct generic_data set_exp_feat_unknown = {
+	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
+	.send_param = set_exp_feat_param_unknown,
+	.send_len = sizeof(set_exp_feat_param_unknown),
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+};
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -11192,5 +11286,48 @@ int main(int argc, char *argv[])
 				setup_get_dev_flags,
 				test_command_generic);
 
+	/* MGMT_OP_READ_EXP_FEATURE
+	 * Read Experimental features - success
+	 */
+	test_bredrle50("Read Exp Feature - Success",
+				&read_exp_feat_success,
+				NULL, test_command_generic);
+	/* MGMT_OP_SET_EXP_FEATURE
+	 * Enable LL Privacy
+	 */
+	test_bredrle50("Set Exp Feature - Enable LL Privacy",
+				&set_exp_feat_enable_ll_privacy,
+				NULL, test_command_generic);
+
+	/* MGMT_OP_SET_EXP_FEATURE
+	 * Disable all features by sending zero UUID
+	 */
+	test_bredrle50("Set Exp Feature - Disable all",
+				&set_exp_feat_disable,
+				NULL, test_command_generic);
+
+	/* MGMT_OP_SET_EXP_FEATURE
+	 * Rejected - If the power is on, the command should be rejected
+	 */
+	test_bredrle50("Set Exp Feature - Rejected",
+				&set_exp_feat_rejected,
+				NULL, test_command_generic);
+
+	/* MGMT_OP_SET_EXP_FEATURE
+	 * Invalid parameter
+	 */
+	test_bredrle50("Set Exp Feature - Invalid params",
+				&set_exp_feat_invalid,
+				NULL, test_command_generic);
+
+
+	/* MGMT_OP_SET_EXP_FEATURE
+	 * Not Supported UUID
+	 */
+	test_bredrle50("Set Exp Feature - Unknown feature",
+				&set_exp_feat_unknown,
+				NULL, test_command_generic);
+
+
 	return tester_run();
 }
-- 
2.26.3

