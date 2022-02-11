Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6484C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 00:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbiBKACQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:02:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiBKACP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 19:02:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC4B43
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:02:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cf2so13680131edb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fCgT38Arn4wQQoi+ovyGr4e/8ACygaFfOcJVPGk/8U=;
        b=X1kqHrKw7icmlX1Mahkh5QLIq4eK2VmAD8BGlp8hIHuBP0Ysb/rbRk7sk80wOMlcy5
         f2q2BqE50X8zzxUgAqScG8LawmQwk7n84WeIrQBWBiVe1poHQ/U8e5XV3EJphpHp2AKV
         xuHQCpSciLiGCK8tD6HqsRUM9mPUX+ZhbEIok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fCgT38Arn4wQQoi+ovyGr4e/8ACygaFfOcJVPGk/8U=;
        b=RYaTJgPKqXt3zp1E5oUVuutEKX/gsxLF3wZl6msqdw3tBzTxDb+xQZ169mi36rHY8M
         X6nAx8GKvTVM2Ut1rJPXdMv4F/ARLAlToFIe1e6sJXfumKhgLlod6wBo3MqJ/VDNzaU7
         MIXZGpCglJA+p2XtnOUizBd9onjAwLEJEoe6+KEnHqrkolxUCQqsCcbBFtkpPLpq5wWp
         7rg9bBvnT4LAaYuhH12mzk2yQzzA8sD7ExwOjd85Xqj16tjzrDg8rKwuW54RnC2xj6XI
         CU9rSqk1anJFBFCow3HVOhrWiI7Go66+CPVLzC840/sr6lUPVoN8dXv1kVfouYJDve9D
         ZnvQ==
X-Gm-Message-State: AOAM531qPaysAqMFiXBJmI2ngslSH6+wmLHjGrEQ2aBZCuopEBseArWQ
        WfpKi+TZDZ0w7lCiWk2veQ+YLBtSq4/OX0xW
X-Google-Smtp-Source: ABdhPJwtlHj4S/9IpIrAdWqlVHSgs+u5CgRVOAz7Vp5WYvNr+QbhIO4U8Bv8cB+g8n5f1a2cRjeVzw==
X-Received: by 2002:aa7:c04d:: with SMTP id k13mr10781113edo.301.1644537733673;
        Thu, 10 Feb 2022 16:02:13 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id h8sm10286273edk.14.2022.02.10.16.02.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 16:02:13 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id v12so12402528wrv.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Feb 2022 16:02:13 -0800 (PST)
X-Received: by 2002:a05:6000:1e15:: with SMTP id bj21mr8110680wrb.222.1644537732577;
 Thu, 10 Feb 2022 16:02:12 -0800 (PST)
MIME-Version: 1.0
References: <CAO271mmuMDoqNdXUUuPpyz3VyuLWrZUr1K=Jry+H9mGEtz-Z4Q@mail.gmail.com>
 <CAO271m=vQsGwRvpe2tUUMuqB7r2z2cAut27U1LY6bQ_sHAk3NA@mail.gmail.com> <CABBYNZKs-JH_g2iUxStL5bRu-1z1TVzrS5pk2RyXUK8hiWYb7Q@mail.gmail.com>
In-Reply-To: <CABBYNZKs-JH_g2iUxStL5bRu-1z1TVzrS5pk2RyXUK8hiWYb7Q@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 10 Feb 2022 16:02:01 -0800
X-Gmail-Original-Message-ID: <CAO271mnbrRxtEvMhc7GMaWY=BEKUzzv_CbN1j5WKf4NruKfJng@mail.gmail.com>
Message-ID: <CAO271mnbrRxtEvMhc7GMaWY=BEKUzzv_CbN1j5WKf4NruKfJng@mail.gmail.com>
Subject: Re: Question about Trusted property
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the clarification. So my guess was right that it does not
have to do with bondedness. In that case, do you think it makes sense
to add a "Bonded" flag property to org.bluez.Device1? There are some
use case flows that pair with a peer device but do not actually bond,
and just with Paired property the UI can't know whether to show this
device as "Bonded" or not.

On Thu, Feb 10, 2022 at 1:30 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Feb 10, 2022 at 11:23 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Dear maintainers,
> >
> > Friendly ping on this question. Does adding "Bonded" property to
> > org.bluez.Device1 make sense?
> >
> > On Fri, Feb 4, 2022 at 4:02 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > Hi Luiz/BlueZ maintainers,
> > >
> > > What is the purpose of the Trusted property on org.bluez.Device1
> > > interface? Does it mean whether the device is bonded? My experiment
> > > with BlueZ shows that sometimes a device with "Trusted" property set
> > > is not bonded (does not have pairing key stored) and also vice versa,
> > > so I am assuming that the Trusted property means something else. What
> > > is an example use case of the Trusted property?
> > >
> > > Eventually, what I am trying to achieve is for BlueZ clients to find
> > > out whether a device is Bonded or not. Using the Paired property is
> > > not very accurate because it is set to true during connection although
> > > the device is not bonded (pairing key does not persist after
> > > disconnection). For this purpose, I am about to propose adding
> > > "Bonded" property to org.bluez.Device1. Some use cases include when
> > > there is a temporary pairing with a peer device we don't want UI to
> > > show that the device is in the Bonded device list. What do you think
> > > about exposing the Bonded state via D-Bus? I will do the
> > > implementation if this idea makes sense.
> > >
> > > Thanks!
>
> Trusted primary use is to bypass agent authorization, so when set the
> agent will not have to authorize profile connections, and yes you can
> set a device to be Trusted even without having it paired since the
> bonding procedure refers to authentication rather than authorization
> which is what Trusted controls.
>
>
> --
> Luiz Augusto von Dentz
