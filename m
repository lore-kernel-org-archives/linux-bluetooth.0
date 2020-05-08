Return-Path: <SRS0=6WQ0=6W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC2C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 15:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B55F21473
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 15:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DorzhROa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEHPTP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 11:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgEHPTO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 11:19:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771EC061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2020 08:19:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so2084373ljj.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2020 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPsS+kSUjL6o+XAMn2cIwqtZEMSXtPwukD2T8n+gRrs=;
        b=DorzhROapcFmlQwyTleW5pU7www6O/n1wQRMbuTC3+JU2JhTbQSGCqG26kDYY8If5i
         cxGB+s0hEbBbiR1sFZo8pT7c+nI3S3EpkHNl4s/Hoj7nMMJNxo7HvASu9U3LJ2DwxZVX
         QIfxQN1qjCEiuXK2EHb2JrBiUoXkuTas2NITpBzm527dZNuqB9g3VivctU6bdL9WYQrB
         1yI5FxgQHPNTmHcyfFTfhmiHjGiq/4pC4cEt0k8njS+mRhjgm3vDQoAYQGJIvz0QxJp+
         t1IWNzLR8avOlDzh9vySBn2h3OLokKiyisFkCBVPGRXI4xKlH40pu3r7Q/i8GIwF2fi/
         djDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPsS+kSUjL6o+XAMn2cIwqtZEMSXtPwukD2T8n+gRrs=;
        b=Ongt8ofq4hot71lUlToGFipyvDTkS4IfOXXOhRsIJ+BhSHNN3y+gdlVepdQa7iM3Gv
         ygC+co4flq2vko8pbAglr/Q+iqzpeMlCowrr9/nK9uJc9pUF81RBC91hS7eE6PUmjk9i
         gdRWaWF7jemEmG1WVk4uxtCjhjOQhi7yHwBQKQja11zxXqqRS70cskE4cxv6Cs0Q2FK/
         oYTxktaUMpi4qZAsO0PofTelipzdLi73E378S+/6ETi+QmY5KZEwVpuR6tpBRSMeeNor
         PoEmcDkAMdBELsGk5yyCP9uMr6zYtxHAAZx3Ur+5Zl9pt0Ii8CEdFwvO5ponq3huOMrm
         NbCQ==
X-Gm-Message-State: AOAM5310FO1psk2zgW9t5hHeoOcm4I6P1MftNFOyN1VHmX4UIH/rVtB2
        SqnIvThFQlOcKj4jmEx3uVeppyMtMPo0FTjaJP2/nQ==
X-Google-Smtp-Source: ABdhPJygcPcyqclqwJsxqdDMRO9rMKnc4wK0Wlz5zKlivyRACLL7NPF6KJV1vivHv3s6pA+z4sb40nkFvF8CfOyGhOA=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr2136469ljw.55.1588951152141;
 Fri, 08 May 2020 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588751831.git.marcel@holtmann.org> <1978B405-610A-4A7C-8E0A-1128B471A707@gmail.com>
In-Reply-To: <1978B405-610A-4A7C-8E0A-1128B471A707@gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 8 May 2020 11:19:00 -0400
Message-ID: <CALWDO_V3hf62O890ExkDZzgjBcW+oakQskzdD07dVDHztZhn5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Patches introducing experimental feature support
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel and Johan!

On Fri, May 8, 2020 at 4:59 AM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Marcel,
>
> On 6. May 2020, at 10.57, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Marcel Holtmann (7):
> >  Bluetooth: Add MGMT_EV_PHY_CONFIGURATION_CHANGED to supported list
> >  Bluetooth: Replace BT_DBG with bt_dev_dbg for management support
> >  Bluetooth: replace zero-length array with flexible-array member
> >  Bluetooth: Introduce HCI_MGMT_HDEV_OPTIONAL option
> >  Bluetooth: Replace BT_DBG with bt_dev_dbg for security manager
> >    support
> >  Bluetooth: Add support for experimental features configuration
> >  Bluetooth: Introduce debug feature when dynamic debug is disabled
> >
> > include/net/bluetooth/bluetooth.h |  11 +
> > include/net/bluetooth/hci.h       |   1 +
> > include/net/bluetooth/hci_core.h  |   1 +
> > include/net/bluetooth/mgmt.h      |  69 ++++--
> > net/bluetooth/Kconfig             |   7 +
> > net/bluetooth/hci_sock.c          |  12 +-
> > net/bluetooth/lib.c               |  33 +++
> > net/bluetooth/mgmt.c              | 364 +++++++++++++++++++++---------
> > net/bluetooth/smp.c               |   8 +-
> > 9 files changed, 365 insertions(+), 141 deletions(-)
>
> All patches in this set have been applied to bluetooth-next. Thanks.
>
> Johan
