Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188DEC001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 12:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGUMFa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGUMFQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 08:05:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37143A8B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so26864771fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1689941097; x=1690545897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq/Ym9K0M1at13oCTYicZlpQJA87B2Yp+rEQ+Rwkc/k=;
        b=ifU79JtfpixOCL1Zk1chV1bFi2QRPPz5TeEhD85J60e74Dq8hVZ2CUcpDIppZ0g6PM
         ZEkj0TOMv2clPN9V5/+uk5GXHAF5BM5SNhh84q2qI2hc9bFM5lvjz2hmkI6Sqh+sRSuB
         QI8qPrV7xH27TMs5Y3SrI2gKdIzTB1bxRc6yiLXz7faKg3TMvuqeZlXVAKMivKVvSZRm
         ezwy0CsBngNRpj/m9oy3h0vN603yeMwDujjuzPoIdrHS0mU1zO/k1LoSh1smpF2uKQG6
         5ROXCxqRBHiruXA0WPPxdkNVS3v1Rd7xZBYE4jr0aJ5qmf7M3v85eWLN0Gw62uja7kag
         NvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941097; x=1690545897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq/Ym9K0M1at13oCTYicZlpQJA87B2Yp+rEQ+Rwkc/k=;
        b=O9PIQ+JPjKE7bsmMYO8yyhp7A2dxrCpMMWxjpozGIzg8Utp/orCQF2hXL+4dqUCg5i
         qh4gwp7EA230j/GicjkmdOyd1oaO2yAGNfuz+enacZbZT76lz1E8OMRWoUfcuaa3PHBf
         RboEBHqrv/ChofwC17CdABpuzkd+rmuGPsHcvf58oMOTx62C0DY+N/gNXp2xt5vP5WuD
         8LOGyFTMPsAqu+Jl78DXt/a8W0jWGwcyFUYCMeeif7vw1ghXRnZAHOcw1bH1NJg48zQx
         yDlnHwqK6viS3mMHRUlQwJTLeMtnbvupXR9WiMC/YCjrIY81XAZaSv66L5rse/kZoqEN
         eqVQ==
X-Gm-Message-State: ABy/qLawjmMowMzvogndmYB0Iec7Vm4pbw+Q6VZL86nqWp/LS+bfaqt4
        H6C6qe7Yl41yNtD0cepkiR6P86lXpgXMptinZ5Q=
X-Google-Smtp-Source: APBJJlE7qQAscXqIy+XMgNfRkbrotHr3slYeXFQ/MscdlWF72QfU9uPvuPml5kFn7hP1tch96xbgSw==
X-Received: by 2002:a2e:9896:0:b0:2b6:e7ff:4b2e with SMTP id b22-20020a2e9896000000b002b6e7ff4b2emr1359918ljj.33.1689941097143;
        Fri, 21 Jul 2023 05:04:57 -0700 (PDT)
Received: from rymek.localdomain (217.96.247.89.ipv4.supernova.orange.pl. [217.96.247.89])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e885a000000b002b6de6deb5asm907977ljj.2.2023.07.21.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:04:56 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 3/4] btmon: Fix obvious typo
Date:   Fri, 21 Jul 2023 14:03:19 +0200
Message-Id: <20230721120320.147496-4-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
References: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index f2167fb52..fd1e9e034 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11593,7 +11593,7 @@ static void le_big_complete_evt(struct timeval *tv, uint16_t index,
 	print_le_phy("PHY", evt->phy);
 	print_field("NSE: %u", evt->nse);
 	print_field("BN: %u", evt->bn);
-	print_field("PTO: %u", evt->bn);
+	print_field("PTO: %u", evt->pto);
 	print_field("IRC: %u", evt->irc);
 	print_field("Maximum PDU: %u", evt->max_pdu);
 	print_slot_125("ISO Interval", evt->interval);
-- 
2.34.1

