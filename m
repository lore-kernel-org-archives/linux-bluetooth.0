Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66401C47080
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBBA613D6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 20:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhFAUVJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 16:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAUVI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 16:21:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE8C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 13:19:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v12so7489995plo.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9YUjnJ2PTkELptkYWCmxO47K33gXfXzwP4BqGN3mI4Y=;
        b=BTpgZwgHBK2v2a2Q4+Pl9EaJ1n9R1MfxOINRamz4GUW4lgmsVHAfEJGcgXZLloL55Y
         utUaxLzhZqPeFR9V2ic+8NPMrTMgcmfDV04e2QntMAfibNLsCU5Hrp1wIy9gdNACFeQb
         dtsuuF1q56sx0xQQDPqc40yb19p8pq++iWAu19x95lLvtigR3GBlWh3jPGz6SrSc32Ql
         G9JaXkglnmDgyTlLwrYEM5RjGAmj2te4YeEDxadv+87Ylp2uG3/3V6Zqz8cqlFJWEzK8
         n6l/jHIllIZf6aDQGHSsQRce1D6zH5/eCKF0ctNiVHDjGt3ddXOYyk4JHwxBxKg8SQ1j
         +Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YUjnJ2PTkELptkYWCmxO47K33gXfXzwP4BqGN3mI4Y=;
        b=EMW9Xow4y/ddhO4+k65ZRQpCQ1hv2r+gp+cvJrHaiCwx/Pd3/DJWPyGh5K0QX7vmap
         wx5RIVPd/xmHxLf7ZSv2VUOCKMpEXEbO7yUIzbpDKFLIs8U6L1Sy/RW9r8N20zo5Uspt
         dV5CK89gjxf2tdaPashCND+6lJqClVEYqiQIm8ih6Ebk9ibZ1D5gqHN0Lc3nZrStvSBq
         WkH8FWwHS6/K2oDeRRFtrJoy0SDfyAKZTqwBfL1P1LvD1F2QK4ohT1ft55gnrxOqvdi4
         rG9YgqdYvOfYYN8uTqBVS/UJG7Ir03Orr4fs5iEyoA6A9Xz7wg7rHWIubHk12HrPfDpP
         QDQg==
X-Gm-Message-State: AOAM533UjMdhql9n6Ztw8BkcaEZTZiVgXuw84Ekpn6BegHoRDQM6OW55
        YehYV4f5SKHoPVM7wD3icxPP3+0N+ZM=
X-Google-Smtp-Source: ABdhPJysTjx9s6WRW7OIBogKZl8n8CEQ+tLNeaNtM6En6/DBpnRfysx2MbBY8o+KzfuW90XDoHjOBQ==
X-Received: by 2002:a17:902:bd0b:b029:ef:8970:281c with SMTP id p11-20020a170902bd0bb02900ef8970281cmr27301602pls.35.1622578766137;
        Tue, 01 Jun 2021 13:19:26 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id y129sm13399262pfy.123.2021.06.01.13.19.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:19:25 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/3] tools/mgmt-tester: Add tests for experimental feature command
Date:   Tue,  1 Jun 2021 13:19:22 -0700
Message-Id: <20210601201923.899950-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210601201923.899950-1-hj.tedd.an@gmail.com>
References: <20210601201923.899950-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds test cases for Read/Set Experimenal Feature commands.
---
 tools/mgmt-tester.c | 139 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4550d6e9c..0d7c6b9e1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6837,7 +6837,7 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 			expect_param = test->expect_func(&expect_len);
 
 		if (length != expect_len) {
-			tester_warn("Invalid cmd response parameter size");
+			tester_warn("Invalid cmd response parameter size: %d", length);
 			tester_test_failed();
 			return;
 		}
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

