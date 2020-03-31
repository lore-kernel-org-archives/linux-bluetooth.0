Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDA5C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F355208FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="EAuHlLyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgCaMHb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:07:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33713 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaMHb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 08:07:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id x200so9924196lff.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPNCoKAOf9UJrzUxNb9VdmxkncVrD3tly2wk6unxj+4=;
        b=EAuHlLylWmupH8eBK7Yq6wr6aYKqqi9+raeb9Wc3+kKFL4nqAIlT4EhodSnFiryqzL
         D5c+MCj151uNEzHleJzKGTPHowL+QiwLXiY0yxvkQEpern5rGDUcS1on4SAI5Tb3EdoT
         oOrrDyYEikgszm7ARrxNOQTQ0Mg2GKa9rxqHYawv8XSc0xrpDjXBnHmb1yEISJjLw5ht
         XOwJzTRVzyFpqk/obgvRBpxiYy09wCXeA1Sys2i+ZSJucvO4LeDXGKB9NDRBdAVvvRPO
         37lZmndw930Rltw6YtspKVpXrOc4MOHyLrd7LdQgFWkn9P/5ZL7KfWM74Cv/31AiixYF
         8W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPNCoKAOf9UJrzUxNb9VdmxkncVrD3tly2wk6unxj+4=;
        b=IXeYnMAAmUfV34/VWf4+A5OlJd9SBvhXL4lnx6ASIZ6Diozkpc9P5rVKJEfRd9Znme
         lX7xZuDfRn4X/ZoNyftzVZ7WMnJj4Kz7v6ui+QrFpe+Tf+FHSFVpBYvQe/97rpTVQvm/
         rVQD6g4jJ1Nof2qzYezPGOH2vEePEhjX+Pflfz8qu9tCYYbRofkCAvmFhQJZFjB+BqeV
         wGAwOahnuGjfF7IotlJ2qT6mYX/b15ef/p7/ufrjmcDj8BezQFGxgr9g4HL8BHyWO6Is
         S8wYYbkjM/CmRLPB/R2Ip4VXqczRi7D5prgStkz1GhB7d2P/fT5W9O3uupIgsvkOqRhB
         PPJQ==
X-Gm-Message-State: AGi0Puax1gPpsHGLtswAsxkOz8BDZQiuR24pW1LFFq1PkCEaPwJo6ZMI
        4l8ZJHywnMT2CeTxfBpNRm1XDkAH1zA=
X-Google-Smtp-Source: APiQypI86w0QFVN30TE8MQCt4w72L6HVcNHtjbg1xmMipvoMJESsKTMEyD/jcckdQtO0kQ0pSF7BkQ==
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr11442498lfq.149.1585656448693;
        Tue, 31 Mar 2020 05:07:28 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id s10sm8691695ljp.87.2020.03.31.05.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:07:28 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] main: Fix GATT option parsing
Date:   Tue, 31 Mar 2020 14:07:25 +0200
Message-Id: <20200331120725.376209-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Key name is Channels.
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 7b927ac79..98621fddf 100644
--- a/src/main.c
+++ b/src/main.c
@@ -109,7 +109,7 @@ static const char *gatt_options[] = {
 	"Cache",
 	"KeySize",
 	"ExchangeMTU",
-	"EATTChannels",
+	"Channels",
 	NULL
 };
 
-- 
2.25.1

