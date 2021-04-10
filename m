Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98037C43460
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 06:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB336113A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 06:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhDJGqX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Apr 2021 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDJGqW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Apr 2021 02:46:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB6C061762
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Apr 2021 23:46:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r13so183650pjf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Apr 2021 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gz45JGs4mR9u24B1XODhzi38OZP4jIhRO+oFSa+kj1E=;
        b=sJdif7AouksV9sq1IuPofppXJI5KJ6qO8b2JAIGsP6VEoPJlLuOP1C0mW6sTGUwZ6W
         PsvsSi02bLrjgV+TdNWDbFeCyCJGXLKmCTAt5XI44jpT2SXICCCPXRHiv3uS0Fb5Z4YT
         wieGRztEiLNFnDdBAbYpOt2RSOuHcEpPdpPl2q2hpaBezzZfroHXfXsfsHBM1Nq4lUfM
         878fn7mHNTZ4MxdUcrbqhCRmTr01IbuWlv+mBLCVKZHTNrJo9MysLNrzCjK3trRrWmtV
         aYWrZbfnj8FtcMQaI0bFwzOHTchpAmyZnGa591s+NQrdBl9GC9hN4Tj8Ohple+mtjrPs
         wA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gz45JGs4mR9u24B1XODhzi38OZP4jIhRO+oFSa+kj1E=;
        b=hfLBeN40Tve02I/IbxAhjE5OyBjo/ut8ZFaRfM8s5fadpo9LzDcERCqEfKJrf713Zx
         8KRoYpQrAHbsuLGZmeNjWmT5Qwjp/j0UQMRAXZ0o29qTI3jiLMnmKTRzU4OyufEAC0Hd
         FbgeGaMdZ532gj/e4pQJle/wygeWTTVFX7nYt+kD92p67ebKYgizrlmxyaeCZo2M8uuI
         SKv+v9NhXfbs/S7ZlFQkcly3HUhh+MB//D4C279cAukZjIufe+qMRTz6dQoVelg3601Q
         7F2Y4QKuPKQ9bM6Fcz6vtSL2tg3H+NMee/iFt6Zc03blx+DoxYVD5Xq98sqloLuKLpvK
         1jEQ==
X-Gm-Message-State: AOAM5302D8ATqSnvgGkIpL8boTZBBe0x1VvUS/tBbF1vhHqQMkeeF7f5
        NXj3BlG+1gnz0Vxbkxiacxa2Dyt4xR0=
X-Google-Smtp-Source: ABdhPJwIOmLVU3KLKpUKZeuFbTxHPw40m6u520K8A/7m13xIPDNtte8eC+RR4SVSJNNVjb0Dzf8vKg==
X-Received: by 2002:a17:902:ea0c:b029:e9:8ae7:408f with SMTP id s12-20020a170902ea0cb02900e98ae7408fmr12404469plg.4.1618037167585;
        Fri, 09 Apr 2021 23:46:07 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:991a:5330:6700:5cc6])
        by smtp.gmail.com with ESMTPSA id i22sm1155929pfq.170.2021.04.09.23.46.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 23:46:07 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] tools/mgmt-tester: Add param check callback for LE Set Adv Params
Date:   Fri,  9 Apr 2021 23:46:05 -0700
Message-Id: <20210410064605.287884-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410064605.287884-1-hj.tedd.an@gmail.com>
References: <20210410064605.287884-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The interval_min and interval_max in LE Set Advertising Parameters
command are changed/updated often whenever the values are tuned in the
kernel, and it causes some tests failure.

This patch adds a parameter check callback for LE Set Advertising
Parameters command to ignore the interval_min and interval_max
parameters.
---
 tools/mgmt-tester.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index ef37f0e03..b05ae4f27 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -910,6 +910,20 @@ static uint8_t set_connectable_off_scan_adv_param[] = {
 		0x00,					/* filter_policy */
 };
 
+static int set_connectable_off_scan_adv_check_func(const void *param,
+								uint16_t length)
+{
+	const uint8_t *received = param;
+	uint8_t *expected = set_connectable_off_scan_adv_param;
+
+	/* Compare the received param with expected param, but ignore the
+	 * min_internal and max_interval since these values are turned often
+	 * in the kernel and we don't want to update the expected value every
+	 * time.
+	 */
+	return memcmp(&received[4], &expected[4], length - 4);
+}
+
 static const struct generic_data set_connectable_off_le_test_2 = {
 	.setup_settings = settings_powered_le_connectable_advertising,
 	.send_opcode = MGMT_OP_SET_CONNECTABLE,
@@ -922,6 +936,7 @@ static const struct generic_data set_connectable_off_le_test_2 = {
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_scan_adv_param,
 	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
+	.expect_hci_param_check_func = set_connectable_off_scan_adv_check_func
 };
 
 static uint16_t settings_powered_le_discoverable[] = {
@@ -949,6 +964,7 @@ static const struct generic_data set_connectable_off_le_test_3 = {
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_scan_adv_param,
 	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
+	.expect_hci_param_check_func = set_connectable_off_scan_adv_check_func
 };
 
 static const struct generic_data set_connectable_off_le_test_4 = {
@@ -964,6 +980,7 @@ static const struct generic_data set_connectable_off_le_test_4 = {
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_scan_adv_param,
 	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
+	.expect_hci_param_check_func = set_connectable_off_scan_adv_check_func
 };
 
 static const char set_fast_conn_on_param[] = { 0x01 };
@@ -4750,6 +4767,7 @@ static const struct generic_data add_advertising_success_13 = {
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_scan_adv_param,
 	.expect_hci_len = sizeof(set_connectable_off_scan_adv_param),
+	.expect_hci_param_check_func = set_connectable_off_scan_adv_check_func
 };
 
 static uint8_t set_connectable_off_adv_param[] = {
@@ -4763,6 +4781,20 @@ static uint8_t set_connectable_off_adv_param[] = {
 		0x00,					/* filter_policy */
 };
 
+static int set_connectable_off_adv_check_func(const void *param,
+								uint16_t length)
+{
+	const uint8_t *received = param;
+	uint8_t *expected = set_connectable_off_adv_param;
+
+	/* Compare the received param with expected param, but ignore the
+	 * min_internal and max_interval since these values are turned often
+	 * in the kernel and we don't want to update the expected value every
+	 * time.
+	 */
+	return memcmp(&received[4], &expected[4], length - 4);
+}
+
 static const struct generic_data add_advertising_success_14 = {
 	.setup_settings = settings_powered_le,
 	.send_opcode = MGMT_OP_ADD_ADVERTISING,
@@ -4774,6 +4806,7 @@ static const struct generic_data add_advertising_success_14 = {
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_adv_param,
 	.expect_hci_len = sizeof(set_connectable_off_adv_param),
+	.expect_hci_param_check_func = set_connectable_off_adv_check_func
 };
 
 static const struct generic_data add_advertising_success_15 = {
@@ -4814,6 +4847,7 @@ static const struct generic_data add_advertising_success_17 = {
 	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
 	.expect_hci_param = set_connectable_off_adv_param,
 	.expect_hci_len = sizeof(set_connectable_off_adv_param),
+	.expect_hci_param_check_func = set_connectable_off_adv_check_func
 };
 
 static const char set_powered_off_le_settings_param[] = {
-- 
2.25.1

