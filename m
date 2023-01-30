Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16801C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjA3XwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjA3XwT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA62DE76
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so13379228plo.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mf0c5zcABKnqhx8xHQgVps/l7BaM9y8KB4s66b3uMaM=;
        b=UOYqYZX4S1BGZ2M5Ub+6/OTCmkD3suU7+SIuexkO/QA6L8lLDRp9GDaypqhYAY0stf
         5uanHBao8rjSqmfNGUC/A7AXQk4CtDPI4UA+CngoKrNHjstrLA4l+3V4xWUml9yaODnC
         hN39QK9r82KQwolJBesjmboga0VG/N3P4kBigjlm7aYjXfMej042yITtQo7I6cmPcBlg
         2PhaX8nUrqrg5KW+mWblr3xXTgNCX9IMML8QoQm+aMJFWopcRkkkM4dEmCcMwhlJSu76
         2foqnuJ1XVeLDJSMzjMq2QQMAmlJ/4xF5UPeWXNedX3mWYPvnTz1cFRt1aRwEvfVokPG
         RSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mf0c5zcABKnqhx8xHQgVps/l7BaM9y8KB4s66b3uMaM=;
        b=SCvauU3koMIM6sAJzzTzlpLT1ciByWPZMmr2PE7T8HSqvp8xxrT1ALNB+Y/r11zaF7
         bwjlzLmpiDkgscHiR4FkhTV81q/cKt3xdazatY1RN2S00J5L6yZIAsPiwoc6x3dbKz9H
         VxYzYMGfxsV/yykq43BtUWIO7r2bePCcWaDrrhQrVDtG51GH8b3x+pzBiMdDRY3iM64v
         JFrOEcqczfqRbEZySfR9THCBTV0CBtqcRhaas8hvDXZNndNmXE9pgNw32/OsgVOKVFYI
         LY88h6Kki1DQhe77ucJde5Cz9XpzECdiUuNvvCEqgH/ODC/qotdumjYPmnMyKMszb5fk
         4ANw==
X-Gm-Message-State: AO0yUKWZF8kF9gyV2L8T8xLzJhBSFFTWEy2dB5vz0Cg2aCsuykD6qlfg
        Lf7fpCdmQxl0aok2z+p4O/Avn5eEY/utTA==
X-Google-Smtp-Source: AK7set/bZmBFe6Ta/mSt96O1o7OsvmYGrTPRsGGaOH7lCZEGMtx8CCkGei4GydW37n4Bd5ibQiSVBw==
X-Received: by 2002:a17:90a:188:b0:22c:891f:5753 with SMTP id 8-20020a17090a018800b0022c891f5753mr7770850pjc.40.1675122737254;
        Mon, 30 Jan 2023 15:52:17 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:16 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v5 00/14] Mesh v1.1 additions
Date:   Mon, 30 Jan 2023 15:51:56 -0800
Message-Id: <20230130235210.94385-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set includes implementations for Client/Server Remote
Provisioning, and Client/Server Mesh Private Beacons

v2 - v4: Clean-up checkpatch warnings.

v5: Add Inga's Extended Composition support

Brian Gix (13):
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
  mesh: Fix Checksmatch warning
  mesh: Remove unused byte swap for ScanBuild

Inga Stotland (1):
  tools/mesh-cfgtest: Support extended device composition

 Makefile.mesh           |   2 +
 doc/mesh-api.txt        | 140 ++++++-
 mesh/cfgmod-server.c    |   2 +-
 mesh/crypto.c           |  13 +-
 mesh/crypto.h           |   2 +-
 mesh/keyring.c          |  28 +-
 mesh/keyring.h          |   1 +
 mesh/manager.c          | 535 +++++++++++++++++++-----
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
 tools/mesh-cfgtest.c    | 188 ++++++++-
 tools/mesh/cfgcli.c     |  99 ++++-
 tools/mesh/mesh-db.c    |  37 +-
 tools/mesh/mesh-db.h    |   1 +
 tools/mesh/remote.c     | 122 ++++++
 tools/mesh/remote.h     |   9 +
 tools/mesh/util.c       |   3 +
 unit/test-mesh-crypto.c | 182 ++++++--
 36 files changed, 4190 insertions(+), 719 deletions(-)
 create mode 100644 mesh/prv-beacon.h
 create mode 100644 mesh/prvbeac-server.c
 create mode 100644 mesh/remprv-server.c
 create mode 100644 mesh/remprv.h

-- 
2.39.1

