Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8B9C48BC2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 00:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A25B61351
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 00:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFXAjW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 20:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFXAjV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 20:39:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE3C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 17:37:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so4826426pjn.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 17:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toIwfYd1migbfBFthqNXleyyHdHwR8ESqVb1r7SHJHo=;
        b=d+jGe++Wb6OSQBgld2CgyykdlQ5X5i1QQWD0mECjEgjKETfpK3JYDpKgv++xGz0kcc
         A6VTJj4jdd+qXtdQH+6Cs9AfvK67YZF8OcRW4/0+zhLyvQMR0HtjZtwcmzLoMhj/chKD
         OkJ7/VZBpL8lBAUZYpe45ZS3JthouZakVY7YJjAoZEbNFFbb14w71+DnkuO9CYzRGMXb
         ZY8EviJActSHw20pOtsoZAG7qQOwvS+gI/xW5FbH+rEmk9L+/NlR4iKZwnOM5ofaVIwV
         3j5Hq2kORQGfICDWJO169hyEgwqxQlEldyuKXLy7YadpCrZuUrkMZKxwlTb/W5p6VaCH
         Ce1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toIwfYd1migbfBFthqNXleyyHdHwR8ESqVb1r7SHJHo=;
        b=eA/uG6tbe/83Z231qs6a9PIZSkTgL1++Odf5VHWkrLq7xjvmGC6YDPry72piOqDu31
         +xdCaVbjuVpS1LPKk7oiCI7s2NxesSB4kHK2BQkB1x4csyDqgToVdOqyNJjpH0GNLCHB
         vV/aEXmH6tM4K1Tda4WOb/Kug0nvzDDKriftJmLolN4he10MoHhVhgC45v64tuC8VEh4
         pn83LjIdaNdSUeQFBpcqVYJFSnx60GE5GSDvTWrehCLkuTxsmb9SktO63sSfl9tXP5B4
         EFlmrxuP2EDBiYyuZFAHc8xZ8GtWrniTBSCTF++FmgLMYGUNFaWA57MzOJZ66K0Kjqld
         kUeA==
X-Gm-Message-State: AOAM533fNNNcdDSjN1wqG+CfEoLEXb2UfjVgp49advU8w5kLQHRAC0rm
        93D5vUAutEjJQmJNi7+L8UHjYLfOB/8=
X-Google-Smtp-Source: ABdhPJwXeau32arI/Pcm3raE2XJqdqx0jAlMp3KD4y2TFRqOsSlM3fdlH/iA/3bGoK3xPXn12BMiMw==
X-Received: by 2002:a17:90a:5d92:: with SMTP id t18mr2300956pji.186.1624495021337;
        Wed, 23 Jun 2021 17:37:01 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::5820])
        by smtp.gmail.com with ESMTPSA id g11sm274543pgj.3.2021.06.23.17.37.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 17:37:00 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v3 1/2] emulator/btdev: Update the white list and resolving list size
Date:   Wed, 23 Jun 2021 17:36:57 -0700
Message-Id: <20210624003659.32410-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the white list and resolving list size to small
number.
Also, it update the size of white list and resolving list to 1 more than
actual size when it is read via HCI read size commands. This is used to
simulate the case when the list is out of space.

Note that the read list size may not represent the current actual list
size depends on the device vendor.
---
 emulator/btdev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 90457a5aa..202fc7996 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,8 +33,8 @@
 #include "monitor/bt.h"
 #include "btdev.h"
 
-#define WL_SIZE			16
-#define RL_SIZE			16
+#define WL_SIZE			3
+#define RL_SIZE			3
 #define CIS_SIZE		3
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
@@ -3402,7 +3402,12 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_white_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = WL_SIZE;
+	/* The size is not fixed and the actual list size can be different from
+	 * the returned size here.
+	 * In order to test such cases, return more than allocated size, and
+	 * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
+	 */
+	rsp.size = WL_SIZE + 1;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3687,7 +3692,12 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	/* The size is not fixed and the actual list size can be different from
+	 * the returned size here.
+	 * In order to test such cases, return more than allocated size, and
+	 * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
+	 */
+	rsp.size = RL_SIZE + 1;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
-- 
2.26.3

