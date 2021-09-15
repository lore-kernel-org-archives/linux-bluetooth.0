Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FB0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610CA60F23
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhIOIdl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhIOIdk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:33:40 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E59C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:21 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w13-20020a05621412ed00b0037cc26a5659so1662465qvv.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B4E2TS4b56n7nnb7XJEqRuIvZxn29Y1xCzeGV059ESU=;
        b=htWfIMwu6aisP8k6HOms6tHjGpGiTNVVPDfeY20FKBuGWpxjb7zsbrX8b/ndU+V/oT
         4WxfHgyv7MfNDBGZil5TlLpLmZkElybTzpsuiZozu90odH+trczgPBF3fX6MNB0uPqre
         yvxLXtCHGhK7xmCPlqp4F/vR5n398cwvwEkynf1XNXsUqSf5a0K27L2WyygbA6/fq9aD
         ZV9aR9126yDOw3S0sGZLu0589J59EDGw6hAgYBYG559KqUuIsJLR4J9/q+jEBeoBUJeO
         U3wuQxJjqqhbXqNgfhhs1sB1CSTzRt7vmIIFbxOXOtsEo3M7n9DBJmRoYNlWBEgSz9vl
         uAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B4E2TS4b56n7nnb7XJEqRuIvZxn29Y1xCzeGV059ESU=;
        b=LKYY31FI5N7TlF5OPVZ3YfWr1WA/3rPwBlSA33qy0Sa94pQlfm+gsOp24u7iOTDaLZ
         Y1nH/eg5Fqs6h2iRriEPRXGHjeoqZWxNbehJA7nAo59W/2M64A19In3LTZbrNVLAeO4m
         sUt1PXCZTh9h3RTKxtKPsPxL5uzJVnnIeFDH728DJ3yVhAaNDo0lG18KBddW10RPJZa5
         QLjDmGa+lP785WTerFUWxhwZmLtwiYI57WF0CfbdsbETvXeig7lMtIQwCyIVZlHeZsMZ
         t7QiguygkGviVOLPkm2TqdoQAJsuccQ9I5lxfbtTInlo5LXksQzU6rg9/pBO6CwK8p6X
         CXKA==
X-Gm-Message-State: AOAM531vvZomfYtqUWQIO5T2rA//ntbbJri2KdhAWpiiGP+RiBaeONlx
        8iaTs93vj/ZhxUvAFeTSlATe+l93g3BcER/BhXQRDryVN+zghUEd6cMtAw4zX77/S1dZ4kjOx2M
        5x1jRibuktUauk14ZCNjG1SkyPQc/LniWIlFHNWcJUV6gQlCGK4uKrAhgSIqX1mH9GSWBbSyK42
        ik
X-Google-Smtp-Source: ABdhPJxkqX11jabWNPP+zJAmvvsgWUcef+b+cJjDPUHYCZ/xF69fNY0bl5ywx48eL5zuLkMpT5d3B5IJW2M4
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a05:6214:11f0:: with SMTP id
 e16mr9685506qvu.30.1631694741032; Wed, 15 Sep 2021 01:32:21 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:31:54 +0800
Message-Id: <20210915083207.243957-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 00/13] Inclusive language changes
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
(3) those serve as input parameters to user facing tools

Thanks,
Archie

Changes in v5:
* Support the original term as input parameter for tools
* Split input parameters changes as a separate patch

Changes in v4:
* Fix line over 80 columns

Changes in v3:
* Not replacing some terms which belong to libluetooth API

Changes in v2:
* Merging several patches from the same directory into one

Archie Pusaka (13):
  lib: Inclusive language changes
  btio: Inclusive language changes
  monitor: Inclusive language changes
  emulator: Inclusive language changes
  tools: Inclusive language changes
  tools: Deprecate some input parameters to align with inclusive
    language
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
 lib/hci.c                  |  32 +--
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
 tools/btiotest.c           |  24 ++-
 tools/btpclientctl.c       |   2 +-
 tools/hci-tester.c         |  16 +-
 tools/hciconfig.c          | 148 ++++++++-----
 tools/hciconfig.rst        |  24 +--
 tools/hcitool.c            | 114 +++++-----
 tools/hcitool.rst          |  30 +--
 tools/l2cap-tester.c       |  36 ++--
 tools/l2test.c             |  10 +-
 tools/mesh-cfgclient.c     |   4 +-
 tools/mesh-gatt/mesh-net.h |   4 +-
 tools/mesh-gatt/net.c      |  60 +++---
 tools/mesh/mesh-db.c       |  17 +-
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
 tools/rctest.c             |  13 +-
 tools/rctest.rst           |   2 +-
 tools/rfcomm-tester.c      |  14 +-
 tools/rfcomm.c             |  17 +-
 tools/rfcomm.rst           |   2 +-
 tools/sco-tester.c         |  10 +-
 tools/smp-tester.c         |  16 +-
 unit/test-mesh-crypto.c    |   4 +-
 79 files changed, 1267 insertions(+), 1181 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

