Return-Path: <SRS0=Arr2=V4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BACC32751
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183C1218A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="JaTZq1j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGaHQz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:16:55 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:41356 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaHQz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Jul 2019 03:16:55 -0400
Received: by mail-lj1-f175.google.com with SMTP id d24so64544280ljg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2019 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQQDYz/El6AKc0oK65k/akYQ5BgL0WN41H/ZZ3bcwz4=;
        b=JaTZq1j4O6C0CxQYIc5Lzbhtdb7x/Vlq4KUnPjFYvxYLzvP3CXHHLAPx+wHLJdx3hl
         zWI9nh8+LOs1oRLlf0U599mxzLwv4N70/OuEewQQmO8qknDwZ/m4CVok7JTpvZKYX+4i
         pK3I4dq2qFGtQTJEh9hYF10cGvAcVGKnnnXmX4R2ES2CeSvI+jvr2oMi6j8lmSdcj02z
         ZIi1OfchTqbBfGTgXGrxmd6VRR4q2OdLlEB5LJqOQHl2Zk4BX/1BCfm96xV3bPHVjser
         Kysbuh0kfmHKo947QsE/W901B1lfcc+5Juiej7DUsESBQTOq0bnWje+Ntqmd6h5AQp7X
         HWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQQDYz/El6AKc0oK65k/akYQ5BgL0WN41H/ZZ3bcwz4=;
        b=ouQCjvl3WXcLYAv/BNMah58fkvveD8lfXBjzIucrPzGjbai8t1fskWQ+UFyuqt9tx4
         uQnlxDynGeLVyLbii+aTsu9gRXrftMF3g36MJOcoqOObB1zzlBjL4KWGaaw31/6XYip2
         2M4ZG+pP1AkQVCw6/PmkuMXDNkijTbt3+k1wB21c5sX1Vb6y4dHNxJTBF11hKCtM16Lb
         NGi3+HUZ1YWujJpRzcopFwbLyj1M3icTOklwVnE/ASBZvXb7iQGMvxsazUanna98wtGT
         uXaMlD2BzeuSkIG/ci8GT615lDhKVJuR2eLwAa2x+xhJ7ymN9c24a1aoL/7cgMyU4g5b
         ctOQ==
X-Gm-Message-State: APjAAAU8v9vTH98autxZ+SfYVTrcUtbKvKXFSNlAqAPR/4Ra4n5YT0jl
        m4nzb8yPksTz9orcZJWrcUhQL8j2U5g=
X-Google-Smtp-Source: APXvYqzs/8+W/ixJOIONkEQbh6+KsJ8zY6Z3PaQiwaTKVDy9g5NYE3hG8W3d9Q652QcQ5JFIg/KUoQ==
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr63002303ljg.168.1564557412937;
        Wed, 31 Jul 2019 00:16:52 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n10sm11662477lfe.24.2019.07.31.00.16.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 00:16:51 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 0/3] Implement org.bluez.mesh.Network1.Import() D-Bus API
Date:   Wed, 31 Jul 2019 09:16:44 +0200
Message-Id: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ Keep defaultTTL and seqNumber optional, but check the format and range
+ Style fixes in mesh-config-json
+ Reworked the API to new signature
+ Removed dependencies on mesh-config


*** BLURB HERE ***

Jakub Witowski (1):
  mesh: Extract read_* functions in mesh-config-json

Michał Lowas-Rzechonek (2):
  mesh: Add documentation for Import() D-Bus API
  mesh: Implement Import() D-Bus API of org.bluez.mesh.Network1
    interface

 doc/mesh-api.txt        |  57 ++++++++++++++------
 mesh/mesh-config-json.c |  83 +++++++++++++++++++++++------
 mesh/mesh.c             | 115 +++++++++++++++++++++++++++++++++++++++-
 mesh/node.c             |  87 +++++++++++++++++++++++++++++-
 mesh/node.h             |   5 ++
 5 files changed, 314 insertions(+), 33 deletions(-)

-- 
2.19.1

