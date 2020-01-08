Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA11C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57FD20692
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Mlxw6KJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAHVBO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:01:14 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40314 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAHVBO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:01:14 -0500
Received: by mail-lj1-f178.google.com with SMTP id u1so4798411ljk.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAmjjzdcWLO9QT6nPg8hQ6lAemKdJ+VPhUVLj9Pgpn4=;
        b=Mlxw6KJPg07HOOO1VUubiiYDp4/FANeVsrslxEwn8AtqvrwKrCeWM9OyAo3vrbkUmj
         4yauUyXdGL1JGLR3sS76FWvG8xR7ktVKv0uPXZJHHPz+KG1lonqHLPQT04wwPbJaQ3ZT
         BxfgWwQsAQj4xF8IqLRRTW6ank27tWP7WoUQg4YoirQy41nuntse/OVGKoMRFywP7PzJ
         LMoDRHHWZs2XKQ6FWV/pmJ5k211ZcgVZkyYNvfBbD8FC/pZ185NtcN82nRoQCuKnMNCC
         gnFmjNFjhiNBrNv1CbWNmCDHE1MDrf1BfsEozW5YhK+AgupdgQEAGVp33MP6PO3NpEaS
         cDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAmjjzdcWLO9QT6nPg8hQ6lAemKdJ+VPhUVLj9Pgpn4=;
        b=PzOLZs2KaPhv/sRDvbnNCpHBJbIxyhpoPFlmECvTvZPotKehGLYoNC2Sk5Lt6B+Mch
         ePHU40hJ0hjLu4UeERhRtpL7Aj+pDf4pegSR8vy34vi1bF6RsNS4AAFrKL9Vb4jL4vgP
         hqr4h8ehZygd6pxNsk9DdEdD3HuOst1d0kg0SRMxbC8m64tMU4YKjzIHiofPBxFAV30l
         K49mErznPEOcol9lbw6RdldhE8y3u/ltCngPdE9CsozthbFfkxHWZ7/A8b9vdkgqnOM5
         szXCXMiKN0qyh4X1Y/1tzo8hHyf+ZmBExzKkJlMN8svrcN+vjivun1INdMeOaULsEenp
         FEiQ==
X-Gm-Message-State: APjAAAVWdSFHkTzNALzlCJN+Iy4GqSu2LYYOtl5xKLxv27VYihyUmzF0
        kl6LT99fwO9RoiI0GG5WdYu7LjlkM+o=
X-Google-Smtp-Source: APXvYqzEcb1Mgivh71jO4b5KoJ9HMU7JPjU3c7fU2en+tWvd+T4qK3anSjaTNzD7p88Lt+lDytPGdg==
X-Received: by 2002:a05:651c:30a:: with SMTP id a10mr4155145ljp.101.1578517271828;
        Wed, 08 Jan 2020 13:01:11 -0800 (PST)
Received: from kynes.internet.domowy (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id w19sm1951773lfl.55.2020.01.08.13.01.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:01:11 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/2] Fix IV recovery procedure
Date:   Wed,  8 Jan 2020 22:01:01 +0100
Message-Id: <20200108210103.32220-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2: Separate actual bugfix from stylistic corrections

Rafał Gajda (2):
  mesh: Fix IV recovery
  mesh: Remove local_iv_index and local_ivu aliases

 mesh/net.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.23.0

