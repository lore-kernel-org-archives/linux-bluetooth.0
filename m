Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC32239EC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 07:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhANHtv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbhANHtv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 02:49:51 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270CC061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:49:09 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id w26so5402147ljo.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 23:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/H33qH15cZSLT3IensLDd2f85ErYSiwxMG3rgZ/rX8=;
        b=EkyA2FzOG0XPF4oZ6JitaiV6oq6Lkx5gmH7zChf3DxvnJH8KYQ/1pEn5wPFaGeRbmu
         vLVwmzYxi7IY84lLKErbsb2CPXP0N+f0H5n9ayc5mNoTuXwPex3IPKtr0QduaLi8fu2H
         GVJ/rEWLgRPWozZ5G5IM6y/GvL3u/9vw7vGWBlmtnc5eJz8Zxotu6hccdfw3wNrtnOZa
         E6OvzpKDN9Nw2b1924KqKVjXOwnDIrn7ri+GyvEogN2VB450Y5daIFHBYy4/3ygP8nMW
         ijA34FDPoSt8r6rdrf1UebvS3yGaM+kBkuROlOIUBOejOfZaY4um4JDNwPywZ5IVPEqb
         IkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/H33qH15cZSLT3IensLDd2f85ErYSiwxMG3rgZ/rX8=;
        b=sgB9DihtOxYCejqdA2nJxaRjdJWOhXE4mNrgRya5hrq3yAhiAj7wCdfUrvRkjN7v1T
         GHxNvZkoBCWTXxtgGXC0sHh/+pCGcVmr70fMmV8CeUYtcce+/I0pRqIBWIhmgMt1Ihvh
         O8XueDEcmTNixT6xuLZKrTyC95sP4QxcjmnEPrH+3WMluC2o6ps3J/LBtwpJnK9C6ILK
         aadfQlq4TnWpFAKMywntSakHyDXKqcgOWw0y7lPYADn+a/yUDajXVH8Nio+jtBV/f/wd
         0qhSoe9MLi4nGFTbe1sJrW3rzXGog9tFwXxKc1Jmj5TUVl+w1d6MQKoO7dFwg+Kg4tCy
         VvhQ==
X-Gm-Message-State: AOAM531rmcwnFaE0e0WFLCHVkmqfYyiMEafTSYAvoZG2YiIiDmlrRpI3
        eie0izGAvfdgROOSDlXpf2cKCcoS/pGhWqjiWnGwYFJs61ZnLQ==
X-Google-Smtp-Source: ABdhPJyhZubU0XzDRmjHFHJiZmqoN+N1UlabMjkDNJrHO13p08YzJW8nUx+rZ3ZgeTpxmdvTKXz32JCin+wPdu1a4Cg=
X-Received: by 2002:a2e:b166:: with SMTP id a6mr2468095ljm.100.1610610547669;
 Wed, 13 Jan 2021 23:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20210113094905.2787919-1-apusaka@google.com> <CABBYNZK322MeXgUbDBoctamaQDYSJFELp=0s3ODeqssCkY_szw@mail.gmail.com>
In-Reply-To: <CABBYNZK322MeXgUbDBoctamaQDYSJFELp=0s3ODeqssCkY_szw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 14 Jan 2021 15:48:56 +0800
Message-ID: <CAJQfnxFkrvgegQ5cThXh2QtP8b=mxT9FHPfc_UOkZhT6+SLO+Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 0/5] Support advertising monitor add pattern with
 RSSI opcode
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I submitted v3 to incorporate your suggestions. Tell me what you think!

Thanks,
Archie

On Thu, 14 Jan 2021 at 01:58, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Wed, Jan 13, 2021 at 1:49 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Hi linux-bluetooth,
> >
> > This series of patches adds a new MGMT command for adding a monitor
> > with RSSI parameter. Changes are focused on passing parameters to
> > the kernel via btmgmt and bluetoothctl.
> >
> > PTAL and thanks for your feedback!
> > Archie
> >
> > Changes in v2:
> > Remove trailing period and fix order of mgmt parameter
> >
> > Archie Pusaka (5):
> >   lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
> >   src/adv_monitor: add monitor with rssi support for mgmt
> >   btmgmt: advmon add rssi support
> >   bluetoothctl: advmon rssi support for mgmt
> >   monitor: Decode add advmon with RSSI parameter
> >
> >  client/adv_monitor.c |  90 ++++++++++++------------
> >  client/adv_monitor.h |   1 +
> >  client/main.c        |  29 ++++----
> >  lib/mgmt.h           |  15 ++++
> >  monitor/packet.c     |  43 ++++++++++--
> >  src/adv_monitor.c    | 143 +++++++++++++++++++++++++++++---------
> >  tools/btmgmt.c       | 160 ++++++++++++++++++++++++++++++++++++-------
> >  7 files changed, 357 insertions(+), 124 deletions(-)
> >
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
>
> While this changes seems fine I was going to suggest we split
> RSSIThresholdsAndTimers to just RSSI and Timer so one don't have to
> set the entire struct if there are not interested in setting a custom
> RSSI and/or Timer, the advantage is the user can just omit one or the
> other and the daemon will take care of filling in the missing fields
> with defaults for the MGMT command. Also we probably just use plain
> int16, int16 and uint16, uint16 so we don't use () around it meaning
> they are not wrapped as a struct which makes it simpler to parse and
> construct.
>
> --
> Luiz Augusto von Dentz
