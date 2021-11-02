Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6051AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 05:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF7A60F4B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 05:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhKBFw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 01:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhKBFw2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 01:52:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC64FC061764
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 22:49:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v20so14283196plo.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wV0C9E8jqNL/zygSd1deVMgqPpEJ+T0n3af606fnerA=;
        b=LoGCAwBtLNgOVXnSAHOMHpRBfM8KyDIy09O8Y7tMY54z2ZTxJxQPr5CcPy92k3BX2c
         wyYAmPuuUVD4eQHQxggmxCrAOpDIRF3BPI4OHPtVc4l8lSpht2qZFq/Iwp9+ri9rQBMg
         FKg0kpvdpeWrwJGqVbd6RRmRhgZb1zgfH8Q0EPBV33q+w4+tBo10UNBQrSmO2Ca4btwT
         wAFPJHm7+/ZoR6b/iCl+g+4HXg9q1WLBMVStsM8qO2LTR0BPJTrAPtwKmD9n3kbHOcFI
         zCxEbTNJP6plLDksDHfcruywbRzaVNrU7ELlopclWvZVahgua8meG0kV4FNjmFX2tnD0
         Rdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wV0C9E8jqNL/zygSd1deVMgqPpEJ+T0n3af606fnerA=;
        b=RUarES2B0YM5XoB5BIUel2qJvHmeL3WhL9O3LqgDnJggT5aWLSY2ihnu6yt+iNDsiV
         261AXKJs9uFIYFGtuQzJ/if8HJJYZUume9vjIacujokJUH/ZpZtPZ+FHhag5rmavFnxB
         iDSTZiBhIXORa4SVTmiiPYe96Neo8xWweXQNyjnFhLGUnD9BePHKXfW+eVlo6BbNfUkc
         ryJZfOBS00ATUGWDw1XE/ddV4UDyPk26R1etB11ubgTEAxuLznLjAh/rK+E2hb48pMFu
         FGNVh+O/4H/pvJaRfHIN49yD8i0KzGN0l2qYeeYKgX1PWlCY21UEUZHCow4eVUnYNRSh
         oIwg==
X-Gm-Message-State: AOAM533cDIaCxzAt5jkit0Fk+cHMmjFBHFi1fIbR+rN8xzfelVSKdMtV
        bFO1P3b1hb7MKbbv425sMCRuugaYpJo=
X-Google-Smtp-Source: ABdhPJzXiY5S0dqnVkXBCyYw+tahA0jY4yUwuS+IyT6bQ42E7Tjk4Mato1M8OJJL0Gktb3CCAjatHA==
X-Received: by 2002:a17:90b:3889:: with SMTP id mu9mr4214425pjb.160.1635832193990;
        Mon, 01 Nov 2021 22:49:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t7sm1212428pjs.45.2021.11.01.22.49.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 22:49:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] mgmt-tester: Enable use of limited/device privacy mode
Date:   Mon,  1 Nov 2021 22:49:52 -0700
Message-Id: <20211102054952.2898328-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102054952.2898328-1-luiz.dentz@gmail.com>
References: <20211102054952.2898328-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables use of limited/device privacy mode in some LL Privacy
tests that are testing the addition of peer in the resolving list
since it does require the use of LE Set Privacy Mode:

< HCI Command: LE Add Devi.. (0x08|0x0027) plen 39
        Address type: Public (0x00)
        Address: 66:55:44:33:22:11 (OUI 66-55-44)
        Peer identity resolving key: 11223344556677881122334455667788
        Local identity resolving key: 01020304050607080102030405060708
> HCI Event: Command Complete (0x0e) plen 4
      LE Add Device To Resolving List (0x08|0x0027) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Priva.. (0x08|0x004e) plen 8
        Peer Identity address type: Public (0x00)
        Peer Identity address: 66:55:44:33:22:11 (OUI 66-55-44)
        Privacy Mode: Use Device Privacy (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Privacy Mode (0x08|0x004e) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Add Devic.. (0x08|0x0011) plen 7
        Address type: Public (0x00)
        Address: 66:55:44:33:22:11 (OUI 66-55-44)
> HCI Event: Command Complete (0x0e) plen 4
      LE Add Device To Accept List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Addre.. (0x08|0x002d) plen 1
        Address resolution: Enabled (0x01)
---
 tools/mgmt-tester.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e9fcb2602..f3a533de5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -274,6 +274,7 @@ struct generic_data {
 	const uint16_t *setup_settings;
 	bool setup_nobredr;
 	bool setup_limited_discov;
+	bool setup_limited_priv;
 	const void *setup_exp_feat_param;
 	uint16_t setup_expect_hci_command;
 	const void *setup_expect_hci_param;
@@ -7160,6 +7161,8 @@ proceed:
 		}
 
 		if (*cmd == MGMT_OP_SET_PRIVACY) {
+			if (test->setup_limited_priv)
+				privacy_param[0] = 0x02;
 			param_size = sizeof(privacy_param);
 			param = privacy_param;
 		}
@@ -10185,6 +10188,7 @@ static const struct generic_data ll_privacy_add_device_3 = {
 
 static const struct generic_data ll_privacy_add_device_4 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_limited_priv = true,
 	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_ADD_DEVICE,
 	.send_param = add_device_le_public_param_2,
@@ -10202,6 +10206,7 @@ static const struct generic_data ll_privacy_add_device_4 = {
 
 static const struct generic_data ll_privacy_add_device_5 = {
 	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_limited_priv = true,
 	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
 	.send_opcode = MGMT_OP_ADD_DEVICE,
 	.send_param = add_device_le_public_param_2,
-- 
2.31.1

