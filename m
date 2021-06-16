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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B53C48BE8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 23:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59487613B9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 23:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhFPXja (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhFPXja (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 19:39:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DCDC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 16:37:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k15so3480841pfp.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN1pbUfQd8Eh24sxWfvqaQUWvLSO0gMwqa1MI7/1idg=;
        b=R8yfvQYSybwBDjKPKctfabkBPK3Daa3yT+NeZLo210xZUjWixXjo0OYe0i4Q4aMF78
         41TE9xJeQHyFPRIYvPU5vpMlOfTONTocojGLg/ioRa1mpTBhzmBE1/n/xIDeH1mQoUsD
         wzJQc2jYLO1XJ73/5qyE4YwMYy5V9yU2h5aoWtTu/uwKjdCv8Aeziyk+xZmAZfVknlF6
         HK8OK1AzDLKCPLaUMOu8KtV7Qc9HllUawQF0MvqqbxdBO8svFCVSIKwQZtdw+xDl7zS5
         Nt6wUNTPRrJpiTP/cXDBMIUCFXTs28yIcQNdfDLc+7WAu3hHME8bN9X5gIbWUcK84tAM
         qiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN1pbUfQd8Eh24sxWfvqaQUWvLSO0gMwqa1MI7/1idg=;
        b=S/mNY0i5TCcgews6nKJO56QnLA0Ww1kDBiBa2fUleRM4crCE5GUxyI2xvRuQmkrV2L
         J5wTKGlcJhorF3VEtnh3Ry3h7Oy3ZqBl0AyVA6PR6Q10o+bRmIk6G5C/c9l1cyd6/9dW
         tdC8nOaSD5hKwfTWj9bhMs4gti76neAAO6VpFZCQdAxj5knDxE0KYdyME4nLr/SF3uWD
         kyRBFU0WoJ9oKoCVjGmxkFSCYHmHF40Bw0zkK/d1luPR/tnZBqQ+AXVF5ee7VTj/GalU
         t78MisihgnH2jBR2IxbsBuYY66hBLWl3RgyqSlgNXPco7v0jUq+LMbCssxUP0IG1i0Qo
         mMVg==
X-Gm-Message-State: AOAM532TOxrrhdYnuqRYUxA7L/mKqFzNS1ucDKMWknXID9zVsiJQxig4
        jFCVZGDDEq76jb0ZqqI22MQL6TPm7XE=
X-Google-Smtp-Source: ABdhPJyvJAD7lPwfjToBopIyHssbdbzpH9QmZdngz2AZMY0Ca2/4iSUbZtYzKLK4xxYF6043dSs+KQ==
X-Received: by 2002:aa7:949d:0:b029:2ef:d1ca:ddd3 with SMTP id z29-20020aa7949d0000b02902efd1caddd3mr2276499pfk.39.1623886640529;
        Wed, 16 Jun 2021 16:37:20 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id u24sm3311059pfm.200.2021.06.16.16.37.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:37:17 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v2 1/2] emulator/btdev: Update the white list and resolving list size
Date:   Wed, 16 Jun 2021 16:37:15 -0700
Message-Id: <20210616233716.1920026-1-hj.tedd.an@gmail.com>
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
index eba9f57f9..d8d6fbc8b 100644
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
@@ -3393,7 +3393,12 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
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
 
@@ -3678,7 +3683,12 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
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

