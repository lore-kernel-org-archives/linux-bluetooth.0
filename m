Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC9DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F54420776
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3tC5aAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgE0Piy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 11:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgE0Pix (ORCPT
        <rfc822;Linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 11:38:53 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3BC05BD1E
        for <Linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 08:38:52 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g25so19442697otp.13
        for <Linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxfTPJMG0B7j7zZi7li0uvVMY8W3X3q/OTBuYRSk/CI=;
        b=E3tC5aAQqDHGy/iMn7mC28/A1D9QNAU8A3at4bE3eP7fON5QOH5NL0NjrwOcKVFsTF
         K8aUiSUQ0IjDnlqoAdKmI3mHcu9Ir2jcnf8cTioB9mtEt0MdCVX1z3CdJ3NIvQnuFoBh
         pHBgu58QSD/rT3jtoh6inrxPR/Tpe1VmFPGTfoG5W4BMDrehuq5Ya6ZFk4VAlWXkXGQ3
         rLXRns8ydMo9/WwAUUYvwczX7HcN8S2hrYXLLtbfCHukd0B0FAXLnrSQh6bbwX9boRo4
         /zTzGT2H3hJGLqvzXG1b0t5oIVe0bgQd/VA4q53FPAKxJ79E8NBdvpY60s0mLKrTtQZs
         aiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxfTPJMG0B7j7zZi7li0uvVMY8W3X3q/OTBuYRSk/CI=;
        b=dvCikQ7CnlVoHT3FerR7NoGoe4TWrCqH20hQVzrUNpUSmMcYFuyMHRtgpGQO5VUyOY
         hX9OLr9jZqVPLTcwp+ZCZ5NchJFT1eK+xYRvpdmCr4EqSO4QsNz1ds0eiTIDwgXjM6N+
         hLz7J4mmLtTjNQBsQCMpa+ImwmMM91WcqWlCwp5A/rPRLChsMaWhXzHmM5OQzog6U0Qo
         U4PUXXCss0gaTP2CCRRAeU2eA1FoWrS1P7Dy+fgsLvo80O6ehpa025EuEuboUA8U4oR4
         TibPWZ66FhxPdRKt41JPtKoPEo7ni9rxj/+FHdrc6c90phmspm2G9vJGCQikPGL+aM9r
         OBgw==
X-Gm-Message-State: AOAM5304TRexgES0gMTxUbj4QBUqpL1ILvDW9Zm/EdH2D4NNFhrWl6Yx
        HDa5XWjndvw1Pck/ehhWYJrI0urMUQiy3QOyuQo=
X-Google-Smtp-Source: ABdhPJyi8X6IeWrw7hreSuP0QVQ6ujc2GVU2GOupRjWJw/iWxGtrGRc16on0bQk8F2B8enKZYlCG3qcPlro7b7gNwAw=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr5205706ots.11.1590593931942;
 Wed, 27 May 2020 08:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR17MB19671EAD4D74EA7BC5915CA7C5B40@MWHPR17MB1967.namprd17.prod.outlook.com>
 <CABBYNZKonvHxnabQsu84rVQEPpou45UgqVUECZ2HoTdd7pWT+A@mail.gmail.com>
 <DM5PR17MB1963CCA502759CB08EB9FFE1C5B10@DM5PR17MB1963.namprd17.prod.outlook.com>
 <11527909.O9o76ZdvQC@ix>
In-Reply-To: <11527909.O9o76ZdvQC@ix>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 May 2020 08:38:38 -0700
Message-ID: <CABBYNZKb2LpyH1iEyc-nOn7ZXYBPA0j+-RoZ0ytNXNndYvEF3A@mail.gmail.com>
Subject: Re: Comments on the ConnectDevice API function
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     Martin Woolley <mwoolley@bluetooth.com>,
        "Linux-bluetooth@vger.kernel.org" <Linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Wed, May 27, 2020 at 7:10 AM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi Martin,
>
> On Wednesday, 27 May 2020 15:41:12 CEST Martin Woolley wrote:
> > Hi Luiz
> >
> > thanks for your response. Much appreciated. I must confess this is the first
> > time I've used the BlueZ APIs directly (via D-Bus).
>
> > I'm all for hiding implementation details where possible in APIs and making
> > the API itself take care of conditional aspects if possible, but these were
> > just my $0.02, no more than that. I wasn't aware of the background or the
> > philosophy, so thanks for that insight as well.
>
> > Having the API take care of the AlreadyExists error by providing a
> > connection to the already discovered device, transparently does seem a nice
> > touch for the application developer but certainly not essential.
>
> This API was added only for qualification purposes (there are some GAP tests
> specified in a way that upper tester is not doing discovery) and it shouldn't
> be used for 'normal' usage.

Btw, we could perhaps have a different flag from such API e.g.
qualification-only or perhaps add an entry on main.conf would be
better in this regard since it may mean that we never really adopt
them as stable APIs.

>
>
> > All the best
> >
> > Martin
> >
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: 22 May 2020 18:49
> > To: Martin Woolley <mwoolley@bluetooth.com>
> > Cc: Linux-bluetooth@vger.kernel.org
> > Subject: Re: Comments on the ConnectDevice API function
> >
> > Hi Martin,
> >
> > On Fri, May 22, 2020 at 1:25 AM Martin Woolley <mwoolley@bluetooth.com>
> > wrote:
> > >
> > >
> > > Hello
> > >
> > >
> > >
> > > I've recently been working with BlueZ via D-Bus and have a situation which
> > > requires me to be able to connect to a device whose Bluetooth device
> > > address is known, but without first scanning. This is a link layer state
> > > transition with the specification allows.
> >
> > >
> > >
> > > BlueZ currently supports this via an API adapter function called
> > > ConnectDevice, whose status is currently "experimental". From my
> > > experience of using this function, it seems to behave like this:
> >
> > >
> > >
> > > If the BlueZ instance has not scanned yet, so that the target device is
> > > not known to it, the ConnectDevice call results in scanning taking place
> > > and then if the target device is found, it is connected to. Success!
> >
> > >
> > >
> > > But if scanning has previously been performed, regardless of the state of
> > > the actual device (e.g. advertising and ready to accept connections), an
> > > exception is thrown with a message whose text value is "Already Exists".
> >
> > >
> > >
> > > I was wondering if I could influence the design of the API before the
> > > ConnectDevice experimental status is removed?
> >
> > >
> > >
> > > I would like to suggest that there should be no need for a special API to
> > > connect directly to a device without first scanning. Why burden the
> > > application developer needing to call it just in case this condition
> > > applies, catching the BlueZ exception ("Already Exists") and responding
> > > by then calling the normal Connect API?
> >
> > I guess the intention was to have the application use the intended API for
> > devices already present _before_ calling ConnectDevice, so before entering
> > the address manually the application would enumerate the existing devices
> > and figure out if that was already present.
>
> >
> > > An alternative would be to accommodate this special case (not scanned
> > > before) in the implementation of the standard device Connect(bdaddr)
> > > function or if that makes no sense because Device objects must correspond
> > > to previously discovered, physical devices, then at least the adapter
> > > ConnectDevice function could take care of the two possible paths and
> > > simplify matters for the application developer.
> >
> > I guess you probably know this but just in case someone look at the archives
> > it is better that we make some things clearer, while the core spec allows
> > connecting without scanning D-Bus are intend to be a higher level API thus
> > why ConnectDevice was not really necessary for a long time and we just
> > introduced it for qualification purpose or when there are multiple adapter
> > where one acts as scanner. Also ever since the introduction of privacy
> > (random addresses) APIs that takes addresses becomes rather complicated to
> > be used directly, and there exists ways to scan for a specific address with
> > pattern filtering:
> > https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kerne
> > l.org%2Fpub%2Fscm%2Fbluetooth%2Fbluez.git%2Ftree%2Fdoc%2Fadapter-api.txt%23n
> > 122&amp;data=02%7C01%7C%7Cfafcb0f940054867612508d7fe7866fb%7Ce4e0fec5fc6c4dd
> > 6ae374bdb30e156b9%7C0%7C0%7C637257665400787125&amp;sdata=Iy%2FwWkxs%2FyW3gL2
> > 39FLWdoDRGa0apb63WxMhYwRoneM%3D&amp;reserved=0
> > That said I don't oppose to remove Already Exists error, but we should be
> > very clear that the use of such API should only be recommended with users
> > input and does not substitute the likes of Device.Connect.
>
> > --
> > Luiz Augusto von Dentz
>
>
> --
> pozdrawiam
> Szymon Janc
>
>


-- 
Luiz Augusto von Dentz
