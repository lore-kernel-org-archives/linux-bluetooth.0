Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD4C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 06:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2016113A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 06:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDJGqX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Apr 2021 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhDJGqW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Apr 2021 02:46:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCAC061763
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Apr 2021 23:46:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so4271611pjg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Apr 2021 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYznmFBAeY66NGe2y6S0jqFozilXP3ud1068M3Uombg=;
        b=sricV30RVHPFAKiPFi4hsHQeDF45Bao5IEeV39O0b65ORQlQ65p1+JWx2AlRJwpoM8
         C1W7syRy7K6kSnMZHZucYD/fsGP2vWJVzf81lV6ydOqXUaXPDkjU2nVr47q8jffhJec3
         69odfDLRUs1vyEvw2norpuOQjzL7DZk/fK+yQ0G1lEcH8/iFNLHaRMzrDrCoBc8lbPuA
         4wZwrOlGhj8bmh2KYDUPGgNXoNP4jSQjPMtgpmK05AkbsR1HE6k/OcaExW7TIKtnN8v0
         jNrj6UJl1xY77egijWbzkOXyQbea/X1/xCU6kB3H/L1raw/oCDYNwvxYV/ZfIUesLKSm
         +yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYznmFBAeY66NGe2y6S0jqFozilXP3ud1068M3Uombg=;
        b=O7al14dk0frVOyJ2KEEm9GJwCEpR4bV1XsT/f5MmqV5vIenHNtnB0wrua37mQCXFZU
         N3jT+sdXxn70H9ZqzFTdfSMrqClcZFOaaoIoikUMzDPmkJLWCTvcHS7vDgy+Na7/CTf+
         4VdX105TmlCLfonR1K+eNsBENS8b2OucPH+3LWPFUMDkGNMPU2LGHhzsJ1rZ7dXKyJkt
         ZQhrs0uIPnxr9fcybjUyjK5V5c1c7/8iL5z78MYevVjHBlPuC8usL0Y4I4XoZ603r3nS
         GV6H+O3I06nAYAyseO2KaVr7MZA5oM8/mJn9KylHsT8R2kDLU6gS6nt0vdvFJWiLh1d4
         uiTQ==
X-Gm-Message-State: AOAM532VGBm/MFT6/dLsS35h79VA1foqTVmP5vzH4LSMK3hRqsDA9mMU
        FEOiBVcssDsJNP1K2KPMCVO8y+uPc/0=
X-Google-Smtp-Source: ABdhPJwdjXMyf9zr0detnddOgOAQDOR0juDQbMUHtzkmLbp3GDBUCTkdxLRklVGvE3f2wCZVjnLHKA==
X-Received: by 2002:a17:902:7589:b029:e8:c011:1f28 with SMTP id j9-20020a1709027589b02900e8c0111f28mr16021005pll.35.1618037166904;
        Fri, 09 Apr 2021 23:46:06 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:991a:5330:6700:5cc6])
        by smtp.gmail.com with ESMTPSA id i22sm1155929pfq.170.2021.04.09.23.46.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 23:46:06 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] tools/mgmt-tester: Add callback routine for validating the parameter
Date:   Fri,  9 Apr 2021 23:46:04 -0700
Message-Id: <20210410064605.287884-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a callback routine for validating the received HCI
parameter, so it can customize to compare the parameters instead of
memcmp the full length.
---
 tools/mgmt-tester.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 1835ca079..ef37f0e03 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -280,6 +280,7 @@ struct generic_data {
 	uint16_t expect_alt_ev_len;
 	uint16_t expect_hci_command;
 	const void *expect_hci_param;
+	int (*expect_hci_param_check_func)(const void *param, uint16_t length);
 	uint8_t expect_hci_len;
 	const void * (*expect_hci_func)(uint8_t *len);
 	bool expect_pin;
@@ -6632,6 +6633,7 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 	const struct generic_data *test = data->test_data;
 	const void *expect_hci_param = test->expect_hci_param;
 	uint8_t expect_hci_len = test->expect_hci_len;
+	int ret;
 
 	tester_print("HCI Command 0x%04x length %u", opcode, length);
 
@@ -6647,7 +6649,11 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 		return;
 	}
 
-	if (memcmp(param, expect_hci_param, length) != 0) {
+	if (test->expect_hci_param_check_func)
+		ret = test->expect_hci_param_check_func(param, length);
+	else
+		ret = memcmp(param, expect_hci_param, length);
+	if (ret != 0) {
 		tester_warn("Unexpected HCI command parameter value:");
 		util_hexdump('>', param, length, print_debug, "");
 		util_hexdump('!', expect_hci_param, length, print_debug, "");
-- 
2.25.1

