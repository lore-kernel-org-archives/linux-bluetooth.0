Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF78C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3306109E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 21:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhHMVnV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhHMVnV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 17:43:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08AC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 14:42:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 202so198525ybc.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1axDwId1hvI72M2Hig+rMSIPqbwhyq+97mTNQRY2+MI=;
        b=b9GM4mtAvSZmrfJQXIyM6y5fFb9lCzoPQrYZvWesTJ1lyNixs1CjCFgx+phQNfAHd3
         oq5dkEFPBW9DACoSMk4CXGhxuueJvLSNx3ljm8yepajlxPn7VPKIrmVKaHFgRPUf2kZk
         Nv7v+MqeHgN5aAjDxXhFal7aaav9KDxyof0pdjvj2QuKcTwdHOcIQTi1LtaJiZ4AdAim
         tL1MKRiZi+NI1uNyeYPm3pe27Nalq+2V/JSzYuhBt0QB90aImxOYg1bt3cjD2E37eure
         ksXHJrlKA6Md7QlqwHrLTpRelRAfVgeoAkbN2xYZe117BwYiUzqxwysErT2z3vy4WQ2X
         rvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1axDwId1hvI72M2Hig+rMSIPqbwhyq+97mTNQRY2+MI=;
        b=L57D0tQOoSK7OWPMAMcvPh494dkBl4jofBjrYTvBcC2aQfVHyULsnaoHszFKayyHQ6
         mAxooEuoMYllYixFDaXY1C3+VElKe9QIOkIClXy9aXGLRkO0JJz6ZYR6UUfRadu06zTM
         gwKCUwe9ac01AZlY4yNtIkAdwqd4WNGTPgQiI8F2xq2Mmc+PRlg2LjWVDwRKQkgzU8fJ
         z3SpIOU4yWG/zTO5G/qZEcMjV4X7WVcREy7g8xFAIs4QyD5tzclJOAoS0bjqwPgWQqDo
         lmQ8di3R+oHu2vFAdaHta5WBdAAH3GYrsrhqPwxlBS2MIHgcF6fKZ7Vfwl1aG5aK08g/
         aovg==
X-Gm-Message-State: AOAM531jRimb9cta7yIT4ibOwAqin+UeSOLVuNUmx2GWvf7HCbOhNVL2
        GrPfK+Mmw80SCcQTLcuwawKZTelzn7GltpIiIRU=
X-Google-Smtp-Source: ABdhPJzYXQGDOkiuLeb6D4W0+pgB9OccwuEv+pk+zNHIlnG8srYxL759VrKEUlPK2Y8wibPxkMgE5a5YLKnYxtCIRuM=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr6046605ybg.347.1628890971950;
 Fri, 13 Aug 2021 14:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 Aug 2021 14:42:40 -0700
