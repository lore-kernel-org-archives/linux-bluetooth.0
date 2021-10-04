Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B12C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0BF61029
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhJDV6X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhJDV6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 17:58:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC4C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 14:56:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so888947pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7+PVjwM8mQB8cOlCJd6DzHMKfvbHulMaayUguM0b7I=;
        b=O47DmgeXVVw1nDdzgCrTId82cM0LI8dv0vJ3LjwaxF2MdOAbt2WeZx6Ctmeuds/wUl
         qPFuAxtEcwy0qWLaK3akrzRzTrfeS6LxgN1MgSZh0dz61gpK1+FS2oH8TLFSJ160Wb7j
         V40UzUi+vHMyUbj64rt6iJ42MeKEFT0yg49bRi4+52Kz1Rqq0D4z9kvpDnib69YwR3zh
         VJocjYLekp3eby+f3/J2uzIn1CZXMxw8KQta+FaLCxzuzQT/wdFaQdBVUOhjrtGKNpoX
         oLU6IqVs17z741S2HvcZwIfdZ8/BI2lnKoD6hlJwQDlNTZTO+ZrH5WgW8ITOMcQ12zdt
         8hQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7+PVjwM8mQB8cOlCJd6DzHMKfvbHulMaayUguM0b7I=;
        b=OEUhqO16y6pZ5asblpUhUHdpCh0T6X9oFt2kDY+fkL2m2Rdps06ILchcjzbFvYEfXy
         pgMg5oPHsZUFchbC1dvneSl4J2rUqjHLXO4Tn9gUII3P6sxwC0F3rBoeQ3h1sYyrGj74
         SEotcYSi3J/trdt6J555rNHMs2+roxDMnQXGbILyueyVyTJ1+cGv17P/P+q7zxlczn/2
         C5DimxQHEOxJ/pKXwH/Y1MqBpUMZLXjUTcbmHqMPHpKro6GFkJnEebMMeurc/FerHCyk
         i4fLUbx5gZGXQtWMg0yqC0JG0aj+nFZP0emuwE/IGpWGMS0hcgH9E61tj0IVI7eOYK8t
         ForQ==
X-Gm-Message-State: AOAM533qIpbnQ43e1kHdX/VFHbf2LWCxdf15JEkFZvAFVyJ9OL9VaH1x
        8A1mtdkdIwlw0iSynmLarLJ5eVcuK80=
X-Google-Smtp-Source: ABdhPJx+kUw9tWDkyszEohuS/3GNMWKn9cHJr7OndtwEXHxM6wKnVorz94BdPvKpGyJOU394vXb4/w==
X-Received: by 2002:a17:90a:1a02:: with SMTP id 2mr32884627pjk.6.1633384591707;
        Mon, 04 Oct 2021 14:56:31 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::d9e])
        by smtp.gmail.com with ESMTPSA id p4sm13383992pjo.0.2021.10.04.14.56.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 14:56:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Fix the suspend reason code
Date:   Mon,  4 Oct 2021 14:56:30 -0700
Message-Id: <20211004215630.216603-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the suspend reason code to align with the corrent
kernel implementation.
---
 tools/mgmt-tester.c | 86 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 45fa9c2e1..acca9ef20 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -340,6 +340,34 @@ static int set_debugfs_force_suspend(int index, bool enable)
 	return err;
 }
 
+static int set_debugfs_force_wakeup(int index, bool enable)
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
+	sprintf(path, "/sys/kernel/debug/bluetooth/hci%d/force_wakeup", index);
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
@@ -10103,6 +10131,10 @@ static const uint8_t suspend_state_param_running[] = {
 	0x00,
 };
 
+static const uint8_t suspend_state_param_disconnect[] = {
+	0x01,
+};
+
 static const uint8_t suspend_state_param_page_scan[] = {
 	0x02,
 };
@@ -10116,8 +10148,8 @@ static const uint8_t resume_state_param_non_bt_wake[] = {
 static const struct generic_data suspend_resume_success_1 = {
 	.setup_settings = settings_powered,
 	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
-	.expect_alt_ev_param = suspend_state_param_page_scan,
-	.expect_alt_ev_len = sizeof(suspend_state_param_page_scan),
+	.expect_alt_ev_param = suspend_state_param_disconnect,
+	.expect_alt_ev_len = sizeof(suspend_state_param_disconnect),
 };
 
 static void test_suspend_resume_success_1(const void *test_data)
@@ -10173,8 +10205,8 @@ static const struct generic_data suspend_resume_success_3 = {
 	.setup_expect_hci_param = le_add_to_accept_list_param,
 	.setup_expect_hci_len = sizeof(le_add_to_accept_list_param),
 	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
-	.expect_alt_ev_param = suspend_state_param_page_scan,
-	.expect_alt_ev_len = sizeof(suspend_state_param_page_scan),
+	.expect_alt_ev_param = suspend_state_param_disconnect,
+	.expect_alt_ev_len = sizeof(suspend_state_param_disconnect),
 };
 
 static void setup_suspend_resume_success_3(const void *test_data)
@@ -10215,8 +10247,8 @@ static const struct generic_data suspend_resume_success_4 = {
 	.setup_expect_hci_param = set_ext_adv_on_set_adv_enable_param,
 	.setup_expect_hci_len = sizeof(set_ext_adv_on_set_adv_enable_param),
 	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
-	.expect_alt_ev_param = suspend_state_param_page_scan,
-	.expect_alt_ev_len = sizeof(suspend_state_param_page_scan),
+	.expect_alt_ev_param = suspend_state_param_disconnect,
+	.expect_alt_ev_len = sizeof(suspend_state_param_disconnect),
 };
 
 static void setup_suspend_resume_success_4(const void *test_data)
@@ -10306,6 +10338,39 @@ static const struct generic_data suspend_resume_success_6 = {
 	.just_works = true,
 };
 
+static const struct generic_data suspend_resume_success_7 = {
+	.setup_settings = settings_powered,
+	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
+	.expect_alt_ev_param = suspend_state_param_page_scan,
+	.expect_alt_ev_len = sizeof(suspend_state_param_page_scan),
+};
+
+static void test_suspend_resume_success_7(const void *test_data)
+{
+	bool suspend;
+	int err;
+
+	/* Set Force Wakeup */
+	suspend = true;
+	err = set_debugfs_force_wakeup(0, suspend);
+	if (err) {
+		tester_warn("Unable to enable the force_wakeup");
+		tester_test_failed();
+		return;
+	}
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
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -12059,6 +12124,15 @@ int main(int argc, char *argv[])
 				setup_pairing_acceptor,
 				test_suspend_resume_success_5);
 
+	/* Suspend/Resume
+	 * Setup : Power on and register Suspend Event
+	 * Run: Enable suspend via force_suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle50("Suspend/Resume - Success 7 (Suspend/Force Wakeup)",
+				&suspend_resume_success_7,
+				NULL, test_suspend_resume_success_7);
+
 	/* MGMT_OP_READ_EXP_FEATURE
 	 * Read Experimental features - success
 	 */
-- 
2.25.1

