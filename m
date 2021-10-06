Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B350C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8053E61152
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJFUO5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhJFUO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 16:14:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC3C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 13:13:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e7so3497393pgk.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=78BcLNH5YsPrph0Xf3fOGBXV8okVPDtTAt2sMI3mByQ=;
        b=jgXMK42X8WwbSYFQo0VPRrwbBiPdIiGbOCS5sOAtZJoCMEOeeGG2UfcYb4BlOs67ey
         OgUAY4QBq1gizK9gtD6bJjKZTJfRs1d7ERIZnCmzykSDzx7aEi4JuelPbUgOd3E5uefc
         e96RUe8l5gSq/LzLblb8pFyNRN98bcvG6oHw3dXoqvd2fLRolbF11TszCeG68rBfbcjo
         yKZpksnEe/nugU1zoahOK1/xy2noy+xhEKB/BtDaPp1UaPkhpYk53Au3o+piXlhOostL
         KYIXiMLnyi2U+KitwVtxRW2xy80dC0KKtjXpPhzxbW4QeFiYWhdMdihXyB6rVHnM3xtu
         7iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78BcLNH5YsPrph0Xf3fOGBXV8okVPDtTAt2sMI3mByQ=;
        b=aNxaEJ27tyIxMoTBQwLtg7qLEyEfH9z7OK+zSu9mzAI1obTh+HJIUoLdUc6W3SVG+b
         NlnRioPN8rpmriIEmPSuYJF18wwO5hyBo0Q1kjr7bgnXM113GMPc5plFov/ejG6o4RhK
         U9//3Nmy/xkaBPqtKrAjIB7PO9nLNEd6GG7s1W2L4yMnnr0EXFVC8CtZmnvc4Om0/cMY
         M2aXmoHHMu5+KQH5QsiI+V2wzK9zqEWXTuEfX1L+8FZnyP0SkZE6V7JWhGubszeXobYm
         rXo9t9/0sGlLt5ImND2xdXnqKmTARJnHfnwGfVPmDRjwXh7rM+EDgPb0bsaRVbFmJk9I
         oLdg==
X-Gm-Message-State: AOAM530O9sRok0Zh1R04+Lb6f/vkG1a5scCwCjaGTxNatLdXjya7o23q
        WOvWa60KgSa6ONUDyNyWjYLO/Y7zKMZFoA==
X-Google-Smtp-Source: ABdhPJxcdU++qXDsMbt0CLplY21QXoNP/Qd9yq40qktzU0XyK0AqYVItKGLei1jLOoQMMYEvtHry+w==
X-Received: by 2002:a63:2bc3:: with SMTP id r186mr34083pgr.385.1633551183457;
        Wed, 06 Oct 2021 13:13:03 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:8e4c:2d64:6206:9120])
        by smtp.gmail.com with ESMTPSA id b10sm16202006pfl.200.2021.10.06.13.13.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:13:02 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/3] tools/mgmt-tester: Add test case for suspend while discovering
Date:   Wed,  6 Oct 2021 13:13:00 -0700
Message-Id: <20211006201300.186055-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006201300.186055-1-hj.tedd.an@gmail.com>
References: <20211006201300.186055-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a test case for suspend while discovering state.
---
 tools/mgmt-tester.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 84d81c8ca..8fd82487d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -10722,6 +10722,27 @@ static void test_suspend_resume_success_7(const void *test_data)
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
 
 int main(int argc, char *argv[])
 {
@@ -12497,6 +12518,15 @@ int main(int argc, char *argv[])
 				&suspend_resume_success_7,
 				NULL, test_suspend_resume_success_7);
 
+	/* Suspend/Resume
+	 * Setup : Power on
+	 * Run: Start discover and enable suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle50_full("Suspend/Resume - Success 8 (Discovering)",
+				&suspend_resume_success_8,
+				NULL, test_suspend_resume_success_8, 4);
+
 	/* MGMT_OP_READ_EXP_FEATURE
 	 * Read Experimental features - success
 	 */
-- 
2.25.1

