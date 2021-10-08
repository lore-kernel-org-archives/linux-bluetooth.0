Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B08C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DC561038
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbhJHTi3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbhJHTi2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:38:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C68C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:36:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j15so6817075plh.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z8YYKCB+IfdGnekxiETO+sQfpHyNoywNe3xx1ruQExw=;
        b=fI6zWe1wcnOO5Me/YhGoX+mvEEldBND5nEOcFnuEifQtCnbRseiaFWslBW4wNfPT8N
         KquyHKmC9vkrrhAS5kzt2UN3wbcyKYuJL123lPgX/HTGlGwoQHx82nwQ7eVi522T3EMO
         +O93tSe2XM+dFc1SCz8C3cEURU/jVwMq+1sj26EDte5era81tzFYL/UYhC5rpxYa76hM
         IcdcAI75X+uLIA9lO9Q2vlNuMT9dUQP6aqjZdLAFfbsX98ilBSc80Q6C3deYwWLgZkV8
         cQjhzL4ljx58OHGhdHtDxhB7QJEXHzDCiv9zATCzYPEDEPZMz6dVscOFAngd2CA6ouIl
         /X6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8YYKCB+IfdGnekxiETO+sQfpHyNoywNe3xx1ruQExw=;
        b=hpHTU/M1ZsmFhZ6zIWYW6iA7U2dYk4TIeE26IR9PEt38PxMB2QFWKrhyOx3UftUmKD
         ksUoqJ26yO8sIwdrBMH7nwhVLt+Jnrjl9yG/GkFtXD71RxwM1sZexVTThx5SMT/DFdZS
         5JrXIfz/i3e2NFvMYj/hvMAbRZJdv8cctUyjaMOblNraTaIyLzDawkZaFWDHSBwrjqoM
         9ekOS33ApQFaBnxM58YsA6JiLDHFhNXa5q5paaoNoQSOsr1Zoq7GyZU9MwcSFcaM+Jrl
         Plh/wRL72ravcgg2dXdoSrqQFSyX1/PDywpDr/Emv8lyTapVMBzBsNnQioF2XJudU/+8
         gGKQ==
X-Gm-Message-State: AOAM532KJAss9kC4RmRAUz9afgy59NecIajJ+Ee6UyJHpz/GKEjP+IUJ
        n+nkynmWJwmparag3lVFzNj3kJfmSc4OlA==
X-Google-Smtp-Source: ABdhPJx3j8OVDF5IB2j71YzOTvh1yrWW2ENZps/+zPwvBBhyw2lkclGGApNRMhq8cvNloviChfLkyg==
X-Received: by 2002:a17:902:e544:b0:13e:e863:6cd2 with SMTP id n4-20020a170902e54400b0013ee8636cd2mr10990105plf.41.1633721792350;
        Fri, 08 Oct 2021 12:36:32 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e91:8dc3:f28b:c60b])
        by smtp.gmail.com with ESMTPSA id g23sm137616pfu.71.2021.10.08.12.36.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:36:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 3/3] tools/mgmt-tester: Add more suspend/resume test cases
Date:   Fri,  8 Oct 2021 12:36:28 -0700
Message-Id: <20211008193628.39347-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008193628.39347-1-hj.tedd.an@gmail.com>
References: <20211008193628.39347-1-hj.tedd.an@gmail.com>
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
 tools/mgmt-tester.c | 171 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 164 insertions(+), 7 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 84d81c8ca..8bddf6b03 100644
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
@@ -12436,7 +12564,7 @@ int main(int argc, char *argv[])
 	 * Run: Enable suspend via force_suspend
 	 * Expect: Receive the Suspend Event
 	 */
