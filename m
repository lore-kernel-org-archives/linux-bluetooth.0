Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D55C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 11:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94524685
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 11:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="s8jEkEBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgA1LHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:07:52 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36143 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgA1LHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 06:07:51 -0500
Received: by mail-lj1-f177.google.com with SMTP id r19so14268157ljg.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 03:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AlK0swRSKffw5t3oOpex4osYrJwoe2JPnE9JGPqnNKI=;
        b=s8jEkEBHt8Ed2ry6Mw9Ry3Rr/muLUNI2nsDhY8YbagW/u7nhYhVaUwZxTyGV+XfYqz
         MSUBRr4PQu5nriHYdFmZ2/a/984EHiFSzUq1ZX3g9wuQo1sbtfr+fzk88kPkncQ3XML3
         umMiME797EzYA6gQ+0pC/xZAOf4MUJPhsOMYLfjkqqaYJ2qJKnseq1mAPziJ1jd/pqBU
         xtm/ar8zKM+y32TUYYxGg59nKrKe1zfM0jkEjipjvhUWVBgXcPTFp4Kcut3FLU5qBZaG
         gwl3c8d8oge9WasSwjOOXY+072MSWFRwmFZcGzmKNyZipvSnp4hvcoMH6mkHdR8J54C1
         etqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AlK0swRSKffw5t3oOpex4osYrJwoe2JPnE9JGPqnNKI=;
        b=CVoCAAEHeK+WgbTjjQVfUECxWvCgrKT4uGDUEGggkAa/LhrcNxFZgPKbEAJbQohLOo
         S/8/Kzr1kP4HR+JbQvOiWsqwyvlE6T1R1O8w3rf62fhkqVWBDUlHpXtnqiKvjowfQBGe
         68fplSqe9bOd+CHNEfjrQf56LPqlpuaxLb7uBBx0aXGr7qVtBi/v6fSJ9qZD9u4Di1jY
         M1dppK+t2XY1ocDB6Jzb/1K4H3yKYjl4GT0S5j6vyMVXdL/uf6GXpXtYr4b1NvNaEwYX
         /r9TfhYAMXog+JOST6nBER2toIKUgYt8mwMm2pfbjhmAn2JiJaH/58rUl+TeJZw3p3ZT
         2zUg==
X-Gm-Message-State: APjAAAVazHwzVc08LBukfzcqQe/Nry3u8C4imxmE3r7PetY5ai7+QupI
        H2K9NzscjOISWpNXutVLuZHF2LEia6A=
X-Google-Smtp-Source: APXvYqwcMD8Do42YRJJ2AFhrBqav4sG32Tsccj2nQhsgdD4XAUBk18RjZ9do5/mfDA6Ypkw3BBvoew==
X-Received: by 2002:a2e:9008:: with SMTP id h8mr12863015ljg.217.1580209667906;
        Tue, 28 Jan 2020 03:07:47 -0800 (PST)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id i20sm9558865lfl.79.2020.01.28.03.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 03:07:47 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] monitor: Add missing HCI command error code decoding
Date:   Tue, 28 Jan 2020 12:07:40 +0100
Message-Id: <20200128110740.41133-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Packet Too Long (0x45 ) status code was missing.
---
 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 6e7cc5e85..07c92ca07 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -519,6 +519,7 @@ static const struct {
 	{ 0x42, "Unknown Advertising Identifier"			},
 	{ 0x43, "Limit Reached"						},
 	{ 0x44, "Operation Cancelled by Host"				},
+	{ 0x45, "Packet Too Long"					},
 	{ }
 };
 
-- 
2.24.1

