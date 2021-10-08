Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36335C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 05:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17892610CE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 05:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhJHFo7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 01:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhJHFo6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 01:44:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8FC061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 22:43:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so5404992plk.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+XKnD4GJOUG4ZpJH3cxocRx3+YDLNLBV8VWzd6UmmAI=;
        b=ktWEiJ6SkxoCtMgqQNpWodBxhZiO+Kb88yu7c0v0jAPHC0+3awafjQzSzWxDRMCTH8
         2L10By5syfkOfAK970bDRL6IaE50RKZnTw58GEWM+BzbjWSCONWA4SLf5BW1dEHB1nl3
         XRHfJZNrTwPCr1d46RrmnCVyv9sa6fABB5YraWas0K2ub/+oxXD8j+axC+i/1soUPL5c
         hMfcp7byC0XtGyQ8U9bVMHpQLY3DD4twsfitwHfYjPr98rt6l4I+s6aJJu/GvcSq4Pqr
         k8lc3eAqTulUipC4oeI5NfQ4kK9f+mRp+Y3WueDC2TFq4aMqTpAqwCTDn0oJZQWCvQQU
         zbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XKnD4GJOUG4ZpJH3cxocRx3+YDLNLBV8VWzd6UmmAI=;
        b=thBIUTL1ndCzYAQvm0h+xIf3zKKXTZ0Jf9Tv/Hro9YVpPodGMR2ST+Y9ms0pzlr4lD
         K4XGmjOHHpHmn6hFymPLrk0DeDzSOhvTl17K6HKOKMbyAWvtThHhe/fcDevIrzOW9t/3
         HgvzoiY6bc8s16pqvVH4RxIV04kMVDkdwUGzDszoLzv8HSCJr9YaEHkbI11RR1RPH3qD
         J+gWvb2GVsvqPAOlbZotJdOn1nlyVBru5X9yQhqE1/fDVN4W7UkQE9L12S//wDf60xZJ
         WDy0W0O3fq3juEjSiqcdkgi03rO/ygAeF5Kx05oNhY35yJ2RaVx+FH66jyrOd5cVtufq
         M2cg==
X-Gm-Message-State: AOAM531E+3mlUuFmOghR80Y2y76h7lQpF+Bxjbt4CbZ0y2fEUaX+/hCZ
        GjFJa3JnG9RW+zaqIoWaLlkz+eyMOjqoHA==
X-Google-Smtp-Source: ABdhPJxl40DYLB9JX07e2E7tFTG+Pu0yzAXz8eTFbzZ9o4BR14R9rkib5D91mBQIhVMb2zNUtI7dLw==
X-Received: by 2002:a17:902:ed0b:b0:13e:acdb:2528 with SMTP id b11-20020a170902ed0b00b0013eacdb2528mr7843852pld.54.1633671783337;
        Thu, 07 Oct 2021 22:43:03 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e91:8dc3:f28b:c60b])
        by smtp.gmail.com with ESMTPSA id x23sm1266315pfq.146.2021.10.07.22.43.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 22:43:02 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 2/3] tools/mgmt-tester: Updates Experimental Feature test cases
Date:   Thu,  7 Oct 2021 22:42:59 -0700
Message-Id: <20211008054300.27989-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008054300.27989-1-hj.tedd.an@gmail.com>
References: <20211008054300.27989-1-hj.tedd.an@gmail.com>
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

