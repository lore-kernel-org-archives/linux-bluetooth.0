Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 01:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D28A600EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 01:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbhI1BkB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 21:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbhI1BkB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 21:40:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7601C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 18:38:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n2so13032031plk.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASO5CnVM0DLPEnCzbqGuJekKsZIb7k9fOH1JvfG5YV4=;
        b=KAZafMUXmq2x0xuq56kBaI79ZUi9gWsOzDULM9FOGP4BQXMwB/w6lmIcWVu6dNjIsz
         XHZ7ZzR+NWirh+TG9N9e6rPsnZ78EwIxdIj6Yr6ILGC9nXUrQh9HNdRgCzNZa54Cqmtm
         XsWkxXuvnjQR8CyNuRpk+STD3/Xb7pi5ZnxTiRwuQQ2/6Z6tTkXzOnO2NtwMD7R+PEdy
         JlVGKlpkEv1s2KjD7zwlKvUg5SkTZmEdfSaHFSypPeiIjZhXkvgAJbd3LCdtYNT8BBXD
         9U5SRDD01uUNKUnODEDoYD2aHGrkWur2juKyNgvoPgh/M+g8ZxyZpqz4L+vwlWu8TE5Q
         pAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASO5CnVM0DLPEnCzbqGuJekKsZIb7k9fOH1JvfG5YV4=;
        b=Qq1Pn/ioZ0xNvAYNysTx7aQHA3k//wIae0YaiXwz/ezsnIt3Sv6Isheb/LKYFuja4n
         0jwJjlyJBHeeI7g6WEwc2xR4tD6P6R67m7y1FTP2dl87K2V7yXhiflLhPOVh69Y/ySnY
         wS9BxKn19Tn2JQtHA9dBX22s7lAnYxxlfYvRA23CdiO7zmYviskkml9OLSXMCvIhGAci
         YlZKzN2XfhKF5q2XZI4bMLMBmv/nbXrVUqlmEVMl11Of/CsHB4PsOCyQWgNTl3pmVhCb
         7IYlxf3OC9FW9f4hjkznk/K5auY3pbPFySPQzOz1KT//fxqgFKRtay6RQhHbZ18z0IKK
         KmpA==
X-Gm-Message-State: AOAM530j0Y0uIeDK90oJJO4W7dUManYz0OzUvxx19CUBftLuwa+P5BYc
        J116qeUoRzvLGvn/WE3/ssSWG5Jshgc=
X-Google-Smtp-Source: ABdhPJwgQLsC143xONAV2qwlhjtL686vh9IS2vRFz9u18H+maoNNGYfHXjcKxJaopEs7oGIsLo92dA==
X-Received: by 2002:a17:903:187:b0:13d:fd13:8862 with SMTP id z7-20020a170903018700b0013dfd138862mr2329521plg.85.1632793101868;
        Mon, 27 Sep 2021 18:38:21 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:76e3:83a2:7b9:4806])
        by smtp.gmail.com with ESMTPSA id v6sm18151738pfv.83.2021.09.27.18.38.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 18:38:21 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Add suspend/resume test cases
Date:   Mon, 27 Sep 2021 18:38:20 -0700
Message-Id: <20210928013820.288289-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the suspend/resume test cases:

Suspend/Resume - Success 1 (Suspend)
Suspend/Resume - Success 2 (Resume)
Suspend/Resume - Success 3 (Device in WL)
Suspend/Resume - Success 4 (Advertising)
Suspend/Resume - Success 5 (Pairing - Legacy)
Suspend/Resume - Success 6 (Pairing - SSP)
---
 tools/mgmt-tester.c | 295 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 9c5b26c9a..fc9df5735 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -15,6 +15,9 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
 #include <errno.h>
 #include <unistd.h>
 
@@ -309,6 +312,34 @@ struct generic_data {
 	uint8_t adv_data_len;
 };
 
+static int set_debugfs_force_suspend(int index, bool enable)
+{
+	int fd, n, err;
+	char val, path[64];
+
+	err = 0;
+
+	/* path for the debugfs file
+	 * /sys/kernel/debug/bluetooth/hciX/force_suspend
+	 */
+	memset(path, 0, sizeof(path));
+	sprintf(path, "/sys/kernel/debug/bluetooth/hci%d/force_suspend", index);
+
+	fd = open(path, O_RDWR);
+	if (fd < 0)
+		return -errno;
+
+	val = (enable) ? 'Y' : 'N';
+
+	n = write(fd, &val, sizeof(val));
+	if (n < (ssize_t) sizeof(val))
+		err = -errno;
+
+	close(fd);
+
+	return err;
+}
+
 static const uint8_t set_exp_feat_param_debug[] = {
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab, /* UUID - Debug */
 	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
@@ -10072,6 +10103,213 @@ static void test_50_controller_cap_response(const void *test_data)
 						data, NULL);
 }
 
