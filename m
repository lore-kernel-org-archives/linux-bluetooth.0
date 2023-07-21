Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2706C001DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jul 2023 12:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGUMF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjGUMFM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jul 2023 08:05:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5DF35BF
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b708e49059so27859571fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jul 2023 05:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1689941096; x=1690545896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ+hV81VUwLcZan3YxnT1oGv7b2v/jxtZKXkrhJcy3w=;
        b=QUsypjJBavJEgtbU0dOkBL+Pki8dqJQ+AfU4FvB1HFIV12l8el9ultxfvWalpWpe+c
         83DDJWwK9nfCoXIv58g/hoCFs5eGnCD47sO7Tm8JGjbIsDbcbeHt+brMobwFUi2Ir2XR
         nvyLBxnfIe3tXtRgO1feqznms8b6wl96dOqEZ4Hc6j3jgGSlVzKqem/RnsQoDOg01OH5
         SBEq54m1aNx3CGPZxPHdUwSmmv0PNdmW8pPrJ1iKAb9Ysf01aOICghkPvyNCmlXiZHWc
         wT20MuPi59nAhVj+FeAg5/zHTFoxjG3ZSq9SumFQwilweec0JMCCXXecvPUxoB1zlrG5
         M1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689941096; x=1690545896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZ+hV81VUwLcZan3YxnT1oGv7b2v/jxtZKXkrhJcy3w=;
        b=MMX2jyqthm2/SZ8Ll5wYYzp/avTggaG+MGgeSKGz7IAViuOBpZQL5oU/GsPQMCU2XJ
         VclEskUA/xLWcde9Caj9SXohGCohKrscwDIKeYNNdW1rBpcy5ANyO1jSecZ+b4gFTZDG
         WqRT7FuxZmeHQDQydWD36gz1JYtVfbMX+s4tMKVl4HZ4TiclVImawlETpfFYQjxAfdH+
         gOk/YDmIPkhlwsOzttGS+xZjrQyChn9xthm8H/uyCRG+3uL7zoB1I3j1QoENjOjDpbpJ
         qGGrY1/QF/dom0rD432q46EkwVo8//LfhhwZ+IpO6quPCvdbHYGFjhyhiiAp4jZIWSjG
         i8/g==
X-Gm-Message-State: ABy/qLa/5yrznRnA1MlKEfMnR+h/b4ktcjznhDnyPMMU9N4jnTPXteEh
        GNeGTVzYZ8xaRHQ1Mob47X54TanX3nET00mi1Rc=
X-Google-Smtp-Source: APBJJlFA0Ng06KZkmPrqnK/T/CbcjdFM8gwll9/1y6MuLZvxn4h6p8YF1w1g4n5ULDcyClWIxyjLDA==
X-Received: by 2002:a2e:9ed6:0:b0:2b4:7559:32b0 with SMTP id h22-20020a2e9ed6000000b002b4755932b0mr1312338ljk.19.1689941096135;
        Fri, 21 Jul 2023 05:04:56 -0700 (PDT)
Received: from rymek.localdomain (217.96.247.89.ipv4.supernova.orange.pl. [217.96.247.89])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e885a000000b002b6de6deb5asm907977ljj.2.2023.07.21.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:04:55 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Subject: [PATCH BlueZ 2/4] monitor: Fix invalid Create BIG Test command
Date:   Fri, 21 Jul 2023 14:03:18 +0200
Message-Id: <20230721120320.147496-3-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
References: <20230721120320.147496-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>

As per Bluetooth Core 5.4 Vol 4 Part E, 7.8.104,
max pdu is 2 octect long and there is no adv_handle before encyption
flag
---
 monitor/bt.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 131024e46..ea24a076e 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2777,14 +2777,13 @@ struct bt_hci_bis_test {
 	uint16_t iso_interval;
 	uint8_t  nse;
 	uint16_t sdu;
-	uint8_t  pdu;
+	uint16_t  pdu;
 	uint8_t  phy;
 	uint8_t  packing;
 	uint8_t  framing;
 	uint8_t  bn;
 	uint8_t  irc;
 	uint8_t  pto;
-	uint8_t  adv_handle;
 	uint8_t  encryption;
 	uint8_t  bcode[16];
 } __attribute__ ((packed));
-- 
2.34.1

