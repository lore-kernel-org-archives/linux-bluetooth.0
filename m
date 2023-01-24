Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF31C54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjAXU0n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjAXU0b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A49C4DE1F
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:21 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d3so15878969plr.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omPXaawKkJpSJNPNhZiMdFrR0kDTec1591sgI+JvFX4=;
        b=AyLxvlFZzp6kxYU2zjp88sF0ipNpd+95oCll4928dH+l/oAK3aUJuLxR9VAZ3Vl6aG
         n5lMygZGP9DIz7RPeSMhUNcYKyrX7xcuPs6L6ZrpSA31thT14tNSSm/YkQ8AzV7h2qBm
         Jkq7rC1kliTFB3bjv/+7rkALQfwMC9yWaEIlxIsJs81YaCHMgrJ9KA9FbrxeGwm4Pkn1
         FBP3X0gehCCZKSBCbHP63OhRG5Hcv1NTd6Li/dZrd/J4I0p6mZD9AaCUecG7ug5ape3O
         tda+vEgTKTTtcEiLcYDcVbs3nbV6UzQbVshAvA7W3DpCv2BcHVTjSpeipm3iiBAkIN3X
         EEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omPXaawKkJpSJNPNhZiMdFrR0kDTec1591sgI+JvFX4=;
        b=WN5zcJNLRDk/R+OxayR0B2kRIX98/oU4hphHEqoMer01LyfyhZ4MJfa1alzlN5io/D
         WcjULJDHqWSr1e1KwTiLEIq4KddVnz4ppQGPN8yD6ytmK03V98iYm9OR6XEPDBF1mHgd
         N55E0r9MWSwW3XQXI1YU5eEwotKFQb2tNjQi3EJhp4ajgNHdtbzLysBb3KIQURDg38sq
         QXuVp8CT3blUx3PUaxen869VQ98XwZbX/Oe4SyN+5YHt5IJfDXF7+N/gs6P7bKslqfpq
         y0mPXvwklzevy6Dr35WmmK/0e/araSY5UCWug7Vi4CiILDajalAlohxxvJ06qxR3jdhN
         1Jpw==
X-Gm-Message-State: AFqh2ko2Pu73okGt//09ErvAryzv4shhWVu6w4ai1wK1UlB6BPccsHn8
        nUVLUfq2agzDIJNhfAcVukgDNYobUnQCFw==
X-Google-Smtp-Source: AMrXdXtYx/ZSugdmDextfXJzyVYS6AQQ/cM0j8eZf833rFq3K5pFpP9hldw7Ls6q2AgguPL7SMuWRw==
X-Received: by 2002:a17:902:7c94:b0:192:8d74:99e0 with SMTP id y20-20020a1709027c9400b001928d7499e0mr29286506pll.4.1674591980353;
        Tue, 24 Jan 2023 12:26:20 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:19 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ v4 00/13] Mesh v1.1 additions
Date:   Tue, 24 Jan 2023 12:26:03 -0800
Message-Id: <20230124202616.310544-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set includes implementations for Client/Server Remote
Provisioning, and Client/Server Mesh Private Beacons

v2 - v4: Clean-up checkpatch warnings.

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

 Makefile.mesh           |   2 +
 doc/mesh-api.txt        | 140 ++++++-
 mesh/cfgmod-server.c    |   2 +-
 mesh/crypto.c           |  13 +-
 mesh/crypto.h           |   2 +-
 mesh/keyring.c          |  29 +-
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
 tools/mesh/cfgcli.c     |  99 ++++-
 tools/mesh/mesh-db.c    |  37 +-
 tools/mesh/mesh-db.h    |   1 +
 tools/mesh/remote.c     | 122 ++++++
 tools/mesh/remote.h     |   9 +
 tools/mesh/util.c       |   3 +
 unit/test-mesh-crypto.c | 128 ++++--
 35 files changed, 3979 insertions(+), 689 deletions(-)
 create mode 100644 mesh/prv-beacon.h
 create mode 100644 mesh/prvbeac-server.c
 create mode 100644 mesh/remprv-server.c
 create mode 100644 mesh/remprv.h

-- 
2.39.1

