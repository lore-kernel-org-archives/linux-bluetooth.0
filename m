Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272E6C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BBF610C8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhIBEvO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIBEvO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:51:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21307C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:50:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so751396wrb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tArx6bO701RXfbXIM5pVuJAAPa+t6UejMWqjW3zEo9U=;
        b=dkJG5ipRtsY0QTVJFy8S3GMKPw2gPXpGRNnBkreksLeUZX54ef7D41k+KiHbTsraQb
         YR0P2HdXUGEST6gkTJcTpXSelq2RIycFjG4d+OvMCD1D21a/G+UA4KfGUgS66jAUQNpJ
         0RjXEtll8mvy6XYEMRRwNUA0mX2T+iPS13oTXAbN8wwUzYkTiKR8oQBx6q1skg4i9bib
         OJJugySVM3MavueZIlRgPA3Ipc/qw1SgNGDCMEdk/npXVW5Q1Y6XMQPMmWc+CnSgFX3D
         82cTlW93hfwdKaUuBeliWdaGGkfbg2Jst3/mFnjyAd6kVIKcQk/hOq4EyppfagR9MGCy
         x+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tArx6bO701RXfbXIM5pVuJAAPa+t6UejMWqjW3zEo9U=;
        b=V0uE8yIFby6CU1+Gfrlj7Rr5YIBD4zV5uTiwIYl8V48qTxfWnhUxGC37JBwZzExI5T
         3x5A8s6FKCJTJkOm4CVHMoGNFIorfawe/y7sJkE9t8NNEWhNNkTMdd7P3SuXhhFS8eIT
         d5s6URZ57mOmZl7+bG6fQBSf+ZqnUtztz5hINLCM+TYyL9st7GvXgENO+R5nv2YAS/Q9
         plHmomKxb+MgC4Qv+afTJSPS7YZnCs5Zgg4/ZOkBDw869BVUBESArhXBXSjepCA04Ona
         C1cdbxwgW5XYsgFHt96C7ti7llpdh3q0IcEw75qg5y0zEORBsFl8UQ88PGTkPSKwLZwb
         46Ww==
X-Gm-Message-State: AOAM530mFIFiUqUJL+Nfzmy/xoEoBJieShSBlHITFvUsnKboGho7KTra
        qph/SCbQ1Qr51pu8Hl9DafKH5h66Jn4uxXTNg/Sj0fyLIyI=
X-Google-Smtp-Source: ABdhPJzJDz3q3vmiq10PfNEwLJiyY24/A31Ex3EcRg6zsKMI+Vfcs46v8W0GGUL9aUTf1+VrAWokSbmuzQmD+VMo4P0=
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr1320003wrx.262.1630558213896;
 Wed, 01 Sep 2021 21:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 2 Sep 2021 12:50:03 +0800
Message-ID: <CAJQfnxGqVX7WSJQse9VNJUEwKXk2CKhuz6Nu-cBk1-3F-rUgsQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 00/13] Inclusive language changes
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There are plenty of linter errors, but mostly it's only because I
replace a few characters on an already faulty line.
Fixing only the problematic lines would be bad because the structure
would not be consistent with the neighboring lines.
Should I also fix those linter errors on those lines and the
neighboring lines?

