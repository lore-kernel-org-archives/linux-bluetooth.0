Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47280C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 10:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D6620707
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 10:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="tRVNqRLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgE1KPh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387784AbgE1KPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 06:15:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CEC08C5C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 03:15:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w15so16198002lfe.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2020 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOnbSv2MzwkHToPYY7gPh1zaMuAdFzMQW2N/t4XfQPk=;
        b=tRVNqRLWbSqKnxQXH8CI4wZgHLT8Ud2uo3nCVSYK6c5OUlIFbY8f3217JBSy5/6r2c
         +tXLW2TiwlEpiT4jRC1WPS714ipLw4pewh7p+Y09ZyfBt/kwJJwney8r8njj7txHZH07
         /OM/ftgF30BrtgslGUL9DC5GqPaPV8wpdQL9TLVx9War+U0S5zOJxxG/H6XzuDIgC5vr
         aiaTC5MEh0VVS7mRRqGUd2vAsXqW+jrMJifV4qW8seAntxu094LZFJdhBXxAdgH/hODs
         XOSOGaU7++UoSkEiJf9C6xD17Ojg5ryKyZZKClI8QhJJaBqieXl6vulc6a67FqhR5M2r
         1g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOnbSv2MzwkHToPYY7gPh1zaMuAdFzMQW2N/t4XfQPk=;
        b=QPeU2NjLhNixsfl43nSgEkNY1foXFMz5W36UZYu7etuEPwNbxNzyDmrY0aMGPwh2+/
         W933ajgY8Ql86e7UbAGfezaOUQujElUSltQXE9AZSfnHhll4hRDqNbQzFPPERJ7RwTlv
         WzQPxWDEha+y3b+FWnpijZM2b6CEDPBDV+64beNLOxgkiPW2nH9tq2o4pRMJaHyisKoZ
         /ol/9Idc4ORbmek/TGcVf4vl2zmsoBncZir2ahSLCownr2UQdzn+5BdLK3ZPtdzRx+R6
         /MwUHJ9taRUzLaKUuzkPO/mQC/8dcrZ6S1cE7QXNej5ezl4lFK59L/PrULFfbuU48DW6
         f7uQ==
X-Gm-Message-State: AOAM5313s7d7c6ogiIe9uY0zsjkjZtvaOCc6wCCZkFbC6XVe2N0PhfRN
        wq1+owUBfJ+ckErmAYAt2HvMA9zIFXA=
X-Google-Smtp-Source: ABdhPJxorfgIiDQh46E6/t4W9cx4+/XHnSjjgRoY1YgroOR/TOEBtPID1glq+TDTiyqhgwbpJzvCag==
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr1313245lfk.87.1590660930141;
        Thu, 28 May 2020 03:15:30 -0700 (PDT)
Received: from michaln-ThinkPad-L490.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id n26sm1348011ljc.42.2020.05.28.03.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 03:15:29 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Narajowski?= 
        <michal.narajowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20Narajowski?= 
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ] monitor: Fix for incorrect len in L2CAP Enhanced Connection Req
Date:   Thu, 28 May 2020 12:14:08 +0200
Message-Id: <20200528101408.98400-1-michal.narajowski@codecoup.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/l2cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 41c766863..e571dbb61 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -1344,7 +1344,7 @@ static void sig_ecred_conn_req(const struct l2cap_frame *frame)
 	const struct bt_l2cap_pdu_ecred_conn_req *pdu = frame->data;
 	uint16_t scid;
 
-	l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
 
 	print_psm(pdu->psm);
 	print_field("MTU: %u", le16_to_cpu(pdu->mtu));
-- 
2.25.1

