Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 19:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiBPTNB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:13:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiBPTNA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 14:13:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08024E8685
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 11:12:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b13so5710634edn.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 11:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28gnj+XMtLZLxONL4SFPBLkXj4fxaMqzeVTUkVSlqac=;
        b=eEmphGODii3w1fd44zy9IvonLOUquFrOlfn3JcgEympM3Bi6n8Xsu+Hfp3M4wzOPwc
         Q8CZgRF0mnH7YAO5yUQNKPk5PH6qjulTF0sMt0IWsPS+ttTa8liVxPFij8elmTZkXX/K
         eoNkoXH5YBCFQHCU99KBB8alC1g8CWlQdLEVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28gnj+XMtLZLxONL4SFPBLkXj4fxaMqzeVTUkVSlqac=;
        b=LDrTehTyUnpaGPOxbSF/nKjNDQ2ZV5KeBf4UAUpmLtoa5tghLYHMLKwm3T1m5tM40m
         3j9EYV7NAbqc+VIR++ixpzxjNUD+8dRS0JumOmYlWevHe85q+HGOd89+lhVJF5XGqeeE
         PRAkPU7hGNtZLRCuXls+I9exLvnCZUJxkxEiUV9owYcdyl+RqPRPzi1pB4BVJZAWDuYx
         gJvQvjj8Qp+CImPAckO0ZsMC8aSRCGCYCqYOoIn+2jx0F2q5wQyqqvSgYrmAi/BCjBZ7
         zZ87voNFNovBhjXtaobP4RgoysOT05s4bmbxS2Vpo3MlUxnKqPUQXu/ile1X0yNhk1CV
         M1pw==
X-Gm-Message-State: AOAM531qlb+J73tAWpuMmvwEQGOfTlhLqUBpctpf3OgG0cHJXGhbBtkG
        PF30YtE1gXQRU+naXgkS0rjH7tS4WwQrtw==
X-Google-Smtp-Source: ABdhPJwMhAdEEuO+38XNMIsQfdRad25KH0nqbmnnAIOYP/IAEgbIAkzIJamadBwPQPtVeJ0cXm1Wxg==
X-Received: by 2002:a05:6402:2065:b0:407:eb07:740 with SMTP id bd5-20020a056402206500b00407eb070740mr4504328edb.406.1645038765371;
        Wed, 16 Feb 2022 11:12:45 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id p18sm238311ejm.63.2022.02.16.11.12.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 11:12:45 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id v12so5114723wrv.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 11:12:44 -0800 (PST)
X-Received: by 2002:adf:dfc4:0:b0:1e4:ed7c:34ca with SMTP id
 q4-20020adfdfc4000000b001e4ed7c34camr3408536wrn.22.1645038764318; Wed, 16 Feb
 2022 11:12:44 -0800 (PST)
MIME-Version: 1.0
References: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
 <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com>
 <CABBYNZKs-JH_g2iUxStL5bRu-1z1TVzrS5pk2RyXUK8hiWYb7Q@mail.gmail.com>
 <CAO271mnbrRxtEvMhc7GMaWY=BEKUzzv_CbN1j5WKf4NruKfJng@mail.gmail.com>
 <CAO271mkRwR9nMe79d78wJSiyybHjiZdGtGApAWBJjWqPYT3KYA@mail.gmail.com> <CABBYNZ+yPyH0u0jQbva33pY6Cx0U7t-rkn4OkJBjbbC-Lvztjg@mail.gmail.com>
In-Reply-To: <CABBYNZ+yPyH0u0jQbva33pY6Cx0U7t-rkn4OkJBjbbC-Lvztjg@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 16 Feb 2022 11:12:33 -0800
X-Gmail-Original-Message-ID: <CAO271mmNb_DF-kg+jwj0-hqFomzYegkHN1mg6okk5VG-wfJw0Q@mail.gmail.com>
Message-ID: <CAO271mmNb_DF-kg+jwj0-hqFomzYegkHN1mg6okk5VG-wfJw0Q@mail.gmail.com>
Subject: Re: Question about Trusted property
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the confirmation, Luiz. We will send patches related to this RFC.

On Tue, Feb 15, 2022 at 5:57 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Tue, Feb 15, 2022 at 8:50 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > Friendly ping here. Could you respond to my RFC about adding "Bonded"
> > property? I am about to write the patch but I would like to hear
> > whether this makes sense from your perspective. Thanks.
>
> Yes please go ahead and introduce it, also remember to add support to
> the likes of bluetoothctl as well.
>
> > On Thu, Feb 10, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Thanks for the clarification. So my guess was right that it does not
> > > have to do with bondedness. In that case, do you think it makes sense
> > > to add a "Bonded" flag property to org.bluez.Device1? There are some
> > > use case flows that pair with a peer device but do not actually bond,
> > > and just with Paired property the UI can't know whether to show this
> > > device as "Bonded" or not.
> > >
> > > On Thu, Feb 10, 2022 at 1:30 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Sonny,
> > > >
> > > > On Thu, Feb 10, 2022 at 11:23 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > >
> > > > > Dear maintainers,
> > > > >
> > > > > Friendly ping on this question. Does adding "Bonded" property to
> > > > > org.bluez.Device1 make sense?
> > > > >
> > > > > On Fri, Feb 4, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > > > >
> > > > > > Hi Luiz/BlueZ maintainers,
> > > > > >
> > > > > > What is the purpose of the Trusted property on org.bluez.Device1
> > > > > > interface? Does it mean whether the device is bonded? My experiment
> > > > > > with BlueZ shows that sometimes a device with "Trusted" property set
> > > > > > is not bonded (does not have pairing key stored) and also vice versa,
> > > > > > so I am assuming that the Trusted property means something else. What
> > > > > > is an example use case of the Trusted property?
> > > > > >
> > > > > > Eventually, what I am trying to achieve is for BlueZ clients to find
> > > > > > out whether a device is Bonded or not. Using the Paired property is
> > > > > > not very accurate because it is set to true during connection although
> > > > > > the device is not bonded (pairing key does not persist after
> > > > > > disconnection). For this purpose, I am about to propose adding
> > > > > > "Bonded" property to org.bluez.Device1. Some use cases include when
> > > > > > there is a temporary pairing with a peer device we don't want UI to
> > > > > > show that the device is in the Bonded device list. What do you think
> > > > > > about exposing the Bonded state via D-Bus? I will do the
> > > > > > implementation if this idea makes sense.
> > > > > >
> > > > > > Thanks!
> > > >
> > > > Trusted primary use is to bypass agent authorization, so when set the
> > > > agent will not have to authorize profile connections, and yes you can
> > > > set a device to be Trusted even without having it paired since the
> > > > bonding procedure refers to authentication rather than authorization
> > > > which is what Trusted controls.
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
