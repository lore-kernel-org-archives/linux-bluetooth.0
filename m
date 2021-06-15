Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE94C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CAC61350
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOTcO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOTcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 15:32:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F6C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 12:30:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 11so8986591plk.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN1pbUfQd8Eh24sxWfvqaQUWvLSO0gMwqa1MI7/1idg=;
        b=cjIGKSUD/1fZqDuCXSMAKRU0N+TK9th9TOjzmYhDtyEpqdwLEsGVM6XrDt3LaBLTPr
         ZFQ8Nfv3TCHWAZpl4fS3KqMAIuys+p/0BwZCU7rt+6aWGj4QYZ/JDLsnCHNWY0baprr8
         GCDi+wRkASSIuryGylLUDBq70jj6Ej4cFK5R3BPe0gcJV7Q3s/KjvDP476NpWWoDVMCp
         v9+rPC/YTimoMACKq/UNNDMccir/+1tFhhlgwvXtpFYVVPAqXJBREcd/uKHtl6E3DeYL
         wCWoTgbgV6mY1fw4nGMehbNKHymHFFvoHFxYVUu5vEioYxQ4XxQJYUpikg5GKbsgFfnM
         GQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GN1pbUfQd8Eh24sxWfvqaQUWvLSO0gMwqa1MI7/1idg=;
        b=cwJ29eF8kSxm8MSpJI1Vrx6Uw+/3VcODwM9APa5KH21YHI62O0N6DCd7gKMvH33WDd
         dt4QVef7VXl7JFAGkdGagwsqz1Pl0ub8tyVtSBRUbxbUGF9bdV6tGbhludFw3HC9ATFu
         DY7h9Kgep5XlgVXxSAKV7sZiSbp0d2c1e8a4B5w+SIKKIhaIWj5sDLhtZfiHWbgJF8Lv
         BOOB8g/wS5QWI1rXiyXfQzgH066fXkmr2WcGG6ilyJGmMLLr/XoPr07/JsaNet4rdgHh
         9XwNf7vri1eYyNkyEsM1ROfDF18vKZF2qmkxOQakBtIAJWkeN/QmRzA4mTN/2DiT4BSt
         yBhg==
X-Gm-Message-State: AOAM531/752i4wIoKvtMu22b8/2l4oHX1DMKfA4rYspXoe9oNoS4rhFD
        NfmK7/8ypUFvF3zJ/H0KiRtCy19Bgmc=
X-Google-Smtp-Source: ABdhPJxq2aD3XHBhq4OtnfDDqvwl0DE1CXJwOh9H+SXWSn1IbbwD0pm41qCBDGnkG8EeYUCGh5LFpA==
X-Received: by 2002:a17:902:9a01:b029:11a:d4e:8f4 with SMTP id v1-20020a1709029a01b029011a0d4e08f4mr5337347plp.52.1623785408360;
        Tue, 15 Jun 2021 12:30:08 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id b129sm8613372pfg.19.2021.06.15.12.30.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:30:07 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH 1/2] emulator/btdev: Update the white list and resolving list size
Date:   Tue, 15 Jun 2021 12:30:06 -0700
Message-Id: <20210615193007.1854488-1-hj.tedd.an@gmail.com>
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

