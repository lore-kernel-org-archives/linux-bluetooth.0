Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B560C001DE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 00:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjG2Ar2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjG2ArY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 20:47:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24843C38
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0e23a4b1so4508701e87.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690591555; x=1691196355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+bw3Sut5iP27MZFEHwNQ7kDpm3wjpKYVtwflfCeqxg=;
        b=1v5m4M7Su+PJMrLQJ0c2hmxykASVDgCvKfFq7pcsfXKxNOqNvEamfKIDYBYOBbAc9Q
         y4K1kX6Q4YuebRIJBGNyj/IhhSZb5mSeyc4f28OJv5UaqY6TOMXHMV/VC94Qvmr0Nix4
         ikq7r93whfABohwJ9WSW5QUowi/gPLRByBRcsBaA3uv5QwIiCqlmsFYDRoRjcp3pBVsg
         Thc5WjUNcfqFccvddPftdrO70vWNUH/gXIkmCNtPpBTIe3Ga+Af45KPoIpwCRftbvTK9
         KGErQiFwh+hQY9xrq9tenY+byvOUhGznw6miO5My7HmCnkjlrukKVNqA/gcUvfdoJHFV
         FR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591555; x=1691196355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+bw3Sut5iP27MZFEHwNQ7kDpm3wjpKYVtwflfCeqxg=;
        b=Fl03SNxRyy/Pzo03pWjujyg9PzvN+dMBMJut9rMDtmdZN2zkgFC8/5DnBmMbo8yNFp
         V5itbmJUCAQIf3A5BPMnGrnPb6osoD8IamM/vXKiHDxtLZAPPYmsfUvik8jr/nTCWYqF
         5JwGWXobNYD4RZUHCadiRj77bhWrjSSAGIgzEY/88rT/QLqXzVMXDQ34/jwjrTloL0zO
         2RwyDPtMAtQ4SfScXvH4faD6GMS+KWMIdhEXY5A2DsFAS5qJLNeFDjbEIzryiRfG7eGI
         JLmX27TzcHCkWIq2549J/TbYlEafUQ8gJ5s2unvRG6hfN1HLC3RI2Zt/NABsQi9PYtv3
         pRog==
X-Gm-Message-State: ABy/qLZ1oFw/214N0e5yvh/W5N8JsdNRZmEwUtdPnaJJ327BHuWiuZ7g
        79FCQNiIgJ6KDJg1FCclrxW5Aj402MQ0pKTDHDU=
X-Google-Smtp-Source: APBJJlEI8w3KRzrtDnywQoYNZVArLJeeXmDtQAQ+ZxtX0iE9C3wf/LfXgZcWzalm+HwIxg7RvEbFow==
X-Received: by 2002:a05:6512:2106:b0:4fd:bc33:e508 with SMTP id q6-20020a056512210600b004fdbc33e508mr2562074lfr.49.1690591555179;
        Fri, 28 Jul 2023 17:45:55 -0700 (PDT)
Received: from rymek.localdomain (217.96.255.138.ipv4.supernova.orange.pl. [217.96.255.138])
        by smtp.gmail.com with ESMTPSA id r25-20020ac24d19000000b004fe1f1c0ee4sm617746lfi.82.2023.07.28.17.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:45:54 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 0/5] Couple of improvements to btmon
Date:   Sat, 29 Jul 2023 02:45:47 +0200
Message-Id: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Szymon Czapracki (1):
  monitor/ll: Add support for connection parameter command.

Łukasz Rymanowski (4):
  monitor: Fix decoding Command Complete for Remove ISO Data path
  monitor: Update le event mask with bits 20-23
  monitor: Add support to decode le read ISO link quality
  monitor: Add parsing Service Data of UUID 128

 monitor/bt.h     | 51 +++++++++++++++++++++++++++++++++++++++
 monitor/ll.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++++--
 monitor/packet.c | 58 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 168 insertions(+), 3 deletions(-)

-- 
2.34.1

