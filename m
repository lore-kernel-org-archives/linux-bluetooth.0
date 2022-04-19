Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46860C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 17:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbiDSRzU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356079AbiDSRzK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 13:55:10 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DD313FB4
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 10:52:27 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so18315257fac.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FzvaJjV9oxOm01NACjZW3vAFQ7w2TlUFgyyDa992Mfo=;
        b=g1Hw4tJUeaK2xMIBi/tO7uUMjN6UqJr1cO2Jr+0GoVN9hvZiYYsrtkzPSKiv1JXE5y
         ewhtLYW/yAnVrgYeNY0cEJ4sOwj6hdrbKlVOXmZTQBmxWoA8ASelVNyGeG5BCgSrIi9N
         YzvCTt1aRZJ5OFfkq+RFOtxXbGnO68X9Nclx0zFra9Pz/t9Ni7quu7OmxHkgA8joIVlL
         yZR30XZmNnlG5W+edf/d2shSevI2OzqUnWFHmQ3t76tiiG64KLXaKOOXft9+J/hGoJRh
         vcbfbRnVzZY8XGyz8UprOW9T1qMeZA67nXxgo/kiK7yi6sODidHUY6UKIJ9+nqjjO/rm
         CkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FzvaJjV9oxOm01NACjZW3vAFQ7w2TlUFgyyDa992Mfo=;
        b=L3JZWoOGKgMaDik7scoQoEn4Aic323fURpYjB2nlE+5i6EtWXGmQtObMpx63t/qLXV
         QM1AlX19SLhd1Z0hw7JBIzmj7ihaLQjpM2qPwEEy92JRy60it2hoD6W25rrDBF5vwX0a
         geza8KyWJSnceueVweTF0cwMKTgWYrzL3NsgmTsF6ZiO2Pgz2/KU4vz8qg0X1RHdeIJr
         LEm0MRv6+rqXB6GXHhUGWy4zScBP6wE2zysiC+23iX9utGOxHKk93mo08+P0/Z7IzeAb
         3fFEDjnY0qM6nyDD799xNSMGC2HSEVlv7oTCcv3jyaXPBhUupnZKWYz//57ysZOS5IrV
         279w==
X-Gm-Message-State: AOAM5335OwcxdZlfdy8PLsUbN9U0as+ya7oWqgkhpR9vcy2qMPlFdbja
        hd8YIpW/WLYVQB1Z3ZY0fPQKZ2eiQHBlmB4X6s9AiFzF
X-Google-Smtp-Source: ABdhPJxNfk5QuDfcorL7RyG5CZpMxBliyQrIlTZ9+VyPMoeqTjD8R0S+o6dnzTy0G6/GeWZ3kvfS1A7hBTbYfruuWo8=
X-Received: by 2002:a05:6870:4598:b0:e5:bffa:56fb with SMTP id
 y24-20020a056870459800b000e5bffa56fbmr6393456oao.85.1650390747266; Tue, 19
 Apr 2022 10:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220413222425.187199-1-luiz.dentz@gmail.com> <61417C2F-0009-4123-8F1C-DACC4A46073D@holtmann.org>
In-Reply-To: <61417C2F-0009-4123-8F1C-DACC4A46073D@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Apr 2022 10:52:15 -0700
Message-ID: <CABBYNZKt+rT5nR2yJeGOTa8wOK84qCVE-6C8X3rQPdqWxBfYmQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] policy: Change AutoEnable default to true
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 19, 2022 at 1:48 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This changes the default of AutoEnable to true so controllers are power
> > up by default.
> >
> > Fixes: https://github.com/bluez/bluez/issues/328
> > ---
> > plugins/policy.c | 6 +++++-
> > src/main.conf    | 4 ++--
> > 2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/plugins/policy.c b/plugins/policy.c
> > index 48f5db7d3..0bbdbfc88 100644
> > --- a/plugins/policy.c
> > +++ b/plugins/policy.c
> > @@ -892,7 +892,11 @@ static int policy_init(void)
> >       }
> >
> >       auto_enable =3D g_key_file_get_boolean(conf, "Policy", "AutoEnabl=
e",
> > -                                                                     N=
ULL);
> > +                                                             &gerr);
> > +     if (gerr) {
> > +             g_clear_error(&gerr);
> > +             auto_enable =3D true;
> > +     }
> >
> >       resume_delay =3D g_key_file_get_integer(
> >                       conf, "Policy", "ResumeDelay", &gerr);
> > diff --git a/src/main.conf b/src/main.conf
> > index 401796235..91b98b8c4 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -276,8 +276,8 @@
> >
> > # AutoEnable defines option to enable all controllers when they are fou=
nd.
> > # This includes adapters present on start as well as adapters that are =
plugged
> > -# in later on. Defaults to 'false'.
> > -#AutoEnable=3Dfalse
> > +# in later on. Defaults to 'true'.
> > +#AutoEnable=3Dtrue
>
> so this is problematic since all wireless technology daemon where design =
to not automatically activate their hardware. It needed a system above like=
 ConnMan, NetworkManager or even the UI to start the operation.
>
> It is especially tricky since bluetoothd doesn=E2=80=99t remember the las=
t state. So if you power off, then restart, it is on again the next time ar=
ound. Not something you might have wanted. Using false here is the right ch=
oice as a default.
>
> If you install systemd-rfkill and want to auto-power once soft-rfkill is =
released and systemd-rfkill remembers the state persistently, then you need=
 to install your main.conf with AutoEnable=3Dtrue. That is a distro choice.

The argument was that nowadays most systems ship with systemd-rfkill
so having AutoEnable=3Dtrue is much more common than the old default,
perhaps we could detect if the system has systemd-rfkill than we
default to AutoEnable=3Dtrue automatically, does this sound better to
you?

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
