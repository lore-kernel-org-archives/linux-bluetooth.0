Return-Path: <SRS0=GIG2=4C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71EC352A3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 00:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD6A2168B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Feb 2020 00:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzCMfhfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBNAs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:48:57 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42514 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbgBNAs5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 19:48:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so7523442otd.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 16:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGT9Q+viJgqllmJ51L2Qr/9aTqjnr5s+hxwU3zAS210=;
        b=kzCMfhfSx4f2aROjAttskPiNZSrl82jRwKO3PQdtDnu4ktxr5W6bcIGkXH0TuQXztp
         FL+Mjzwitv7WcZSS/FO2Xt3IpQE+FdMeU7hf7uzEa25RgFUToPG4+DpqilYZlKA38Hxu
         EX9Fscy78lKSeQwwm/S7EI0cBwpOje4fP5I3CWJkmBHhZTr8vVG14vZCOZMDbQWlSvdv
         G5DRdA71xPif3p5zxTlvGu5YWr/BtrmN7Y9TOTkfjS/NwCTMTdstPgM3G4WDutjjbV6O
         5FFFehH42YMzghvFl1n8UeVSlf4EvECLswxsRZR/xW2P3aRnEEDPq6kaAOcuKMtKlhA/
         vQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGT9Q+viJgqllmJ51L2Qr/9aTqjnr5s+hxwU3zAS210=;
        b=OPxUC3m+H8p8zVeJs2jcVST8smvZqzO2nmaZ1VaxYF0Ta6UagciwFqOSsIQIIx1M8W
         ttbhth39+LyKLRfuHVH+Owq4Eoz7vAKbfYwckk6GOP/D5hXp+ecxp52aonuuyRb2C6Qv
         JJdyCXpAHdK2SOnBxHZevyEa4Y0lK3uye/RtmaBPirbY+t2G+5Itq4adq6E4p3bA3rMB
         ZKqSKhcq9/JcwJaQLSSmZD8lNlWFGYbYwfux8n3p6RPzkPwhRL5t4yHcvdqgRiGJjmLN
         qwYSNGuNWaWbeiGq/zz7m3xZmzTyh7NAdf0L0EuqkjsrppmCwoj4OX2+fJ8UbpVtB1/d
         62jQ==
X-Gm-Message-State: APjAAAUULTJ935wvkhSFhzXVBRiGhROk0EBJ0NL9cgo3eDU+o47Srrqu
        JmQ4eayx6bzBvq6MlSlSF4XUMqorkCqbkcQesnlZ0A==
X-Google-Smtp-Source: APXvYqzi8Rp2Y47orfcFx8u6Pup5LL8NAEqSZILETk5nXkbz0TjE5tTDjXgBMnzqwVIV+az65fzcmhxi8dzGCnD/lyo=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr207518otc.146.1581641336053;
 Thu, 13 Feb 2020 16:48:56 -0800 (PST)
MIME-Version: 1.0
References: <CAANRJtzBpw__m0ymcXJu1VhYhGcVT=AkLYpwHaahT=F4xKo+Wg@mail.gmail.com>
 <CABBYNZLngK1F_=fVYhCJNJGnkR+oK93-rN2MTN4z3dMFTP+E3Q@mail.gmail.com> <CAANRJtxFLMU6i4maUgpLC1iar1Q9HJv+ELcwpQv=c4bLo-uPAQ@mail.gmail.com>
In-Reply-To: <CAANRJtxFLMU6i4maUgpLC1iar1Q9HJv+ELcwpQv=c4bLo-uPAQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 13 Feb 2020 16:48:30 -0800
Message-ID: <CABBYNZJccLD-BD1aAB70sX9_FqSwkDc789-WQhi0V4Udbp5wBA@mail.gmail.com>
Subject: Re: OPP throughput is low in ubuntu 18.04
To:     Amit K Bag <amit.k.bag@intel.corp-partner.google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

On Thu, Feb 13, 2020 at 3:32 AM Amit K Bag
<amit.k.bag@intel.corp-partner.google.com> wrote:
>
> Hello Luiz,
>
> I tested with the patch you have mentioned but not getting any better
> throughput.
> Please have a look at the log attached.
>
> We are using below configuration for linux
> - Kernel : 4.19.102
> - OS : ubuntu 18.04.2 LTS
> - Bluez -5.48
>
> For other machine we are using windows

I think there is some work to be done to work with RFCOMM since we are
only doing this for L2CAP, I will have a look later this week, btw
have you look into any difference we may have between these kernels?
Or actually in what combination they appear because there could be an
isolated problem in either the kernel or the userspace changes.

> On Mon, Feb 10, 2020 at 11:03 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Amit,
> >
> > On Mon, Feb 10, 2020 at 3:20 AM Amit K Bag
> > <amit.k.bag@intel.corp-partner.google.com> wrote:
> > >
> > > Hello All,
> > >
> > > I am tring to test the OPP throughput in linux.
> > > I transferred between 2 machines having ubuntu 16.04 with bluez
> > > version 5.44 in that I am getting 1.4mbps speed.
> > >
> > > Kernel : 4.14.13
> > > OS : ubuntu 18.04.2 LTS
> > > Bluez -5.44
> > >
> > > I am using a 12 MB of audio file.
> > > But the same file when I transferred between  2 machines having ubuntu
> > > 18.04 the speed is significantly reduced.
> > >
> > > Kernel : 4.18.0-15-generic
> > > OS : ubuntu 18.04.2 LTS
> > > Bluez -5.48
> > >
> > > Could someone tell me why its reduced in ubuntu 18.04
> >
> > I don't think we change anything on Obexd related to that so perhaps
> > it is something related to the L2CAP MTU? We could try setting the MTU
> > to 0 so it automatically picks the matching MTU if you do have the
> > following patch applied to your kernel:
> >
> > Bluetooth: Auto tune if input MTU is set to 0
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
