Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A62C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B312080D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZ9Jh1Rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgEFRF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729414AbgEFRF3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 13:05:29 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01445C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 10:05:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so1956913otf.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 10:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DLwyIPK6buxu5yaIFcTNmFbpLpYN/APPLRjWM2lxlVM=;
        b=aZ9Jh1RctJxSGenTZRJj3dPc9leETx5BNc1JrqfuSq9KHUGLyNep9XoONLHyfTpMIU
         43alsQH0SE9XiJwX28mte/IeW0WMpwAdaRjVoDonRPftkAwDw9T7yskuJhw3zEfNohZq
         fJBsNAGLHVHKEP7rT9WohCE1El73Wn13nAgBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DLwyIPK6buxu5yaIFcTNmFbpLpYN/APPLRjWM2lxlVM=;
        b=DmcEDaQhxDitZOjwadX0rcLY4tOgFxFHo1izeN7kH1G6skEzKVo4W8cs0JK92E4l+4
         /0PhMFgJB/4FxpUxRlWB0IMHDjsNzEw5wp5od+EOrd4b936WFTeJ0JQJv9ZN1gBnBHEe
         x4XiQnE2GmoFh9nRs4uyk0azXSYvnTPk+FYQ//dvRliUvN+fDbYqkSBDfpzXaorrmIoN
         jPk+VzUOEjeaDdTQZuGybKnbn3O2FEfXIlJZgUK+zGyf1w38feX7et1fKvtXeaT2cmEn
         0zRW/O3X24wp/gxyRc7n5MNUHRyRJGOnYVx+TbW5kz/BqUSjTuNo/Zz3+zlGvsP1Gytz
         0ZZQ==
X-Gm-Message-State: AGi0PuZuLNAsg3s8TVxAbXIt2yglEUTKOWS2629URdp4shH/931ktWfp
        kopHNxMnl4PxVnsT8MfxMFUp/4thyyVVCWN5ZRoiSTuh
X-Google-Smtp-Source: APiQypIZbzmj8OoY8uxDntgdfSUMFjRku3HU325K0Y9bxoBC8wG0em4HHZaWmDDFbt8fNEZ92+oeLTY+80WWwAR9Ink=
X-Received: by 2002:a05:6830:1d9c:: with SMTP id y28mr7849338oti.280.1588784728367;
 Wed, 06 May 2020 10:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005528.2897-1-sonnysasaka@chromium.org> <56F32068-E8EC-45DD-B233-DBDAFBFA0187@holtmann.org>
In-Reply-To: <56F32068-E8EC-45DD-B233-DBDAFBFA0187@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 6 May 2020 10:05:16 -0700
Message-ID: <CAOxioN=XkDSDEE=PcZJf8JoTiDBPMoYpK1zAyRoReEUx9B-Mmg@mail.gmail.com>
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

Chrome OS doesn't support HID-HCI switchable controllers so we would
like to remove this from being installed to reduce maintenance burden.
Disabling udev unfortunately also uninstalls sixaxis plugin, which we
still need. Do you have a suggestion how we can achieve this?

On Wed, May 6, 2020 at 4:06 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > ---
> > configure.ac | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 1433ace4a..ba9937a16 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -218,8 +218,11 @@ if (test "${enable_udev}" !=3D "no" && test -z "${=
path_udevdir}"); then
> > fi
> > AC_SUBST(UDEV_DIR, [${path_udevdir}])
> >
> > +AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--disable-hid2hci],
> > +             [disable hid2hci tool]), [enable_hid2hci=3D${enableval}])
> > AM_CONDITIONAL(HID2HCI, test "${enable_tools}" !=3D "no" &&
> > -                                             test "${enable_udev}" !=
=3D "no")
> > +                                     test "${enable_udev}" !=3D "no" &=
&
> > +                                     test "${enable_hid2hci}" !=3D "no=
")
>
> can you give me a bit of background why you need that. We did have that a=
nd I removed it in favor of putting everything behind udev. Mainly since we=
 really don=E2=80=99t need most of these things anymore. Can=E2=80=99t you =
just disable udev support and get the same result?
>
> Regards
>
> Marcel
>
