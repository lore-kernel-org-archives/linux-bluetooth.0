Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345EEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 02:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196226115A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 02:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbhJFCmQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 22:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCmQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 22:42:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43EC061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 19:40:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1147458pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87lHPkRARbCPrsf6XsX9vExWJu40BU0Q33czj1EDd/E=;
        b=ESHchqt4XeSBusnSVYnX9+ZjvKjYOzMcmaab6eqeSq/KjAHcPNBo4zEP6xXC6f8NIi
         9Jr7yMf9VaX61ZbhBFRRKDovAbxBc85snj0HS/CRO9wEepHBIhcdlBhLqjVKjgQWhrhd
         uyEWcPpt5iFDeONAc7+YocUJerbQdUFwjkSgVdVP1BBonB8l3LUYLekx6fUgGZG6vUYA
         f7eISIx3TOjxJirCVTGoQjaSwZ/i1JD5pp0wvjW0PHPCjcV52Qs3Zsyl2NQo3jjRUrF5
         ONhRv/VuaRJSW9ABXz+v8Rnbzs1RwKXPlWJ4+iqA67BYM10rgAFciLoNhiUeINBuAPD2
         woZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87lHPkRARbCPrsf6XsX9vExWJu40BU0Q33czj1EDd/E=;
        b=oEtDQRX6KgrO5eSeGVJ03LJUtswvztrQfG522/5TGnQYQsH6I1JGKEkly8aHYNnLET
         SPVVtj2c4wZZcDw0toYj51EX4TbnWH6hOYS/qwKVdTD+kczVoRWVEOZycwOMlqqcgmVS
         InCbE3TAOqyyCT97sDh+taSDnviWluDeaVU/2HH2S2Amso0ViA962rOqjTTi01GHWPON
         n62RPKp69pTpZCgCHu3qJOXCEjPjJS562qq3uweb+hylEshnZJxjoC3rMDvujXp45s69
         y1XGzgOfdbCb5LqrxwBmTsOHEQmgq5aPCqLb2z0kiScDwa2xakrcjwOyMS6PZ+kskTm7
         xvxQ==
X-Gm-Message-State: AOAM532rWFr2CoiBVRXfrTXyQ7tY6c8FMrw8mByGzGoxPKsjAdiJCYtl
        4gYYBW6Ep26ZXuZpTV0GU/+RTeIPTD49FQ==
X-Google-Smtp-Source: ABdhPJxjNsTRc+N5I8B755CfBiTFGeM/aqmME/uYV4d3GUuY1ozhrClZ7TeMz6gsJQntrg4SgeJL0w==
X-Received: by 2002:a17:90b:3147:: with SMTP id ip7mr4521819pjb.13.1633488024220;
        Tue, 05 Oct 2021 19:40:24 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:b80e:8aa2:35bc:9d60])
        by smtp.gmail.com with ESMTPSA id q21sm17961406pgk.71.2021.10.05.19.40.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 19:40:23 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Update the correct suspend reason for disconnect
Date:   Tue,  5 Oct 2021 19:40:22 -0700
Message-Id: <20211006024022.111584-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the suspend reason for the pairing test cases to the
disconnect.
---
 tools/mgmt-tester.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 611bf3dbf..1a2aba7fd 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -10414,10 +10414,6 @@ static void test_50_controller_cap_response(const void *test_data)
 						data, NULL);
 }
 
-static const uint8_t suspend_state_param_running[] = {
-	0x00,
-};
-
 static const uint8_t suspend_state_param_disconnect[] = {
 	0x01,
 };
@@ -10587,8 +10583,8 @@ static const struct generic_data suspend_resume_success_5 = {
 	.client_pin = pair_device_pin,
 	.client_pin_len = sizeof(pair_device_pin),
 	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
-	.expect_alt_ev_param = suspend_state_param_running,
-	.expect_alt_ev_len = sizeof(suspend_state_param_running),
+	.expect_alt_ev_param = suspend_state_param_disconnect,
+	.expect_alt_ev_len = sizeof(suspend_state_param_disconnect),
 };
 
 static void trigger_force_suspend(void *user_data)
@@ -10616,8 +10612,8 @@ static const struct generic_data suspend_resume_success_6 = {
 	.setup_settings = settings_powered_connectable_bondable_ssp,
 	.client_enable_ssp = true,
 	.expect_alt_ev = MGMT_EV_CONTROLLER_SUSPEND,
-	.expect_alt_ev_param = suspend_state_param_running,
-	.expect_alt_ev_len = sizeof(suspend_state_param_running),
+	.expect_alt_ev_param = suspend_state_param_disconnect,
+	.expect_alt_ev_len = sizeof(suspend_state_param_disconnect),
 	.expect_hci_command = BT_HCI_CMD_USER_CONFIRM_REQUEST_REPLY,
 	.expect_hci_func = client_bdaddr_param_func,
 	.io_cap = 0x03, /* NoInputNoOutput */
-- 
2.25.1

