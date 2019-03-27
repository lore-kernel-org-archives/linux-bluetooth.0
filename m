Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A198AC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 10:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C54D2070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="ZpJcHoNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfC0KAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:00:39 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37109 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfC0KAi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Mar 2019 06:00:38 -0400
Received: by mail-lj1-f179.google.com with SMTP id v13so13812876ljk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2019 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcrIlH+1Rx3nANifGO+dBeNkUQhCv9UG1Gr8hKE3Vag=;
        b=ZpJcHoNPyw++b41XBijVV1aXUwyoEKARjbVWUpRS6dPkI4DhHdJyCBaq3KuvmvLv5x
         rjPFXIm8L8d4EtKUTYtBLnk60ALtSep60TL2uEElElg/40R09w69OEhxa8vs7cRALWSu
         DgcxejcoSrW3xpSi5ej7Sh0vyRaY0p9XiVhrfPOvuhL59m6kV6EBGMXJZy41GondkZju
         dOOKkin1xYKhj/ANwFARJnE8BiuP3T7Bvi7HQ8M/RRI0PUwjpqwa5syhIGqjx61enuIa
         /OiDVo41c20/QC176+GspjELw61l3heh1vjUyAT0N/pGHdT08HoPfuz0Mxakw2SfYJ4m
         w2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcrIlH+1Rx3nANifGO+dBeNkUQhCv9UG1Gr8hKE3Vag=;
        b=EPcfQjYAe/pbeTCt5VunM+kL+J1h3xfdrOoZ6Nm+ZvYGVO8Ajtk1UwIj26leSlbkc4
         N2nerJhq47yVSwN1FmVNjPChOsg7edKEK6jHZPH1iMojajz7IHNNSZcoFlCipvYRs90f
         tI5yU3zm50Yvbcr2eRccEI6DMwU1ep4/ipOEFjLkvIK1C38MYx4Fg52QRtTN4eIA1HXb
         zVQcb65oNxWESFmBcpVvHnGqOMeCkdOaNnLoDqPkXGzjpFZ0LA0Uo2MfFVR49n5OpzG8
         oBjK6VV2vTP+j3LTwQP+LkwPg4/WsjzUMUCofosSOi8akSGfyBKK3nPFc/8IqW/SvLu2
         J8lQ==
X-Gm-Message-State: APjAAAUGd5sMlkmrGPEvBTb6OMsxMeo18H7VdqWNDRJd4p5j65s24yd4
        P8I4JG4bFQUj5nsUvzZXJUtMKHwrdME=
X-Google-Smtp-Source: APXvYqwVXLsIfRMdQVhK7r+bPbIqP/NMm93s9MGQ7Hbbz3XcdLcWbIfui5OpjaKVVs+OYJ5RDmOflQ==
X-Received: by 2002:a2e:2f06:: with SMTP id v6mr19295204ljv.139.1553680836391;
        Wed, 27 Mar 2019 03:00:36 -0700 (PDT)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id l22sm4117512lja.97.2019.03.27.03.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 03:00:35 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] emulator: Fix handling of Set Event Mask Page 2 Command
Date:   Wed, 27 Mar 2019 11:00:31 +0100
Message-Id: <20190327100031.32062-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This command is also valid for BR/EDR only (was introduced in 3.0)
and for LE only controllers (Authenticated Payload Timeout Expired
Event).
---
 emulator/btdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 4d34aee1a..f4c79c2d0 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3206,8 +3206,8 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		break;
 
 	case BT_HCI_CMD_SET_EVENT_MASK_PAGE2:
-		if (btdev->type != BTDEV_TYPE_BREDRLE &&
-				btdev->type != BTDEV_TYPE_BREDRLE50)
+		if (btdev->type == BTDEV_TYPE_BREDR20 ||
+				btdev->type == BTDEV_TYPE_AMP)
 			goto unsupported;
 		semp2 = data;
 		memcpy(btdev->event_mask_page2, semp2->mask, 8);
-- 
2.20.1

