Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB514C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 06:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0E621974
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 06:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucsb.edu header.i=@cs.ucsb.edu header.b="XqqI2QSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgI1GpK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1GpK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 02:45:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA1C0613CE
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2020 23:45:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y14so7421997pgf.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2020 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.ucsb.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZJpLD4uYHRKMNGuo9mwwZSUN3GIyS/qi5PxKB8N12U=;
        b=XqqI2QSUxCNWyixMAgHn18AHsBFEGOX9zlH5aEqNVEdovK3AIGUd4E+fzecEpyv+Xr
         B/K9VzbPjSK0yLvHW3gOBtYMr18VFilfAZKnPF4TRwtKHHi0cFrvkqmiBnlKCQtlqYGi
         POtDJwVvTy5zLZZLzhBBzG+8x3MF5uBUFz5zYm68UVyxfjW6ejUipkveaQwJeEqsvdFI
         QwiDXLb7Um98DFAwHlFP2q4G1F25IoiJJOiID1bMJhbV6V0NowQcnSttY+ReX/iXThAj
         07Jio6K09R2jikPWCuafPf/FOzrKTlm80IV+/0aC2m9fV9Add+88s2EtK78flgo1bOlN
         KqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZJpLD4uYHRKMNGuo9mwwZSUN3GIyS/qi5PxKB8N12U=;
        b=IeSud52h6BKzwS4U8L1z3Gx0CWYhues0dlSA/LtTZnGXhvj/0H1+xXU8OesLMJqYnj
         AwDWNIZwxuJ6mWyesQOC08GqGBQlQ1NzuAKTskMddLbgB1Lc1PSJwJ9Ssb1ayqDEe+Dt
         U5hINlEFO5zndW9YGFkV6FdJtOMxnZB0qrgJx/2wKHo3bwYaQ60ewX9RGns2aLIlcs8n
         LQIYCF+XpjG0jXn8s4KpeHWudHBD8GomaM4T4qHqQxZRr/s2xFKMY1OOwo0PL7tz89bb
         ++AjYBqmvKIGoV5QE4kT/hrTk6FpptJqbEfY4BkHPoHnGMw0Jcl5wU/iDkzxgM1iNEVc
         aixg==
X-Gm-Message-State: AOAM531BLho/Z6C57Np1iHnBKq+DB3qT5le7dg493Afjehj23fcHFE2Z
        idkxjn+SsfOsSGXT5oOeJa99yls4wbM31wCohOcwD1g0GnqVnPi2EgZw9r2xjfpUdFeKlSmobna
        RTm1mj5yrvKLY29k1ArnuYDVNjxx91rPCUCNQPm/YCqgxlsZIaWJkMTZcTwkajTM22Q/nnMLDVQ
        rPDcGIYg==
X-Google-Smtp-Source: ABdhPJw9dQSkKuqwuHnHIPYHJpSv4RqiQuy8dn6kk53OkA2u7hpb7riRHywwcgcU3fmT5gE8J5yWaQ==
X-Received: by 2002:aa7:9a90:0:b029:142:2501:39e7 with SMTP id w16-20020aa79a900000b0290142250139e7mr9063313pfi.54.1601275509107;
        Sun, 27 Sep 2020 23:45:09 -0700 (PDT)
Received: from localhost.localdomain (ip72-194-13-5.sb.sd.cox.net. [72.194.13.5])
        by smtp.gmail.com with ESMTPSA id n9sm129705pgi.2.2020.09.27.23.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 23:45:08 -0700 (PDT)
From:   Aravind Machiry <machiry@cs.ucsb.edu>
To:     linux-bluetooth@vger.kernel.org
Cc:     mhnaik@seas.upenn.edu, liby99@seas.upenn.edu,
        Aravind Machiry <machiry@cs.ucsb.edu>
Subject: [PATCH BlueZ] lib/sdp.c: Validate attribute search return value
Date:   Sun, 27 Sep 2020 23:44:46 -0700
Message-Id: <20200928064446.17803-1-machiry@cs.ucsb.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The calls to gen_[searchseq|attridseq]_seq functions return negative
value on failure. The return value should be checked to gracefully
exit with a proper exit code.
---
 lib/sdp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index 532039a23..a27cd3a7b 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -3419,6 +3419,12 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	/* add service class IDs for search */
 	seqlen = gen_searchseq_pdu(pdata, search);
 
+	if (seqlen < 0) {
+		errno = EINVAL;
+		status = -1;
+		goto end;
+	}
+
 	SDPDBG("Data seq added : %d", seqlen);
 
 	/* set the length and increment the pointer */
@@ -3841,6 +3847,11 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	/* add service class IDs for search */
 	seqlen = gen_searchseq_pdu(pdata, search);
 
+	if (seqlen < 0) {
+		t->err = EINVAL;
+		goto end;
+	}
+
 	SDPDBG("Data seq added : %d", seqlen);
 
 	/* now set the length and increment the pointer */
@@ -4054,6 +4065,11 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	/* add service class IDs for search */
 	seqlen = gen_searchseq_pdu(pdata, search);
 
+	if (seqlen < 0) {
+		t->err = EINVAL;
+		goto end;
+	}
+
 	SDPDBG("Data seq added : %d", seqlen);
 
 	/* now set the length and increment the pointer */
-- 
2.25.1

