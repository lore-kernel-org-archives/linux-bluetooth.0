Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23345C47082
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7A6613CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 05:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhEZFPB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 May 2021 01:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEZFOq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 May 2021 01:14:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8DC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y202so77262pfc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 22:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V9FyyF9jdSeK5S3rBQkL/uwGCuTX2AyYnA3Dlag4pLU=;
        b=UugGpP2oZDST6ydnEIlcE+mtcrln3MaHc9maNyssOuoAcGdbFa9tSt71nJhPImzx/V
         pRloNgvV854VrJkf055zkFJzUq7CTXqvFC5jKqjuF1wzpbf830oykh+q7w5p66V40WCR
         TGWuRhyt4fW3EgDHeOtqTuAtgfsHo+t75CSWBSEE22BDLhm1fSeETZQ/OBP2oLeeKHv7
         097CdUf2RM/+nLnNynCTgscbAee4xLkH1G/EzIutTNEK7K71cwP72VapmUg4GKiPU43M
         7pDQAMCtdwR7fj0r5J0RnAFou1H/zyAhxrwVKZevNCNvhWxMULxApHIw42pffw4XKEaf
         auwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9FyyF9jdSeK5S3rBQkL/uwGCuTX2AyYnA3Dlag4pLU=;
        b=Nbilu5iccasGL4QQ3HXMoH7pGR5A+ugWIiZTxSYZmE2n7ZvLTUqkVK8k2M+9rE9wD7
         3y0tBXND9sWL3g10cuYKuO8j8Za34cz6xVaws+T/8vSf0YlgsQOfISe/lNw5QBm5Dtng
         CglaevJd5wTGub0gkJeDC+AXLEx4XZMcanFdzWWqxyvLLDB0YwtD5Mh31s7LGA5j18II
         HrQaS5Myw2yA6VAqNbve4mHKwfS1gl61BulTQiaYIxTrzRIja1rblpoVvVWLmFQ+Bnkt
         uTV4cYDpiBB+bccghq8SYs+l00q1T6Ew4zqF4OmNA+0NzaMSEBZqE25prjJjrELroneT
         xX1w==
X-Gm-Message-State: AOAM531vbBDPyFdgWWDU/8RU/dohXcaXGUadOw5dm7UanW8RCEnF7NsN
        RkGCL49QslBGwnzMFZXmRmuq2fpEgypMRQ==
X-Google-Smtp-Source: ABdhPJwC5hCzIUnuG/gXpqGiUq0/fLrYxxwqI+H4PwuehJk9zqdD6SkMMWT5SqEU/7ZXbirZ9/zntg==
X-Received: by 2002:a65:68d4:: with SMTP id k20mr11376463pgt.442.1622005995223;
        Tue, 25 May 2021 22:13:15 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id h8sm13865944pfv.60.2021.05.25.22.13.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 22:13:14 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH V2 4/4] tools/mgmt-tester: Add test cases for get/set device flags
Date:   Tue, 25 May 2021 22:13:10 -0700
Message-Id: <20210526051310.423630-4-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210526051310.423630-1-hj.tedd.an@gmail.com>
References: <20210526051310.423630-1-hj.tedd.an@gmail.com>
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

