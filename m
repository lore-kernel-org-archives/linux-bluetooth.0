Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3C0C63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E264206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 17:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPj24FnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbgKXRbr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 12:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgKXRbq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 12:31:46 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5A6C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:31:46 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id z129so5087548qkb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fMZvC2e8DdkNbFAMDgQGil84VDaU0e9nObrLBBeq6yU=;
        b=WPj24FnMbNfyT0nCCKzSXT4qxm2TkvWaYhDYmb7kAsryAjYfeyynBjG3h8UoFykrzT
         0bYmmX2rsVgO/bYOz5Av7aDf63r7y4n0Xf61eWMtgEO3haiayZZrKCzZwDGaXb9LdCPV
         r9s4BOBfGRr8rLEIHGzOdvkYS4Dct7QZNdVYtpsY+hpnb6cNG25aOiEy71X6HeUYuMxb
         8iwFe9SysBxBJEER2RBX/WzTjTxlTJqGFWkmi65ezOF1xJWvLMWJk1DnDbgQSQc9pfQU
         XVPdQcIoFe44sGJtEZS0LA6XBwtAm+QXiaa1rpubpGg9QdpjaobAmSDrolM9h5atVAgk
         e6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fMZvC2e8DdkNbFAMDgQGil84VDaU0e9nObrLBBeq6yU=;
        b=KgwtoRacSXt7DO7bkFjtdraTaQmTLkZlIxIZSWtW0qfchKT8QtySlLLych3p8mjbFU
         o42eHUoe7Aj9Pivp/KlJ2uluQlsHIPqyP4uRXUiEe8tkg4EMMaG6rwhKWfPOkpptxedS
         YmHk5s6v/ZafHxoGucL6sC3nDK4TXTkMx8s/k8uLQFeZBwoKXstfw8OUjjZ8it0u6GsO
         Cv+3VEmr+gLkuB46fnWzkMsUEfg1U9qFk3IfCpzsNGBOmEDC1xK572QVis9oa24+HanT
         bqBJXp8wbZ+GyirsCvITtrKmsNBCGeVfCJqXR63+znLnleUnI8V9Elx8NRP9wkqZ7g7u
         fH5A==
X-Gm-Message-State: AOAM532NNeLWmcmb+jdrd9mw/Vyj8o+jf1yp0pDl4f0EmHvG1YGvPIcS
        5oDxLz88TLL6PjaG1ICXZ7QVXmbWmWDsguZImqJS
X-Google-Smtp-Source: ABdhPJyb/Wpq/C1KZ64T4ITzi1fbPTA+h4DzQbYIoRV0CHlPRz3LBFGn/Hpo1IprkxvTJeM8ZrwMsVY6UQIPzBM3GrKe
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:d0d3:: with SMTP id
 h202mr7238495ybg.405.1606239105837; Tue, 24 Nov 2020 09:31:45 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:31:22 -0800
In-Reply-To: <20201124173123.1272892-1-danielwinkler@google.com>
Message-Id: <20201124092549.Bluez.1.Ia11a74cda6aa978ddd357bd37b1f9b0a363ba8bf@changeid>
Mime-Version: 1.0
References: <20201124173123.1272892-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [Bluez PATCH 1/2] tools/mgmt-tester: Add mgmt-tester coverage for
 controller capabilities
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds two test cases for the new Read Controller
Capabilities MGMT command. Since the command itself is simple, the test
cases are simple as well:

1. Ensures that providing invalid parameters to the request will result
in a failed MGMT response.

2. Ensures that if the controller is BT5 compliant, the Read Controller
Capabilities command will return a valid TX power range as expected,
otherwise fail.

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

 tools/mgmt-tester.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 0540efafc..79e653e9e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5269,6 +5269,19 @@ static const struct generic_data read_ext_ctrl_info5 = {
 	.expect_len = sizeof(ext_ctrl_info5),
 };
 
+static const struct generic_data read_controller_cap_invalid_param_test = {
+	.send_opcode = MGMT_OP_READ_CONTROLLER_CAP,
+	.send_param = dummy_data,
+	.send_len = sizeof(dummy_data),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const struct generic_data read_controller_cap_success = {
+	.send_opcode = MGMT_OP_READ_CONTROLLER_CAP,
+	.expect_ignore_param = true,
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -8762,6 +8775,61 @@ static void test_connected_and_advertising(const void *test_data)
 						data, NULL);
 }
 
+static void read_50_controller_cap_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = user_data;
+	const struct mgmt_rp_read_controller_cap *rp = param;
+	const uint8_t *ptr = rp->cap;
+	size_t offset = 0;
+	uint8_t tag_len;
+	uint8_t tag_type;
+
+	if (status || !param) {
+		tester_warn("Failed to read advertising features: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		tester_test_failed();
+	}
+
+	if (sizeof(rp->cap_len) + rp->cap_len != length) {
+		tester_warn("Controller capabilities malformed, size %lu != %u",
+				sizeof(rp->cap_len) + rp->cap_len, length);
+		tester_test_failed();
+	}
+
+	while (offset < rp->cap_len) {
+		tag_len = ptr[offset++];
+		tag_type = ptr[offset++];
+
+		switch (tag_type) {
+		case MGMT_CAP_LE_TX_PWR:
+			if ((tag_len - sizeof(tag_type)) != 2) {
+				tester_warn("TX power had unexpected length %d",
+					tag_len);
+				break;
+			}
+			tester_print("Expected Tx Power discovered: %d-%d",
+					ptr[offset], ptr[offset+1]);
+			test_condition_complete(data);
+		}
+
+		/* Step to the next entry */
+		offset += (tag_len - sizeof(tag_type));
+	}
+}
+
+static void test_50_controller_cap_response(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	test_add_condition(data);
+
+	mgmt_send(data->mgmt_alt, MGMT_OP_READ_CONTROLLER_CAP, data->mgmt_index,
+						0, NULL,
+						read_50_controller_cap_complete,
+						data, NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -10216,5 +10284,13 @@ int main(int argc, char *argv[])
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
+	test_bredrle("Read Controller Capabilities - Invalid parameters",
+				&read_controller_cap_invalid_param_test,
+				NULL, test_command_generic);
+
+	test_bredrle50("Read Controller Capabilities - (5.0) Success",
+				&read_controller_cap_success,
+				NULL, test_50_controller_cap_response);
+
 	return tester_run();
 }
-- 
2.29.2.454.gaff20da3a2-goog

