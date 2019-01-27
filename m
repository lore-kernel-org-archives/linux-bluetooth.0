Return-Path: <SRS0=3wSE=QD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F76EC282C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282AD21473
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMADrCCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfA0L5J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:57:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55173 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfA0L5J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jan 2019 06:57:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so10939801wmh.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jan 2019 03:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0yKgIB7lo5yEbhS2G4L9FhFiFA+8LYtbnRwbv9K2Qe8=;
        b=nMADrCCotwsB1dREFJa8n7xWEu1k70wgcgA27S6K8+B+THMXJCzS0z3imXVrSy7Sm6
         ElN3m/F1AhWoLMz1ussL93NQYxU0klMzra9HtRZqe4eecOTg4Md2xpNbpX23k6QyieSp
         Ei4wpx+qBDqipYsG3aWH7EjeFtXrWWO58L3gGZ/eNCE42U585aSzbOBWcxVggSfPwihv
         HzYu/6ZzmLTCZJVGZsQGLGi9IO8vwtjs6i8UNWuAkFil/mtTbh86KrRnbphkBzoNZFbw
         YG1prr0Wp+5ro/ND95N0OtCSjJirCoi7AjLexqTNqlr6YgMZL2C2DSCFOC0BlPUbxXUv
         /57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0yKgIB7lo5yEbhS2G4L9FhFiFA+8LYtbnRwbv9K2Qe8=;
        b=mNcArVwCuREMxFG8z657Xc56FkY4mhzt5GoHrPyy9zz5ToVki4a7Z07D6vaVZ8/RJw
         cDGshxh9TJnTNODtimqi8VVhuq7glN6qIjh/wVRceaMmGrrIg/Od4F8KZE6ZWVAZVovI
         8LU5BDT5qAsOwnUujB28VhDoCxSp6s1OTcV8/AxEg6Itfxiia2WnW1B4DLCFsfDIv58s
         j6BBUSBiQw6T4dbZ8dnGoQgil7bSotfh0H6lFoGlcJXf+zp8spBfvB5qUeS6h3MKwRYC
         22ok9/aC5ARAhqhmv48e9kEq65s57vamsnHPpGd/jK7Tht8P7kYl8vXR/zMBpGvg3Hxe
         OJzw==
X-Gm-Message-State: AJcUukcP8dECJEO3oD99Yfh/NvRstJ3QsCl6WGfpQN2cUXZjckmDC32a
        PM1/YEI1bhUPEhJBnLRYICL/qDG0
X-Google-Smtp-Source: ALg8bN46XvOa3wMnXYeHJEbakB6ZhfF49Quz7zN5Dj0dZoU5aaVke1fZ5ONCflbMl8GJq6V8m8BPxQ==
X-Received: by 2002:a1c:f112:: with SMTP id p18mr12537848wmh.83.1548590227083;
        Sun, 27 Jan 2019 03:57:07 -0800 (PST)
Received: from Buero.fritz.box ([2001:a62:158e:8d01:357b:74c0:62f9:a1b8])
        by smtp.gmail.com with ESMTPSA id 67sm178999281wra.37.2019.01.27.03.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 03:57:06 -0800 (PST)
From:   Christian Zimmermann <zimmermach@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Christian Zimmermann <zimmermach@gmail.com>
Subject: [PATCH BlueZ 0/2] Added config conversion tool
Date:   Sun, 27 Jan 2019 12:56:44 +0100
Message-Id: <20190127115646.5814-1-zimmermach@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added a config conversion tool for Bluez4 config, instead of doing the conversion in adapter.c

Christian Zimmermann (2):
  Renamed Bluez4 config read functions
  Added config converter for Bluez4 config conversion

 .gitignore                |   2 +
 Makefile.am               |  12 ++++
 Makefile.tools            |   9 +++
 src/adapter.c             |   8 +--
 src/storage.c             |  36 +++--------
 src/storage.h             |  10 +--
 tools/config-conversion.c | 129 +++++++++++++++++++++++++++++++++++++
 tools/config-conversion.h |  23 +++++++
 tools/config-converter.c  |  69 ++++++++++++++++++++
 unit/test-conversions.c   | 158 ++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 420 insertions(+), 36 deletions(-)
 create mode 100644 tools/config-conversion.c
 create mode 100644 tools/config-conversion.h
 create mode 100644 tools/config-converter.c
 create mode 100644 unit/test-conversions.c

-- 
2.11.0

