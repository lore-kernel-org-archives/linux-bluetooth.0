Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD66C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C34261152
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhJFUO4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJFUOz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 16:14:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F294C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 13:13:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w14so2444614pll.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+XKnD4GJOUG4ZpJH3cxocRx3+YDLNLBV8VWzd6UmmAI=;
        b=Wtol52tYm6eTDflwfr6E/kwuzqLo9m1yUCgfTYTwcjmtGls2ACuFo9/Rx61tu9DNLA
         OxODj+qr9+UChFj6JQfO3EzrHY3sUhGY1jTiQFnMZilpH9ThsA+gCBL25G+87tSyp3rN
         +DMJQtQCzUAnlUhrqVJlIzVV18Wq3zb+FrTgxTZKJh8uGFKSKBC3KoZWQhf7MwDzKKcS
         2m/mSEysVOBqlOSnpunflMo3y9g57pD9720A3iy+kGJiLf6Z65YyPcPr5yJOyWJrMYMM
         TibdQOu7R7u8XmlfxPIb5DIexsMre2YH2gcZ0tctSodfbIjxiqvaG+TpWgzp+5/ISoKd
         0jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XKnD4GJOUG4ZpJH3cxocRx3+YDLNLBV8VWzd6UmmAI=;
        b=aFZCkXK7LszY+LO/i2elC8vVn26aBTs8k6nj/G3Ech9UpKOYmaz3LBnjvenl/ymRhP
         Rc1rKqxCCBvmsF1CmefPkPxhb+bb8KwzeVUyBEtdD0f7YtUXVUjclAy76dYC2tB3Gm6g
         38EKerVqfZNPW3wRCWoBu2rBq2HrUL8kSvEQQm3AokFbPl+RYalVfTYKF7bj35Noc1vl
         oSVvI323STv69Fhur/K1jiXuHPWjkEgDLdhPDDhBcMXrofbOzrEVauD5B7loKd0BOFGC
         bNdhchZDGJLspTbUh1QGPrz21AQauqH4daCtVpo1CTvjfTD0oFIzyodN+taQWI2eWRYd
         r6YA==
X-Gm-Message-State: AOAM532bM1u93o2N3btNfwsYfvf+zH/0FeYDqozrLeXE3tLv+H+GD3BI
        kr3MFeAUcPYZyVXS6+dEc0tTkp4dtNB5hg==
X-Google-Smtp-Source: ABdhPJxkiwUE3G7Zs2sDcS0tukaXKEIj28GG4tUERsdM2Fn5m800wCrQbRq2wIFx3DlPdhDyWjwgqg==
X-Received: by 2002:a17:902:934c:b0:13d:c685:229b with SMTP id g12-20020a170902934c00b0013dc685229bmr207702plp.25.1633551182562;
        Wed, 06 Oct 2021 13:13:02 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:8e4c:2d64:6206:9120])
        by smtp.gmail.com with ESMTPSA id b10sm16202006pfl.200.2021.10.06.13.13.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:13:01 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/3] tools/mgmt-tester: Updates Experimental Feature test cases
Date:   Wed,  6 Oct 2021 13:12:59 -0700
Message-Id: <20211006201300.186055-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006201300.186055-1-hj.tedd.an@gmail.com>
References: <20211006201300.186055-1-hj.tedd.an@gmail.com>
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

