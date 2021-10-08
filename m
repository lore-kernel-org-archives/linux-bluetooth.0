Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F33DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E1660FF2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbhJHTi2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhJHTi1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:38:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BE4C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:36:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa6-20020a17090b1bc600b0019ffc4b9c51so10032406pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+XKnD4GJOUG4ZpJH3cxocRx3+YDLNLBV8VWzd6UmmAI=;
        b=nlnFT/fDhSDkW/+0Gk4tk1Tsyi/8OPRN0W0jqGPi2VNvfH+ZNSDMFTqsoD4E/lVCMC
         EU/s1vitdgd27OozkNn3cfmXIVILYm/n9G/SXx3F+cEZqybdzHHyhpA2YMHXkZ2dD83s
         HKLZkoPZb14STYPVfgrIC3EzoZcfJdXkkeKndUzoPm1Bm+sbSeUznypA0btgeCTtSEw7
         n4hUDGZ6pzfQb0ZiWou93iNjskKlG7BIWNR/4kJAPlWsJuhqy7cTqDEYvHj7mMjxMXV/
         iExGb3l0sKpTuHbWY5AqpxGBdRfDHinmn6Qm/j0q9w6sgboMR+HVKlrFEbEDNMZu/mnv
         hjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XKnD4GJOUG4ZpJH3cxocRx3+YDLNLBV8VWzd6UmmAI=;
        b=zd4a5NrGht2dhGlqTgZiHpqNpM7LDToqn/MYBvz0zUnciLcXDcKeQNgDloXnkKFpzt
         lBS52ODFHOoCP4z6vzAsQ7DuIyiksjiIZtLZjKjl2Pf5BKYtTZPr749xvHyRsyBGjiQl
         4kVn1vQl24SWD+Mh6FuDl3MDNOZm0UutWYYvuecOrRV4AB9AeCx3esgSOt6Vz26hGj+Y
         v1w2B9D3qlEhDvH1j4Y+HPkykixHyzGe2+C9C2p6X1toOOihmKzd7SCefnJ/S7C/yQ8W
         rr3JclZ40lrlikulKPVFMfeMRvDAVMyCMikdX3B1pteKfNYGSAtIJJZxXvni3jrdDjWj
         ofvA==
X-Gm-Message-State: AOAM531D/zGOSvDqe+VGcesuTkX8063QNOn80W4F2TNPkRFMOk/QolBn
        sBGiXACRM93DN9jGYvOTwKenDWlDaRpybA==
X-Google-Smtp-Source: ABdhPJxYrVx6faneX/PSTUhMm4F+1zWtbUglLE34PEgwH+OzemVOO0x3cYIczuaJ0l5IowJKHIvPiA==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr14331322pjr.17.1633721791531;
        Fri, 08 Oct 2021 12:36:31 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e91:8dc3:f28b:c60b])
        by smtp.gmail.com with ESMTPSA id g23sm137616pfu.71.2021.10.08.12.36.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:36:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 2/3] tools/mgmt-tester: Updates Experimental Feature test cases
