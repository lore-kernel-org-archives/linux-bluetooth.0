Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D6C761AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 06:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjC3GIM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjC3GIL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 02:08:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D855AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:08:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t12-20020a65608c000000b005091ec4f2d4so5156917pgu.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680156489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKMfx70vP8aOdUGwEndKdp+7fg6o7JbmUDyHHJ9sQSs=;
        b=b57nSnAUXIXdYRos2BqkofyrDsYfiAjm1itPtpNJY5/0ymuFjJJpqPv6o9GVuCWBjH
         f2risgO/BMoX+OH1EbKij3eKhwXmfNiv0oTwzmx5VAJ6ejIOuuLaC8OnMZDBWUZcQDsz
         hgpiwr7UJjPtJLcLg5Ewi39BO9PHPvgGgtGfe7nxWNvKBqwXcFFXTHc13IbUJoJOTGmo
         aKluRX5iaJYXazzS3wkYdqaS0GDOE2wfaHHu1FDByAwdIe7wvZw8EERhhjYyktx/ThIN
         XCfMfnr5aBu0WTaKzzbBu01yOjBGFOtVtZXoIbVSAwuoZOMg6/LwNRGfoz+mlz2Qctjk
         NM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKMfx70vP8aOdUGwEndKdp+7fg6o7JbmUDyHHJ9sQSs=;
        b=jRVORreQvweEJ0i8bFmxDBpZ0Z24vdKtfyj0O1q2VF5HpVM6wBMHYEByHcwWz/RAl/
         eRfLKHkCeregJfJlqyQG3czNuR7OxjImXQjEAmkVHxH289izNwzkgX0i5bBldr9ZLrrE
         e46DobdkcNKw7SWbQYCwsBfrFS3fZSCqjqYditNqN8/fO5ieH/+5F/80SxlGyijjw50P
         a229aANIFnNsOCBiNC+Cs5bwIVPEt7KDl1kUYH/dqC/thOxIWOTfL3pS1NzLLzmRlryA
         8UAcuuFp3VsHLtyeeQx4rLuJNqlgUggtb4rzFAifNeUamGYaiLiE0TRgWDUvoUBUTpkI
         Rqkw==
X-Gm-Message-State: AAQBX9eYRbMCDmTMjYGln4dWlVFPGD/pU9ckCgqbvbj3WRno2Ri3UrlL
        IToIKRBwc7r5+5yTRp5KDrT8/vF8cmaF7w==
X-Google-Smtp-Source: AKy350bvryDCxkdoT/6T2nZDjHmYb8Nqyr77x2IN3iAoIn/l6bYgoph+1vKfVCt7j910RgD6epNOlYVVWkn54A==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:c8f:b0:240:18c9:66ba with SMTP id
 v15-20020a17090a0c8f00b0024018c966bamr6616394pja.6.1680156488932; Wed, 29 Mar
 2023 23:08:08 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:08:03 -0700
In-Reply-To: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Mime-Version: 1.0
References: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230329230734.BlueZ.v5.2.I6b8d9794fa661c63824306ccc8eecf6479040b1a@changeid>
Subject: [BlueZ PATCH v5 2/2] mgmt-tester: Add devcoredump tests
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add mgmt-tester tests for hci devcoredump. These testa trigger the
devcoredump with a test data and verifies the generated devcoredump
file for the test data and correct devcoredump header fields.

---

Changes in v5:
- Refactor test_hci_devcd()
- Add tests for devcoredump abort and timeout

Changes in v4:
- New patch in the series

 tools/mgmt-tester.c | 173 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a56c38173..1a8cff999 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -290,6 +290,20 @@ static void index_removed_callback(uint16_t index, uint16_t length,
 	tester_post_teardown_complete();
 }
 
