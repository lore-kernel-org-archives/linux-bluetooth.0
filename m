Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A762BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8483D60EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhIBEIR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhIBEIR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:08:17 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED43C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:07:19 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l12-20020a0cc20c000000b0037766e5daaeso583642qvh.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Gzy7HnakEL9Mz1UD5e/d9LNjvaiXPIAImZPp4blVsh4=;
        b=GDUp083QxnNWYzIT4yPgFHtC/UOvINMZqe1OR3mtANH5U2+9fsdtPKXJQiDw9/yFui
         /q05rXM2GrL1kWQxtxTXXcTxBCZftVyFP+1Vc7b1wgsQgtQ2YY5XTOd7yaM1AMat8afu
         vcgZHYgc+igfRdOsEb2kWmc9Ga0j08rd+tKdOjmnz6AXhQTM8CylwYVtNipwaLEMsyZF
         89hE3ylH9ixNlZkCUIqrhIRj8NIFoBhjBrYCl98cDrZfdr+g3qb7Hcz5J6w4CHesWqTk
         pJ7c5zgFIsV1mcnDf7v2yRcmsxKBIY2kVZxzCFhZhWP7rh9cLm89UPk4RIZ9ugtOAPFN
         nFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Gzy7HnakEL9Mz1UD5e/d9LNjvaiXPIAImZPp4blVsh4=;
        b=dMaFww+zXUuukOsdusrLfvDejzahJvATTSi3jpQK87YOYRkU/0N/49emtCuIEuZ6W0
         f7Bh2OkyEmltx7gGTw/rf6nmfJntmq3ZvSVWeZeU/i6zNEdkH9ac5Quryd835TaLnahV
         eq9mHVeonjal/LhN7OfZqwI5qJN5yu/Z43dKz5uTr4qBcYCDrldAA/JJxYLkds3hW7WQ
         eNCG1r3WVBBIJxBhqMPAP42lU/1gpBfp5lIQ7u6hQ3m9JkA8MViPT2+NW8AS5BazNnWT
         ZDJ8BJkEAfjeaWPeqRBz8BQ7Va/sXFxzAFk8ZuAq6126O5VVw7Y3qDefowHM/C8SU6H3
         52og==
X-Gm-Message-State: AOAM530m7wP59e0BYn1hFxv9cv46JbhpllQ0iZRoN3ep5RSDOVVd7fb+
        UdeAVsdtg0fsRn8GRTRks/IcSXG65KP/p9onMapVG4rDELCDP/bsfPHUDvDC8vtlCyUq1zMpyQa
        J0JAShor+LOsPFe21ZoP1mR+FRAjcbXKEsj/EJOgzohmy9a3m5LkXlayP4f6cxxUYSG+uGVKynu
        Da
X-Google-Smtp-Source: ABdhPJxu9SD9pynSdKTwMHlOkpBogZa9P1NGoFzzA1skZLW5WBhw8ehyHN9uyzeJ/8Ceikl49K3zchmYacmX
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:94c:: with SMTP id
 dn12mr1055603qvb.60.1630555637854; Wed, 01 Sep 2021 21:07:17 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:06:58 +0800
Message-Id: <20210902040711.665952-1-apusaka@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 00/13] Inclusive language changes
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
which belong to the same directory into one patch. However I didn't
get a clear opinion on "storing LTK" patch which will break stored
data, so I separate that into its own patch.

I also don't know the scope of libbluetooth, so please advise me on
which terms shouldn't be changed yet, if any.

Thanks,
Archie

Changes in v2:
* Merging several patches from the same directory into one

Archie Pusaka (13):
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
  adapter: Inclusive language for storing LTK

 android/a2dp.c             |   2 +-
 android/bluetooth.c        |   4 +-
 android/handsfree-client.c |   2 +-
 android/tester-main.c      |   2 +-
 btio/btio.c                |  62 +++---
 btio/btio.h                |   2 +-
 client/main.c              |   6 +-
 doc/mesh-api.txt           |   2 +-
 doc/mgmt-api.txt           |   6 +-
 doc/settings-storage.txt   |   4 +-
 emulator/btdev.c           | 198 +++++++++---------
 emulator/hciemu.c          |  21 +-
 emulator/hciemu.h          |  12 +-
 emulator/le.c              | 116 +++++------
 emulator/serial.c          |   6 +-
 emulator/smp.c             |   8 +-
 lib/hci.c                  |  52 ++---
 lib/hci.h                  |  44 ++--
 lib/hci_lib.h              |   8 +-
 lib/l2cap.h                |   2 +-
 lib/mgmt.h                 |   2 +-
 lib/rfcomm.h               |   2 +-
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
 profiles/health/mcap.c     |  22 +-
 profiles/health/mcap.h     |   2 +-
 profiles/sap/server.c      |   2 +-
 src/adapter.c              | 117 ++++++-----
 src/adapter.h              |   4 +-
 src/device.c               |   6 +-
 src/sdpd-server.c          |  10 +-
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
 tools/hcitool.c            | 110 +++++-----
 tools/hcitool.rst          |  30 +--
 tools/l2cap-tester.c       |  36 ++--
 tools/l2test.c             |  22 +-
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
 tools/parser/hci.c         |  49 ++---
 tools/parser/lmp.c         | 112 +++++-----
 tools/parser/parser.h      |   2 +-
 tools/parser/smp.c         |  12 +-
 tools/rctest.c             |  22 +-
 tools/rctest.rst           |   4 +-
 tools/rfcomm-tester.c      |  14 +-
 tools/rfcomm.c             |  16 +-
 tools/rfcomm.rst           |   2 +-
 tools/sco-tester.c         |  10 +-
 tools/smp-tester.c         |  16 +-
 unit/test-mesh-crypto.c    |   4 +-
 84 files changed, 1237 insertions(+), 1222 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

