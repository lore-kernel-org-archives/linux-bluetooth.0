Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4838520B80
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NR8YlSFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbgEZTZo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 15:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392568AbgEZTZi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 15:25:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E72C03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 12:25:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w10so26023904ljo.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxKmxSaEr4yh3HnXyZtdzWzs8mO5jn/1jUUMtoKpqzk=;
        b=NR8YlSFq+cIUv4V6Z5Ec/HvbjPTqxSjgu6AFouJalMDxeobzNK3Dm04K60OEGj45MA
         92Zor/+BTQIe4wrJ3C2ix3AT0JMWSpwFmp8xLHdKSc+b/1qf5bjAw0Tfvz8vs49llEuY
         KnmSIAyRQ8lyiZB4CifR6mx2h5Jw85ZoTOvKultKkE0KiVrOmN0zlJ3m3ULodeiGqUqY
         9eSIdVp71G7D2s+A6yRzcCT4dIZBaxD5k6hbwud3SQq9dekNsxBUwL0AwTJeLvWmfoI5
         bvDeGIq302YQtC+PCH3ieeqE1flHNjulCnAbkku51Cyq+CyLman6U4cLNwCB1K+w5ks0
         NHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxKmxSaEr4yh3HnXyZtdzWzs8mO5jn/1jUUMtoKpqzk=;
        b=CHbicrjw7BLL6JHHbal74Ui1PvUc3UZncAo1ebZdoO4rbIE/9VSTwhECKfazZfHRhA
         kL/bwsjN3VUagNTukCa4XYI1YMkVhCsB5JGLei9XOv2CP9gbXrfVONWjR6KlcLGgOAGP
         kGC3+Z/R50DL6WYIAkHjNFSWyU/rDfcNFpfYjmJqSjUpOIxk15C5FFg+bEvRuW5FjPDN
         vLVgh+s/1K2Cnr/EvtWTUdqBp2ZvfdpB+V3jigc6fXNzPYohb3PddXVaERpcFGBre3H8
         yIc7a9kx+e2wBu86/qYq1dgI391O/8X69nCYpHKGGNiRZFV/618BgLE2CNjLR1US4ogW
         efAg==
X-Gm-Message-State: AOAM531IwF15O0sLfrmUnJb+zLs/NzuI/DBFjPW9XtSXkXBfxDHVoKf5
        pf32duh27vrEhKcp8ofF7rx4eOXsbRvQLzFIDEJp4Q==
X-Google-Smtp-Source: ABdhPJxExIWJPgqQwoDTqvb8AqZKs+JR0EWIGe5MfQIFI0DJiPJr9I1mbqTKbwm4+mPFsMddPeXkjnm+eM5ayoWkmhM=
X-Received: by 2002:a2e:98da:: with SMTP id s26mr1305931ljj.3.1590521136130;
 Tue, 26 May 2020 12:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2KLba+-VC+zytj=gwie8FOBwE6H78R78h5_Fqfn_Jnd=BvKA@mail.gmail.com>
 <CALWDO_W+8SDCOn_b_4_FB-KR43xjyYB8u+kSgQ1YVx1Mp_FG=g@mail.gmail.com> <CAA2KLbaXKro_KTHzZf+PyWejqKG=vjz1oro-2W=jcqj_nC+O4Q@mail.gmail.com>
In-Reply-To: <CAA2KLbaXKro_KTHzZf+PyWejqKG=vjz1oro-2W=jcqj_nC+O4Q@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 26 May 2020 15:25:24 -0400
Message-ID: <CALWDO_WbKxyWgM9A-9XSCqDtc2uXnLOANiswS-8TEzCR=PoRrg@mail.gmail.com>
Subject: Re: UUIDs for every single physical peripheral's service and characteristics?
To:     Christopher de Vidal <cbdevidal.jk1@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Yes.  Unless each of your 1000 devices will have a different
protocol/contract to interact with them, you don't need to have unique
UUIDs for the services/characteristics per device instance.

On Tue, May 26, 2020 at 12:22 PM Christopher de Vidal
<cbdevidal.jk1@gmail.com> wrote:
>
> So let me make sure I understand. The devices themselves have their
> own Bluetooth addresses (similar to MAC addresses, I don't know the
> proper term) which are unique among every physical device sold. And
> also there is one (and only one) service UUID which is shared among
> all 1,000+ peripherals which I sell, and 19 characteristic UUIDs that
> are shared among the physical peripherals. The devices come with their
> own Bluetooth "MAC" and I only need to obtain 20 UUIDs in total for
> the product line. Did I get that right?
>
> Christopher de Vidal
>
> Would you consider yourself a good person? Have you ever taken the
> 'Good Person' test? It's a fascinating five minute quiz. Google it.
>
> On Tue, May 26, 2020 at 10:57 AM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Hi Christopher,
> >
> > The term "unique" will vary based on context.  In the context of a
> > Gatt Service and Characteristic, it is intended to uniquely identify
> > the "contract" defined by the service/characteristics.  For example a
> > Temperature Service would have a UUID that universally defines the
> > contract/interface defined by that service.
> >
> > So for your custom service, you'll need to define a set of 20 128 bit
> > UUID (16 bit uuids are reserved for SIG defined uuids) that uniquely
> > identify the contract that's defined by your service/characteristics.
> > The devices can uniquely be identified/addressed by their respective
> > addresses.
> >
> > I hope this is helpful.
> >
> > Thanks!
> > Alain
> >
> > On Tue, May 26, 2020 at 10:38 AM Christopher de Vidal
> > <cbdevidal.jk1@gmail.com> wrote:
> > >
> > > Help a newbie? I'm seeking to build a niche product for sale, a
> > > Raspberry Pi-based device which during the initial setup acts a BLE
> > > peripheral. (Python using dbus to Bluez.) It has a single service and
> > > 19 characteristics. I get that the first "U" in UUID stands for
> > > unique. Must that be unique among each physical product, or may it be
> > > unique among the product line?
> > >
> > > So if I sell 1,000 units (which would be a success), would I need to
> > > obtain 1,000 service UUIDs and 19,000 characteristic UUIDs? Or just 20
> > > total, for the entire product line?
> > >
> > > The goal is so that the iOS/Android app can have that pre-set in the
> > > code and quickly discover the device, pair it automagically.
> > >
> > > I suppose the risk is of a conflict of two similar devices which are
> > > in the same vicinity of the phone, and both set into peripheral mode
> > > at the same time. But that would be a minimal risk which I could
> > > accommodate for.
> > >
> > > Christopher de Vidal
> > >
> > > Would you consider yourself a good person? Have you ever taken the
> > > 'Good Person' test? It's a fascinating five minute quiz. Google it.
