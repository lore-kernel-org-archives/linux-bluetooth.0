Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3BCC38159
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 19:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjATTrm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjATTrj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Jan 2023 14:47:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513BFBB96
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so6603026pjg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ND2zUS33F0ZGk7pfPodjU4KpbhoItVhsoFmt7NsUrVY=;
        b=JaRBeC2QwqLcpVD9N84bQXX/i2N1KcFRLZKxTn7fy27pB6VkTAGvLXTI/IcVDY/Z5Y
         NtJnSWfLA5sw3Q1Kj4d7g2T9ypAktlFIqDY9ePiHt7DN3BIcFjomGQdInjc4Rk366VDK
         wqMXoHGO4TC8e2jo8xxGiudbXaNgqueipZmaBHsN56vgfC40iuNZAAmb90wa8a+9Vwye
         gd9Ilm8FPukz/HWWrFcMI58lKJnwKSPBaUXpnKsF1V4OuY7+10dcseL+VbE7Wvd2ZC7n
         +MyoEPUY4iKH65Pd8pgR8H/fgwjt38Hgqx1Sw3urWnRlIjlYZFHGsdD+Rd69p8IC6jHN
         5GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND2zUS33F0ZGk7pfPodjU4KpbhoItVhsoFmt7NsUrVY=;
        b=Jx/wu8cZ/E2v3uQvXnTxDyksVhdm2JuNMCOMvfRfzOktYrVgw97vE2Wd1Fcy5Nr041
         /dCWFTvjRpuMFERfPzbV/0gdhqhLhgK9NCJYK3eJCDtlhD+RPcI9MvRAJBIEIe1HgLJs
         vFqx2zWdF5ppZsfjuqspJuABrkwNIXZvJGw6EjBxChb0M8SM3NVrUs+kThCqkLg760Ml
         oIW4Z0U+TB5HjqTSCOKNmyBvDSSDszpMpFw93x+Ek2vKoSU5yJ9LBX0/cVBtsqyM5msa
         Exd/ulYRgZuxDJkEoFhQz5lrcVEVxQBq2VajAXt8P5ZFQKVVRkrzpSx/9Gfa2z2sx/Fo
         dolA==
X-Gm-Message-State: AFqh2kp4K7VxqeKUgaUP5mZ5Bb8Mzj6yKFxI3F612LkEnkVbvZEM3wQY
        zA5vozyYWdbpy2E7pCJ8aG9kDhD6/TRp3Q==
X-Google-Smtp-Source: AMrXdXtySh2Yc0ljzZhks3FdCsIxbLWXJkmhNEa8rNPg7y1QRWCX61iKLt076GWj4R+S1ARR9LCyAQ==
X-Received: by 2002:a17:902:e80c:b0:192:6b23:e38b with SMTP id u12-20020a170902e80c00b001926b23e38bmr20263528plg.24.1674244057129;
        Fri, 20 Jan 2023 11:47:37 -0800 (PST)
Received: from fedora.. (174-21-24-126.tukw.qwest.net. [174.21.24.126])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm5149967plg.134.2023.01.20.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:47:36 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v2 00/11] Mesh v1.1 additions
Date:   Fri, 20 Jan 2023 11:47:20 -0800
Message-Id: <20230120194731.90065-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set includes implementations for Client/Server Remote
Provisioning, and Client/Server Mesh Private Beacons

v2: Clean-up checkpatch warnings.

Brian Gix (11):
  doc/mesh: Add Remote Provisioning DBus APIs
  mesh: Add Remote Provisioning
  tools/mesh: Optimize for multiple RPR servers and NPPI
  mesh: Rename parameter list per crypto usage
  unit/mesh:  Add unit testing of Mesh Private Beaconing
  mesh: Add storage of Mesh Private Beacon settings
  mesh: Add Mesh Private Beacon server
  mesh: Add Tx/Rx support of Mesh Private Beacons
  mesh: Add internal Mesh Private Beacon model
  tools/mesh: Add support for Mesh Private Beacons
  mesh: Switch beaconing net key

 Makefile.mesh           |   2 +
 doc/mesh-api.txt        | 140 ++++++-
 mesh/cfgmod-server.c    |   2 +-
 mesh/crypto.c           |   4 +-
 mesh/crypto.h           |   2 +-
 mesh/keyring.c          |  29 +-
 mesh/keyring.h          |   1 +
 mesh/manager.c          | 533 ++++++++++++++++++-----
 mesh/mesh-config-json.c | 428 +++++++++++++------
 mesh/mesh-config.h      |  12 +-
 mesh/model.c            |  37 +-
 mesh/net-keys.c         | 506 +++++++++++++++++-----
 mesh/net-keys.h         |  11 +-
 mesh/net.c              | 188 ++++++---
 mesh/net.h              |   6 +-
 mesh/node.c             | 326 ++++++++++++---
 mesh/node.h             |   5 +
 mesh/pb-adv.c           |   4 +-
 mesh/pb-adv.h           |   2 +-
 mesh/prov-acceptor.c    |  87 ++--
 mesh/prov-initiator.c   | 269 +++++++++++-
 mesh/prov.h             |   4 +-
 mesh/provision.h        |  23 +-
 mesh/prv-beacon.h       |  36 ++
 mesh/prvbeac-server.c   | 128 ++++++
 mesh/remprv-server.c    | 908 ++++++++++++++++++++++++++++++++++++++++
 mesh/remprv.h           |  78 ++++
 tools/mesh-cfgclient.c  | 488 +++++++++++++++++----
 tools/mesh/cfgcli.c     |  99 ++++-
 tools/mesh/mesh-db.c    |  37 +-
 tools/mesh/mesh-db.h    |   1 +
 tools/mesh/remote.c     | 122 ++++++
 tools/mesh/remote.h     |   9 +
 tools/mesh/util.c       |   3 +
 unit/test-mesh-crypto.c | 100 ++++-
 35 files changed, 3954 insertions(+), 676 deletions(-)
 create mode 100644 mesh/prv-beacon.h
 create mode 100644 mesh/prvbeac-server.c
 create mode 100644 mesh/remprv-server.c
 create mode 100644 mesh/remprv.h

-- 
2.39.0