Message-ID: <CABBYNZJOwSw_M3f4EOLdce6Xw9PE8=atKODdVb=OxsgXerZP1Q@mail.gmail.com>
Subject: Re: [Bluez PATCH 00/62] Inclusive language changes
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Fri, Aug 13, 2021 at 5:19 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
>
> Hi BlueZ maintainers,
>
> This series of patches promotes the usage of the more inclusive terms
> such as central/peripheral, accept list/reject list, or their
> equivalent where appropriate.
>
> This is also reflected on the changes to Core spec v5.3 and the
> appropriate language mapping table by Bluetooth SIG
> https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
>
> I tried to make the changes for each patch as local as possible,
> hopefully this could ease the adoption for downstream. As a side
> effect, I ended up with more patches than I had hoped before.
>
> Do take note that some patches, most notably the ones ending with
> "* storing LTK", will break the stored data, thus perhaps are not
> suitable to be merged as is. I don't have the plan to write patch to
> support both the old and the replacement version since that would
> still left us the less inclusive terms on the code base, but with
> additional complexity.
>
> Some other patches, mainly those on tools/* change the output or
> input parameter to tools, this might come as a surprise for users who
> uses another program that depends on the i/o parameter of those tools.
>
> I leave the discretion of choosing which patches are better to be left
> out to you.
>
> Thanks,
> Archie
>
>
> Archie Pusaka (62):
>   lib: Inclusive language in HCI commands and events
>   lib: Inclusive language in consts and strings
>   tools/hciconfig: Inclusive language update
>   core: Inclusive language for l2cap
>   core: Inclusive language for rfcomm
>   lib: Inclusive language for filtering devices
>   lib/mgmt: Inclusive language for LTK
>   doc/mgmt: Inclusive language update
>   btio: Inclusive language changes
>   shared/ad: Inclusive language changes
>   shared/hfp: Inclusive language changes
>   monitor: Inclusive language in struct member
>   monitor: Inclusive language in SMP related things
>   monitor: Inclusive language in LE states
>   monitor: Inclusive language in LL feature
>   monitor: Inclusive language in link key transaction
>   monitor: Inclusive language in peripheral broadcast
>   monitor: Inclusive language in peripheral page response timeout
>   monitor: Inclusive language in consts and strings
>   monitor: Inclusive language in filtering devices
>   emulator: Inclusive language in naming
>   emulator: Inclusive language in strings
>   emulator: Inclusive language in filtering device
>   tools: Inclusive language in referring the central address
>   tools/parser/hci: Inclusive language changes
>   tools/parser/smp: Inclusive language changes
>   tools/3dsp: Inclusive language changes
>   tools/mgmt-tester: Inclusive language changes
>   tools/bdaddr: Inclusive language changes
>   tools/hciconfig: Inclusive language changes
>   tools/meshctl: Inclusive language changes
>   tools/mgmt-tester: Inclusive language changes
>   tools/parser: Inclusive language in struct member
>   tools/parser/lmp: Inclusive language changes
>   tools/parser/avdtp: Inclusive language changes
>   tools/parser/csr: Inclusive language changes
>   tools/btpclientctl: Inclusive language changes
>   tools/l2cap-tester: Inclusive language changes
>   tools/hci-tester: Inclusive language changes
>   tools/btiotest: Inclusive language changes
>   tools/hcitool: Inclusive language changes, central peripheral
>   tools/hcitool: Inclusive language changes, accept list
>   tools/l2test: Inclusive language changes
>   tools/rctest: Inclusive language changes
>   tools/rfcomm: Inclusive language changes
>   plugins/sixaxis: Inclusive language changes
>   profiles/audio: Inclusive language changes
>   profiles/health: Inclusive language changes
>   sdp: Inclusive language changes
>   adapter: Inclusive language for central and peripheral
>   adapter: Inclusive language for storing LTK
>   adapter: Inclusive language for device filtering
>   client: Inclusive language changes
>   mesh: Inclusive language changes
>   tools/mesh: Inclusive language changes
>   tools/mesh-gatt: Inclusive language changes
>   unit/mesh: Inclusive language changes
>   doc/mesh: Inclusive language changes
>   android: Inclusive language for volume control
>   android: Inclusive language for describing relation
>   android: Inclusive language for filtering devices
>   android: Inclusive language in storing LTK

Can we perhaps group these changes on a one per directory? Also I
wouldn't bother with Android it already considered deprecated and
should be removed at some point, so only change things if it no longer
builds but otherwise leave it alone.

>  android/a2dp.c                  |   2 +-
>  android/bluetooth.c             |  62 ++---
>  android/client/if-hf-client.c   |   2 +-
>  android/hal-audio.c             |  12 +-
>  android/hal-ipc-api.txt         |   2 +-
>  android/hal-sco.c               |  12 +-
>  android/handsfree-client.c      |   2 +-
>  android/hardware/audio.h        |  20 +-
>  android/hardware/bt_hf_client.h |   2 +-
>  android/tester-main.c           |   8 +-
>  btio/btio.c                     |  62 ++---
>  btio/btio.h                     |   2 +-
>  client/main.c                   |   6 +-
>  doc/mesh-api.txt                |   2 +-
>  doc/mgmt-api.txt                |   6 +-
>  doc/settings-storage.txt        |   4 +-
>  emulator/btdev.c                | 198 ++++++++--------
>  emulator/hciemu.c               |  21 +-
>  emulator/hciemu.h               |  12 +-
>  emulator/le.c                   | 116 ++++-----
>  emulator/serial.c               |   6 +-
>  emulator/smp.c                  |   8 +-
>  lib/hci.c                       |  52 ++--
>  lib/hci.h                       |  44 ++--
>  lib/hci_lib.h                   |   8 +-
>  lib/l2cap.h                     |   2 +-
>  lib/mgmt.h                      |   2 +-
>  lib/rfcomm.h                    |   2 +-
>  mesh/net-keys.c                 |  38 +--
>  mesh/net-keys.h                 |   8 +-
>  mesh/net.h                      |   4 +-
>  monitor/broadcom.c              |   8 +-
>  monitor/bt.h                    | 150 ++++++------
>  monitor/control.c               |  14 +-
>  monitor/l2cap.c                 |  10 +-
>  monitor/ll.c                    |  60 ++---
>  monitor/lmp.c                   |   2 +-
>  monitor/packet.c                | 407 ++++++++++++++++----------------
>  plugins/sixaxis.c               |  44 ++--
>  profiles/audio/a2dp.c           |   2 +-
>  profiles/audio/avctp.c          |  10 +-
>  profiles/audio/avctp.h          |   2 +-
>  profiles/health/mcap.c          |  22 +-
>  profiles/health/mcap.h          |   2 +-
>  profiles/sap/server.c           |   2 +-
>  src/adapter.c                   | 117 ++++-----
>  src/adapter.h                   |   4 +-
>  src/device.c                    |   6 +-
>  src/sdpd-server.c               |  10 +-
>  src/sdpd.h                      |   2 +-
>  src/shared/ad.c                 |   8 +-
>  src/shared/ad.h                 |   2 +-
>  src/shared/hfp.c                |   4 +-
>  src/shared/hfp.h                |   2 +-
>  tools/3dsp.c                    |  62 ++---
>  tools/bdaddr.rst                |   2 +-
>  tools/btiotest.c                |  22 +-
>  tools/btpclientctl.c            |   2 +-
>  tools/hci-tester.c              |  16 +-
>  tools/hciconfig.c               |  26 +-
>  tools/hciconfig.rst             |  24 +-
>  tools/hcitool.c                 | 110 ++++-----
>  tools/hcitool.rst               |  30 +--
>  tools/l2cap-tester.c            |  36 +--
>  tools/l2test.c                  |  22 +-
>  tools/mesh-cfgclient.c          |   4 +-
>  tools/mesh-gatt/mesh-net.h      |   4 +-
>  tools/mesh-gatt/net.c           |  60 ++---
>  tools/mesh/mesh-db.c            |  28 +--
>  tools/mesh/mesh-db.h            |   4 +-
>  tools/mesh/remote.c             |  53 ++---
>  tools/mesh/remote.h             |   5 +-
>  tools/meshctl.c                 |   6 +-
>  tools/mgmt-tester.c             | 138 +++++------
>  tools/oobtest.c                 |  12 +-
>  tools/parser/avdtp.c            |   4 +-
>  tools/parser/csr.c              |  17 +-
>  tools/parser/ericsson.c         |   2 +-
>  tools/parser/hci.c              |  49 ++--
>  tools/parser/lmp.c              | 112 ++++-----
>  tools/parser/parser.h           |   2 +-
>  tools/parser/smp.c              |  12 +-
>  tools/rctest.c                  |  22 +-
>  tools/rctest.rst                |   4 +-
>  tools/rfcomm-tester.c           |  14 +-
>  tools/rfcomm.c                  |  16 +-
>  tools/rfcomm.rst                |   2 +-
>  tools/sco-tester.c              |  10 +-
>  tools/smp-tester.c              |  16 +-
>  unit/test-mesh-crypto.c         |   4 +-
>  90 files changed, 1293 insertions(+), 1276 deletions(-)
>
> --
> 2.33.0.rc1.237.g0d66db33f3-goog
>


-- 
Luiz Augusto von Dentz