Date:   Fri,  8 Oct 2021 12:36:27 -0700
Message-Id: <20211008193628.39347-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008193628.39347-1-hj.tedd.an@gmail.com>
References: <20211008193628.39347-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates/adds test cases for Read and Set Experimental Feature
commands.
---
 tools/mgmt-tester.c | 92 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1a2aba7fd..84d81c8ca 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -390,8 +390,8 @@ static void debug_exp_feature(struct test_data *data)
 	tester_print("Enabling Debug feature");
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
-		sizeof(set_exp_feat_param_debug), set_exp_feat_param_debug,
-		debug_exp_callback, NULL, NULL);
+		  sizeof(set_exp_feat_param_debug), set_exp_feat_param_debug,
+		  debug_exp_callback, NULL, NULL);
 }
 
 static void read_index_list_callback(uint8_t status, uint16_t length,
@@ -9702,6 +9702,23 @@ static const struct generic_data read_exp_feat_success = {
 	.expect_len = sizeof(read_exp_feat_param_success),
 };
 
+
+static const uint8_t read_exp_feat_param_success_index_none[] = {
+	0x01, 0x00,				/* Feature Count */
+	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
+	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
+	0x30, 0x25, 0x99, 0xd4,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+};
+
+static const struct generic_data read_exp_feat_success_index_none = {
+	.send_index_none = true,
+	.send_opcode = MGMT_OP_READ_EXP_FEATURES_INFO,
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = read_exp_feat_param_success_index_none,
+	.expect_len = sizeof(read_exp_feat_param_success_index_none),
+};
+
 static uint16_t settings_powered_le_privacy[] = { MGMT_OP_SET_LE,
 						MGMT_OP_SET_PRIVACY,
 						MGMT_OP_SET_POWERED, 0 };
@@ -9720,6 +9737,20 @@ static const uint8_t set_exp_feat_rsp_param_ll_privacy[] = {
 	0x03, 0x00, 0x00, 0x00,			/* Action - enable */
 };
 
+static const uint8_t set_exp_feat_param_offload_codec[] = {
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
+	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
+	0xce, 0x5a, 0x69, 0xa6,
+	0x01,					/* Action - enable */
+};
+
+static const uint8_t set_exp_feat_rsp_param_offload_codec[] = {
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
+	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
+	0xce, 0x5a, 0x69, 0xa6,
+	0x01, 0x00, 0x00, 0x00,			/* Action - enable */
+};
+
 static const struct generic_data set_exp_feat_enable_ll_privacy = {
 	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
 	.send_param = set_exp_feat_param_ll_privacy,
@@ -9727,6 +9758,44 @@ static const struct generic_data set_exp_feat_enable_ll_privacy = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = set_exp_feat_rsp_param_ll_privacy,
 	.expect_len = sizeof(set_exp_feat_rsp_param_ll_privacy),
+	.expect_alt_ev = MGMT_EV_EXP_FEATURE_CHANGE,
+	.expect_alt_ev_len = sizeof(struct mgmt_ev_exp_feature_changed),
+};
+
+static void read_exp_feature_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Received Read Experimental Features Info");
+
+	tester_setup_complete();
+}
+
+static void setup_set_exp_feature_alt(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* Send the Read Experiemental Features Information command to receive
+	 * the Experiemental Feature Changed event
+	 */
+	mgmt_send(data->mgmt_alt, MGMT_OP_READ_EXP_FEATURES_INFO,
+			data->mgmt_index, 0, NULL,
+			read_exp_feature_callback, NULL, NULL);
+}
+
+static const struct generic_data set_exp_feat_offload_codec = {
+	.send_opcode = MGMT_OP_SET_EXP_FEATURE,
+	.send_param = set_exp_feat_param_offload_codec,
+	.send_len = sizeof(set_exp_feat_param_offload_codec),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_exp_feat_rsp_param_offload_codec,
+	.expect_len = sizeof(set_exp_feat_rsp_param_offload_codec),
+	.expect_alt_ev = MGMT_EV_EXP_FEATURE_CHANGE,
+	.expect_alt_ev_len = sizeof(struct mgmt_ev_exp_feature_changed),
 };
 
 static const uint8_t set_exp_feat_param_disable[17] = { 0x00 };
@@ -12434,12 +12503,29 @@ int main(int argc, char *argv[])
 	test_bredrle50("Read Exp Feature - Success",
 				&read_exp_feat_success,
 				NULL, test_command_generic);
+
+	/* MGMT_OP_READ_EXP_FEATURE
+	 * Read Experimental features - success (Index None)
+	 */
+	test_bredrle50("Read Exp Feature - Success (Index None)",
+				&read_exp_feat_success_index_none,
+				NULL, test_command_generic);
+
 	/* MGMT_OP_SET_EXP_FEATURE
 	 * Enable LL Privacy
 	 */
 	test_bredrle50("Set Exp Feature - Enable LL Privacy",
 				&set_exp_feat_enable_ll_privacy,
-				NULL, test_command_generic);
+				setup_set_exp_feature_alt,
+				test_command_generic);
+
+	/* MGMT_OP_SET_EXP_FEATURE
+	 * Offload Codec
+	 */
+	test_bredrle50("Set Exp Feature - Offload Codec",
+				&set_exp_feat_offload_codec,
+				setup_set_exp_feature_alt,
+				test_command_generic);
 
 	/* MGMT_OP_SET_EXP_FEATURE
 	 * Disable all features by sending zero UUID
-- 
2.25.1

