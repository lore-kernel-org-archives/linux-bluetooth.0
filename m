Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DAC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 14:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1037207BC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NUZdhXe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFAOVF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAOVE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 10:21:04 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88BC05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2020 07:21:04 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u7so3253vsp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zl0BzJZIWU/alHJduKdSmJI0Dbc9zTzRj4cdjL7Z3dU=;
        b=NUZdhXe3ltwCq9CkNmgizossLkQ6MGNBs7BlBMMxYAbeb3nkgL+LwanAGUD5g60Mkt
         I8r8peO4g5V4b1Kqj54jR/4k8lVUXmumPwPpTmbcgQJo6pqb2QfWEoeV5pkcs9JQjyll
         aqwkGqo24xhb1BQePHP3pO0h3GCdmLw3QuM2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zl0BzJZIWU/alHJduKdSmJI0Dbc9zTzRj4cdjL7Z3dU=;
        b=YEYLyHRimGmwq7+Cv81t8hb3SAcdk2SA8tt5kWMlicyDhSGM0f4kvYzR+LOxc0HWNe
         n4fQ6mg859zPMoSwW8gXzkDy3RJpJ5rQSVYcLnnV32Ip9JL+9RquboxKl1gA41NTdK5X
         VY4Jvbw7RmmmUEmpqB5Pu+rPQHOWjFGY0tfG70W1/gh9m5anvLylENc/tF3ABNUmDLzW
         C2MLhtEyIZwONzwtA57BDEn2xn/nsMRe6thPFgMgFRQ/Nb/gpiAUR41w12jxHo8uZjuT
         u64QbFYF85M/skDGW03VET6drAdWJVk4XfZhpdTy/6n9lxYzjzVb/77Oe+NbO8irq99K
         8nEQ==
X-Gm-Message-State: AOAM531Z3OTDRGcna5gBd/3QnCDugpLae+knITNdcBhRoU+cjF5yuAwA
        mHRFJueIVu69cdVIanbc6hTvLMhWYbE=
X-Google-Smtp-Source: ABdhPJxawxc9qqp/uRu8p5QxOz9djB7yQP8gYor8TUTkHf6DKoosF2OzMQXP2XbfPoMJYwInp912rw==
X-Received: by 2002:a67:4383:: with SMTP id q125mr8937448vsa.167.1591021262757;
        Mon, 01 Jun 2020 07:21:02 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id z15sm358437uai.12.2020.06.01.07.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 07:21:02 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1] bluetooth:Removing noisy dbg message
Date:   Mon,  1 Jun 2020 14:20:59 +0000
Message-Id: <20200601142059.136748-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch removes a particularly noisy dbg message.  The debug message
isn't particularly interesting for debuggability so it was simply
removed to reduce noise in dbg logs.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/af_bluetooth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 3fd124927d4d..b751a7c1b20f 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -453,8 +453,6 @@ __poll_t bt_sock_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
-	BT_DBG("sock %p, sk %p", sock, sk);
-
 	poll_wait(file, sk_sleep(sk), wait);
 
 	if (sk->sk_state == BT_LISTEN)
-- 
2.27.0.rc2.251.g90737beb825-goog

