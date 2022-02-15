Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 16:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiBOQuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:50:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiBOQuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 11:50:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2385A106C98
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 08:50:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u18so447678edt.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 08:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0zjgVIDtplPos2VPoxikHAoSHBsMmx80q+K1Ie+nTE=;
        b=oZnCFgJp+oPjIuynVGNWfdx/LwanTzp9svRdpwK9i8mJMRj3rwTQ24Gmmy9Q2J1MyB
         UuRXaWBl2riv5PALrJ/7U7Jf7VUChLlZ6Vgl79w1jhg9DmXpgjTHar1uDcahfoGAXSOE
         L75iR7henSS08xSmJNJEP8k4DNRAsAmjp+W2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0zjgVIDtplPos2VPoxikHAoSHBsMmx80q+K1Ie+nTE=;
        b=LbbMKEUPsgVDKYk2Nqv0f+6Nrmwy0qDn5Io340dpBs/SvSd/QkkHLDx/pai7eQyISp
         +cUp04Wxrr1EQailJRfa7cb8n/5vBkpLJ15kEKHconULRI7JCNgJcAvvU8LAG0lcCjJ4
         8DM9yr7Te+f58betzTmOq1hgIjsqICFlfIABMNCxVdoEndDOlV2ral3MQRg34prH5vp+
         n0XX6lK78Cn8mc1B06NwZO/uvNdIjNkfAQzIjjjxV7+JSOIFo4vqEv3977aJin+MQ3so
         AEmAsgxrnFzOArbxch8mUHnrVvKMvyJzvBIAEXxaLDhUEu31sUaavoR8PlMrhGkeO7PC
         Pq3w==
X-Gm-Message-State: AOAM532R5UMAZkabd3iK3Ei1YVSA8YAU8bXxXmmplQ0K5I2LgNghU60F
        PF4JAuKO3befD6KzvDnqWK09JF4cgue6vw==
X-Google-Smtp-Source: ABdhPJw0R5cTStfnVoHkln5Bwb9BRFmlVX+3tynZBFV2UNForrsJyYMYYWxo+9znkhbeLWQNxNLKrQ==
X-Received: by 2002:aa7:d553:: with SMTP id u19mr4762256edr.298.1644943808201;
        Tue, 15 Feb 2022 08:50:08 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r1sm10805479ejh.52.2022.02.15.08.50.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 08:50:07 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id i14so33100459wrc.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 08:50:07 -0800 (PST)
X-Received: by 2002:a05:6000:1683:: with SMTP id y3mr4024542wrd.222.1644943807164;
 Tue, 15 Feb 2022 08:50:07 -0800 (PST)
MIME-Version: 1.0
References: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
 <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com>
 <CABBYNZKs-JH_g2iUxStL5bRu-1z1TVzrS5pk2RyXUK8hiWYb7Q@mail.gmail.com> <CAO271mnbrRxtEvMhc7GMaWY=BEKUzzv_CbN1j5WKf4NruKfJng@mail.gmail.com>
In-Reply-To: <CAO271mnbrRxtEvMhc7GMaWY=BEKUzzv_CbN1j5WKf4NruKfJng@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Tue, 15 Feb 2022 08:49:55 -0800
X-Gmail-Original-Message-ID: <CAO271mkRwR9nMe79d78wJSiyybHjiZdGtGApAWBJjWqPYT3KYA@mail.gmail.com>
Message-ID: <CAO271mkRwR9nMe79d78wJSiyybHjiZdGtGApAWBJjWqPYT3KYA@mail.gmail.com>
Subject: Re: Question about Trusted property
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Friendly ping here. Could you respond to my RFC about adding "Bonded"
property? I am about to write the patch but I would like to hear
whether this makes sense from your perspective. Thanks.

On Thu, Feb 10, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
> Thanks for the clarification. So my guess was right that it does not
> have to do with bondedness. In that case, do you think it makes sense
> to add a "Bonded" flag property to org.bluez.Device1? There are some
> use case flows that pair with a peer device but do not actually bond,
> and just with Paired property the UI can't know whether to show this
> device as "Bonded" or not.
>
> On Thu, Feb 10, 2022 at 1:30 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Thu, Feb 10, 2022 at 11:23 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > Dear maintainers,
> > >
> > > Friendly ping on this question. Does adding "Bonded" property to
> > > org.bluez.Device1 make sense?
> > >
> > > On Fri, Feb 4, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > > >
> > > > Hi Luiz/BlueZ maintainers,
> > > >
> > > > What is the purpose of the Trusted property on org.bluez.Device1
> > > > interface? Does it mean whether the device is bonded? My experiment
> > > > with BlueZ shows that sometimes a device with "Trusted" property set
> > > > is not bonded (does not have pairing key stored) and also vice versa,
> > > > so I am assuming that the Trusted property means something else. What
> > > > is an example use case of the Trusted property?
> > > >
> > > > Eventually, what I am trying to achieve is for BlueZ clients to find
> > > > out whether a device is Bonded or not. Using the Paired property is
> > > > not very accurate because it is set to true during connection although
> > > > the device is not bonded (pairing key does not persist after
> > > > disconnection). For this purpose, I am about to propose adding
> > > > "Bonded" property to org.bluez.Device1. Some use cases include when
> > > > there is a temporary pairing with a peer device we don't want UI to
> > > > show that the device is in the Bonded device list. What do you think
> > > > about exposing the Bonded state via D-Bus? I will do the
> > > > implementation if this idea makes sense.
> > > >
> > > > Thanks!
> >
> > Trusted primary use is to bypass agent authorization, so when set the
> > agent will not have to authorize profile connections, and yes you can
> > set a device to be Trusted even without having it paired since the
> > bonding procedure refers to authentication rather than authorization
> > which is what Trusted controls.
> >
> >
> > --
> > Luiz Augusto von Dentz
