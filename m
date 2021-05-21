Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69AAC43460
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 06:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827D6613BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 06:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhEUG0H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 02:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhEUG0G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 02:26:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E767C061763
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 23:24:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 22so13791619pfv.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dqrvlGYZ2YDyLi6uDC9XBI9g6rtUG/9PFuBejLo/ZGA=;
        b=VUkuBPEB6uTffxuvtGyyNfxdthlUJ7xaTvwggIp6D2RFXAbuV8y9qArkpDC0L8vkzO
         TFCQMlf9RSiVZrYUXrPqlEknt41AAYU/GG1zMcfOr2zvbycpO3uAXdmJiNvKU8AdRTAY
         24TM2QvECgSp896/MvjSVVkG7bSvxIDtKVebr5uzLqz1FA3Zmqqw/cE/WQtuzo9MQHLM
         WemNZdHTkvNx5x4UMIPa3KaWk9azdqrIi3vRd6CoO2a71Lh0xMQ/4XhKCvVFM4N2bnM2
         cxCYrFQS0YrJd39x6mVT5BGqSGZu/sW7Y7HGEgY/rRfoTupqjn1BB1D7wAKERSTo/PSV
         JQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqrvlGYZ2YDyLi6uDC9XBI9g6rtUG/9PFuBejLo/ZGA=;
        b=fOqvNmoKSRDkK0IziZVHkN8Qdc7Vqcb8jCLsXjVB/uaQ6PWrB+BNeExo7I3vr+P3o3
         MlUmEq0q2b/Vp0Q4q+zaMWUuntfsTrnfvtbzS4zdq/hA22Z4LS1xtAztNN6rl7rZjX6S
         RZtXeuu6UMfCrIQiHe4A0+Wu5wINxQAQgYK9P7jzN5SQ8qKp54pKyNAIaJES1pyhhYov
         j9dOTH8i1VHmMdZdvILHzTQE4ScZ0SVKW1dMY70qmor7BnOgikQCwEn98b69d6pLJIpp
         yl2+IGvVKP6/fuXhq3wTtJi/wl2LxiPlr0+qsplcEk47SHE3/2oskMHKbLuOwt/FiQ9L
         hA8w==
X-Gm-Message-State: AOAM5339xmE22kZiBTJJEwuCEBpHhUe5TX8UbdXag0togs9TMT8k+Lzn
        fVmMpUH68ChLqWsdYB0bhNYg9Fzzy9AYPw==
X-Google-Smtp-Source: ABdhPJzFp2tF3algELzEZAPluQpQTX15SRkw7UrcOYGtVBlgDmATvTVQVn8WveievaEr/G6mThILpQ==
X-Received: by 2002:a63:7107:: with SMTP id m7mr8369387pgc.287.1621578283528;
        Thu, 20 May 2021 23:24:43 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id a23sm2965473pjo.21.2021.05.20.23.24.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:24:42 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/2] tools/mgmt-tester: Add test cases for remove uuid command
Date:   Thu, 20 May 2021 23:24:41 -0700
Message-Id: <20210521062441.155117-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210521062441.155117-1-hj.tedd.an@gmail.com>
References: <20210521062441.155117-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds test cases for the Remove UUID command.
---
 tools/mgmt-tester.c | 143 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e3523dcd5..973e5966f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2534,6 +2534,65 @@ static const struct generic_data add_uuid_mix_test_1 = {
 	.expect_hci_len = sizeof(write_eir_uuid_mix_hci),
 };
 
