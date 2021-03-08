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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896066525F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 22:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCHWLS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 17:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHWKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 17:10:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2384C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 14:10:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n17so1994488plc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 14:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2fPOdA2Ht3DVZCeUZ8JXe38aGyGDP4IZUzHum7DT3A=;
        b=EPkFsAegXc/9JNJ2iVjejRp17mPa/S9lI2ihAoPX+hUjm1BYcyVYz3Elbfn+MImS7y
         wuFsRLvi0DqgU81Nqr07uOgcwVgT+CaW4XWenr1Swu0LjjXGlo3WyrKJyVJM69/U/u5m
         TTAJMoRAuk+F84woswYmUNLj523+/NxDZlgFrqIMUA3jdkFGF+wYOoJ2JAUcMTM4oK8K
         E8lh9krF0t40ykmuOy4HMSmi1DuXY1vovH2i2Bt/RG4qKIo3vl5XiAZe5pwYjU5cLyvp
         P7uEysdj/Jmh5OSjncPUnjBdNWG+X+mWGCuEUKlhL8U1I8EKGqb0flIp2MXdJfL8EKm+
         lNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2fPOdA2Ht3DVZCeUZ8JXe38aGyGDP4IZUzHum7DT3A=;
        b=MHDhHXnZ+iia6r19+rd3HZHT9YHSEJKdMHcXV1eblaIZ7f7DH5/ldJ5fPyTWLU4lm8
         a3eZ3ZGodIyJOU9zKah4d7ukccudSqS2ONqW1Barahv/R5VYINTuMpkaJ0oJXDP2DpI9
         aIL4JMW34yumuRFV3zvXskoivuKmG4hSnfrzG9GsC2VJA728J8bj0Vc/Sv9I7jej1o5o
         onK5lMFetW9EPvJ8v9B/Zasaxr2/r6TrGVR0JP2qblQXYa5mE3hOdRtsklDGQGcR3JaY
         lD2y66ZSJ9+iftX6QVlG0g+Mqt4ds25bAK3xU2JfaUgBkJbSOqchOi7MNXlTIcCVralg
         mApw==
X-Gm-Message-State: AOAM532I41A+c0G5/CO5G3hJTfvbWuU7cI/020wj4hpQOrqwv8oJIz0i
        pg5tItBO+xNnbA0tswj/L2RstULyM4vsoA==
X-Google-Smtp-Source: ABdhPJwcU9bojXFCMQ598IT1tN/Xuv+6DHxJ+0UkQiyw7CTZzcDsheEkNrhehammZdW6llwTJwAOow==
X-Received: by 2002:a17:90a:ce03:: with SMTP id f3mr1029156pju.195.1615241448234;
        Mon, 08 Mar 2021 14:10:48 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w79sm2977095pfc.87.2021.03.08.14.10.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:10:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Fix invalid access
Date:   Mon,  8 Mar 2021 14:10:46 -0800
Message-Id: <20210308221046.339931-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ident can be NULL when printing user logs which may lead ot invalid
access.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index a72b424fe..8b87d3d8b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11306,7 +11306,7 @@ void packet_user_logging(struct timeval *tv, struct ucred *cred,
 			label = "Message";
 	}
 
-	if (ident[0] == '<' || ident[0] == '>') {
+	if (ident && (ident[0] == '<' || ident[0] == '>')) {
 		packet_decode(tv, cred, ident[0], index, color,
 				label == ident ? &ident[2] : label,
 				data, size);
-- 
2.29.2

