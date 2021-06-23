Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5897DC49EA5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED4D60698
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 22:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWWiD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWWiD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 18:38:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF81C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:35:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bm25so9576853qkb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAYl+/1usO+36xFxopY4DIvTrqgPU1U0/I4g5j0JsS4=;
        b=CCqIwiMsZswlTCyGNagFpf57FAvrW7Kv5j4CuxKggBXSg717sCmZ8DMThVbINzUhgh
         ouTSwDWUXWtaLmoAzTL8mDpLGfGXv+QAyaU6SOjhx4zzRUnNClB8tscpa/NrTd0+gebr
         nRvevO9bbkaa2f0vjyk6+AIv6ZJBU1ilJPo6Uc6ytUD+FlLVNBNNiEAFZJOg03R34Nzi
         CtR7R0kGLfRquHzwY11+MkqRYRYbOa6IVENJAlhRTTZGxEzUGO5Iz2GmSevqoJfculFi
         N4ACIJR6BgGystYJmOCVhmbbKrezS4EsBUFmyPk174gmadcp47083Q5mdZF7qAzjm6Kx
         Wq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAYl+/1usO+36xFxopY4DIvTrqgPU1U0/I4g5j0JsS4=;
        b=gVb46uk9osve1xNr49eWQnD3QcxT/Ia2uQG+v8rkuB0HeE1xSzcSmPvkqyp4YkeXIv
         2GCOR8Pm1HkW7Kgx8wWXx+UEuY2PMmBfaBo1T8FvN+gWXz/YnnoeCq9O5F6iiOF7PMiV
         B6mdO/jfvSDj/0cmci/Byfxv0ged8e+64jUBbanRuo3JppHUdVGVJ2wgQ+ffvaYowu2L
         gN30JJFXTUOGL24IAiQMK4Zwudxz7h9+nYVnePmQINKu5DlluFJvqCVdIYNoAL2Jusvy
         1D2tS6tKBmnyEI8ghVRCmxWebngKFk7CG82oNuKBto3CNDfTmdCkJ1KryLAz6xYIdHDp
         7KJg==
X-Gm-Message-State: AOAM530uoP00L/FGPTMJ2mqSXzCfg6xoKGPRdB2GaU+P/JhoqCC2+HyT
        W6evXmx/c4UjqXk6rUxcJdle9IU+wS7hKBObzrk=
X-Google-Smtp-Source: ABdhPJwOXnseXmmdZFk3orPw3y2QwDDudxaJM/euvTJ+iNZz99ZZQOlfsvsm35GwdT+JClUNgtGE9t4YwwSXVAofmqs=
X-Received: by 2002:a25:acdf:: with SMTP id x31mr539339ybd.222.1624487744301;
 Wed, 23 Jun 2021 15:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210503131210.90066-1-benjamin@sipsolutions.net>
 <fe5e3c7519a52aa59e33939c64e9aa4b7c5e30c3.camel@hadess.net> <e2e0ef088416fdc37d240c2b7b3e348d8179db86.camel@hadess.net>
In-Reply-To: <e2e0ef088416fdc37d240c2b7b3e348d8179db86.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jun 2021 15:35:33 -0700
Message-ID: <CABBYNZ+Sx0XZB=kp+GhEXZrOBr2g52N-JEp4Rbc3e_jTz6-cYA@mail.gmail.com>
Subject: Re: [PATCH] rfkill: Fix reading from rfkill socket
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Benjamin Berg <bberg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Jun 10, 2021 at 5:53 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2021-06-10 at 14:45 +0200, Bastien Nocera wrote:
> > On Mon, 2021-05-03 at 15:12 +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <bberg@redhat.com>
> > >
> > > The kernel will always send exactly one event, but the size of the
> > > passed struct will depend on the length of the submitted read() and
> > > the
> > > kernel version. i.e. the interface can be extended and we need to
> > > expect
> > > for a read to be longer than expected if we ask for it.
> > >
> > > Fix this by only requesting the needed length and explicitly check
> > > the
> > > length against the V1 version of the structure to make the code a bit
> > > more future proof in case the internal copy of the struct is updated
> > > to
> > > contain new fields.
> >
> > This fixes a bug in GNOME where to enable Bluetooth, we removed a soft
> > rfkill block on the Bluetooth interface.
> >
> > Without this, the bluetooth rfkill gets unblocked, but bluetoothd
> > doesn't see it as unblocked so never powers it on, causing the UI to
> > appear broken, as we expect Bluetooth devices to be either blocked
> > through rfkill, or powered on.
> >
> > The equivalent gnome-settings-daemon fix (which deals with rfkill) was
> > reviewed by Hans de Goede:
> > https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/234
> >
> > Benjamin, it might be worth resending this with a better commit message
> > explaining exactly what it fixes and referencing the gnome-bluetooth
> > bug:
> > https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/38
>
> >
> It's also been pushed to Fedora rawhide and Fedora 34:
> https://bodhi.fedoraproject.org/updates/FEDORA-2021-2cd83da751

I missed this one for some reason, it has been applied now.

-- 
Luiz Augusto von Dentz
