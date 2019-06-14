Return-Path: <SRS0=cJ+v=UN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42317C31E4B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DCF21473
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jun 2019 12:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="LH5xKxeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfFNMpU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:45:20 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:43530 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNMpU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jun 2019 08:45:20 -0400
Received: by mail-lf1-f51.google.com with SMTP id j29so1631937lfk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2019 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nJHV00xMC56jxW7Ns4G5WUx+UCTKF182nDYqVbfVK6s=;
        b=LH5xKxeB5qitei/VprVm1cmTB7Yi13VfbgqEOM4rJ4JHy7kPcTWSZRuZAYaf85H9c3
         Z8XeZdyRx4QBJWJUY8SkR1srT02khIDvIZbYHh1UYMesJXOEsUP4ZcpV4je+kE58EGdO
         PF6v2nuu1Q4dtiKwyAM6Gt2t69ohnK5P94Hxe3zqUxVqaf24d3ziPgGZugbS9OAZOhHQ
         CzAh9SIEpEZQFSVgLvLgW4rXf/DRtU6+PfzSMkl99d/cW/4uvvwgandk5umHqIgI8zWK
         ijr2a7ncVSE+QuM6PyKQYSSeupHr6YOgalhYJeJWptEUkr8mMJQyzJPKrGfC43Mt+6w2
         wICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nJHV00xMC56jxW7Ns4G5WUx+UCTKF182nDYqVbfVK6s=;
        b=e0xb8tzPlsJ1unwBEy3cLmpf2Yrm10J0Vb2nSZ1HqnNgOhDntiS6g3Kp8vxD2D0IYp
         c+rp3WFD4s9squPKLrTzmzpJAMV+zy966llcQJfGSMc8uKpAc+BD+2M6KchvN4iIM4f6
         zSQuMaPOXgDVu59ctuvDFMc0/+MWjp2dRY2U6JIiGygFJRRUCWVoK3hFgdL0jrdG+hi0
         NI7d7NDpwAvL3u3UoUi4HAUA6G4rNvRKGvYLmYsBhSPr026gp/X+/GaGPDW4rqbxAV50
         F6ZOzIQPNrRJypR20VAnmofE9A3yRpDCLO6z3IOTF+q0AzDGeYeOcXE8WbHwFc+3aNP8
         29JA==
X-Gm-Message-State: APjAAAUsIVjA4i4lzsIp0gRHm9GWQ5wYSvTGLFBjsK4SPC/BW5RBSAlJ
        gWaXwQh9jOgibjcI7hGJ1z/b00hlej/ReA==
X-Google-Smtp-Source: APXvYqzpXN4FRMOi1nMmSw8MTFQTw0LMQpxpWaZ5HvYlF7/c7Gmf0ufvF96Lav6M+IgktPcYTeF6DQ==
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr31284057lfb.67.1560516318120;
        Fri, 14 Jun 2019 05:45:18 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v4sm572722lji.103.2019.06.14.05.45.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:45:17 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 0/3] Import local node
Date:   Fri, 14 Jun 2019 14:45:08 +0200
Message-Id: <20190614124512.19062-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
I have implemented importing local node functionality.
Please comment what do You think about this solution.

I'm still working on it but for now I didn't noticed any side effects.

BR,
Jakub Witowski

Jakub Witowski (2):
  mesh: Added functionality of import local node
  mesh: Allow to import multiple network keys

Michał Lowas-Rzechonek (1):
  mesh: Added ImportLocalNode call

 doc/mesh-api.txt |   2 +-
 mesh/keyring.h   |   1 +
 mesh/mesh.c      |  55 ++++-
 mesh/model.c     |   5 +-
 mesh/node.c      | 543 +++++++++++++++++++++++++++++++++++++++++++----
 mesh/node.h      |   4 +-
 6 files changed, 566 insertions(+), 44 deletions(-)

-- 
2.20.1