+#define MAX_COREDUMP_LINE_LEN	40
+
+struct devcoredump_test_data {
+	enum devcoredump_state {
+		HCI_DEVCOREDUMP_IDLE,
+		HCI_DEVCOREDUMP_ACTIVE,
+		HCI_DEVCOREDUMP_DONE,
+		HCI_DEVCOREDUMP_ABORT,
+		HCI_DEVCOREDUMP_TIMEOUT,
+	} state;
+	unsigned int timeout;
+	char data[MAX_COREDUMP_LINE_LEN];
+};
+
 struct hci_cmd_data {
 	uint16_t opcode;
 	uint8_t len;
@@ -362,6 +376,8 @@ struct generic_data {
 	bool set_adv;
 	const uint8_t *adv_data;
 	uint8_t adv_data_len;
+	const struct devcoredump_test_data *dump_data;
+	const char (*expect_dump_data)[MAX_COREDUMP_LINE_LEN];
 };
 
 static const uint8_t set_exp_feat_param_debug[] = {
@@ -12511,6 +12527,139 @@ static void test_suspend_resume_success_10(const void *test_data)
 	tester_wait(2, trigger_force_resume, NULL);
 }
 
+#define MAX_COREDUMP_BUF_LEN	512
+
+static const struct devcoredump_test_data data_complete_dump = {
+	.state = HCI_DEVCOREDUMP_DONE,
+	.data = "test data",
+};
+
+static const char expected_complete_dump[][MAX_COREDUMP_LINE_LEN] = {
+	"Bluetooth devcoredump",
+	"State: 2",
+	"Controller Name: vhci_ctrl",
+	"Firmware Version: vhci_fw",
+	"Driver: vhci_drv",
+	"Vendor: vhci",
+	"--- Start dump ---",
+	"", /* end of header data */
+};
+
+static const struct generic_data dump_complete = {
+	.dump_data = &data_complete_dump,
+	.expect_dump_data = expected_complete_dump,
+};
+
+static const struct devcoredump_test_data data_abort_dump = {
+	.state = HCI_DEVCOREDUMP_ABORT,
+	.data = "test data",
+};
+
+static const char expected_abort_dump[][MAX_COREDUMP_LINE_LEN] = {
+	"Bluetooth devcoredump",
+	"State: 3",
+	"Controller Name: vhci_ctrl",
+	"Firmware Version: vhci_fw",
+	"Driver: vhci_drv",
+	"Vendor: vhci",
+	"--- Start dump ---",
+	"", /* end of header data */
+};
+
+static const struct generic_data dump_abort = {
+	.dump_data = &data_abort_dump,
+	.expect_dump_data = expected_abort_dump,
+};
+
+static const struct devcoredump_test_data data_timeout_dump = {
+	.state = HCI_DEVCOREDUMP_TIMEOUT,
+	.timeout = 1,
+	.data = "test data",
+};
+
+static const char expected_timeout_dump[][MAX_COREDUMP_LINE_LEN] = {
+	"Bluetooth devcoredump",
+	"State: 4",
+	"Controller Name: vhci_ctrl",
+	"Firmware Version: vhci_fw",
+	"Driver: vhci_drv",
+	"Vendor: vhci",
+	"--- Start dump ---",
+	"", /* end of header data */
+};
+
+static const struct generic_data dump_timeout = {
+	.dump_data = &data_timeout_dump,
+	.expect_dump_data = expected_timeout_dump,
+};
+
+static void verify_devcd(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+	char buf[MAX_COREDUMP_BUF_LEN] = {0};
+	char delim[] = "\n";
+	char *line;
+	char *saveptr;
+	int i = 0;
+
+	/* Read the generated devcoredump file */
+	if (vhci_read_devcd(vhci, buf, sizeof(buf)) <= 0) {
+		tester_warn("Unable to read devcoredump");
+		tester_test_failed();
+		return;
+	}
+
+	/* Verify if all devcoredump header fields are present */
+	line = strtok_r(buf, delim, &saveptr);
+	while (strlen(test->expect_dump_data[i])) {
+		if (!line || strcmp(line, test->expect_dump_data[i])) {
+			tester_warn("Incorrect coredump data: %s (expected %s)",
+					line, test->expect_dump_data[i]);
+			tester_test_failed();
+			return;
+		}
+
+		if (!strcmp(strtok(line, ":"), "State")) {
+			/* After updating the devcoredump state, the HCI
+			 * devcoredump API adds a `\0` at the end. Skip it
+			 * before reading the next line.
+			 */
+			saveptr++;
+		}
+
+		line = strtok_r(NULL, delim, &saveptr);
+		i++;
+	}
+
+	/* Verify the devcoredump data */
+	if (!line || strcmp(line, test->dump_data->data)) {
+		tester_warn("Incorrect coredump data: %s (expected %s)", line,
+				test->dump_data->data);
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
+static void test_hci_devcd(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+
+	/* Triggers the devcoredump */
+	if (vhci_force_devcd(vhci, test->dump_data, sizeof(*test->dump_data))) {
+		tester_warn("Unable to set force_devcoredump");
+		tester_test_failed();
+		return;
+	}
+
+	tester_wait(test->dump_data->timeout + 1, verify_devcd, NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -14651,5 +14800,29 @@ int main(int argc, char *argv[])
 				setup_ll_privacy_add_device,
 				test_command_generic);
 
+	/* HCI Devcoredump
+	 * Setup : Power on
+	 * Run: Trigger devcoredump via force_devcoredump
+	 * Expect: Devcoredump is generated with correct data
+	 */
+	test_bredrle("HCI Devcoredump - Dump Complete", &dump_complete, NULL,
+			test_hci_devcd);
+
+	/* HCI Devcoredump
+	 * Setup : Power on
+	 * Run: Trigger devcoredump via force_devcoredump
+	 * Expect: Devcoredump is generated with correct data
+	 */
+	test_bredrle("HCI Devcoredump - Dump Abort", &dump_abort, NULL,
+			test_hci_devcd);
+
+	/* HCI Devcoredump
+	 * Setup : Power on
+	 * Run: Trigger devcoredump via force_devcoredump
+	 * Expect: Devcoredump is generated with correct data
+	 */
+	test_bredrle_full("HCI Devcoredump - Dump Timeout", &dump_timeout, NULL,
+				test_hci_devcd, 3);
+
 	return tester_run();
 }
-- 
2.40.0.348.gf938b09366-goog

