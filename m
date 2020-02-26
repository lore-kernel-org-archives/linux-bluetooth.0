Return-Path: <SRS0=9bU/=4O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AABC4BA0B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 05:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB1124650
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Feb 2020 05:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORiAzZEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgBZFSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:18:43 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40279 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgBZFSn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Feb 2020 00:18:43 -0500
Received: by mail-vs1-f67.google.com with SMTP id c18so1011493vsq.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2020 21:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRc0TFZncUMTBEAZ24syFr6KVuMYXTjMoyGZ8Xhk3ys=;
        b=ORiAzZEO5f1GV4ZwnZzq9jXWQgbKArDOovQ+ccBgwobLEEGuZJUeFZ5IJr+AxWTdS6
         2m3NqZvRYMdJZRgKMVT/9jg7CTBvAO6HROqTuDj5slsxLSLc94TseMlQqnUpTkNnCHaX
         tK47UQuZbiyNDXOn1i77WgAmpp41KQAbmZFzW0J8Tv1NlHj7oWh2OEhs1FSpGkdmYgxK
         QUvmDtWCsNSV93OhnCw82wyN2Y17cyhQZRbUvFPvFTx+4TG+DxQ8Psy1DeklGTxkfv1G
         CSqNAaHP2nicyY/07jAIP6S4WGPHjxa3hB94/tN4jr4KyvhLn6E4YCJO+rXdGJFBZbnh
         Z28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRc0TFZncUMTBEAZ24syFr6KVuMYXTjMoyGZ8Xhk3ys=;
        b=r4z0Cz7PRFaXB7u+AdH03UzIkwYXmn69tfjViqttqDWij4zxtbhx70E0LNGhKrtQS3
         7yC/ln3qCdjHpTk4BCp3rsteuK13QtzTJnD1rgYEXcPcvt9QyZCL8fN9wh3201WBNc8p
         1es2LrCxTAPnMZD8PQ6ibnKXJY1Q2kuOzQZqEd1JWaBU72L9wCHLJKC8r3GFJWXOwPDL
         sjA9+dbDPgr2FhaW1IMcWZqARBAOHLRITZPd7b4OEN/oAijnry3IQIjKTgHHrBDo4b2i
         Uul1fEaIMqgi/fnrbvUAdWmngxvclk5LrrsDBsrb9yig0p9e6ATBujPnnzQnLSbDQpDl
         ukjw==
X-Gm-Message-State: APjAAAXryOun2uGUpENSh4yI+NACaJF3yMbgCaREtreGOagAX6O5tm5Y
        FAd9heuSXWzkBR0tM6rafIZTztuRMcy9+5PVpNexIQ==
X-Google-Smtp-Source: APXvYqwGu/P1SifQUjGrzkuXrysrZ8dzK69FIck4CbiT80KWBVvSLUHrZEoj8YJdBDNt5qlmCtz9Cz1s2/vdST/ZtdA=
X-Received: by 2002:a67:f641:: with SMTP id u1mr3066531vso.86.1582694320187;
 Tue, 25 Feb 2020 21:18:40 -0800 (PST)
MIME-Version: 1.0
References: <CAANRJtzBpw__m0ymcXJu1VhYhGcVT=AkLYpwHaahT=F4xKo+Wg@mail.gmail.com>
 <CABBYNZLngK1F_=fVYhCJNJGnkR+oK93-rN2MTN4z3dMFTP+E3Q@mail.gmail.com>
 <CAANRJtxFLMU6i4maUgpLC1iar1Q9HJv+ELcwpQv=c4bLo-uPAQ@mail.gmail.com>
 <CABBYNZJccLD-BD1aAB70sX9_FqSwkDc789-WQhi0V4Udbp5wBA@mail.gmail.com> <CAANRJty7xZ+GNyAU82oXAdCuJ07LnaZm_M2yUet3rfgwd6AVMA@mail.gmail.com>
In-Reply-To: <CAANRJty7xZ+GNyAU82oXAdCuJ07LnaZm_M2yUet3rfgwd6AVMA@mail.gmail.com>
From:   Amit K Bag <amit.k.bag@intel.corp-partner.google.com>
Date:   Wed, 26 Feb 2020 10:48:29 +0530
Message-ID: <CAANRJtzaB=8=eghLq1qygyAtNf0SZwV8dAj_fMQfup8hqoEd_Q@mail.gmail.com>
Subject: Re: OPP throughput is low in ubuntu 18.04
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz,

I tried to test with your patch linux to linux which will use L2CAP
but still see the same low throughput.

On Fri, Feb 14, 2020 at 7:51 AM Amit K Bag
<amit.k.bag@intel.corp-partner.google.com> wrote:
>
> Hello Luiz,
>
> I am not sure what changes in kernel causing low throughput. If I get
> any clue I will let you know.
> I wil lalso test your patch with linux - linux and update the result.
>
> On Fri, Feb 14, 2020 at 6:18 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Amit,
> >
> > On Thu, Feb 13, 2020 at 3:32 AM Amit K Bag
> > <amit.k.bag@intel.corp-partner.google.com> wrote:
> > >
> > > Hello Luiz,
> > >
> > > I tested with the patch you have mentioned but not getting any better
> > > throughput.
> > > Please have a look at the log attached.
> > >
> > > We are using below configuration for linux
> > > - Kernel : 4.19.102
> > > - OS : ubuntu 18.04.2 LTS
> > > - Bluez -5.48
> > >
> > > For other machine we are using windows
> >
> > I think there is some work to be done to work with RFCOMM since we are
> > only doing this for L2CAP, I will have a look later this week, btw
> > have you look into any difference we may have between these kernels?
> > Or actually in what combination they appear because there could be an
> > isolated problem in either the kernel or the userspace changes.
> >
> > > On Mon, Feb 10, 2020 at 11:03 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Amit,
> > > >
> > > > On Mon, Feb 10, 2020 at 3:20 AM Amit K Bag
> > > > <amit.k.bag@intel.corp-partner.google.com> wrote:
> > > > >
> > > > > Hello All,
> > > > >
> > > > > I am tring to test the OPP throughput in linux.
> > > > > I transferred between 2 machines having ubuntu 16.04 with bluez
> > > > > version 5.44 in that I am getting 1.4mbps speed.
> > > > >
> > > > > Kernel : 4.14.13
> > > > > OS : ubuntu 18.04.2 LTS
> > > > > Bluez -5.44
> > > > >
> > > > > I am using a 12 MB of audio file.
> > > > > But the same file when I transferred between  2 machines having ubuntu
> > > > > 18.04 the speed is significantly reduced.
> > > > >
> > > > > Kernel : 4.18.0-15-generic
> > > > > OS : ubuntu 18.04.2 LTS
> > > > > Bluez -5.48
> > > > >
> > > > > Could someone tell me why its reduced in ubuntu 18.04
> > > >
> > > > I don't think we change anything on Obexd related to that so perhaps
> > > > it is something related to the L2CAP MTU? We could try setting the MTU
> > > > to 0 so it automatically picks the matching MTU if you do have the
> > > > following patch applied to your kernel:
> > > >
> > > > Bluetooth: Auto tune if input MTU is set to 0
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
