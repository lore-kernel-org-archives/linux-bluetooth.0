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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4CAC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 06:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B68F613BB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 06:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhEUG0H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 02:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhEUG0G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 02:26:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C2C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 23:24:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u7so1852753plq.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGe4rS+ZCBBmZdyzIKwWth7aSA57alM2esDsZUbFARY=;
        b=njFcnQ00L7iinHMmDgaixGJwBx54FviEHv5Vk+FIpV7UveIUKlo6gawhhpcgneRr8L
         VMWCubYrLp2MCDugQAs6EeWFQp/FvS/iN0J1/VoDnWHQ2j2450PrgsEb7jSPXUXJoXju
         EIq+U5fh3QpL2anv6k2EphWTnl8trqvTKizQqyq4eogXuwUMYsCHgzbVL5gVq4zCYLeo
         MiEYmU0yxnCICqZn1r+sXHcNfIEbifytfPURJO76zs0q0fbH8mDcl+h79dwdpFSF3ZI9
         JUDj+szBj0f6lDgDssH3pAQdP4xgEuvN9J105BIvodJkwy43cHazQ4/BefAZkx8m1pRG
         tSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGe4rS+ZCBBmZdyzIKwWth7aSA57alM2esDsZUbFARY=;
        b=pk+O9SE57Lr6CSLrHx0nuJlxbwqdNfocNmxVASu8y47lFBX4f3nfyOm2JoJWqrK0gz
         PY4NONY4n46ttx4w2XiU+Q16kvbRoS36ElrLLUU2sTqKLfahO8xQJVwUte/MyzLXa74y
         t0nOeocUjFGigMAHrsxgCXWJRLOP+YiELEDGc3f2zzjCG/V6SyhtknUCyleLt3Zard9W
         /eyIizL+UlP1pNTS+TsWF1JMdX/HToahpiwoCbLZeY+lM1JYK9ZPsaH6YSTtN0czpYuq
         UublQ0HrsW8n4nkG/t9hFm4Mz2CJyIACFp/OzHVeIgdTuuSe0A6v7GtgxsEYF/chYaPZ
         g2ng==
X-Gm-Message-State: AOAM531UefxI+P96f9ueZZubVmisKyeML9gyEEXPlHBPIn09NKMwsshk
        eP8AKXMCfR29Ty9GLMTEjvEJ6mqDwpA1Rg==
X-Google-Smtp-Source: ABdhPJy/LkZsJU58GHUY5bIqcj3B6b0y0F2RGm4XaNe3Nzfu5oCwHJKhS49/nWL38eMUgL6hcRgulw==
X-Received: by 2002:a17:90a:520f:: with SMTP id v15mr9019390pjh.23.1621578282366;
        Thu, 20 May 2021 23:24:42 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id a23sm2965473pjo.21.2021.05.20.23.24.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:24:41 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/2] tools/mgmt-tester: Add test cases for set device id command
