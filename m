Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F7C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32D220739
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 16:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeqI6KJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGPQXF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGPQXE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 12:23:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F51EC061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 09:23:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e90so4677735ote.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IZc2F918h2+FHFet26cGpwU2BaEtZt3mo3ssI9Dft3U=;
        b=YeqI6KJEcghpQRPuHbtZBrisGOPwUqHOE9ZD0Hzks+S1psI5yUN2pN0GYHAeGmRoRS
         fHl3UBQqoyoHtoJLzB+GEOyAev5E9FXY/zRdrmcHI0f9vihQPF/MNYdIoEEODLC/u9vu
         QV/KSIQevwTRFXam+M9pTFstFt5ZU+GPbLmg7rqmXEDcL4KH2h2tcM0P9xl5JTU6HepM
         dV/YWVoUaG6ziuVrju/Fzjv6lGlQXztu2p2h/4SIOuCVmaq1ibKW7ETZi95SnmyxrGaa
         FeQUDyozeC8cE0fLdq7p9B+oiV943vtBbCQLerQHacqBhJ6Joqu00ewPg4rsYGTSqFgw
         WlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IZc2F918h2+FHFet26cGpwU2BaEtZt3mo3ssI9Dft3U=;
        b=HD/Yle2K00RMubv4lZYs8FZgMIfOWozEkZ/9+MP1T5hQ6mHS0dBPQX478o3SFMEFa5
         T1ToH7UsKgJuKuO01JUPBUvnZDNdPBQmPllFBFHnaQlu5eh+4xfx4VBZCtMgDB6MSHA3
         zIcFX6OzsX4L91a0FQkj4iqZbVJvUSTfeZoLOO9Cdv2Mx96amx4ia8EkPAw/XBcxLIze
         iStE4yLZPsjUgQhSFzYhLFtTuLoOLsVo6MgWsGaT9W9lyPRE16H1OYaUdsA38XeKN4yL
         6c4swvwmJc4o7rkpofVnqKwuTjBgK7Cvm0PasL8R38CswmDux3YztCoW9BxDwwDicFVc
         MDxw==
X-Gm-Message-State: AOAM533vo1e4teSseJB8DBkLkgkOjgv7IRjoG4PzXpfSj0EWveq6P6hw
        vTk1/yXhwATbGCNxtycVLz5rgrXxm9k0qxie/ai0jyRjVy4=
X-Google-Smtp-Source: ABdhPJwUuCmjoh1rO2VOnD+R3nJopK6weO4QH8X5fYth49o0hwgH0HO3CLcpFxkkWhZCB6IoUy525ECr2CxYKuJY6uI=
X-Received: by 2002:a9d:6c09:: with SMTP id f9mr5056421otq.362.1594916583801;
 Thu, 16 Jul 2020 09:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142541.28412-1-amitx.k.singh@intel.com>
 <20200605142541.28412-4-amitx.k.singh@intel.com> <CABBYNZ+iO_0djYfBmTyURC3NU_jpUHRHBr21zF-gNXNJLKySGg@mail.gmail.com>
 <DM6PR11MB3369DA18BE2A012A64A8637BB67F0@DM6PR11MB3369.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3369DA18BE2A012A64A8637BB67F0@DM6PR11MB3369.namprd11.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 Jul 2020 09:22:52 -0700
Message-ID: <CABBYNZL7h5vVs_31FuM5GWRCDPyk3gJm30aLCT4xropac4kDqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bluez:load Generic access service
To:     "Singh, AmitX K" <amitx.k.singh@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Panda, Bharat B" <bharat.b.panda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

On Thu, Jul 16, 2020 at 1:40 AM Singh, AmitX K <amitx.k.singh@intel.com> wr=
ote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Friday, June 5, 2020 10:34 PM
> > To: Singh, AmitX K <amitx.k.singh@intel.com>
> > Cc: linux-bluetooth@vger.kernel.org
> > Subject: Re: [PATCH 1/2] bluez:load Generic access service
> >
> > Hi Amit,
> >
> > On Fri, Jun 5, 2020 at 7:31 AM Amitsi5x <amitx.k.singh@intel.com> wrote=
:
> > >
> > > From: =E2=80=9CAmitSingh=E2=80=9D <amitx.k.singh@intel.com>
> > >
> > > It allow to load generic access service to database
> > >
> > > Signed-off-by: =E2=80=9CAmitSingh=E2=80=9D <amitx.k.singh@intel.com>
> > > ---
> > >  src/gatt-client.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/src/gatt-client.c b/src/gatt-client.c index
> > > 20c3fbec2..2ae258da0 100644
> > > --- a/src/gatt-client.c
> > > +++ b/src/gatt-client.c
> > > @@ -2009,9 +2009,6 @@ static void export_service(struct
> > gatt_db_attribute *attr, void *user_data)
> > >         struct btd_gatt_client *client =3D user_data;
> > >         struct service *service;
> > >
> > > -       if (gatt_db_service_get_claimed(attr))
> > > -               return;
> > > -
> >
> > This is actually done on purpose in order to avoid extra traffic since =
the
> > daemon already exposes this information in other interfaces.
> >
>
> GAP service is not getting stored is hash database .To verify the PTS tes=
t  case GATT/CL/GAD/BV-02-C which is GAP service discovery with '1800' UUID=
, verdicts as "INCONCLUSIVE" as it does not find the GAP UUID in place

BlueZ does perform the so-called discover all service procedure,
perhaps you need to select the procedure correctly in order to pass
this test.

> > >         service =3D service_create(attr, client);
> > >         if (!service)
> > >                 return;
> > > --
> > > 2.17.1
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
