Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C6C2D0F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FED205C9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 21:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GxrDSsQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgELVTy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVTy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 17:19:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D5DC061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 14:19:52 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v128so2737099oia.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uQM7OuZc3/XM3criQX7kxoOVIn4TSkp5YzxO9h9Oi5M=;
        b=GxrDSsQzSJ8V+6/4B4gS3WnKa0M9/Wj6ZqIyTXD7uPbcvbk7C8i9JCWIAWFbMY9nRh
         PTv73Fu/mOIQx1W4IaBlct8dYaXR7E+djrDjVuh85MZKNIBEU7ihgEr4stwT9GydgybG
         7gMhWz/ZtwnEmW85ddFNs9cphHTNHgmDfBzxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uQM7OuZc3/XM3criQX7kxoOVIn4TSkp5YzxO9h9Oi5M=;
        b=G8TRnE2MZfq/5O/+znBOwqk/gF6v0wOrof1E9ScT1CW+VHr3jn646Bf26Q3Hc8TVrJ
         aoiJeSFQB57j5v+rMZL6ZRlEkR/gDq5Gfu9tLdIbOisgA5LaB8t1qlGxq++6+PkqqgWG
         E/1eVcKuLW3imrfCB+ttLSQiIV1qrHTx/kQHy4c88eAZkEIqSeQFejbDYthKSPz0C3Pe
         5eC+9ROQk8KcBZ+w76CURor3unN4I69fUIURzKpxCPUhPqtulKsDm2xpceWCLY3TM6Q1
         Duoheyg8RmqchpzWF3kqD4tfzepYuZqQDYtfdcdsQ0ZE0NpDp3Y3ujLSI9Zulndzg3Yi
         GVmA==
X-Gm-Message-State: AGi0PuaXbsuvdD4g2Xs3ApflVZzTq1Hp0wJcNFUFEA046b527JhlfnAm
        PlbIoyFmt0HD8nDbBTZjf2XmixQhG2m6uWmjREfwNjvq
X-Google-Smtp-Source: APiQypJsTxp5io/zcitRgQZYl8pALxI37co7CFNPZgSajvSzBekDLzd3syHbH82AGvYgAGQafqlBWX1TmTBecu3aXoo=
X-Received: by 2002:aca:c68b:: with SMTP id w133mr22740291oif.27.1589318392333;
 Tue, 12 May 2020 14:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005528.2897-1-sonnysasaka@chromium.org>
 <56F32068-E8EC-45DD-B233-DBDAFBFA0187@holtmann.org> <CAOxioN=XkDSDEE=PcZJf8JoTiDBPMoYpK1zAyRoReEUx9B-Mmg@mail.gmail.com>
In-Reply-To: <CAOxioN=XkDSDEE=PcZJf8JoTiDBPMoYpK1zAyRoReEUx9B-Mmg@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 12 May 2020 14:19:40 -0700
Message-ID: <CAOxioNkFnfBcXzAJqMGnzAPPHtWJcALiYr1=e9O1Lw13jKBjNQ@mail.gmail.com>
Subject: Re: [PATCH] build: Add an option to explicitly disable installing hid2hci
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Could you please take another look at this patch? Thanks!

On Wed, May 6, 2020 at 10:05 AM Sonny Sasaka <sonnysasaka@chromium.org> wro=
te:
>
> Hi Marcel,
>
> Chrome OS doesn't support HID-HCI switchable controllers so we would
> like to remove this from being installed to reduce maintenance burden.
> Disabling udev unfortunately also uninstalls sixaxis plugin, which we
> still need. Do you have a suggestion how we can achieve this?
>
> On Wed, May 6, 2020 at 4:06 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> >
> > Hi Sonny,
> >
> > > ---
> > > configure.ac | 5 ++++-
> > > 1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/configure.ac b/configure.ac
> > > index 1433ace4a..ba9937a16 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -218,8 +218,11 @@ if (test "${enable_udev}" !=3D "no" && test -z "=
${path_udevdir}"); then
> > > fi
> > > AC_SUBST(UDEV_DIR, [${path_udevdir}])
> > >
> > > +AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--disable-hid2hci],
> > > +             [disable hid2hci tool]), [enable_hid2hci=3D${enableval}=
])
> > > AM_CONDITIONAL(HID2HCI, test "${enable_tools}" !=3D "no" &&
> > > -                                             test "${enable_udev}" !=
=3D "no")
> > > +                                     test "${enable_udev}" !=3D "no"=
 &&
> > > +                                     test "${enable_hid2hci}" !=3D "=
no")
> >
> > can you give me a bit of background why you need that. We did have that=
 and I removed it in favor of putting everything behind udev. Mainly since =
we really don=E2=80=99t need most of these things anymore. Can=E2=80=99t yo=
u just disable udev support and get the same result?
> >
> > Regards
> >
> > Marcel
> >