+static const uint8_t suspend_state_param_running[] = {
+	0x00,
+};
+
+static const uint8_t suspend_state_param_page_scan[] = {
+	0x02,
+};
+
+static const uint8_t resume_state_param_non_bt_wake[] = {
+	0x00,
+	0x00, 0x00, 0x0, 0x00, 0x00, 0x00,
+	0x00
+};
+
+static const struct generic_data suspend_resume_success_1 = {
+	.setup_settings = settings_powered,
+	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
+	.expect_alt_ev_param = suspend_state_param_page_scan,
+	.expect_alt_ev_len = sizeof(suspend_state_param_page_scan),
+};
+
+static void test_suspend_resume_success_1(const void *test_data)
+{
+	bool suspend;
+	int err;
+
+	/* Triggers the suspend */
+	suspend = true;
+	err = set_debugfs_force_suspend(0, suspend);
+	if (err) {
+		tester_warn("Unable to enable the force_suspend");
+		tester_test_failed();
+		return;
+	}
+	test_command_generic(test_data);
+}
+
+static const struct generic_data suspend_resume_success_2 = {
+	.setup_settings = settings_powered,
+	.expect_alt_ev = MGMT_EV_CONTROLLER_RESUME,
+	.expect_alt_ev_param = resume_state_param_non_bt_wake,
+	.expect_alt_ev_len = sizeof(resume_state_param_non_bt_wake),
+};
+
+static void test_suspend_resume_success_2(const void *test_data)
+{
+	bool suspend;
+	int err;
+
+	/* Triggers the suspend */
+	suspend = true;
+	err = set_debugfs_force_suspend(0, suspend);
+	if (err) {
+		tester_warn("Unable to enable the force_suspend");
+		tester_test_failed();
+		return;
+	}
+
+	/* Triggers the resume */
+	suspend = false;
+	err = set_debugfs_force_suspend(0, suspend);
+	if (err) {
+		tester_warn("Unable to enable the force_suspend");
+		tester_test_failed();
+		return;
+	}
+	test_command_generic(test_data);
+}
+
+static const struct generic_data suspend_resume_success_3 = {
+	.setup_expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
+	.setup_expect_hci_param = le_add_to_accept_list_param,
+	.setup_expect_hci_len = sizeof(le_add_to_accept_list_param),
+	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
+	.expect_alt_ev_param = suspend_state_param_page_scan,
+	.expect_alt_ev_len = sizeof(suspend_state_param_page_scan),
+};
+
+static void setup_suspend_resume_success_3(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	/* Add Device 1 */
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_success_param_3),
+					add_device_success_param_3,
+					setup_add_device_callback,
+					NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+}
+
+static void test_suspend_resume_success_3(const void *test_data)
+{
+	bool suspend;
+	int err;
+
+	/* Triggers the suspend */
+	suspend = true;
+	err = set_debugfs_force_suspend(0, suspend);
+	if (err) {
+		tester_warn("Unable to enable the force_suspend");
+		tester_test_failed();
+		return;
+	}
+	test_command_generic(test_data);
+}
+
+static const struct generic_data suspend_resume_success_4 = {
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.setup_expect_hci_param = set_ext_adv_on_set_adv_enable_param,
+	.setup_expect_hci_len = sizeof(set_ext_adv_on_set_adv_enable_param),
+	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
+	.expect_alt_ev_param = suspend_state_param_page_scan,
+	.expect_alt_ev_len = sizeof(suspend_state_param_page_scan),
+};
+
+static void setup_suspend_resume_success_4(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct mgmt_cp_add_advertising *cp;
+	unsigned char adv_param[sizeof(*cp) + TESTER_ADD_ADV_DATA_LEN];
+	unsigned char param[] = { 0x01 };
+
+	cp = (struct mgmt_cp_add_advertising *) adv_param;
+	setup_add_adv_param(cp, 1);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+					sizeof(param), &param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_ADVERTISING, data->mgmt_index,
+					sizeof(adv_param), adv_param,
+					setup_add_advertising_callback,
+					NULL, NULL);
+}
+
+static void test_suspend_resume_success_4(const void *test_data)
+{
+	bool suspend;
+	int err;
+
+	test_command_generic(test_data);
+
+	/* Triggers the suspend */
+	suspend = true;
+	tester_print("Set the system into Suspend via force_suspend");
+	err = set_debugfs_force_suspend(0, suspend);
+	if (err) {
+		tester_warn("Unable to enable the force_suspend");
+		tester_test_failed();
+		return;
+	}
+}
+
+static const struct generic_data suspend_resume_success_5 = {
+	.setup_settings = settings_powered_connectable_bondable,
+	.pin = pair_device_pin,
+	.pin_len = sizeof(pair_device_pin),
+	.client_pin = pair_device_pin,
+	.client_pin_len = sizeof(pair_device_pin),
+	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
+	.expect_alt_ev_param = suspend_state_param_running,
+	.expect_alt_ev_len = sizeof(suspend_state_param_running),
+};
+
+static void trigger_force_suspend(void *user_data)
+{
+	bool suspend;
+	int err;
+
+	/* Triggers the suspend */
+	suspend = true;
+	tester_print("Set the system into Suspend via force_suspend");
+	err = set_debugfs_force_suspend(0, suspend);
+	if (err) {
+		tester_warn("Unable to enable the force_suspend");
+		return;
+	}
+}
+
+static void test_suspend_resume_success_5(const void *test_data)
+{
+	test_pairing_acceptor(test_data);
+	tester_wait(1, trigger_force_suspend, NULL);
+}
+
+static const struct generic_data suspend_resume_success_6 = {
+	.setup_settings = settings_powered_connectable_bondable_ssp,
+	.client_enable_ssp = true,
+	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
+	.expect_alt_ev_param = suspend_state_param_running,
+	.expect_alt_ev_len = sizeof(suspend_state_param_running),
+	.expect_hci_command = BT_HCI_CMD_USER_CONFIRM_REQUEST_REPLY,
+	.expect_hci_func = client_bdaddr_param_func,
+	.io_cap = 0x03, /* NoInputNoOutput */
+	.client_io_cap = 0x03, /* NoInputNoOutput */
+	.just_works = true,
+};
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -11768,6 +12006,63 @@ int main(int argc, char *argv[])
 				setup_get_dev_flags,
 				test_command_generic);
 