-	test_bredrle50("Suspend/Resume - Success 1 (Suspend)",
+	test_bredrle50("Suspend - Success 1",
 				&suspend_resume_success_1,
 				NULL, test_suspend_resume_success_1);
 
@@ -12445,7 +12573,7 @@ int main(int argc, char *argv[])
 	 * Run: Enable suspend, and then resume via force_suspend
 	 * Expect: Receive the Resume Event
 	 */
-	test_bredrle50("Suspend/Resume - Success 2 (Resume)",
+	test_bredrle50("Resume - Success 2",
 				&suspend_resume_success_2,
 				NULL, test_suspend_resume_success_2);
 
@@ -12454,7 +12582,7 @@ int main(int argc, char *argv[])
 	 * Run: Add new device, and enable suspend.
 	 * Expect: Receive the Suspend Event
 	 */
-	test_bredrle50("Suspend/Resume - Success 3 (Device in WL)",
+	test_bredrle50("Suspend - Success 3 (Device in WL)",
 				&suspend_resume_success_3,
 				setup_suspend_resume_success_3,
 				test_suspend_resume_success_3);
@@ -12464,7 +12592,7 @@ int main(int argc, char *argv[])
 	 * Run: Enable suspend
 	 * Expect: Receive the Suspend Event
 	 */
-	test_bredrle50("Suspend/Resume - Success 4 (Advertising)",
+	test_bredrle50("Suspend - Success 4 (Advertising)",
 				&suspend_resume_success_4,
 				setup_suspend_resume_success_4,
 				test_suspend_resume_success_4);
@@ -12474,7 +12602,7 @@ int main(int argc, char *argv[])
 	 * Run: Enable suspend
 	 * Expect: Receive the Suspend Event
 	 */
-	test_bredrle("Suspend/Resume - Success 5 (Pairing - Legacy)",
+	test_bredrle("Suspend - Success 5 (Pairing - Legacy)",
 				&suspend_resume_success_5, NULL,
 				test_suspend_resume_success_5);
 
@@ -12483,7 +12611,7 @@ int main(int argc, char *argv[])
 	 * Run: Enable suspend
 	 * Expect: Receive the Suspend Event
 	 */
-	test_bredrle("Suspend/Resume - Success 6 (Pairing - SSP)",
+	test_bredrle("Suspend - Success 6 (Pairing - SSP)",
 				&suspend_resume_success_6,
 				setup_pairing_acceptor,
 				test_suspend_resume_success_5);
@@ -12493,10 +12621,39 @@ int main(int argc, char *argv[])
 	 * Run: Enable suspend via force_suspend
 	 * Expect: Receive the Suspend Event
 	 */
-	test_bredrle50("Suspend/Resume - Success 7 (Suspend/Force Wakeup)",
+	test_bredrle50("Suspend - Success 7 (Suspend/Force Wakeup)",
 				&suspend_resume_success_7,
 				NULL, test_suspend_resume_success_7);
 
+	/* Suspend/Resume
+	 * Setup : Power on
+	 * Run: Start discover and enable suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle50_full("Suspend - Success 8 (Discovery/Suspend)",
+				&suspend_resume_success_8,
+				NULL, test_suspend_resume_success_8, 4);
+
+	/* Suspend/Resume
+	 * Setup : Power on, start discovery
+	 * Run: Start discover, enable suspend and resume.
+	 * Expect: Receive the Resume Event
+	 */
+	test_bredrle50_full("Resume - Success 9 (Discovery/Suspend/Resume)",
+				&suspend_resume_success_9,
+				setup_suspend_resume_success_9,
+				test_suspend_resume_success_9, 4);
+
+	/* Suspend/Resume
+	 * Setup : Power on
+	 * Run: Suspend, Resume, Suspend, and Resume
+	 * Expect:
+	 */
+	test_bredrle50_full("Resume - Success 10 (Multiple Suspend/Resume)",
+				&suspend_resume_success_10,
+				setup_suspend_resume_success_10,
+				test_suspend_resume_success_10, 6);
+
 	/* MGMT_OP_READ_EXP_FEATURE
 	 * Read Experimental features - success
 	 */
-- 
2.25.1

