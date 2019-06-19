Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EFEC31E49
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 11:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6892070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 11:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="lttl16+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfFSLZL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:25:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42155 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSLZK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 07:25:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so611546lje.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2019 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irbYFP+e2fgTooBori7Ytfy6o7Xv5RFxprkVWRfTosM=;
        b=lttl16+wExa1VC6+ACxLbp6CtITnWmWAAQNCOyqX4zZtFIrLL6UOTRMTkgWpwhep50
         8/ci1rh+UO/dNcnchXsolkHnlNYo3YgQiSqg48ccYYmIg60C7xmXfhQg4T8vnqnxZF86
         hgvWorVU/UeVz8hnaZGKMnfk1A48Bgh0STQ7YN127O5Hvmyo8PWNCScKqjXdejl0Nl7d
         ODKfUk0JZVcGW4tqVAkGTgXmjVYlvGjHK0u2sedyXsjwbx2v9H4vCWswiCFzWwCFGUGP
         sVyIIbCyb5PVjcGdAXZN4b3WpMoTqxxiz2DV162cPRuk0lCBMFwjoB3M3LqLi84F2hoX
         hgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=irbYFP+e2fgTooBori7Ytfy6o7Xv5RFxprkVWRfTosM=;
        b=cBa+VdC1mM9uN98YrEGaDcu/Z0yPHSZqjhUkjRohUHmlVz3WrzcW78BIBdeU33BuMd
         /sgwsKDXzK7qZvfD4iIUL2s2nSS7mZwVHTHqe8VSn1TusLuYIGxViop2FeyYFFAYBCNb
         2++kdlxKebUpd18mdV6SmaNgDGU450bBJIUfovSKGSc64rCjGwf1I3qkHPnptfHeLHhl
         rDf1EDD3GkgBvu+Kpjyn0nLqvIe43TNv5j0wzbenks7B+G1uuIMC+Va4q1coUhLudfFP
         5qu7TvnV/z4WWEfQhugO0SYueXAmjbU4ANHCieYj2rw4teCmMgiSvF3ICdfHqLVEunK3
         byRg==
X-Gm-Message-State: APjAAAUX1FjKPhGbpjYlcQ+LXvYO23BgV6WLLICpgYant1K1Dr5jxhe0
        ly4pC+r7d8HuEbQ7HycuQQZOf69aUTc=
X-Google-Smtp-Source: APXvYqz1U+LDUDE3FeKRKsi4sYx4KpzubZ9o9VbHx6Gp8wsr2l+7m0TiOKi4iuuylrD23NIS4EAisg==
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr2817783lja.220.1560943508629;
        Wed, 19 Jun 2019 04:25:08 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u13sm2635066lfc.5.2019.06.19.04.25.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 04:25:07 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/2] mesh: Move HCI handling to mesh-io-generic
Date:   Wed, 19 Jun 2019 13:25:01 +0200
Message-Id: <20190619112503.3398-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This version of the patchset extracts MGMT handling into a new module,
mesh-mgmt, and changes --index daemon option to --io, allowing more
flexibility when selecting io layer.

Michał Lowas-Rzechonek (2):
  mesh: Move HCI handling to mesh-io-generic
  mesh: Changed --index option to --io

 Makefile.mesh          |   1 +
 mesh/main.c            |  75 +++++++++++----
 mesh/mesh-io-api.h     |   3 +-
 mesh/mesh-io-generic.c |  63 ++++++++-----
 mesh/mesh-io.c         |  17 ++--
 mesh/mesh-io.h         |   2 +-
 mesh/mesh-mgmt.c       | 207 +++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-mgmt.h       |  23 +++++
 mesh/mesh.c            | 189 +++----------------------------------
 mesh/mesh.h            |   4 +-
 10 files changed, 354 insertions(+), 230 deletions(-)
 create mode 100644 mesh/mesh-mgmt.c
 create mode 100644 mesh/mesh-mgmt.h

-- 
2.19.1

