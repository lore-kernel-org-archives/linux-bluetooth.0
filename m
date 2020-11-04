Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A59C56202
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADAD22203
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 23:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFbhY/7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbgKDXmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbgKDXmd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 18:42:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706FC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 15:42:33 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i7so192610pgh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 15:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yytsr00+6Kp33M5vY3Jf40tOEkQR8081Jx2QjpPNKpM=;
        b=fFbhY/7iEzmKzuKMgNTCpl6re4tZf7KqZ4u2Xr1i6YnJB747eG0/jBjOTzEVM6tSsx
         Ws5DSYURK/gYtyz2A3ZepaA84JkBvSo7Fu48zXdyw6rWYdc2N8xOrZJpcUcLvEHNfTZ1
         I3jyLtQHdGhUj+1aA5Lh/n5QE3NbtKNwVgmehCQS0znVZWldyH6tZXr+liea0oZSiRNG
         Y+CowgTxSKz2z4sy0IwoQaQkdo0+jD/BtJHpQah3UZR2cyHQxdndCLyBUfgnYjnsl6Fu
         whOq0ZlHAWfIrZQamiDn5/+kQVnkQ53m/Fefjf2efYJhk4vKnBPH20dkJ4zKJ9V8f4G7
         XooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yytsr00+6Kp33M5vY3Jf40tOEkQR8081Jx2QjpPNKpM=;
        b=MQ+jOuwehYK4xngxNXqfLP/cQgqkJrS9Ox6Wys+n2fiQ9yCLkO/sxphfU3RHWmA11l
         gjXtHH/ONj9RihOXJBY2MWP0KLrrupQqLPoM5ZCBixTipVzKhZ3vciiTWLWd5W2gqvr1
         uRnqL80jucWZ+HIIArG1yft3tado71lb1LThDUTACsMFmVP2Fwv7Vlrbsns9e9WBi4Ex
         8DakZfeOCj/weRElbjsGfaECB2J2dYoRncvvssRaj/nI+hC5ghoJgFVPCwQj8hDH4xLK
         jh8cBEg2Z+vfL0NKUxN1hYoVvXEBxM8xjJ+vMZjif8zvSQJOX669QokQL+SUAe5MFpBQ
         hIrw==
X-Gm-Message-State: AOAM530ur0OJ2hrCd1rKLTHxL6GstVwwIfO0MAkv5yqnX+J8dh+0mVrj
        NtJn1qpw0Z8dcdraMUUmTqJuRc5if8Q7AQ==
X-Google-Smtp-Source: ABdhPJz9xzNI0H4mykZOMY9w2F2XIDwuUhWztyblolJgsNNm+REGHPKeg/kuNn+FAjQ0HMPJoPgqHw==
X-Received: by 2002:a17:90a:540e:: with SMTP id z14mr274258pjh.187.1604533352343;
        Wed, 04 Nov 2020 15:42:32 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 30sm3361513pgl.45.2020.11.04.15.42.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:42:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] test-runner: Fix using removed options
Date:   Wed,  4 Nov 2020 15:42:22 -0800
Message-Id: <20201104234228.2257427-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes -nodefconfig and -balloon which are not longer valid
options:

  qemu-system-x86_64: -nodefconfig: invalid option
  qemu-system-x86_64: -balloon: invalid option
---
 tools/test-runner.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 6b7c33734..5d2dbb992 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -181,7 +181,6 @@ static void prepare_sandbox(void)
 static char *const qemu_argv[] = {
 	"",
 	"-nodefaults",
-	"-nodefconfig",
 	"-no-user-config",
 	"-monitor", "none",
 	"-display", "none",
@@ -190,7 +189,6 @@ static char *const qemu_argv[] = {
 	"-nographic",
 	"-vga", "none",
 	"-net", "none",
-	"-balloon", "none",
 	"-no-acpi",
 	"-no-hpet",
 	"-no-reboot",
-- 
2.26.2

