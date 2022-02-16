Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23F6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 01:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbiBPB50 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:57:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiBPB5V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 20:57:21 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8AA7F6D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 17:57:06 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id l125so1647828ybl.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 17:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZT4wF/MHqavWEsO40mxjqMITqCdp59SbwsnEV7hRF7g=;
        b=PerSpL7e4qINu5kCY49pWoLsJeCrR96nNucAiC9ZHmVcOoYg9JGlfDu46mLuFePTnh
         36sTiAa4sZZWv3Ev7OTYXNFf8Kr+wx5+e+BmV3lSNTPyKTYeNau2KiZbpakxqYibb+cW
         SaivgQLIwxIiDXxlQ775Rjg7W5sijsF5qQLKAC4hOXc9TaDZONzC4OpGZEmG/5pyOZqf
         B5mryRyhCoU/S+aBVq9FIYoB27u37RH3fUfscvuoiylO53kUv9hJ1Zx9rPB5ys95VSLJ
         x2viZ35LtseDIu1epgwhfbWcXLyZTrUXY8KEuK9Z1wpcPHbrd3oSVe4fKyfEtE4mWMEM
         E7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT4wF/MHqavWEsO40mxjqMITqCdp59SbwsnEV7hRF7g=;
        b=Uq0AaTAcVf1PlypmrByh+Kr18VK4mdDzyR6RFaesamZdsNpmmaaYSB/CNX2nwaCNOc
         q9R2T/XRhLAIjlvjc3YEVPYCzh2Cl1YGw8MBBNhOLiNUIU5JKsg2DNnv8I2VEIr7bkzR
         ljuyx+moLJnsVO5VIIxiM2lmR74o51WMG3gLhSuy0J1Od6gvUNvDtZQ5e3AgrxyCVYw8
         XuXFuWaglsi7ZLUnAr9xkCmA389731S+z8SWR0GBM92SSpTWQxbIGozfNXxLeOCAoPhd
         ivuS+y1eWvS3s7aZP+k3fTiG528qGjAZtbxszVEHD/2NgTL/kzgzEyRIJ+LEwOkmj8IF
         i67w==
X-Gm-Message-State: AOAM531ymP7bJTDwaCMON8F9ezBn+EN+45Bl/8yr6HlfvSg1OUEurhI/
        I4qnpMEHlOUcuRnsSHpESImSpk2NQ1OUF97TnSo=
X-Google-Smtp-Source: ABdhPJxENvgHgTR46PepwnRA1Df6r+EHe704LD1//d3bKHM11rXf4Muilyxq34HMbcOKDq8ioxenOJ4bjIMSD/kN+zs=
X-Received: by 2002:a81:ed06:0:b0:2d1:5f32:7e94 with SMTP id
 k6-20020a81ed06000000b002d15f327e94mr508170ywm.317.1644976625420; Tue, 15 Feb
 2022 17:57:05 -0800 (PST)
MIME-Version: 1.0
References: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
 <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com>
 <CABBYNZKs-JH_g2iUxStL5bRu-1z1TVzrS5pk2RyXUK8hiWYb7Q@mail.gmail.com>
 <CAO271mnbrRxtEvMhc7GMaWY=BEKUzzv_CbN1j5WKf4NruKfJng@mail.gmail.com> <CAO271mkRwR9nMe79d78wJSiyybHjiZdGtGApAWBJjWqPYT3KYA@mail.gmail.com>
In-Reply-To: <CAO271mkRwR9nMe79d78wJSiyybHjiZdGtGApAWBJjWqPYT3KYA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Feb 2022 17:56:54 -0800
Message-ID: <CABBYNZ+yPyH0u0jQbva33pY6Cx0U7t-rkn4OkJBjbbC-Lvztjg@mail.gmail.com>
Subject: Re: Question about Trusted property
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Feb 15, 2022 at 8:50 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> Friendly ping here. Could you respond to my RFC about adding "Bonded"
> property? I am about to write the patch but I would like to hear
> whether this makes sense from your perspective. Thanks.

Yes please go ahead and introduce it, also remember to add support to
the likes of bluetoothctl as well.

> On Thu, Feb 10, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > Thanks for the clarification. So my guess was right that it does not
> > have to do with bondedness. In that case, do you think it makes sense
> > to add a "Bonded" flag property to org.bluez.Device1? There are some
> > use case flows that pair with a peer device but do not actually bond,
> > and just with Paired property the UI can't know whether to show this
> > device as "Bonded" or not.
> >
> > On Thu, Feb 10, 2022 at 1:30 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Sonny,
> > >
> > > On Thu, Feb 10, 2022 at 11:23 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > Dear maintainers,
> > > >
> > > > Friendly ping on this question. Does adding "Bonded" property to
> > > > org.bluez.Device1 make sense?
> > > >
> > > > On Fri, Feb 4, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > >
> > > > > Hi Luiz/BlueZ maintainers,
> > > > >
> > > > > What is the purpose of the Trusted property on org.bluez.Device1
> > > > > interface? Does it mean whether the device is bonded? My experiment
> > > > > with BlueZ shows that sometimes a device with "Trusted" property set
> > > > > is not bonded (does not have pairing key stored) and also vice versa,
> > > > > so I am assuming that the Trusted property means something else. What
> > > > > is an example use case of the Trusted property?
> > > > >
> > > > > Eventually, what I am trying to achieve is for BlueZ clients to find
> > > > > out whether a device is Bonded or not. Using the Paired property is
> > > > > not very accurate because it is set to true during connection although
> > > > > the device is not bonded (pairing key does not persist after
> > > > > disconnection). For this purpose, I am about to propose adding
> > > > > "Bonded" property to org.bluez.Device1. Some use cases include when
> > > > > there is a temporary pairing with a peer device we don't want UI to
> > > > > show that the device is in the Bonded device list. What do you think
> > > > > about exposing the Bonded state via D-Bus? I will do the
> > > > > implementation if this idea makes sense.
> > > > >
> > > > > Thanks!
> > >
> > > Trusted primary use is to bypass agent authorization, so when set the
> > > agent will not have to authorize profile connections, and yes you can
> > > set a device to be Trusted even without having it paired since the
> > > bonding procedure refers to authentication rather than authorization
> > > which is what Trusted controls.
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
