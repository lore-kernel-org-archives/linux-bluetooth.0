Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A414C4708B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C436142C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhEZAV7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 20:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhEZAV6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 20:21:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072E7C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:20:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j12so24094805pgh.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V9FyyF9jdSeK5S3rBQkL/uwGCuTX2AyYnA3Dlag4pLU=;
        b=o0hQdpviZ+/D9Iy9GBB1+G24XY8SIu+HGzr+Z7GJHfpTtcRzQ4tlIT3rvCNhamykPM
         RUeSju/8N2rl+Ji7TyFK7Q4SwvrHPipy6e9fhOE2FspzKRQPqsdqxiJ8z62+GH2SxYwG
         yqBLk8R0bAudMEXTdzIpwieVRir6y0x1CC+DkCRSFkRXEs2vsfpAnet8ZtWi7BSFHlU8
         rFgauesUO+x+XYZhiQKi5N/QnshjpD9nVW5MENnoFffWH/AHVeRbCvdKY2vFuxHH/jFM
         94ySlgqh0a6D5UtGrUhxr86JCuxMfMGK6iqEirzEIniPb/B4gVXkHBN3S/L4YzivpYEK
         Iraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9FyyF9jdSeK5S3rBQkL/uwGCuTX2AyYnA3Dlag4pLU=;
        b=hGrEjk1dTCy6HKCy+K9ThRvPKKhEXo9+exh6w+xItccOkmHTgSorD7uiJ5ZDNSviAk
         iShVB2ofP/enbdkrDQFMX8GKM44nvwWl5R1uEc58AEoksjOFGJ5NCMJV8+wkfmhQLwm+
         HlgmTCiesdlvs7U2O791sVBOg2qjcNPgIBhA6+eIxGJ5kvaBlaXgz4TbZF6DCMCviLhb
         TdhcuwGsWMOLFqtwOHMLkUeYtiLxKDr1XLYiPEoC0Z08zoxLMcEhM+9Y3NVjKJ0aW3Kq
         wRA27FPttNBONoRt+dlkSB4Op1pSCQ0zJVc0YqCUgCGrCJFP7BQGDKEiH4rUIYXPwPqB
         UKBQ==
X-Gm-Message-State: AOAM5325UUl1CJ7fQNS48trnz66GabjyL5unS3QUxGJb2o2FUFjIhYaY
        GohbdGayhoeYON/h2vgPoQdRcphtAiCNnQ==
X-Google-Smtp-Source: ABdhPJxWUhokg6NARyG6GG+1cO3yEecMGVm8/1RsW7Al8RK+kXBmXRJuhU8R1nO9G2V5N4WONwOV4g==
X-Received: by 2002:a65:5248:: with SMTP id q8mr21625101pgp.176.1621988427345;
        Tue, 25 May 2021 17:20:27 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id t19sm14305726pfq.116.2021.05.25.17.20.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 17:20:26 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 4/4] tools/mgmt-tester: Add test cases for get/set device flags
Date:   Tue, 25 May 2021 17:20:24 -0700
Message-Id: <20210526002024.412237-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210526002024.412237-1-hj.tedd.an@gmail.com>
References: <20210526002024.412237-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds test cases for get/set device flags commands.
---
 tools/mgmt-tester.c | 182 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 767e010a6..4550d6e9c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8990,6 +8990,140 @@ static void setup_phy_configuration(const void *test_data)
 				NULL, NULL);
 }
 