On Thu, 2 Sept 2021 at 12:07, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
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
> As you suggested, I dropped the Android changes and merge patches
> which belong to the same directory into one patch. However I didn't
> get a clear opinion on "storing LTK" patch which will break stored
> data, so I separate that into its own patch.
>
> I also don't know the scope of libbluetooth, so please advise me on
> which terms shouldn't be changed yet, if any.
>
> Thanks,
> Archie
>
> Changes in v2:
> * Merging several patches from the same directory into one
>
> Archie Pusaka (13):
>   lib: Inclusive language changes
>   btio: Inclusive language changes
>   monitor: Inclusive language changes
>   emulator: Inclusive language changes
>   tools: Inclusive language changes
>   plugins/sixaxis: Inclusive language changes
>   profiles: Inclusive language changes
>   src: Inclusive language changes
>   client: Inclusive language changes
>   mesh: Inclusive language changes
>   unit/mesh: Inclusive language changes
>   doc: Inclusive language update
>   adapter: Inclusive language for storing LTK
>
>  android/a2dp.c             |   2 +-
>  android/bluetooth.c        |   4 +-
>  android/handsfree-client.c |   2 +-
>  android/tester-main.c      |   2 +-
>  btio/btio.c                |  62 +++---
>  btio/btio.h                |   2 +-
>  client/main.c              |   6 +-
>  doc/mesh-api.txt           |   2 +-
>  doc/mgmt-api.txt           |   6 +-
>  doc/settings-storage.txt   |   4 +-
>  emulator/btdev.c           | 198 +++++++++---------
>  emulator/hciemu.c          |  21 +-
>  emulator/hciemu.h          |  12 +-
>  emulator/le.c              | 116 +++++------
>  emulator/serial.c          |   6 +-
>  emulator/smp.c             |   8 +-
>  lib/hci.c                  |  52 ++---
>  lib/hci.h                  |  44 ++--
>  lib/hci_lib.h              |   8 +-
>  lib/l2cap.h                |   2 +-
>  lib/mgmt.h                 |   2 +-
>  lib/rfcomm.h               |   2 +-
>  mesh/net-keys.c            |  38 ++--
>  mesh/net-keys.h            |   8 +-
>  mesh/net.h                 |   4 +-
>  monitor/broadcom.c         |   8 +-
>  monitor/bt.h               | 150 +++++++-------
>  monitor/control.c          |  14 +-
>  monitor/l2cap.c            |  10 +-
>  monitor/ll.c               |  60 +++---
>  monitor/lmp.c              |   2 +-
>  monitor/packet.c           | 411 +++++++++++++++++++------------------
>  plugins/sixaxis.c          |  44 ++--
>  profiles/audio/a2dp.c      |   2 +-
>  profiles/audio/avctp.c     |  10 +-
>  profiles/audio/avctp.h     |   2 +-
>  profiles/health/mcap.c     |  22 +-
>  profiles/health/mcap.h     |   2 +-
>  profiles/sap/server.c      |   2 +-
>  src/adapter.c              | 117 ++++++-----
>  src/adapter.h              |   4 +-
>  src/device.c               |   6 +-
>  src/sdpd-server.c          |  10 +-
>  src/sdpd.h                 |   2 +-
>  src/shared/ad.c            |   8 +-
>  src/shared/ad.h            |   2 +-
>  src/shared/hfp.c           |   4 +-
>  src/shared/hfp.h           |   2 +-
>  tools/3dsp.c               |  62 +++---
>  tools/bdaddr.rst           |   2 +-
>  tools/btiotest.c           |  22 +-
>  tools/btpclientctl.c       |   2 +-
>  tools/hci-tester.c         |  16 +-
>  tools/hciconfig.c          |  26 +--
>  tools/hciconfig.rst        |  24 +--
>  tools/hcitool.c            | 110 +++++-----
>  tools/hcitool.rst          |  30 +--
>  tools/l2cap-tester.c       |  36 ++--
>  tools/l2test.c             |  22 +-
>  tools/mesh-cfgclient.c     |   4 +-
>  tools/mesh-gatt/mesh-net.h |   4 +-
>  tools/mesh-gatt/net.c      |  60 +++---
>  tools/mesh/mesh-db.c       |  28 ++-
>  tools/mesh/mesh-db.h       |   4 +-
>  tools/mesh/remote.c        |  53 +++--
>  tools/mesh/remote.h        |   5 +-
>  tools/meshctl.c            |   6 +-
>  tools/mgmt-tester.c        | 138 +++++++------
>  tools/oobtest.c            |  12 +-
>  tools/parser/avdtp.c       |   4 +-
>  tools/parser/csr.c         |  17 +-
>  tools/parser/ericsson.c    |   2 +-
>  tools/parser/hci.c         |  49 ++---
>  tools/parser/lmp.c         | 112 +++++-----
>  tools/parser/parser.h      |   2 +-
>  tools/parser/smp.c         |  12 +-
>  tools/rctest.c             |  22 +-
>  tools/rctest.rst           |   4 +-
>  tools/rfcomm-tester.c      |  14 +-
>  tools/rfcomm.c             |  16 +-
>  tools/rfcomm.rst           |   2 +-
>  tools/sco-tester.c         |  10 +-
>  tools/smp-tester.c         |  16 +-
>  unit/test-mesh-crypto.c    |   4 +-
>  84 files changed, 1237 insertions(+), 1222 deletions(-)
>
> --
> 2.33.0.259.gc128427fd7-goog
>
