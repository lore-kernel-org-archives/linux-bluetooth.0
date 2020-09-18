Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B39C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 01:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B318C2087D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 01:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH5/cCLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIRBKp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIRBKp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 21:10:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B2C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 18:10:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id r19so2099097pls.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 18:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0xM1qNB/p3ifzv7crdTb3hiZTxDeC5+s7eoLwsd2UE=;
        b=eH5/cCLHfbmch/MgBaNgIBL2EqhLlaOSlPDeHctnRwIYnvgKjMJBXY+olQpMfDlMUs
         TiSLM3DLd6pOUjtHpGMrIg1RZ1i3TEzl+8tDVApVnJg69aeQA6ThfA5t1QR7lurqbLyI
         /NfZRbUfeU7xH2DwWqlVyTEqRd8vEUIg0Tw7uEix10a9B18kOv/qPxf8NvpH6XsvYVld
         A+pOqTeFGyw4VkJ8H/y284gzsoDEqVcyhT5xQzkrAYAsk8tyNAU9VOwhmTQt2mvTucXm
         gtE5CF7UfP71c49ZzFN/jhJn8q+BEkUv7UwiaMzQU/1ajqd4a7QHNKfq69K1TNIYk3vq
         VLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0xM1qNB/p3ifzv7crdTb3hiZTxDeC5+s7eoLwsd2UE=;
        b=YYFvBk22I8cqFa/89FrnwzI5e9u6PQNy/8nsyVBH68NTj+mDnvbkfoE+oVW8Ywxicy
         Cr74bRWbhuQdwNde5e09B+Ve/uD3efM3y0QWa4trDiFxosRIbv9Rbbxbni7yRRbycwPu
         M5GOUIB72r0Oo5WrEs9vWj35dd7lO5bIUH3XgJXi7BF4gd7v8RBd6Hh61kdGg6vl8RtA
         G8keI5D+zk2fqj1by4qrFrodcEhu1HHN0xmiDA7QiVk+8Dh9jDues7RVCLKJ7jnSnkwH
         Q3oMiuL5vvTwnv/1sKuKHz22iy/dmTxJIoxOrgILPYeWIx2w5G1bKjoJl1YDInUWsIo7
         tvOg==
X-Gm-Message-State: AOAM531NcgZXgf1YaTTwEdOyLpPRdcjlAyaxw7lKEmexy/gupnxva85H
        wIn5pdMYXDFrdwklotYm6GSfdA5Ak+E=
X-Google-Smtp-Source: ABdhPJz13zmOXwlA4GPpDwzvM4dJHZ6RU5eV3hys5JyOSa6Na6tFcV4tTHXYXKmS6Sy33ZwfXI5axQ==
X-Received: by 2002:a17:902:9b95:b029:d2:219:e438 with SMTP id y21-20020a1709029b95b02900d20219e438mr3747875plp.76.1600391444048;
        Thu, 17 Sep 2020 18:10:44 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gi20sm850005pjb.28.2020.09.17.18.10.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 18:10:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avdtp: Fix not checking if stream is already set as pending open
Date:   Thu, 17 Sep 2020 18:10:42 -0700
Message-Id: <20200918011042.3141447-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving a Open command the stream will be set as pending_open but
the remote may attempt to send yet another Open command in the meantime
reseting resulting in another setup and yet another timer leaving the
old timer active which will likely cause a crash when it expires.
---
 profiles/audio/avdtp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 782268c08..e0c6f44f0 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1687,7 +1687,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 
 	stream = sep->stream;
 
-	if (sep->ind && sep->ind->open) {
+	if (sep->ind && sep->ind->open && !session->pending_open) {
 		if (!sep->ind->open(session, sep, stream, &err,
 					sep->user_data))
 			goto failed;
@@ -1699,11 +1699,13 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 						AVDTP_OPEN, NULL, 0))
 		return FALSE;
 
-	stream->open_acp = TRUE;
-	session->pending_open = stream;
-	stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
+	if (!session->pending_open) {
+		stream->open_acp = TRUE;
+		session->pending_open = stream;
+		stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
 						stream_open_timeout,
 						stream);
+	}
 
 	return TRUE;
 
-- 
2.26.2

