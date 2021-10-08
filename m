Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9ACC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 05:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19F461100
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 05:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhJHFpA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 01:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhJHFo7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 01:44:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A72C061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 22:43:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so5456214pls.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 22:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bVV9XvPl5GyN9f6ZH1CXkBqIWqakPZ6SGjMoHq/hW18=;
        b=S/Wmhfod+ybTk6EVFsWvdYCn5WXUFsuQL+bO/qCc3eTLi7rorBAWDMRO3KGLNMZpTs
         5NQsHs08CKBuN+7wHPKTMkCGRH+pOF1dEiWL30ZwGWuAmYS2ndMPaR9r2h33eAcB9xsX
         75ws8hMVugrCfXcK7bN55qXBrZwIEeI0krLc9NlzS8tXVXqbKzIevA2ce78WnoU/6cvE
         lg1dp2qBMfqX7VpbNCcqI/vN5z70mFxk9wTmhTSwYn7tVEMI/nNCcsktSH4VUEjVxqJ+
         HkPcqIDGFotFsO7rIQlwVquNJToVt/NRSyT3hKylO9WCYjlUfSw5GnKFQaOhAX9hgeyp
         9B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVV9XvPl5GyN9f6ZH1CXkBqIWqakPZ6SGjMoHq/hW18=;
        b=Bz+czU8dgYEZTlMpY7m2mmzEvjoDXiBuHSgximQO71VH6ueSFcrCtSdr7U5fp7EC84
         YQsJ77qwclQg3ghJVMlizaZNWVfR2xxy5QmXnh8ycwMqFDM0HV3DZN6dVe3FEYtezUvL
         u6P2U/dT8UscC33Y9M2gfrMB4RvXuCTikShWEL8wfFf94at1DJXR08U/ndLkLTWFD2hG
         sHLrwa9BhXwh8XmPiDo0uNbx6nx6jQ6KSlyivLKc/juKedLbH0PN7Fu3h2ZnCygJ3PDU
         5bLzhjuj2fcqcRFI3mX4lenAubZ0kUV9kxyUOtSiEox18QO4bzl3gpXUDiYuMpsY5vXF
         WOQw==
X-Gm-Message-State: AOAM532uZFD2Ab3rgjPcYNHgJD2OVt5tlWn8imLD9duQyIbqB8BNGdQ5
        KshEwK8TnSsLYp66PWnxdLJuat3Zg4vDqg==
X-Google-Smtp-Source: ABdhPJybDCzWL0+0BgKAy0WprwYfhpABwkr5g7mjLatOh5q/9sd6imi1poXF59wNskMWGazxDvEJ9w==
X-Received: by 2002:a17:902:e78f:b0:13d:f99f:34bb with SMTP id cp15-20020a170902e78f00b0013df99f34bbmr7581904plb.48.1633671784099;
        Thu, 07 Oct 2021 22:43:04 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e91:8dc3:f28b:c60b])
        by smtp.gmail.com with ESMTPSA id x23sm1266315pfq.146.2021.10.07.22.43.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 22:43:03 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 3/3] tools/mgmt-tester: Add more suspend/resume test cases
Date:   Thu,  7 Oct 2021 22:43:00 -0700
Message-Id: <20211008054300.27989-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008054300.27989-1-hj.tedd.an@gmail.com>
References: <20211008054300.27989-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds more suspend/resuem test cases like
 - Discover -> Suspend
 - Discover -> Suspend -> Resume
 - Suspend -> Resume -> Suspend -> Resume
---
 tools/mgmt-tester.c | 157 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 84d81c8ca..e5a3ad270 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -267,6 +267,7 @@ struct generic_data {
 	uint16_t setup_send_len;
 	const struct setup_mgmt_cmd *setup_mgmt_cmd_arr;
 	bool send_index_none;
+	const void *setup_discovery_param;
 	uint16_t send_opcode;
 	const void *send_param;
 	uint16_t send_len;
@@ -7299,6 +7300,11 @@ proceed:
 			param = privacy_param;
 		}
 
+		if (*cmd == MGMT_OP_START_DISCOVERY) {
+			if (test->setup_discovery_param)
+				memcpy(param, test->setup_discovery_param, 1);
+		}
+
 		if (*cmd == MGMT_OP_SET_LE && test->setup_nobredr) {
 			unsigned char off[] = { 0x00 };
 			mgmt_send(data->mgmt, *cmd, data->mgmt_index,
@@ -10671,6 +10677,21 @@ static void trigger_force_suspend(void *user_data)
 	}
 }
 
+static void trigger_force_resume(void *user_data)
+{
+	bool suspend;
+	int err;
+
+	/* Triggers the suspend */
+	suspend = false;
+	tester_print("Set the system into Resume via force_suspend");
+	err = set_debugfs_force_suspend(0, suspend);
+	if (err) {
+		tester_warn("Unable to disable the force_suspend");
+		return;
+	}
+}
+
 static void test_suspend_resume_success_5(const void *test_data)
 {
 	test_pairing_acceptor(test_data);
@@ -10722,6 +10743,113 @@ static void test_suspend_resume_success_7(const void *test_data)
 	test_command_generic(test_data);
 }
 
