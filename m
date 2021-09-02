Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D625C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE00610CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbhIBKup (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243737AbhIBKun (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:50:43 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC496C061575
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:49:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z10-20020a170903018a00b00134def0a883so724338plg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OLVR+Z/2hKdNsVDGuTnZANcOYlHANzIXsPMrFvJp+ek=;
        b=UydHxC14Jh3KKQlyvx2uyoz0xQ7Et6iyoEVNBScrzId7Wz3telcMAaJoWqvev3sfnF
         1S6kc1tJPMD9rIVJBe0Zn+9j8ZEKWpJ4yyFr0FSF6Pxv7LjfJ8mYONt90SUDqNSTJ/6f
         3c0wWb65qm7YEcZLMoLuECYqRMQj52xLYlUMA+o2yXIs3CsdkWiqSnBBvHAcXzcK5nzj
         x98POB5x55ahBlQ3ONexDoYPptC0GvWTWwi3QhXOQxKBVzcR4QexVjt3/rVC/hVdGsAx
         /uY59zid78Qi2k5bYD+8f7zwpXd6ssE5NyvRocYXhXXATzWkgbZ6StDUAbyu2EoHA698
         sQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OLVR+Z/2hKdNsVDGuTnZANcOYlHANzIXsPMrFvJp+ek=;
        b=Ztfh7C+yTL46dPvL/0QjH1oS72rT3GG0wlRbbNEAedbVSyzi+O7oi5XEa9ltSevzDd
         mhpD76wtPL0EFb2ubloVah5sRrrXrhEqxHOdn+ENcnmVJE+QrH20VEU1planUdrBywyI
         x9fqhEsseiROWfTAtHaIpQSETvEz5z/sVafPLhBQgaEJhOnmqClybCzYkh5oOr6BPsxB
         DtistjOG9/yJO4pwInjBmlzrXrdr4e5l2zFN2HFSfUGjjJB6Sbv5NmtfyKvsmmyQ7rHm
         ZLjkFrXeQWQ6wwbPmfNSMxzSrDh4N3tWHuf9Kap2GTGFhPBMcrkUJBQsF63I0xhhpmIJ
         y/xg==
X-Gm-Message-State: AOAM533WNgXeKlVErq4u5kDeY7LJTMAT1yhYhFpPRXMUASBUWvfeb0wU
        Ihqz3Ehcuvt8AeqT8OB8IUDQTrSCLllYXCK9mfSmA9AXPR+9M+0HI5k5NvRWX9+yosBpExQXpii
        hL5rfZjUwhjTx+1Cb8Sac/eSPMPBeVwjT4uxK7Er3Br74RhQg2ckprvt/QCBeijmldtpF+xbctq
        tt
X-Google-Smtp-Source: ABdhPJwQVKlcS7hX1EzeqsyIMeeANpObV2MpGS00eEVmu02a8RurX3MHz3CgBcpycgSy36vP3Lopr9k0YsPZ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a62:920b:0:b0:3ec:7912:82be with SMTP id
 o11-20020a62920b000000b003ec791282bemr2898912pfd.34.1630579784238; Thu, 02
 Sep 2021 03:49:44 -0700 (PDT)
Date:   Thu,  2 Sep 2021 18:49:26 +0800
Message-Id: <20210902104938.824737-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v3 00/12] Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Hi BlueZ maintainers,

This series of patches promotes the usage of the more inclusive terms
such as central/peripheral, accept list/reject list, or their
equivalent where appropriate.

This is also reflected on the changes to Core spec v5.3 and the
appropriate language mapping table by Bluetooth SIG
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

As you suggested, I dropped the Android changes and merge patches
which belong to the same directory into one patch.

Note that the following terms are not replaced:
(1) those involving storage format (i.e. storing LTK)
(2) those which belong to the libbluetooth API

Thanks,
Archie

Changes in v3:
* Not replacing some terms which belong to libluetooth API

Changes in v2:
* Merging several patches from the same directory into one

Archie Pusaka (12):
  lib: Inclusive language changes
  btio: Inclusive language changes
  monitor: Inclusive language changes
  emulator: Inclusive language changes
  tools: Inclusive language changes
  plugins/sixaxis: Inclusive language changes
  profiles: Inclusive language changes
  src: Inclusive language changes
  client: Inclusive language changes
  mesh: Inclusive language changes
  unit/mesh: Inclusive language changes
  doc: Inclusive language update

 android/a2dp.c             |   2 +-
 android/bluetooth.c        |   4 +-
 android/handsfree-client.c |   2 +-
 android/tester-main.c      |   2 +-
 btio/btio.c                |  42 ++--
 btio/btio.h                |   2 +-
 client/main.c              |   6 +-
 doc/mesh-api.txt           |   2 +-
 doc/mgmt-api.txt           |   6 +-
 emulator/btdev.c           | 198 +++++++++---------
 emulator/hciemu.c          |  21 +-
 emulator/hciemu.h          |  12 +-
 emulator/le.c              | 116 +++++------
 emulator/serial.c          |   6 +-
 emulator/smp.c             |   8 +-
 lib/hci.c                  |  22 +-
 lib/mgmt.h                 |   2 +-
 mesh/net-keys.c            |  38 ++--
 mesh/net-keys.h            |   8 +-
 mesh/net.h                 |   4 +-
 monitor/broadcom.c         |   8 +-
 monitor/bt.h               | 150 +++++++-------
 monitor/control.c          |  14 +-
 monitor/l2cap.c            |  10 +-
 monitor/ll.c               |  60 +++---
 monitor/lmp.c              |   2 +-
 monitor/packet.c           | 411 +++++++++++++++++++------------------
 plugins/sixaxis.c          |  44 ++--
 profiles/audio/a2dp.c      |   2 +-
 profiles/audio/avctp.c     |  10 +-
 profiles/audio/avctp.h     |   2 +-
 profiles/health/mcap.c     |  20 +-
 profiles/health/mcap.h     |   2 +-
 profiles/sap/server.c      |   2 +-
 src/adapter.c              | 113 +++++-----
 src/adapter.h              |   4 +-
 src/device.c               |   6 +-
 src/sdpd-server.c          |   8 +-
 src/sdpd.h                 |   2 +-
 src/shared/ad.c            |   8 +-
 src/shared/ad.h            |   2 +-
 src/shared/hfp.c           |   4 +-
 src/shared/hfp.h           |   2 +-
 tools/3dsp.c               |  62 +++---
 tools/bdaddr.rst           |   2 +-
 tools/btiotest.c           |  22 +-
 tools/btpclientctl.c       |   2 +-
 tools/hci-tester.c         |  16 +-
 tools/hciconfig.c          |  26 +--
 tools/hciconfig.rst        |  24 +--
 tools/hcitool.c            | 102 ++++-----
 tools/hcitool.rst          |  30 +--
 tools/l2cap-tester.c       |  36 ++--
 tools/l2test.c             |  18 +-
 tools/mesh-cfgclient.c     |   4 +-
 tools/mesh-gatt/mesh-net.h |   4 +-
 tools/mesh-gatt/net.c      |  60 +++---
 tools/mesh/mesh-db.c       |  28 ++-
 tools/mesh/mesh-db.h       |   4 +-
 tools/mesh/remote.c        |  53 +++--
 tools/mesh/remote.h        |   5 +-
 tools/meshctl.c            |   6 +-
 tools/mgmt-tester.c        | 138 +++++++------
 tools/oobtest.c            |  12 +-
 tools/parser/avdtp.c       |   4 +-
 tools/parser/csr.c         |  17 +-
 tools/parser/ericsson.c    |   2 +-
 tools/parser/hci.c         |  35 ++--
 tools/parser/lmp.c         | 112 +++++-----
 tools/parser/parser.h      |   2 +-
 tools/parser/smp.c         |  12 +-
 tools/rctest.c             |  18 +-
 tools/rctest.rst           |   4 +-
 tools/rfcomm-tester.c      |  14 +-
 tools/rfcomm.c             |  14 +-
 tools/rfcomm.rst           |   2 +-
 tools/sco-tester.c         |  10 +-
 tools/smp-tester.c         |  16 +-
 unit/test-mesh-crypto.c    |   4 +-
 79 files changed, 1162 insertions(+), 1147 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