Date:   Thu, 20 May 2021 23:24:40 -0700
Message-Id: <20210521062441.155117-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds test cases for the Set Device ID command.
---
 tools/mgmt-tester.c | 163 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index de35008ad..e3523dcd5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5506,6 +5506,119 @@ static const struct generic_data adv_data_invalid_params = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const uint8_t set_dev_id_param_success_1[] = {
+	0x01, /* Source - 0x0001 (Bluetooth SIG) */
+	0x00,
+	0x02, /* Vendor */
+	0x00,
+	0xcd, /* Product */
+	0xab,
+	0x34,
+	0x12, /* Version */
+};
+
+static const char write_eir_set_dev_id_success_1[241] = {
+			0x00, 0x02, 0x0a, 0x00, 0x09, 0x10, 0x01, 0x00,
+			0x02, 0x00, 0xcd, 0xab, 0x34, 0x12 };
+
+static const struct generic_data set_dev_id_success_1 = {
+	.setup_settings = settings_powered_ssp,
+	.send_opcode = MGMT_OP_SET_DEVICE_ID,
+	.send_param = set_dev_id_param_success_1,
+	.send_len = sizeof(set_dev_id_param_success_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
+	.expect_hci_param = write_eir_set_dev_id_success_1,
+	.expect_hci_len = sizeof(write_eir_set_dev_id_success_1),
+};
+
+static const uint8_t set_dev_id_param_success_2[] = {
+	0x02, /* Source - 0x0001 (Bluetooth SIG) */
+	0x00,
+	0x02, /* Vendor */
+	0x00,
+	0xcd, /* Product */
+	0xab,
+	0x34,
+	0x12, /* Version */
+};
+static const char write_eir_set_dev_id_success_2[241] = {
+			0x00, 0x02, 0x0a, 0x00, 0x09, 0x10, 0x02, 0x00,
+			0x02, 0x00, 0xcd, 0xab, 0x34, 0x12 };
+
+static const struct generic_data set_dev_id_success_2 = {
+	.setup_settings = settings_powered_ssp,
+	.send_opcode = MGMT_OP_SET_DEVICE_ID,
+	.send_param = set_dev_id_param_success_2,
+	.send_len = sizeof(set_dev_id_param_success_2),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
+	.expect_hci_param = write_eir_set_dev_id_success_2,
+	.expect_hci_len = sizeof(write_eir_set_dev_id_success_2),
+};
+
+static const uint8_t set_dev_id_param_disable[8] = { 0x00 };
+
+static const struct generic_data set_dev_id_disable = {
+	.setup_settings = settings_powered_ssp,
+	.send_opcode = MGMT_OP_SET_DEVICE_ID,
+	.send_param = set_dev_id_param_disable,
+	.send_len = sizeof(set_dev_id_param_disable),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const struct generic_data set_dev_id_power_off_on = {
+	.setup_settings = settings_ssp,
+	.setup_send_opcode = MGMT_OP_SET_DEVICE_ID,
+	.setup_send_param = set_dev_id_param_success_1,
+	.setup_send_len = sizeof(set_dev_id_param_success_1),
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_ssp_settings_param_2,
+	.expect_len = sizeof(set_ssp_settings_param_2),
+	.expect_settings_set = MGMT_SETTING_POWERED,
+	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
+	.expect_hci_param = write_eir_set_dev_id_success_1,
+	.expect_hci_len = sizeof(write_eir_set_dev_id_success_1),
+};
+
+static const struct generic_data set_dev_id_ssp_off_on = {
+	.setup_settings = settings_powered,
+	.setup_send_opcode = MGMT_OP_SET_DEVICE_ID,
+	.setup_send_param = set_dev_id_param_success_1,
+	.setup_send_len = sizeof(set_dev_id_param_success_1),
+	.send_opcode = MGMT_OP_SET_SSP,
+	.send_param = set_ssp_on_param,
+	.send_len = sizeof(set_ssp_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_ssp_settings_param_2,
+	.expect_len = sizeof(set_ssp_settings_param_2),
+	.expect_hci_command = BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE,
+	.expect_hci_param = write_eir_set_dev_id_success_1,
+	.expect_hci_len = sizeof(write_eir_set_dev_id_success_1),
+};
+
+static const uint8_t set_dev_id_invalid_1[] = {
+	0x03, /* Source */
+	0x00,
+	0x02, /* Vendor */
+	0x00,
+	0xcd, /* Product */
+	0xab,
+	0x34,
+	0x12, /* Version */
+};
+
+static const struct generic_data set_dev_id_invalid_param = {
+	.setup_settings = settings_powered_ssp,
+	.send_opcode = MGMT_OP_SET_DEVICE_ID,
+	.send_param = set_dev_id_invalid_1,
+	.send_len = sizeof(set_dev_id_invalid_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -10697,5 +10810,55 @@ int main(int argc, char *argv[])
 				setup_ext_adv_params,
 				test_command_generic);
 
+	/* MGMT_OP_SET_DEVICE_ID
+	 * Using Bluetooth SIG for source.
+	 */
+	test_bredrle50("Set Device ID - Success 1",
+				&set_dev_id_success_1,
+				NULL,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_ID
+	 * Using SB Implementer's Forum for source.
+	 */
+	test_bredrle50("Set Device ID - Success 2",
+				&set_dev_id_success_2,
+				NULL,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_ID
+	 * Disable DID with disable flag for source.
+	 */
+	test_bredrle50("Set Device ID - Disable",
+				&set_dev_id_disable,
+				NULL,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_ID
+	 * Power off, set device id, and power on.
+	 * Expect Write_Extended_Inquiry with device id when power on.
+	 */
+	test_bredrle50("Set Device ID - Power off and Power on",
+				&set_dev_id_power_off_on,
+				setup_command_generic,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_ID
+	 * SSP off, set device id, and SSP on.
+	 * Expect Write_Extended_Inquiry with device id when SSP on.
+	 */
+	test_bredrle50("Set Device ID - SSP off and Power on",
+				&set_dev_id_ssp_off_on,
+				setup_command_generic,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_ID
+	 * Invalid parameter
+	 */
+	test_bredrle50("Set Device ID - Invalid Parameter",
+				&set_dev_id_invalid_param,
+				NULL,
+				test_command_generic);
+
 	return tester_run();
 }
-- 
2.26.3

