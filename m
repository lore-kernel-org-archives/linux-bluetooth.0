Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E4EC0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 19:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjG2TLm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jul 2023 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjG2TLl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jul 2023 15:11:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5F10C0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jul 2023 12:11:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bc0da5684so442730066b.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jul 2023 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690657899; x=1691262699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojpnUMvxLE3SnhJliW2dIhSRczHfAozwoPwbsdkUtnM=;
        b=xLOg7YtYkBcKIpk+EGBSXVY3H29QcY+hm4x7tfwBFodUA78sWJZBO2qvV/tNglJs9h
         qcxA+/k65QA7+bM/n/4YOG/W5so2eVeo4uoXv6sDm88cvoA0eMxjJkPGp5SABTE1qM7z
         id7xv8RhlKv/i9pDLkNQzX4DGcfaLCLFtaT37bAnAN3fcdqlgBKbnLwPF8e1dtE8+BO9
         /1rF4ks0fybBpm85/I/ntlQMsT0mf16SMS70XubWcNCeoZOEy4yLuBkR3ARbnHP8dXec
         QfaJ3tBcxxdrEFtwYbXHRjjhaFDkxWH/Z2upNn+k4s0TjXaRo+uGmcxd132cgNntjH0N
         ycSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657899; x=1691262699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojpnUMvxLE3SnhJliW2dIhSRczHfAozwoPwbsdkUtnM=;
        b=O9rYWvXQ4KdITUMvXK2WSFWlARojt+c+1iRCB4ECIUHaBtTEMIN1wrRIFqVMEfh8lA
         GEOOydoZ7/eARfWQLQIA4ttSYgRsLuy0LFt92zO9ktENjT3b+Z3q16/EgTvuI26ba4YQ
         Y9iQPU7o8tW2n8ZqHyaauRkAuWVAeokiHGZU54zPNjfi7aUoo4UnhwmfF1mSOOghn+Ly
         SL2jH3L2VKaOuiHJjIb7iBGNnZAOj3pPty5Vbl5tDUEq06Ac8tEwdMaht/5bYsoldDkG
         XE7U7/B4Wmpz+DsYHtyK38r5ldzP6uZMprG6kKXuy5bjZfIG33CUD8QZjzRg3xb+CIHv
         3zuA==
X-Gm-Message-State: ABy/qLbbBna96SLQyv382anJVZp0fRUccBmhnZAan3tWEhBvtYWukVpn
        ft2CeBGXR/BEWEx6TQXjUo+sNgidIBRMB6k5HaNP5b8eNJbGMvmP
X-Google-Smtp-Source: APBJJlERXD/ul+kkKSMxObADH9wrN3gHp+fAHgnIT4/iF8hbwCobmBSYxyOu2zq5WzwLplvKG4cAspx/gam2ZA/HG4g=
X-Received: by 2002:a17:906:1089:b0:993:6382:6e34 with SMTP id
 u9-20020a170906108900b0099363826e34mr2597645eju.72.1690657898993; Sat, 29 Jul
 2023 12:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
 <20230729004552.1422547-6-lukasz.rymanowski@codecoup.pl> <907983cc-4175-1130-cb1c-ca42baa40dfa@molgen.mpg.de>
In-Reply-To: <907983cc-4175-1130-cb1c-ca42baa40dfa@molgen.mpg.de>
From:   =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Date:   Sat, 29 Jul 2023 21:11:03 +0200
Message-ID: <CAExxLLAEgGJFyAWV-sX06o9nxTbDoUy=KH6e_jxUOYuhXFbOOQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] monitor: Add parsing Service Data of UUID 128
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul


On Sat, 29 Jul 2023 at 06:42, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear =C5=81ukasz,
>
>
> Thank you for your patch.
>
> Am 29.07.23 um 02:45 schrieb =C5=81ukasz Rymanowski:
> > In the advertising report, instead of deciding EIR 0x21 into this:
>
> Do you mean deciphering?

Thanks for pointing it out. Just sent v2 for this patch.

>
> >
> >       Unknown EIR field 0x21: 3a048f2ba97ea6ae1b49c619e973a4a701480d130=
d
> >
> > We can do bit better
> >
> >          Service Data UUID 128: Vendor specific
> >            Data: 01480d130d
> > ---
> >   monitor/packet.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/monitor/packet.c b/monitor/packet.c
> > index 3031b028f..21e08ccef 100644
> > --- a/monitor/packet.c
> > +++ b/monitor/packet.c
> > @@ -3997,6 +3997,18 @@ static void print_eir(const uint8_t *eir, uint8_=
t eir_len, bool le)
> >                       print_service_data(data, data_len);
> >                       break;
> >
> > +             case BT_EIR_SERVICE_DATA128:
> > +                     if (data_len <=3D 16)
> > +                             break;
> > +
> > +                     print_field("Service Data UUID 128: %s ",
> > +                                             bt_uuid128_to_str(&data[0=
]));
> > +
> > +                     if (data_len > 16)
> > +                             print_hex_field("  Data", &data[16],
> > +                                                             data_len =
- 16);
> > +
> > +                     break;
> >               case BT_EIR_RANDOM_ADDRESS:
> >                       if (data_len < 6)
> >                               break;
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

Best
=C5=81ukasz
