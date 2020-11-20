Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A436C56202
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0692C2240A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2hIClu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgKTUHb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgKTUHb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:07:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B39C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g7so8928875pfc.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=uz5Je2GO4Y4lUeU8Nm3qiNFyYWK2y4YsXzOtpUfdpFg=;
        b=Q2hIClu+OqOvox7gD5M1jE0DKSJSYKiMcGkB7/b8L3vEF3quGc+YY8Aj7hfEFgB6c6
         AGp5YlcnAWJhzdYpvxd0erXiAQS9vbACB6G1HGEGgdAO5FSn+zuAcrCO43ZsNbdZjUM7
         4Wlvf+NF0+g1VvxR9hAQ7nx2BmNAJJ9HhaZlUIKj5PWaLLzFrB+w2Has/gFceaI1vYgW
         6C8rhiKXvmUmjOVPokgylY2qys6UnwSQEwACyi7hTFKGcBtfdBR6lxpg5IOtc3hUNYft
         pk/IV8FDHowA8W9b0aZN6IBR0Dm15p+5Sk3ZTKzDE+m0RNxs/vN3qbG94p3jdTgDATOk
         6SkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=uz5Je2GO4Y4lUeU8Nm3qiNFyYWK2y4YsXzOtpUfdpFg=;
        b=k/A4818a+aqirt0oaQSyX44SorMJKtByZPqtmwvp9rH8MyRg0v7+TuJD1jdglGoQ0P
         vPVfkDfope3zXP8CAgPQvsaGH/c/bhgXQqwtwSHuAJMSpHCIzkqyPg5LxnHWMl6wWloX
         ISwWIbY3h3SlPTLeCAznzA8sW/lVLENM/+Aak3qWbeiDntpItODkiW7F4dX0x/1ts1sd
         DfJ8Qm25zM3bCUlkS3qRvWXYtq7RcDF2yrbLqtwWlTJ7D5RwAzvo/77+OUDUSFXowtDO
         e2hJSGPAJwuNZ4Ckm+w750Td9j4ED/tFGsYlNKN4Z7yo3erk4o39Q9QymW3XegkcJo0F
         FaXA==
X-Gm-Message-State: AOAM533HASroFKkHC72p5/ZeYW4ILE+peecHUnZ++O11DsKJH4QHU2PF
        2n2bI97eqo//kBzT6UcxACKJ8zHCA3E7rw==
X-Google-Smtp-Source: ABdhPJwRX5ukqWMhML/QTisBNgKvVYnJiDXbb4F0YOV1tAwVfPHgdVy2l48jeX1R6JJSNUFSFVwwbQ==
X-Received: by 2002:a05:6a00:2305:b029:197:a56b:899f with SMTP id h5-20020a056a002305b0290197a56b899fmr10483799pfh.52.1605902850813;
        Fri, 20 Nov 2020 12:07:30 -0800 (PST)
Received: from han1-mobl3.jf.net (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id t5sm3979267pgt.15.2020.11.20.12.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:07:30 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     tedd.an@intel.com
Subject: [PATCH 3/6] btio: Fix the unchecked return value
Date:   Fri, 20 Nov 2020 12:07:09 -0800
Message-Id: <20201120200712.491219-3-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201120200712.491219-1-tedd.an@intel.com>
References: <20201120200712.491219-1-tedd.an@intel.com>
Reply-To: tedd.an@intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the unchecked return value.
---
 btio/btio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index c18b6a012..8230212b4 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1701,8 +1701,11 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 
 	/* Use DEFER_SETUP when connecting using Ext-Flowctl */
 	if (opts.mode == BT_IO_MODE_EXT_FLOWCTL && opts.defer) {
-		setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP, &opts.defer,
-							sizeof(opts.defer));
+		if (setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP,
+					&opts.defer, sizeof(opts.defer)) < 0) {
+			ERROR_FAILED(gerr, "setsockopt(BT_DEFER_SETUP)", errno);
+			return NULL;
+		}
 	}
 
 	switch (opts.type) {
@@ -1761,8 +1764,11 @@ GIOChannel *bt_io_listen(BtIOConnect connect, BtIOConfirm confirm,
 	sock = g_io_channel_unix_get_fd(io);
 
 	if (confirm)
-		setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP, &opts.defer,
-							sizeof(opts.defer));
+		if (setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP,
+					&opts.defer, sizeof(opts.defer)) < 0) {
+			ERROR_FAILED(err, "setsockopt(BT_DEFER_SETUP)", errno);
+			return NULL;
+		}
 
 	if (listen(sock, 5) < 0) {
 		ERROR_FAILED(err, "listen", errno);
-- 
2.25.4