+	/* Suspend/Resume
+	 * Setup : Power on and register Suspend Event
+	 * Run: Enable suspend via force_suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle50("Suspend/Resume - Success 1 (Suspend)",
+				&suspend_resume_success_1,
+				NULL, test_suspend_resume_success_1);
+
+	/* Suspend/Resume
+	 * Setup : Power on and register Suspend Event
+	 * Run: Enable suspend, and then resume via force_suspend
+	 * Expect: Receive the Resume Event
+	 */
+	test_bredrle50("Suspend/Resume - Success 2 (Resume)",
+				&suspend_resume_success_2,
+				NULL, test_suspend_resume_success_2);
+
+	/* Suspend/Resume
+	 * Setup: Enable LL Privacy and power on
+	 * Run: Add new device, and enable suspend.
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle50("Suspend/Resume - Success 3 (Device in WL)",
+				&suspend_resume_success_3,
+				setup_suspend_resume_success_3,
+				test_suspend_resume_success_3);
+
+	/* Suspend/Resume
+	 * Setup: Start advertising and power on.
+	 * Run: Enable suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle50("Suspend/Resume - Success 4 (Advertising)",
+				&suspend_resume_success_4,
+				setup_suspend_resume_success_4,
+				test_suspend_resume_success_4);
+
+	/* Suspend/Resume
+	 * Setup: Pair.
+	 * Run: Enable suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle("Suspend/Resume - Success 5 (Pairing - Legacy)",
+				&suspend_resume_success_5, NULL,
+				test_suspend_resume_success_5);
+
+	/* Suspend/Resume
+	 * Setup: Pair.
+	 * Run: Enable suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle("Suspend/Resume - Success 6 (Pairing - SSP)",
+				&suspend_resume_success_6,
+				setup_pairing_acceptor,
+				test_suspend_resume_success_5);
+
 	/* MGMT_OP_READ_EXP_FEATURE
 	 * Read Experimental features - success
 	 */
-- 
2.25.1

