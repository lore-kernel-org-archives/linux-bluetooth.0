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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73630C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4475E64EAD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBPXeV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBPXeU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 18:34:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825E2C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:33:40 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b8so6360110plh.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NV4mCh1O2tdKISHhIpj/kqto2I7ZrYdJg+KpJgpm6q8=;
        b=NOwdCgmhcyWap+LCGyhSvYKKjsIu/chKFvvKLk7MqS75z8qDreMtrWMqSePyAq/psO
         Mo6JGjfDHejq4mP5J0rZHj6/JPZko6eMOat54fXFMXatKX06T25KXq01BocfK/bHMEu7
         XssKiUOEioF6JDjbxF7Im1SEbEDKgcutgQENC0G52vM9EVUTUWS8WSS7Dp0rXMVS9gtp
         HA1zzi1K9oPHE/vPSth/S0AjJErhid1yjasMf8PxgP4pPzBD6I1HRgOS8FpH8Kz8gLus
         KUxTtkSoSkpnXVP/r8FSxVFtNUeitEjr8TPeQGXgyvhnTP5mtjOUqF5Rz8SlMnChwD5x
         Ts1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NV4mCh1O2tdKISHhIpj/kqto2I7ZrYdJg+KpJgpm6q8=;
        b=ovp0b9FbPIvu3+NgRCSYUiB2uR149mACmvQqtrA5xdOc1S2ExvZtdkVivisAoT+mQ+
         LrBbRfQt8xJp+avAKUXWcU3unIkZZn1D6dS7L1OAP1FQ2Wq033lYvNIOgzx6U8EdEkLE
         Y2V6tQqld/n6vxRqoX8j2BAkvm42rbDMhmfmc7CLnnaNcJhZDCYtm//5pVurpoL65h05
         qp8J1H8WfyUQk2/iolCIfCBwWJgeeODl4Geybn0H53G2rQFxzTHRxnB1pHAP9KJXPNqT
         IVzFv/ZqwT1lWuhteLd65Cf0mkElmPF9bG4OME9XYCc1MCv22PvOdCjulM27Bl/rqWpQ
         4w5Q==
X-Gm-Message-State: AOAM530sAjmBAvi7ZtymajLWE8cHkaRk8mT2i27/xJDXb0FQOBBHUw/2
        ITp+hQk7JG9e/jwkooCTe0kZCCscx8yyxw==
X-Google-Smtp-Source: ABdhPJykyiN1JX04dBw44ZSS0LTC7dDQ4OdBNlyb3F4lixLQUj7UWSwZfI/9eTYFrRqDqc1u8FGV/g==
X-Received: by 2002:a17:90a:f981:: with SMTP id cq1mr6193589pjb.167.1613518419792;
        Tue, 16 Feb 2021 15:33:39 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h5sm99956pgv.87.2021.02.16.15.33.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 15:33:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] btio: Use G_PRIORITY_HIGH for watches
Date:   Tue, 16 Feb 2021 15:33:36 -0800
Message-Id: <20210216233337.859955-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216233337.859955-1-luiz.dentz@gmail.com>
References: <20210216233337.859955-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes btio watches default to G_PRIORITY_HIGH instead of
G_PRIORITY_DEFAULT so it takes priority over regular traffic or
timeout handling.
---
 btio/btio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 8230212b4..1f1c374bc 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -274,7 +274,7 @@ static void server_add(GIOChannel *io, BtIOConnect connect,
 	server->destroy = destroy;
 
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, server_cb, server,
+	g_io_add_watch_full(io, G_PRIORITY_HIGH, cond, server_cb, server,
 					(GDestroyNotify) server_remove);
 }
 
@@ -291,7 +291,7 @@ static void connect_add(GIOChannel *io, BtIOConnect connect, bdaddr_t dst,
 	conn->dst = dst;
 
 	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb, conn,
+	g_io_add_watch_full(io, G_PRIORITY_HIGH, cond, connect_cb, conn,
 					(GDestroyNotify) connect_remove);
 }
 
@@ -307,7 +307,7 @@ static void accept_add(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 	accept->destroy = destroy;
 
 	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, accept_cb, accept,
+	g_io_add_watch_full(io, G_PRIORITY_HIGH, cond, accept_cb, accept,
 					(GDestroyNotify) accept_remove);
 }
 
-- 
2.29.2

