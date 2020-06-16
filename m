Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68D1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5332207C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 12:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="GmSjm9vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgFPM1a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPM12 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 08:27:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F35C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 05:27:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x25so7155130edr.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0rpZ0RT5AIgAlvJnYng6I2el9Zqqe4dE1ldx4/bb1fg=;
        b=GmSjm9vhoF3btgE+FGeqq4PqIYlnYF+nlZR3WSv2s3/xJcyy1uWrkoHHFQtypUvMsC
         Fk8dbeRyvzLdjhM4midBH60MopQOVE2pvrBrdwM2I/mpP9J4Avly5ZJqB++y39J/cCUL
         bGh8buRbqYwQFSwaaNymyUhFTOzrdA+PFSTXcsN3j4GYGEQNcrCq7YRLVgFwqYhJypfk
         Xb5qH0zor73r8DawJ2FXyhT9nqhc7E+kgHjiizNaPsxUo9l7bKDpQhuOCqN5Eq1QtGjr
         dyVFQ/pdCuZHHX37w9Ty2A2I7cqngxyH7vWKXuQvucOsMc9OuEfDzOhvcP/Szsv1kZiJ
         PbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0rpZ0RT5AIgAlvJnYng6I2el9Zqqe4dE1ldx4/bb1fg=;
        b=ALcQ0igZsqBO5oVLHsd7LCqVS2wgjvWHtepwlATTE1fYJie+a7wABE2df3liV+4ukL
         vhXd8sEKG+HMpGk9/zPsbF3PIrP2O3fSoQYEjUXGbmMDlHikDfjZI57QET0WShGYxbik
         sTI/fmyi4ZmwDl5c6Gcqm8KlN93QcwSLaQ7r/hPhueG8m0lnNVqIUGmrfQTa3S4jU6Dm
         0AeRuHey5+L380KvZaxSKaz5xESPylHw/vl8o9IWdJqLIjr4YkILq8d6KnbGVBbvTeGg
         VvqGlKLWXr14Do49p2eGZo2w67AdKMBTt1CvBnQknby5mGMXSX/er5p+JJm+Aegl71oF
         slUw==
X-Gm-Message-State: AOAM533ZhDfDIj1uy6FtIIw2GDjS7w24IOFpBKYme9iNPuJf4epi5sWV
        IldgVg61s06SmHndL7LjFemLxrOTUW+D5A==
X-Google-Smtp-Source: ABdhPJzK4MjVTJUKE5R0FqGVOrf2/8tjcI1pZe8lrbag5g6l/QQ5zuA1vUg5douLaoWyHqcyStOfzA==
X-Received: by 2002:a50:9517:: with SMTP id u23mr2248672eda.332.1592310445534;
        Tue, 16 Jun 2020 05:27:25 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id bt11sm3246334edb.48.2020.06.16.05.27.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:27:25 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 0/2] mesh: Deliver mesh packets over datagram socket
Date:   Tue, 16 Jun 2020 14:27:43 +0200
Message-Id: <20200616122745.25056-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset adds another D-Bus API for attaching applications, called
AttachFD.

When application uses that API, it receives one end of a datagram socket
pair, which it's supposed to recv() from in order to receive mesh
packets, instead of wating for *MessageReceived() calls over D-Bus.

This significantly reduces system load for high traffic environment
(e.g. an application that subscribes to a large number of publications
in a big network).

Message delivery is one way only: application is still supposed to call
*Send methods via D-Bus, although the socket pair is bidirectional, so
it would be possible to add sending as well.

Michał Lowas-Rzechonek (1):
  mesh: Implement AttachFD method

Przemysław Fierek (1):
  mesh: Add documentation for AttachFD

 doc/mesh-api.txt |  40 +++++++++++++++
 mesh/mesh.c      |  12 ++++-
 mesh/model.c     | 126 ++++++++++++++++++++++++++++++++++++++++++++++-
 mesh/node.c      |  83 ++++++++++++++++++++++++++++++-
 mesh/node.h      |   4 +-
 5 files changed, 259 insertions(+), 6 deletions(-)

-- 
2.20.1