+static const char remove_dun_uuid_param[] = {
+			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x03, 0x11, 0x00, 0x00 };
+
+static const char write_eir_remove_dun_hci[241] = {
+			0x00, 0x02, 0x0a, 0x00, 0x05, 0x03, 0x01, 0x11, 0x04,
+			0x11 };
+
+static const struct generic_data remove_uuid_success_1 = {
+	.send_opcode = MGMT_OP_REMOVE_UUID,
+	.send_param = remove_dun_uuid_param,
+	.send_len = sizeof(remove_dun_uuid_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_dev_class_zero_rsp,
+	.expect_len = sizeof(set_dev_class_zero_rsp),
+	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
+	.expect_hci_param = write_eir_remove_dun_hci,
+	.expect_hci_len = sizeof(write_eir_remove_dun_hci),
+};
+
+static const char remove_all_uuid_param[16] = { 0x00 };
+
+static const struct generic_data remove_uuid_all_success_2 = {
+	.send_opcode = MGMT_OP_REMOVE_UUID,
+	.send_param = remove_all_uuid_param,
+	.send_len = sizeof(remove_all_uuid_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_dev_class_zero_rsp,
+	.expect_len = sizeof(set_dev_class_zero_rsp),
+};
+
+static const struct generic_data remove_uuid_power_off_success_3 = {
+	.send_opcode = MGMT_OP_REMOVE_UUID,
+	.send_param = remove_dun_uuid_param,
+	.send_len = sizeof(remove_dun_uuid_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_dev_class_zero_rsp,
+	.expect_len = sizeof(set_dev_class_zero_rsp),
+};
+
+static const struct generic_data remove_uuid_power_off_on_success_4 = {
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_ssp_settings_param_2,
+	.expect_len = sizeof(set_ssp_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
+	.expect_hci_param = write_eir_remove_dun_hci,
+	.expect_hci_len = sizeof(write_eir_remove_dun_hci),
+};
+
+static const struct generic_data remove_uuid_invalid_params_1 = {
+	.send_opcode = MGMT_OP_REMOVE_UUID,
+	.send_param = add_opp_uuid_param,
+	.send_len = sizeof(add_opp_uuid_param),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
 static const char load_link_keys_valid_param_1[] = { 0x00, 0x00, 0x00 };
 static const char load_link_keys_valid_param_2[] = { 0x01, 0x00, 0x00 };
 static const char load_link_keys_invalid_param_1[] = { 0x02, 0x00, 0x00 };
@@ -5893,6 +5952,56 @@ static void setup_multi_uuid16(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
+static void setup_multi_uuid16_power_off(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding UUIDs without powering on");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_UUID, data->mgmt_index,
+				sizeof(add_spp_uuid_param), add_spp_uuid_param,
+				NULL, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_ADD_UUID, data->mgmt_index,
+				sizeof(add_dun_uuid_param), add_dun_uuid_param,
+				NULL, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_ADD_UUID, data->mgmt_index,
+			sizeof(add_sync_uuid_param), add_sync_uuid_param,
+			NULL, NULL, NULL);
+
+	setup_bthost();
+}
+
+static void setup_multi_uuid16_power_off_remove(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Adding UUIDs without powering on and remove UUID");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_UUID, data->mgmt_index,
+				sizeof(add_spp_uuid_param), add_spp_uuid_param,
+				NULL, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_ADD_UUID, data->mgmt_index,
+				sizeof(add_dun_uuid_param), add_dun_uuid_param,
+				NULL, NULL, NULL);
+	mgmt_send(data->mgmt, MGMT_OP_ADD_UUID, data->mgmt_index,
+			sizeof(add_sync_uuid_param), add_sync_uuid_param,
+			NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_REMOVE_UUID, data->mgmt_index,
+			sizeof(remove_dun_uuid_param), remove_dun_uuid_param,
+			NULL, NULL, NULL);
+
+	setup_bthost();
+}
+
 static void setup_multi_uuid16_2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -9817,6 +9926,40 @@ int main(int argc, char *argv[])
 				&add_uuid_mix_test_1,
 				setup_uuid_mix, test_command_generic);
 
+	/* MGMT_OP_REMOVE_UUID
+	 * Remove existing UUID.
+	 */
+	test_bredrle("Remove UUID - Success 1",
+				&remove_uuid_success_1,
+				setup_multi_uuid16, test_command_generic);
+	/* MGMT_OP_REMOVE_UUID
+	 * Remove all UUID by sending zero filled UUID
+	 */
+	test_bredrle("Remove UUID - All UUID - Success 2",
+				&remove_uuid_all_success_2,
+				setup_multi_uuid16, test_command_generic);
+	/* MGMT_OP_REMOVE_UUID
+	 * Remove UUID while powering off
+	 * Expect the 0x000000 for the class of device
+	 */
+	test_bredrle("Remove UUID - Power Off - Success 3",
+				&remove_uuid_power_off_success_3,
+				setup_multi_uuid16_power_off,
+				test_command_generic);
+	/* MGMT_OP_REMOVE_UUID
+	 * Remove UUID while powering off and then powering on
+	 */
+	test_bredrle("Remove UUID - Power Off and On - Success 4",
+				&remove_uuid_power_off_on_success_4,
+				setup_multi_uuid16_power_off_remove,
+				test_command_generic);
+	/* MGMT_OP_REMOVE_UUID
+	 * Remove UUID doesn't exist - Invalid parameter
+	 */
+	test_bredrle("Remove UUID - Not Exist - Invalid Params 1",
+				&remove_uuid_invalid_params_1,
+				setup_multi_uuid16, test_command_generic);
+
 	test_bredrle("Load Link Keys - Empty List Success 1",
 				&load_link_keys_success_test_1,
 				NULL, test_command_generic);
-- 
2.26.3

