Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A12C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 19:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjAWTtE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 14:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjAWTs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 14:48:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782FA3644A
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso12001717pjf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjiTuSj1GAY7KgEhF+G5Ge8dOpHQ5oT6h3DYxVDwqNY=;
        b=gvxbsSq5elLD0vZSKBeC7yJjHTPb+GTAvBq+gLnxfgJMzvz2Du+Wil9JEfXGU0qwVX
         hKEMCF6eaDU6o3hrmojRFLjSwa+5RTnizQ3cIi654h3ZuYy7xrBLAUZhnNxwR1jVHSOd
         U6BVefI6zt2gdEj/on3wEW2Icxx3RQi84Y5JggWfaGFpuldX8WJ9s4J6Q+596w5sCb4T
         dIzM6VUua++TcnBNAQP1G4rZJeJSYJ9zg5gu8EZ2BdTEs1wOlNxJ61PzU7qmfFh+ejVW
         UcBGoF5iSfuAzN+AWA1q5TL3QAT/bbu2MoaaBtwvdnZycc67Asfkd02iUB5dBgDY/hyF
         A4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjiTuSj1GAY7KgEhF+G5Ge8dOpHQ5oT6h3DYxVDwqNY=;
        b=mdol7rug5+/lHABHDg1RSottJXOQqemVMv0kTMwqb4UbKur9NUJx417IXDFtV9wotm
         VA0VAsiHEhPTDcMU9B+mvpw/Zv+J5iQR528utCa9iaZb0HyAWP3920P07BaoyMDYNXnB
         3U5Ckail6tjKvFh3XscEqH5HdIlNvMaUPeDgJ0mzktrmtN20r/FFn9AjLPv6EvpOthlE
         vkT7Z4i31drrfg3azV27RWdyl4Kb6Xo+9ky75yZNJ+PWOXv3Wi0ozq0ZM2HHSJuAcdmd
         Uag1uhJh43P4oaBdfmEBseAg51z3e/FVMvpaSxLHMeP/K9AAA0M7K/3GHdtWOx4cU3gL
         kwxA==
X-Gm-Message-State: AFqh2krzpfNt5O3nv2NQrSCyJ1f8WVJTswMu17ocYxgRNdOdy3eLJY6X
        +ylPbOBbxlr7kRn5NNZIQC49xG5V2GqwBg==
X-Google-Smtp-Source: AMrXdXtEs0rQPcng4cSOx4lXaMabjWN0M/oKOfn5WhK77RP7+KKVf4ghrJlV+aj6mkVdRpclT3+pHA==
X-Received: by 2002:a17:902:e749:b0:188:6300:596a with SMTP id p9-20020a170902e74900b001886300596amr36400378plf.7.1674503322683;
        Mon, 23 Jan 2023 11:48:42 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b0017d97d13b18sm97068plb.65.2023.01.23.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:48:42 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v3 00/11] Mesh v1.1 additions
Date:   Mon, 23 Jan 2023 11:48:13 -0800
Message-Id: <20230123194824.257351-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set includes implementations for Client/Server Remote
Provisioning, and Client/Server Mesh Private Beacons

v2 & v3: Clean-up checkpatch warnings.

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
 mesh/remprv-server.c    | 907 ++++++++++++++++++++++++++++++++++++++++
 mesh/remprv.h           |  78 ++++
 tools/mesh-cfgclient.c  | 488 +++++++++++++++++----
 tools/mesh/cfgcli.c     |  99 ++++-
 tools/mesh/mesh-db.c    |  37 +-
 tools/mesh/mesh-db.h    |   1 +
 tools/mesh/remote.c     | 122 ++++++
 tools/mesh/remote.h     |   9 +
 tools/mesh/util.c       |   3 +
 unit/test-mesh-crypto.c | 125 ++++--
 35 files changed, 3975 insertions(+), 679 deletions(-)
 create mode 100644 mesh/prv-beacon.h
 create mode 100644 mesh/prvbeac-server.c
 create mode 100644 mesh/remprv-server.c
 create mode 100644 mesh/remprv.h

-- 
2.39.1

