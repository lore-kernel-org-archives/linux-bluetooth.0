Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF78C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853E0207D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzukBiYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgEZQWA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgEZQV7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 12:21:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AFFC03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 09:21:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a2so24432495ejb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaSBbAvhD/ngIFpKWu2r1Cofpo1zAj87bUvJZlIEYK8=;
        b=QzukBiYDI5PsVgvbHOld5q+6ajgr9jDZCSZ3bl4Ma9oAmb7yhHDC+JM6lR1lJ/5DFy
         3mAmPOzrazpPHfyBxXSx3WuawgcuKqo72J8rjiZQIC6AZoUpLepNBJ4Hov4mkkwmPG8m
         +QAuTMesS8EIKZMIlqpx3r0NNGbO2p8SnkAXnCaSVaoFbUSw3bE5m93nSJMTQIYhM8ko
         iTDVN1iM9aqcwmkY2qhZ3pNeVuFoRW9LjwT5/dYRgPw+lgx1Hjtj4dTE6Ik7/AaKhu8d
         hya3OFhXyCl3beILPdKU0yWkozZznmUBkjeLUNOWY1Jz+dY3DkyhDpLPZ0j7LOVQL7+F
         2H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaSBbAvhD/ngIFpKWu2r1Cofpo1zAj87bUvJZlIEYK8=;
        b=kGxQ3EKLCsRH+qzgettG1e9w9IHl7v7Bz6VWE/YswILhEGXvwmJYf4xX6Nd9jua/5N
         RNM7Lya76Dw2G2KFMqWX+PCtq7R8zsKD4AIlQPdKQdGMJxcj4iK9aoYvGRkyTxQmgfya
         nAr+YTN3CWs93W0rdXrSI1usluo2HD+5c59/bp4431/Y+5ke9sTMc/Emkgt7H1OigG+Q
         13Qa/tshPvN0hME81t0mdL249XEUm8x05aMRInsfWMc/VRcNmeKQGZLqKuP8Wely+5p7
         JYJ7Y4BTW5hw51YYiEtWVgH9ZN2uv4CrlEjtLF1W1OMCNhKLTsROgWEfJq5zOzHZDejo
         Rs/Q==
X-Gm-Message-State: AOAM5334mwK+yajngSDkYq5HpbDTi1z7KWprAeAxSniTLoJ0oJuhrUH+
        3UGRJFdIQnoVjly0FedSD3/MgF+F1zK3hdA0NkAY6MtA
X-Google-Smtp-Source: ABdhPJyZxEIWJILPGVbGNnaFh175oMese/1zNAqwerd4a+t+msWnD4VvTsrNVbqmdf6e9uesbdy2NkxpRewy2TP9PAc=
X-Received: by 2002:a17:906:379a:: with SMTP id n26mr1760512ejc.513.1590510117889;
 Tue, 26 May 2020 09:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2KLba+-VC+zytj=gwie8FOBwE6H78R78h5_Fqfn_Jnd=BvKA@mail.gmail.com>
 <CALWDO_W+8SDCOn_b_4_FB-KR43xjyYB8u+kSgQ1YVx1Mp_FG=g@mail.gmail.com>
In-Reply-To: <CALWDO_W+8SDCOn_b_4_FB-KR43xjyYB8u+kSgQ1YVx1Mp_FG=g@mail.gmail.com>
From:   Christopher de Vidal <cbdevidal.jk1@gmail.com>
Date:   Tue, 26 May 2020 12:21:20 -0400
Message-ID: <CAA2KLbaXKro_KTHzZf+PyWejqKG=vjz1oro-2W=jcqj_nC+O4Q@mail.gmail.com>
Subject: Re: UUIDs for every single physical peripheral's service and characteristics?
To:     Alain Michaud <alainmichaud@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

So let me make sure I understand. The devices themselves have their
own Bluetooth addresses (similar to MAC addresses, I don't know the
proper term) which are unique among every physical device sold. And
also there is one (and only one) service UUID which is shared among
all 1,000+ peripherals which I sell, and 19 characteristic UUIDs that
are shared among the physical peripherals. The devices come with their
own Bluetooth "MAC" and I only need to obtain 20 UUIDs in total for
the product line. Did I get that right?

Christopher de Vidal

Would you consider yourself a good person? Have you ever taken the
'Good Person' test? It's a fascinating five minute quiz. Google it.

On Tue, May 26, 2020 at 10:57 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Christopher,
>
> The term "unique" will vary based on context.  In the context of a
> Gatt Service and Characteristic, it is intended to uniquely identify
> the "contract" defined by the service/characteristics.  For example a
> Temperature Service would have a UUID that universally defines the
> contract/interface defined by that service.
>
> So for your custom service, you'll need to define a set of 20 128 bit
> UUID (16 bit uuids are reserved for SIG defined uuids) that uniquely
> identify the contract that's defined by your service/characteristics.
> The devices can uniquely be identified/addressed by their respective
> addresses.
>
> I hope this is helpful.
>
> Thanks!
> Alain
>
> On Tue, May 26, 2020 at 10:38 AM Christopher de Vidal
> <cbdevidal.jk1@gmail.com> wrote:
> >
> > Help a newbie? I'm seeking to build a niche product for sale, a
> > Raspberry Pi-based device which during the initial setup acts a BLE
> > peripheral. (Python using dbus to Bluez.) It has a single service and
> > 19 characteristics. I get that the first "U" in UUID stands for
> > unique. Must that be unique among each physical product, or may it be
> > unique among the product line?
> >
> > So if I sell 1,000 units (which would be a success), would I need to
> > obtain 1,000 service UUIDs and 19,000 characteristic UUIDs? Or just 20
> > total, for the entire product line?
> >
> > The goal is so that the iOS/Android app can have that pre-set in the
> > code and quickly discover the device, pair it automagically.
> >
> > I suppose the risk is of a conflict of two similar devices which are
> > in the same vicinity of the phone, and both set into peripheral mode
> > at the same time. But that would be a minimal risk which I could
> > accommodate for.
> >
> > Christopher de Vidal
> >
> > Would you consider yourself a good person? Have you ever taken the
> > 'Good Person' test? It's a fascinating five minute quiz. Google it.
