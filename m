Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3542EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjG1Wm6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjG1Wm4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:42:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108384495
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686be28e1a8so1858206b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690584175; x=1691188975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp/DcLh5WO3tRYY+x0GV4ZFX6NbomSTB3aO/vJlAm5w=;
        b=TQqL+5Uq9RycNTJVfTHIiusD5SytAfByhkBxSMSbCD33OVJ6ADXsFFjUQoCj55gyRQ
         rTELET/8ktt+2XEu/pMmB2s1aoMpOJQfQiX05FEJgmXu5SIF+wU2BFBNtWa2mQxa2WZv
         aRQM1zYMV9lwKC6Lmbvcr0s5lZ4/Wp6qwRgoT9w42QUqLnLP9n3G4lXK3Xl1AuZYihe/
         Pzq/UBUBKEtWbngTh+9m3XtbUQAT19RccBe6qhaWyZBj3ruMR/O/FqT3CJURT5YUTXGA
         jDfc6b7z4+tS7tSrxNvn2EuayYXDOXbbo/Bghr3ApMd5fXlZwt4vWuE+0JMge7oed8Sx
         q6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584175; x=1691188975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp/DcLh5WO3tRYY+x0GV4ZFX6NbomSTB3aO/vJlAm5w=;
        b=fqpHyn7310V+ZeyO+6nOfI0mdjGdkuBvwr4YHIelY68zA5+nKVa6K4x/CimlmdMNzu
         87WuLo7w9HtPeQljzcBsOPvs+KeLtMQsjS4s3wMCVuzrl/AEykj3WQJQD5ppp5nNWlgp
         4wvXw3AiW72ZsCFOgOe3kTnsg+9TK7lCYcVKBr9FWv0rea8vUs6oWkyf70fruQ24Frw0
         RQlt8cOWtxHS2jAn9P8gCWR4KxWSJ42heghlLpMSbIeSif5jIx3zX/EMzTh/6w5rTmTo
         2JKEy/V0nGJt4WjQGLjP5p1XGIXb8gi9PsG6Y1SfmiVjs6PdIJommh7QUOpxvDCh8awf
         MPEw==
X-Gm-Message-State: ABy/qLaZq0SVeGDhEzV4cvNSXPaT1o4nRFOsV/wsprY36wf2ix24Pmqo
        Ye/brc6ztcOsjiPsh74pAFkKWfFzV7w=
X-Google-Smtp-Source: APBJJlHXpPDWO/O6iDuodBuVAFJBSEgxzsS4wfMehqP+40thaYC5PNGFrmJpdJhKNWWjbaENgzoKcA==
X-Received: by 2002:a05:6a00:8c9:b0:682:a6bd:e952 with SMTP id s9-20020a056a0008c900b00682a6bde952mr3348102pfu.6.1690584174834;
        Fri, 28 Jul 2023 15:42:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b0068703879d3esm2731041pfu.113.2023.07.28.15.42.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:42:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 4/7] monitor: Fix not dequeing TX packet properly
Date:   Fri, 28 Jul 2023 15:42:44 -0700
Message-ID: <20230728224247.102057-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

num_completed_packets_evt contain a count for how many packets have been
completed per handle.
---
 monitor/packet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index b905080edc60..badc9b9c7785 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10406,6 +10406,7 @@ static void num_completed_packets_evt(struct timeval *tv, uint16_t index,
 	for (i = 0; i < evt->num_handles; i++) {
 		uint16_t handle;
 		uint16_t count;
+		int j;
 
 		if (!util_iov_pull_le16(&iov, &handle))
 			break;
@@ -10415,9 +10416,10 @@ static void num_completed_packets_evt(struct timeval *tv, uint16_t index,
 		if (!util_iov_pull_le16(&iov, &count))
 			break;
 
-		print_field("Count: %d", le16_to_cpu(evt->count));
+		print_field("Count: %d", count);
 
-		packet_dequeue_tx(tv, handle);
+		for (j = 0; j < count; j++)
+			packet_dequeue_tx(tv, handle);
 	}
 
 	if (iov.iov_len)
-- 
2.41.0

