Return-Path: <SRS0=obUF=UX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10FC43613
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 07:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BEB20663
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jun 2019 07:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="z/X62Zll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfFXHcf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:32:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35269 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfFXHcf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jun 2019 03:32:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so9262390lfg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2019 00:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UumPiBjFTuL4dc3jLD4Cp7hwqG00noau7fcysxyeln0=;
        b=z/X62ZllUYMeC6RxHmhMUL6UUeX9Q7o/xCv5QjkvYGPdcY7aUK6AddgjQ7s+ury1L+
         fcUr9DCbLSI03yMN0RnophG8ct/zDklyffj/K2DmhV3Gs1kBLK8HyUHbCuiCzFVQBCmm
         A7oZABkahT0/5oC/JU6w5AkEIq7V55ic33p08X+i0IBZrg9DRueMvFlEOmaDD4F+MzUg
         LYKIiDffup0Uglu4+Qa8CICiOvvo+mz0RwFqEapUZDQPKYPhrL71zsWoRWzwGsiqp9ah
         TcAaNLSzPznbRlWdyyJR/zDs0IyfmO1q4uTZ6tERanWslH8NmK98pprpt7ZOahIwZFzC
         IFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UumPiBjFTuL4dc3jLD4Cp7hwqG00noau7fcysxyeln0=;
        b=LyrMzb5WD0J63QYiCaeN4EzRRp0oWP+fog/oFmHgl7Ec1z+SW5kOONeIZ7w7+Eh5D7
         oF68tD+VyLSr6ZdBqfEe1zZJ/CCOb0DeW2A3vMZ2D97SnAFfWV60iLWJOWrhjvtLZ8gn
         lAfIdTVroPdOC4vmBeftiluqNsvqBA8NHZyXE/Otc8JaPKMsrXgzkFBtYvZ8s42lJ71n
         jBOZdKdnKS1LrFwlWy1z5tekDXqJM/kZHnza/uQC24xEQ1RumuE3or/8zljsLIMYJT5M
         lBqlnN1Q/QJzyit0J5WnMhVu++zDDpa8uG5B+QOcDXF+oeJxZSfmlDds6+lDokbKlD+X
         XZlA==
X-Gm-Message-State: APjAAAWE2QYggwiyWZj/o3PVEk8iYqx+AOyBaSacfa/rwxtn6I2S4GWK
        ecTOhkgxwGFBzCZf4hisVko+hLVeDCk=
X-Google-Smtp-Source: APXvYqy6fonhV6uIi0ABWk00dCwJgHIU/ph6SwyLRb7PmlX922nvlQK9+TpRjhjdddsp02b6JTxqHg==
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr34724988lfl.121.1561361554011;
        Mon, 24 Jun 2019 00:32:34 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id k4sm1609873ljg.59.2019.06.24.00.32.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 00:32:33 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/2] mesh: Move HCI handling to mesh-io-generic
Date:   Mon, 24 Jun 2019 09:32:27 +0200
Message-Id: <20190624073229.8652-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This version of the patchset addresses Brian's comments.
Thanks for the review!

First patch has a few style/convention corrections.

Second patch now introduces --io option, but leaves --index working as
it used to.

Michał Lowas-Rzechonek (2):
  mesh: Move HCI handling to mesh-io-generic
  mesh: Added --io option

 Makefile.mesh          |   1 +
 mesh/main.c            |  96 +++++++++++++++----
 mesh/mesh-io-api.h     |   3 +-
 mesh/mesh-io-generic.c |  63 ++++++++-----
 mesh/mesh-io.c         |  15 ++-
 mesh/mesh-io.h         |   2 +-
 mesh/mesh-mgmt.c       | 204 +++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-mgmt.h       |  23 +++++
 mesh/mesh.c            | 189 +++-----------------------------------
 mesh/mesh.h            |   4 +-
 10 files changed, 370 insertions(+), 230 deletions(-)
 create mode 100644 mesh/mesh-mgmt.c
 create mode 100644 mesh/mesh-mgmt.h

-- 
2.19.1

