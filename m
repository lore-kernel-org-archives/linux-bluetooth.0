Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7846AC83F2F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 21:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347488AbjHaVGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbjHaVGG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 17:06:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D6FF
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 14:06:02 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79545e141c7so479539f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693515961; x=1694120761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=831ueawN1ZuY6C4hHW57A2awdydSD+F9hRNVyAv/uCo=;
        b=NNIb9tDh0p1akxPV1i5JAC95RftN9dpDJrH7njcg0zuMPp62PQ88j8sFseAxxKRl/C
         WCHV7E0PMOAi3LcNBsPFOKjqQKHVgc7bCbFqCY69czbbUr1nRwqqU5+yx9aTd83Ov/a7
         XAmVMeO3V0+TuMJFjG8Gy/ymTfsSK2Ydp/DEqzn1Z+BgLMX4HEhn6ip/fSK92sagN028
         +a70sT/A7cLB7CMmS/MksLuSpaXlxcTxVEOvJBIMX9AdERLwBAk+FiCmQLtYAs24aTUT
         l6QHrnsNcrkJAPbRLZK7dB45r45UzqvZSq/+OEyhulvUMlos+6Bfrh42B3xLEa5wuYFi
         CX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515961; x=1694120761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=831ueawN1ZuY6C4hHW57A2awdydSD+F9hRNVyAv/uCo=;
        b=WHWBc9M3p1e+C4/blu2acf28937X65s4gng7utceyJiSiPeNrUA3e+xI67yVQnfw3D
         lkx5dZIIp5WlXRPT2zQt02iFMjEUkC/Eb+FcTpiN68a9ARr5J2/Qi2rKc5NNXf0lOTtK
         ybM5iIvshK1+XldGc/JmYz/FWzIiVO19O9qRwfR4JG+GMrsUYPScWlTR8s44gobVT01B
         tA8zRJCAB6o9QQF2dzLPOqRHJB5vjOht9nieU+/ahkPtrhh7ppJc/Z6Az80b2hi0kRNH
         rO5IXW2WgucSRIVJ59LCy5M19pb3lXIJoEHWgS9QzQ/iG29Ac3ealVqjm4y2bTPn1zLu
         QMdw==
X-Gm-Message-State: AOJu0YzBAHKa8Z9Tuz0qeJ8Z2HgkeO3m0CAxn/d0sRsKHRAVC/shL8Kv
        sWu0RimQ1FdkNsgbN2ZCmqcP62e0nyI=
X-Google-Smtp-Source: AGHT+IErC0gs3XJS41TyKnLcvxesi1KBDWmnHUzyBUMIMhGUz/138msLrVUpi1PYPFQptE5sKU1aPw==
X-Received: by 2002:a6b:3b41:0:b0:794:e98c:30c9 with SMTP id i62-20020a6b3b41000000b00794e98c30c9mr2771983ioa.1.1693515961522;
        Thu, 31 Aug 2023 14:06:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id eq10-20020a0566384e2a00b004290f6c15bfsm598184jab.145.2023.08.31.14.06.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:06:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Fix runtime error
Date:   Thu, 31 Aug 2023 14:05:54 -0700
Message-ID: <20230831210554.1141646-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following runtime error:

monitor/packet.c:10476:2: runtime error: division by zero
Floating point exception
---
 monitor/packet.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 8eae8c9ea8fa..279f5408df42 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10473,11 +10473,14 @@ static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 
 	packet_latency_add(&conn->tx_l, &delta);
 
-	print_field("#%zu: len %zu (%lld Kb/s)", frame->num, frame->len,
-					frame->len * 8 / TV_MSEC(delta));
-	print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec)",
-			TV_MSEC(delta), TV_MSEC(conn->tx_l.min),
-			TV_MSEC(conn->tx_l.max), TV_MSEC(conn->tx_l.med));
+	if (TV_MSEC(delta)) {
+		print_field("#%zu: len %zu (%lld Kb/s)", frame->num, frame->len,
+				frame->len * 8 / TV_MSEC(delta));
+		print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec)",
+				TV_MSEC(delta), TV_MSEC(conn->tx_l.min),
+				TV_MSEC(conn->tx_l.max),
+				TV_MSEC(conn->tx_l.med));
+	}
 
 	l2cap_dequeue_frame(&delta, conn);
 
-- 
2.41.0

