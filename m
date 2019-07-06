Return-Path: <SRS0=OJUr=VD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFCCC0650E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1140C20838
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Jul 2019 15:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="a1FBXno5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfGFPjN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:39:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45171 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGFPjN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Jul 2019 11:39:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so11870760lje.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Jul 2019 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEzKKzK5fk/Bt6kVYxicW2d3oYJ/0z0xpzJO67okGCQ=;
        b=a1FBXno5jAlKNzFEl2+nItxp4J1XVF7HZVrsXMTkwQ50PXehFrdvm27Qp0gsYBiC3r
         MoYTgSBF+AstdphlEnGBLnVZznhexQYczNl9BmLmtR2Qd1tg02e2QmwpMr7rET3L/wca
         LVlDkR/Su9WF+7mWPeYSG49W0+l7tBZNw3CmK42V22TPi9FcrHaHlP9BjpjBg0FwPqF3
         DOWLJpu9f1VWvpjHJZtjGlgmY1X6t1nLvRiRNLwGJVZma0CvxRTXrNKxrUGRvsEy7dwa
         fLcwHaJVa/PdQ3fqRmVSHdM6mEK9+UnOpwveT/2B5Xbb3K1WUS+19Xn1BG1cwYIt3mWM
         myMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEzKKzK5fk/Bt6kVYxicW2d3oYJ/0z0xpzJO67okGCQ=;
        b=A5wP4bxFrliLJax2DbH48bOM6qrB6dgAJr6grxZ9y9tUpRysCGPOpv/zkZv+4pT2os
         /8IYAg3uEB0b8axKz/i2xWzUNocPQlLUINivILurN5IZB/+uNeiAqpAeJ6uBDDDqrpKX
         KGi2T5JnsPskz8DpNP9FujmUN/JRR0RxVJcByQoKzHJGvh/jZMJcELYa6nUkn9qjX1Ex
         BOgBTsGmYsYLIhd6CbJeQTy0mleyhkuwa2nV//LVqYztXUucU6Z5n0s5zL3IG4YxKcCz
         8cgwHRrNMNt+F4tW3Pf/alNp4VGrhvo+VX0UCdMVjcB00LRjugfyOIULPXIoInAelP1s
         x/Iw==
X-Gm-Message-State: APjAAAXh+XHFQWJhRrqIbluopPMIOCcCQCzl1yIi2SMfieqcTx8bcoYX
        F/2dLTHCHbQhFzERdf6R7CLbQB8bhGs=
X-Google-Smtp-Source: APXvYqxUH3GkZ949Kta7xP2yg0QYAUofppPoalm9vrHo4p0yuE733DpXWN5y3cUcNwnZMCATQzPj6w==
X-Received: by 2002:a2e:7c14:: with SMTP id x20mr5262647ljc.56.1562427550972;
        Sat, 06 Jul 2019 08:39:10 -0700 (PDT)
Received: from kynes.internet.domowy (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id u9sm1910609lfk.64.2019.07.06.08.39.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 08:39:10 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/1] Add --io command line argument
Date:   Sat,  6 Jul 2019 17:39:03 +0200
Message-Id: <20190706153904.12009-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Continuing the refactoring started in 12b984d1d, this patch adds --io
option to bluetooth-meshd, so that the user is able to select mesh-io
implementation.

Compared to v3, this moves option parsing from main into mesh-io-api.

Michał Lowas-Rzechonek (1):
  mesh: Added --io option

 mesh/main.c            | 48 +++++++++++++++++++++++++++---------------
 mesh/mesh-io-api.h     |  2 ++
 mesh/mesh-io-generic.c | 30 ++++++++++++++++++++++++++
 mesh/mesh-io.c         |  9 ++++++--
 mesh/mesh-io.h         |  2 +-
 mesh/mesh.c            |  4 ++--
 mesh/mesh.h            |  2 +-
 7 files changed, 74 insertions(+), 23 deletions(-)

-- 
2.22.0

