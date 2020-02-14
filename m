Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4EC352A3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 02:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF7E217F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 02:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUKWat4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBNCVP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:21:15 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38987 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgBNCVP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 21:21:15 -0500
Received: by mail-vs1-f66.google.com with SMTP id p14so4992914vsq.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 18:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdZU6oxzz8082H5wxa3sUHsd3r2/KMEe1ZoAk6X+3z4=;
        b=eUKWat4VTepUvloVJUuVaKHR6JxtasrCqdEXsVVK9T8+FHIRwLNnjTk8221JCte4BT
         fcWTNUBKuwUnNAt45Iw67/ztMhGgR0l3qDYqT4QjIq5s131aFcoZoC1V25eNrrm9TqG5
         sOQb8x+lgmp3kAzIZFb5rXWVd5WOOBMSMcvErYxjR8eOGFNchu+Ni9JRdJ1RkiUKd6Qf
         rPVzHqBtfc32br8iqNVuzhqchskUFxA+0EBz9pWN3DHlbSRafNgEQRWwEeojDXubyWEw
         O3w6b9BJaC+2EwMMdjjIdVlk9nOTJpeK4PbuuEhvbEY84RKUkeJW0AX31ndy46lCmaYH
         y0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdZU6oxzz8082H5wxa3sUHsd3r2/KMEe1ZoAk6X+3z4=;
        b=VUMzNJ9OIXYmnFTguJsjU5YEW0En6+PeEoNlfyzdNy+WI6n0u8HKg09rgKp8oZ265z
         F5Zid5VQ3QOu2GQ9VdNi9Lna0Kr05ZbNomBbOMgeYKo0IDxbMHjxRPUf6uzaxkijq8gP
         OyvNyf5UF3fs3uqu2G8nlYx/oldarMDJ5ubgj8Pg8hcH6nA9ejgYwIcBdX56KCYybWd0
         HwXfSOAzXANQBLZT66OBTFdlDql+bA5tsQyVN443ffimC/LUKrKGcSyZgFEc9vclGVgN
         0cIx7+aTqMtICh//iftX/xWfCKBoyy7db69p2v9/hCJKg5AhA74a6fEcondW7LAz5qEm
         6ZVQ==
X-Gm-Message-State: APjAAAWsEXttD7aKuq3m9zpA6qlT72i81hoBXsZSzTu8pbYu3pLMJKR9
        GEChZam1aSs+A+kQ1HSa07wp9FhzU391wOPIHY/uTdF37mM=
X-Google-Smtp-Source: APXvYqwIfKA+CfTUrEU4IWI95odBptrxzgwObVTD5cwsuPnhn1hZmU7BTNJwowGPMy4cohr2oVeVuv1srg7ldmkWVFA=
X-Received: by 2002:a67:f49a:: with SMTP id o26mr225848vsn.124.1581646873860;
 Thu, 13 Feb 2020 18:21:13 -0800 (PST)
MIME-Version: 1.0
References: <CAANRJtzBpw__m0ymcXJu1VhYhGcVT=AkLYpwHaahT=F4xKo+Wg@mail.gmail.com>
 <CABBYNZLngK1F_=fVYhCJNJGnkR+oK93-rN2MTN4z3dMFTP+E3Q@mail.gmail.com>
 <CAANRJtxFLMU6i4maUgpLC1iar1Q9HJv+ELcwpQv=c4bLo-uPAQ@mail.gmail.com> <CABBYNZJccLD-BD1aAB70sX9_FqSwkDc789-WQhi0V4Udbp5wBA@mail.gmail.com>
In-Reply-To: <CABBYNZJccLD-BD1aAB70sX9_FqSwkDc789-WQhi0V4Udbp5wBA@mail.gmail.com>
From:   Amit K Bag <amit.k.bag@intel.corp-partner.google.com>
Date:   Fri, 14 Feb 2020 07:51:04 +0530
Message-ID: <CAANRJty7xZ+GNyAU82oXAdCuJ07LnaZm_M2yUet3rfgwd6AVMA@mail.gmail.com>
Subject: Re: OPP throughput is low in ubuntu 18.04
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

I am not sure what changes in kernel causing low throughput. If I get
any clue I will let you know.
I wil lalso test your patch with linux - linux and update the result.

On Fri, Feb 14, 2020 at 6:18 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Amit,
>
> On Thu, Feb 13, 2020 at 3:32 AM Amit K Bag
> <amit.k.bag@intel.corp-partner.google.com> wrote:
> >
> > Hello Luiz,
> >
> > I tested with the patch you have mentioned but not getting any better
> > throughput.
> > Please have a look at the log attached.
> >
> > We are using below configuration for linux
> > - Kernel : 4.19.102
> > - OS : ubuntu 18.04.2 LTS
> > - Bluez -5.48
> >
> > For other machine we are using windows
>
> I think there is some work to be done to work with RFCOMM since we are
> only doing this for L2CAP, I will have a look later this week, btw
> have you look into any difference we may have between these kernels?
> Or actually in what combination they appear because there could be an
> isolated problem in either the kernel or the userspace changes.
>
> > On Mon, Feb 10, 2020 at 11:03 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Amit,
> > >
> > > On Mon, Feb 10, 2020 at 3:20 AM Amit K Bag
> > > <amit.k.bag@intel.corp-partner.google.com> wrote:
> > > >
> > > > Hello All,
> > > >
> > > > I am tring to test the OPP throughput in linux.
> > > > I transferred between 2 machines having ubuntu 16.04 with bluez
> > > > version 5.44 in that I am getting 1.4mbps speed.
> > > >
> > > > Kernel : 4.14.13
> > > > OS : ubuntu 18.04.2 LTS
> > > > Bluez -5.44
> > > >
> > > > I am using a 12 MB of audio file.
> > > > But the same file when I transferred between  2 machines having ubuntu
> > > > 18.04 the speed is significantly reduced.
> > > >
> > > > Kernel : 4.18.0-15-generic
> > > > OS : ubuntu 18.04.2 LTS
> > > > Bluez -5.48
> > > >
> > > > Could someone tell me why its reduced in ubuntu 18.04
> > >
> > > I don't think we change anything on Obexd related to that so perhaps
> > > it is something related to the L2CAP MTU? We could try setting the MTU
> > > to 0 so it automatically picks the matching MTU if you do have the
> > > following patch applied to your kernel:
> > >
> > > Bluetooth: Auto tune if input MTU is set to 0
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
