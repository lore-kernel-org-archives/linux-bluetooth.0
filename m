Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3347BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 08:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C5B61168
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 08:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhIUIzd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 04:55:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49020 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhIUIzd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 04:55:33 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id B15A7CED13;
        Tue, 21 Sep 2021 10:54:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [Bluez PATCH v5 00/13] Inclusive language changes
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Date:   Tue, 21 Sep 2021 10:54:03 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D8F94F09-3695-4EC1-A633-BE9CDCC3E919@holtmann.org>
References: <20210915083207.243957-1-apusaka@google.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> This series of patches promotes the usage of the more inclusive terms
> such as central/peripheral, accept list/reject list, or their
> equivalent where appropriate.
> 
> This is also reflected on the changes to Core spec v5.3 and the
> appropriate language mapping table by Bluetooth SIG
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
> 
> As you suggested, I dropped the Android changes and merge patches
> which belong to the same directory into one patch.
> 
> Note that the following terms are not replaced:
> (1) those involving storage format (i.e. storing LTK)
> (2) those which belong to the libbluetooth API
> (3) those serve as input parameters to user facing tools
> 
> Thanks,
> Archie
> 
> Changes in v5:
> * Support the original term as input parameter for tools
> * Split input parameters changes as a separate patch
> 
> Changes in v4:
> * Fix line over 80 columns
> 
> Changes in v3:
> * Not replacing some terms which belong to libluetooth API
> 
> Changes in v2:
> * Merging several patches from the same directory into one
> 
> Archie Pusaka (13):
>  lib: Inclusive language changes
>  btio: Inclusive language changes
>  monitor: Inclusive language changes
>  emulator: Inclusive language changes
>  tools: Inclusive language changes
>  tools: Deprecate some input parameters to align with inclusive
>    language
>  plugins/sixaxis: Inclusive language changes
>  profiles: Inclusive language changes
>  src: Inclusive language changes
>  client: Inclusive language changes
>  mesh: Inclusive language changes
>  unit/mesh: Inclusive language changes
>  doc: Inclusive language update
> 
> android/a2dp.c             |   2 +-
> android/bluetooth.c        |   4 +-
> android/handsfree-client.c |   2 +-
> android/tester-main.c      |   2 +-
> btio/btio.c                |  42 ++--
> btio/btio.h                |   2 +-
> client/main.c              |   6 +-
> doc/mesh-api.txt           |   2 +-
> doc/mgmt-api.txt           |   6 +-
> emulator/btdev.c           | 204 +++++++++---------
> emulator/hciemu.c          |  21 +-
> emulator/hciemu.h          |  12 +-
> emulator/le.c              | 116 +++++------
> emulator/serial.c          |   6 +-
> emulator/smp.c             |   8 +-
> lib/hci.c                  |  32 +--
> lib/mgmt.h                 |   2 +-
> mesh/net-keys.c            |  38 ++--
> mesh/net-keys.h            |   8 +-
> mesh/net.h                 |   4 +-
> monitor/broadcom.c         |   8 +-
> monitor/bt.h               | 150 +++++++-------
> monitor/control.c          |  14 +-
> monitor/l2cap.c            |  10 +-
> monitor/ll.c               |  60 +++---
> monitor/lmp.c              |   2 +-
> monitor/packet.c           | 411 +++++++++++++++++++------------------
> plugins/sixaxis.c          |  44 ++--
> profiles/audio/a2dp.c      |   2 +-
> profiles/audio/avctp.c     |  10 +-
> profiles/audio/avctp.h     |   2 +-
> profiles/health/mcap.c     |  20 +-
> profiles/health/mcap.h     |   2 +-
> profiles/sap/server.c      |   2 +-
> src/adapter.c              | 113 +++++-----
> src/adapter.h              |   4 +-
> src/device.c               |   6 +-
> src/sdpd-server.c          |   8 +-
> src/sdpd.h                 |   2 +-
> src/shared/ad.c            |   8 +-
> src/shared/ad.h            |   2 +-
> src/shared/hfp.c           |   4 +-
> src/shared/hfp.h           |   2 +-
> tools/3dsp.c               |  62 +++---
> tools/bdaddr.rst           |   2 +-
> tools/btiotest.c           |  24 ++-
> tools/btpclientctl.c       |   2 +-
> tools/hci-tester.c         |  16 +-
> tools/hciconfig.c          | 148 ++++++++-----
> tools/hciconfig.rst        |  24 +--
> tools/hcitool.c            | 114 +++++-----
> tools/hcitool.rst          |  30 +--
> tools/l2cap-tester.c       |  36 ++--
> tools/l2test.c             |  10 +-
> tools/mesh-cfgclient.c     |   4 +-
> tools/mesh-gatt/mesh-net.h |   4 +-
> tools/mesh-gatt/net.c      |  60 +++---
> tools/mesh/mesh-db.c       |  17 +-
> tools/mesh/mesh-db.h       |   4 +-
> tools/mesh/remote.c        |  53 +++--
> tools/mesh/remote.h        |   5 +-
> tools/meshctl.c            |   6 +-
> tools/mgmt-tester.c        | 138 +++++++------
> tools/oobtest.c            |  12 +-
> tools/parser/avdtp.c       |  11 +-
> tools/parser/csr.c         |  17 +-
> tools/parser/ericsson.c    |   2 +-
> tools/parser/hci.c         |  38 ++--
> tools/parser/lmp.c         | 112 +++++-----
> tools/parser/parser.h      |   2 +-
> tools/parser/smp.c         |  12 +-
> tools/rctest.c             |  13 +-
> tools/rctest.rst           |   2 +-
> tools/rfcomm-tester.c      |  14 +-
> tools/rfcomm.c             |  17 +-
> tools/rfcomm.rst           |   2 +-
> tools/sco-tester.c         |  10 +-
> tools/smp-tester.c         |  16 +-
> unit/test-mesh-crypto.c    |   4 +-
> 79 files changed, 1267 insertions(+), 1181 deletions(-)

all 13 patches have been applied.

Regards

Marcel

