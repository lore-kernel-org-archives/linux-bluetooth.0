Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E725CC004D4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjASX6O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjASX6K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB14A9F3B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:04 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9so3850947pll.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhW84Hd08Yh0djZ/IA1tMAN3nBncRabhVhFuk8nl7rU=;
        b=Qt7YHupDuK0YOP7o4FTXRXY8HSZFKkyz0q20z/bcTRjUjYBM5ApFWJM7Zto90hsd++
         NBbUMl7DteLJuVMcCsPJZylUObJxa1RUJ4uTzpTdnisW6SIhHMI3ONhHYWyMgHCgqsNl
         HWCrc4CPam8xr+3iA4Wt/U7rYO8P6Gz4IBHn7pKewTuEnv8NfGkqqo3+Kkvwyl/misTi
         Ap5QPs8xjTL6XNBzUYIU3EohPdakyd9UOcQ/IP/KpOsu/cuihLS6uriJHascnrO4tAoB
         TL2cl4Gw0b3oOxurFMsrg2KeeD6nv/Tmd6e5l4LKGn8TWh1yTLwAI4JyCYfK5skP2jQq
         qeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhW84Hd08Yh0djZ/IA1tMAN3nBncRabhVhFuk8nl7rU=;
        b=jX4bNQA+rEbwPrGgvedxbIpHgcK6dLKM8Dt+ddaINCp68nNC5XjflMVkllFx8oW+5x
         58wHXCldhasl9axEh0BF9M0G2cDzJeku94nmkgoindN+ybQqzkp96+/No7owVcJi40PJ
         PKJX+ljHRxNDRCLJSUOWl7ix9LmBOZ2w2f0HT+cOcYwOp+CUaPCushTkauwuTznF468r
         Vaq28IR6CPhAk3vlrugqpmqezekZHIDcAkb5MFXbqdvOoINf0H1VW9NCLvqTjZ0gkJty
         tR6HHfD98Fiy24gL7fWnFCSSrk83uxhMV80GPzB+afHDAxtO/3QgFiTDrG1D1Fi4zWvg
         D+dA==
X-Gm-Message-State: AFqh2koCCNrmmn7shfqr9QW/9z0O+8ydAVyNYMeXnSfdQ1ud4++PZsVy
        YXtp3dFXhNQn7SUuBwJZdNzUd4PkKFG2sg==
X-Google-Smtp-Source: AMrXdXvHc/0CJNnRRlAsWOeTUPyoXdDGnaepxuJj4bPOJgGUTgRlDBYvQICrkRZbtOCH4+e2J7BtTw==
X-Received: by 2002:a17:902:cf08:b0:192:c125:ac2f with SMTP id i8-20020a170902cf0800b00192c125ac2fmr14632415plg.8.1674172683578;
        Thu, 19 Jan 2023 15:58:03 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:03 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@gmail.com>
Subject: [PATCH BlueZ 00/12] Mesh v1.1 additions
Date:   Thu, 19 Jan 2023 15:57:43 -0800
Message-Id: <20230119235755.46002-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch-set includes implementations for Client/Server Remote
Provisioning, and Client/Server Mesh Private Beacons

Brian Gix (12):
  doc/mesh: Add Remote Provisioning DBus APIs
  mesh: Add Remote Provisioning
  tools/mesh: Optimize for multiple RPR servers and NPPI
  mesh: Rename parameter list per crypto usage
  unit/mesh:  Add unit testing of Mesh Private Beaconing
  mesh: Add storage of Mesh Private Beacon settings
  mesh: Add Mesh Private Beacon server
  mesh: Add Tx/Rx support of Mesh Private Beacons
  mesh: Add internal Mesh Private Beacon model
  mesh: Plumb in Mesh Private Beacon model
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
 mesh/net-keys.c         | 502 +++++++++++++++++-----
 mesh/net-keys.h         |  11 +-
 mesh/net.c              | 188 ++++++---
 mesh/net.h              |   6 +-
 mesh/node.c             | 326 ++++++++++++---
 mesh/node.h             |   5 +
 mesh/pb-adv.c           |   4 +-
 mesh/pb-adv.h           |   2 +-
 mesh/prov-acceptor.c    |  87 ++--
 mesh/prov-initiator.c   | 266 +++++++++++-
 mesh/prov.h             |   4 +-
 mesh/provision.h        |  23 +-
 mesh/prv-beacon.h       |  36 ++
 mesh/prvbeac-server.c   | 128 ++++++
 mesh/remprv-server.c    | 908 ++++++++++++++++++++++++++++++++++++++++
 mesh/remprv.h           |  78 ++++
 tools/mesh-cfgclient.c  | 488 +++++++++++++++++----
 tools/mesh/cfgcli.c     |  99 ++++-
 tools/mesh/mesh-db.c    |  36 +-
 tools/mesh/mesh-db.h    |   1 +
 tools/mesh/remote.c     | 122 ++++++
 tools/mesh/remote.h     |   9 +
 tools/mesh/util.c       |   3 +
 unit/test-mesh-crypto.c |  87 +++-
 35 files changed, 3943 insertions(+), 666 deletions(-)
 create mode 100644 mesh/prv-beacon.h
 create mode 100644 mesh/prvbeac-server.c
 create mode 100644 mesh/remprv-server.c
 create mode 100644 mesh/remprv.h

-- 
2.39.0

