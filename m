Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0B60F43
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbhIFIGB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbhIFIGA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:06:00 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E49C061757
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:04:56 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 13-20020ac8560d000000b0029f69548889so8780526qtr.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X+91x5XKoUfrfKTqDx3QI4eHyqzJIQ3/p9sD2Futs+E=;
        b=FmXYY4NyCZmTb9NhAIqrZJz8Nb2CsMNJk0JRyjWNf8yT9FvOg5kViheIUkN0GyB6On
         NAa4i25YDp3OfpiqzunD7OSJYGt6O5c3kkdSOdIl7NIf2VVX4V/GkwNFYX/d0xAiEja+
         QT0Id5o49/HUWPD/mOUpS0Pt5hU0neMl0N5VXm46ms+4JU9l7cQpa/wdkC5o4x+Xgyfa
         WdDGd0Ux0r2XYPD5IAfycSX6eIpMUKizaT7gj8CIXvm1N2zJizgGBR8lTI54TJe9avju
         6YWipZhil84biJl+mQYGJJ1TUcGN1OMxmFsr6Y82Cp55ca6W7Fn15mPt2WS4kt7IGp14
         gyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X+91x5XKoUfrfKTqDx3QI4eHyqzJIQ3/p9sD2Futs+E=;
        b=Rsiwj7ZEpeuvOeySAqzVbJRounR483nhefOSmOY1qivDqhxSCkJ+fFNVfxI0TNi5kv
         AbkzssFtcnUePpkO60urTlyB/SZO9AUlsWMpHxQ/pWsuAP2GHrbP6JHnezz18yxpOGz9
         Q4lKrqOtPlg+yfZUDE0u+2+PeJtf3kNx5QehwbLly9SsVh9TGXwNENHINiYCc3UxE9oM
         KSkx3ceaKFMhu65OR+T6dGZA3oR6k6tGKdsrJYx5FgESR/WLNiulH54gcWpjWY/ewC9W
         eODn7vpdQVpS822jYq8wU2Co+ow0N0Jp7COiM6BUUj9wIFOjsuLeEfofdXZ2IlCET4XO
         jn/Q==
X-Gm-Message-State: AOAM531lKx6E4xIIA5Uy539NjjL/fbYUuWrzEVXBXUKlj7uZHikJkD7+
        cXedW94bLxzAjVAqCTA71relQlTzSxKsBlZB7XqtXznrG1e29Bx5IACfqCJ+eqHr6TMC8lSC6Ft
        g+Qmbo2H5d/yhNP6zIoO5+2yqdUHWwLyNYXQMmQAJo6m/az6JcF6SylEj38Hy6BHoJ0ozCsnIZH
        Xs
X-Google-Smtp-Source: ABdhPJz2MMShuYr47Js56WsCUCnQKoWXG2wJtzfywXOI8SMFH54pVNDg7ulcpsdO91deZjq/wE0YP7ajbuiX
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3b13:95ba:12e5:7134])
 (user=apusaka job=sendgmr) by 2002:a05:6214:2427:: with SMTP id
 gy7mr10859783qvb.20.1630915494943; Mon, 06 Sep 2021 01:04:54 -0700 (PDT)
Date:   Mon,  6 Sep 2021 16:04:38 +0800
Message-Id: <20210906080450.1771211-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v4 00/12] Inclusive language changes
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

Changes in v4:
* Fix line over 80 columns

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
 emulator/btdev.c           | 204 +++++++++---------
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
 tools/hciconfig.c          | 148 ++++++++-----
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
 tools/parser/avdtp.c       |  11 +-
 tools/parser/csr.c         |  17 +-
 tools/parser/ericsson.c    |   2 +-
 tools/parser/hci.c         |  38 ++--
 tools/parser/lmp.c         | 112 +++++-----
 tools/parser/parser.h      |   2 +-
 tools/parser/smp.c         |  12 +-
 tools/rctest.c             |  19 +-
 tools/rctest.rst           |   4 +-
 tools/rfcomm-tester.c      |  14 +-
 tools/rfcomm.c             |  15 +-
 tools/rfcomm.rst           |   2 +-
 tools/sco-tester.c         |  10 +-
 tools/smp-tester.c         |  16 +-
 unit/test-mesh-crypto.c    |   4 +-
 79 files changed, 1256 insertions(+), 1193 deletions(-)

-- 
2.33.0.153.gba50c8fa24-goog