+static const struct generic_data suspend_resume_success_8 = {
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_START_DISCOVERY,
+	.send_param = start_discovery_le_param,
+	.send_len = sizeof(start_discovery_le_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = start_discovery_le_param,
+	.expect_len = sizeof(start_discovery_le_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE,
+	.expect_hci_param = start_discovery_valid_ext_scan_enable,
+	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_enable),
+	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
+	.expect_alt_ev_param = suspend_state_param_disconnect,
+	.expect_alt_ev_len = sizeof(suspend_state_param_disconnect),
+};
+
+static void test_suspend_resume_success_8(const void *test_data)
+{
+	test_command_generic(test_data);
+	tester_wait(1, trigger_force_suspend, NULL);
+}
+
+static uint16_t settings_powered_le_discovery[] = { MGMT_OP_SET_LE,
+						    MGMT_OP_SET_POWERED,
+						    MGMT_OP_START_DISCOVERY,
+						    0 };
+
+static const struct generic_data suspend_resume_success_9 = {
+	.setup_settings = settings_powered_le_discovery,
+	.setup_discovery_param = start_discovery_bredrle_param,
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE,
+	.setup_expect_hci_param = stop_discovery_valid_ext_scan_disable,
+	.setup_expect_hci_len = sizeof(stop_discovery_valid_ext_scan_disable),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE,
+	.expect_hci_param = start_discovery_valid_ext_scan_enable,
+	.expect_hci_len = sizeof(start_discovery_valid_ext_scan_enable),
+	.expect_alt_ev = MGMT_EV_CONTROLLER_RESUME,
+	.expect_alt_ev_param = resume_state_param_non_bt_wake,
+	.expect_alt_ev_len = sizeof(resume_state_param_non_bt_wake),
+};
+
+static void trigger_force_suspend_9(void *user_data)
+{
+	trigger_force_suspend(user_data);
+}
+
+static void setup_suspend_resume_success_9(const void *test_data)
+{
+	setup_command_generic(test_data);
+	tester_wait(1, trigger_force_suspend_9, NULL);
+}
+
+static void test_suspend_resume_success_9(const void *test_data)
+{
+	test_command_generic(test_data);
+	tester_wait(2, trigger_force_resume, NULL);
+}
+
+static const struct generic_data suspend_resume_success_10 = {
+	.setup_settings = settings_powered_le,
+	.expect_alt_ev = MGMT_EV_CONTROLLER_RESUME,
+	.expect_alt_ev_param = resume_state_param_non_bt_wake,
+	.expect_alt_ev_len = sizeof(resume_state_param_non_bt_wake),
+};
+
+static void resume_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct mgmt_ev_controller_resume *ev = param;
+
+	mgmt_unregister(data->mgmt, data->mgmt_discov_ev_id);
+
+	if (length != sizeof(*ev)) {
+		tester_warn("Incorrect resume event length");
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("New Controller Resume event received");
+	test_condition_complete(data);
+	tester_setup_complete();
+}
+
+
+static void setup_suspend_resume_success_10(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned int id;
+
+	tester_print("Registering Controller Resume notification");
+	id = mgmt_register(data->mgmt, MGMT_EV_CONTROLLER_RESUME,
+			   data->mgmt_index, resume_event, NULL, NULL);
+	/* Reuse the variable */
+	data->mgmt_discov_ev_id = id;
+	test_add_condition(data);
+
+	tester_wait(1, trigger_force_suspend, NULL);
+	tester_wait(2, trigger_force_resume, NULL);
+}
+
+static void test_suspend_resume_success_10(const void *test_data)
+{
+	test_command_generic(test_data);
+	tester_wait(1, trigger_force_suspend, NULL);
+	tester_wait(2, trigger_force_resume, NULL);
+}
 
 int main(int argc, char *argv[])
 {
@@ -12497,6 +12625,35 @@ int main(int argc, char *argv[])
 				&suspend_resume_success_7,
 				NULL, test_suspend_resume_success_7);
 
+	/* Suspend/Resume
+	 * Setup : Power on
+	 * Run: Start discover and enable suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle50_full("Suspend/Resume - Success 8 (Discovery/Suspend)",
+				&suspend_resume_success_8,
+				NULL, test_suspend_resume_success_8, 4);
+
+	/* Suspend/Resume
+	 * Setup : Power on, start discovery
+	 * Run: Start discover, enable suspend and resume.
+	 * Expect: Receive the Resume Event
+	 */
+	test_bredrle50_full("Suspend/Resume - Success 9 (Discovery/Suspend/Resume)",
+				&suspend_resume_success_9,
+				setup_suspend_resume_success_9,
+				test_suspend_resume_success_9, 4);
+
+	/* Suspend/Resume
+	 * Setup : Power on
+	 * Run: Suspend, Resume, Suspend, and Resume
+	 * Expect:
+	 */
+	test_bredrle50_full("Suspend/Resume - Success 10 (Multiple Suspend/Resume)",
+				&suspend_resume_success_10,
+				setup_suspend_resume_success_10,
+				test_suspend_resume_success_10, 6);
+
 	/* MGMT_OP_READ_EXP_FEATURE
 	 * Read Experimental features - success
 	 */
-- 
2.25.1