+static const uint8_t get_dev_flags_param[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+};
+
+static const uint8_t get_dev_flags_rsp_param[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+	0x01, 0x00, 0x00, 0x00,			/* Supported Flages */
+	0x00, 0x00, 0x00, 0x00,			/* Current Flages */
+};
+
+static const struct generic_data get_dev_flags_success = {
+	.send_opcode = MGMT_OP_GET_DEVICE_FLAGS,
+	.send_param = get_dev_flags_param,
+	.send_len = sizeof(get_dev_flags_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = get_dev_flags_rsp_param,
+	.expect_len = sizeof(get_dev_flags_rsp_param),
+};
+
+static const uint8_t get_dev_flags_param_fail_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+};
+
+static const struct generic_data get_dev_flags_fail_1 = {
+	.send_opcode = MGMT_OP_GET_DEVICE_FLAGS,
+	.send_param = get_dev_flags_param_fail_1,
+	.send_len = sizeof(get_dev_flags_param_fail_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static void setup_get_dev_flags(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+	const unsigned char *add_param;
+	size_t add_param_len;
+
+	tester_print("Powering on controller (with added device)");
+
+	if (data->hciemu_type == HCIEMU_TYPE_LE) {
+		add_param = add_device_success_param_2;
+		add_param_len = sizeof(add_device_success_param_2);
+	} else {
+		add_param = add_device_success_param_1;
+		add_param_len = sizeof(add_device_success_param_1);
+	}
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+			add_param_len, add_param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+static const uint8_t set_dev_flags_param[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+	0x01, 0x00, 0x00, 0x00,			/* Current Flages */
+};
+
+static const uint8_t set_dev_flags_rsp_param[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+};
+
+static const uint8_t dev_flags_changed_param[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+	0x01, 0x00, 0x00, 0x00,			/* Supported Flages */
+	0x01, 0x00, 0x00, 0x00,			/* Current Flages */
+};
+
+static const struct generic_data set_dev_flags_success = {
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_dev_flags_param,
+	.send_len = sizeof(set_dev_flags_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_dev_flags_rsp_param,
+	.expect_len = sizeof(set_dev_flags_rsp_param),
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = dev_flags_changed_param,
+	.expect_alt_ev_len = sizeof(dev_flags_changed_param),
+};
+
+static const uint8_t set_dev_flags_param_fail_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+};
+
+static const struct generic_data set_dev_flags_fail_1 = {
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_dev_flags_param_fail_1,
+	.send_len = sizeof(set_dev_flags_param_fail_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const uint8_t set_dev_flags_param_fail_2[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+	0x03, 0x00, 0x00, 0x00,			/* Current Flages */
+};
+
+static const struct generic_data set_dev_flags_fail_2 = {
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_dev_flags_param_fail_2,
+	.send_len = sizeof(set_dev_flags_param_fail_2),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = set_dev_flags_rsp_param,
+	.expect_len = sizeof(set_dev_flags_rsp_param),
+};
+
+static const uint8_t set_dev_flags_param_fail_3[] = {
+	0x11, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+	0x01, 0x00, 0x00, 0x00,			/* Current Flages */
+};
+
+static const uint8_t set_dev_flags_rsp_param_fail_3[] = {
+	0x11, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
+	0x00,					/* Type */
+};
+
+static const struct generic_data set_dev_flags_fail_3 = {
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_dev_flags_param_fail_3,
+	.send_len = sizeof(set_dev_flags_param_fail_3),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+	.expect_param = set_dev_flags_rsp_param_fail_3,
+	.expect_len = sizeof(set_dev_flags_rsp_param_fail_3),
+};
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -11010,5 +11144,53 @@ int main(int argc, char *argv[])
 				NULL,
 				test_command_generic);
 
+	/* MGMT_OP_GET_DEVICE_FLAGS
+	 * Success
+	 */
+	test_bredrle50("Get Device Flags - Success",
+				&get_dev_flags_success,
+				setup_get_dev_flags,
+				test_command_generic);
+
+	/* MGMT_OP_GET_DEVICE_FLAGS
+	 * Fail - Invalid parameter
+	 */
+	test_bredrle50("Get Device Flags - Invalid Parameter",
+				&get_dev_flags_fail_1,
+				setup_get_dev_flags,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_FLAGS
+	 * Success
+	 */
+	test_bredrle50("Set Device Flags - Success",
+				&set_dev_flags_success,
+				setup_get_dev_flags,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_FLAGS
+	 * Invalid Parameter - Missing parameter
+	 */
+	test_bredrle50("Set Device Flags - Invalid Parameter 1",
+				&set_dev_flags_fail_1,
+				setup_get_dev_flags,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_FLAGS
+	 * Invalid Parameter - Not supported value
+	 */
+	test_bredrle50("Set Device Flags - Invalid Parameter 2",
+				&set_dev_flags_fail_2,
+				setup_get_dev_flags,
+				test_command_generic);
+
+	/* MGMT_OP_SET_DEVICE_FLAGS
+	 * Device not exist
+	 */
+	test_bredrle50("Set Device Flags - Device not found",
+				&set_dev_flags_fail_3,
+				setup_get_dev_flags,
+				test_command_generic);
+
 	return tester_run();
 }
-- 
2.26.3

