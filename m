Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D15C282E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 11:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824EA214AE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 11:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfDYLJB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:09:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40456 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDYLJB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 07:09:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so12724794qka.7;
        Thu, 25 Apr 2019 04:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+9b+va5qRp1P2e6+CDCSoTfNbUEAY+YmGN5WIBQ1fRQ=;
        b=GqoZicgzAvMNMoHR7/kPrAGBvEm3IrB8xISeAeEflqcVDOItuAClT6lcnA8bo7vGTl
         nEtmdTNQ2ZS+Qwlq9xaHMKgM/+R0CSm8AZVwxbtmcCyGgQXqJ1WW+lV3PGM87r3YyJtJ
         bwMpytS1NVNVR6YdACGtrtweNF4FiLBAKEvHfl4SzIAG/6XnwVGC3YnsWdYhIjGn3bm1
         iW7eZjQGs6JCNZNxvLdplv8zcEBolAKQGGU/D15dNvUIOyfE4XpDnl4dI6gGsr4X5lmX
         WFBOtcH+1iLg5p4oA+tbaFJ/Lg+NZmbExcZQB5fL64tLHp4v0gC6ziHylTdzY8W/oPXF
         uUYA==
X-Gm-Message-State: APjAAAV+EjaRMtgmcJMY/qPoNp7L0sMHQInm0yeBF7CFLhuoNtkgIjl7
        OZRKPwmur+/XGbmIr9arK1k2x2gZOT4k1MUnOBk=
X-Google-Smtp-Source: APXvYqw0CZPiWFZ8gKf2hZAEH/N9HtP/XH7SGT2VExRdj+QhBmct/tWWYd2du+xIsH9Oupi7jM9tAN4Jt+JqIcpG9Ok=
X-Received: by 2002:a37:49ce:: with SMTP id w197mr20415796qka.330.1556190540273;
 Thu, 25 Apr 2019 04:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190423151143.464992-1-arnd@arndb.de> <20190423.193735.412590692063607790.davem@davemloft.net>
 <CAK8P3a1ViEZmK-+rpYgpFkJHs+7XoNCTuK1iHcgSrZXaOJedLQ@mail.gmail.com>
 <FBF10E1F-2D3D-4FFC-8F8C-5969A2F2A475@holtmann.org> <CAK8P3a2FLrGXh9iv4eWBX8D_zb7rq5YDErkzDjjHbA5JENHVGw@mail.gmail.com>
 <D5B4825C-88DE-4011-8C2C-141214486861@holtmann.org>
In-Reply-To: <D5B4825C-88DE-4011-8C2C-141214486861@holtmann.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Apr 2019 13:08:41 +0200
Message-ID: <CAK8P3a2bZpnv+NGQxiA3t_LB8e+so4Nkab5kuTcGjgn8i+f=BA@mail.gmail.com>
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Networking <netdev@vger.kernel.org>,
        isdn4linux@listserv.isdn4linux.de, Paul Bolle <pebolle@tiscali.nl>,
        Holger Schurig <holgerschurig@googlemail.com>,
        Tilman Schmidt <tilman@imap.cc>,
        Al Viro <viro@zeniv.linux.org.uk>,
        gigaset307x-common@lists.sourceforge.net,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 24, 2019 at 4:30 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arnd,
>
> >>>>> When isdn4linux came up in the context of another patch series, I
> >>>>> remembered that we had discussed removing it a while ago.
> >>
> >> NAK.
> >>
> >> I do not care about isdn4linux, but this is a purely CAPI based driver. So removing (or moving to staging)
> >> CAPI support seems rather premature.
> >>
> >> Maybe someone would have started talking to us before trying to move this into staging. It is a
> >> maintained driver. That it is rather simple and hasn’t seen patches in a long time, doesn’t mean
> >> it is not maintained and staging material. I see no reason to tell any user to enable staging tree
> >> to get CMTP support.
> >
> > I can definitely leave out the last patch from the series if we know
> > that there are
> > still users on CMTP. I searched around for a bit but could not find
> > any indication
> > what this is still used for, if anything.
>
> I would prefer if we leave CAPI support and with that CMTP mainstream and not move
> that to staging. For isdn4linux, I have no objections to move that to staging since
> mISDN was suppose to replace it anyway.

Sure, I can rework the patch to leave the CAPI subsystem and only move the
other three drivers (avm, hysdn, gigaset) into staging to see if
anyone uses them.

> > What I found were a couple of references of the driver no longer working
> > about 10 years ago:
> >
> > https://wiki.ubuntuusers.de/Archiv/Bluetooth/BlueFritz%21/
> > https://www.opensuse-forum.de/thread/2776-erledigt-suse-11-2-und-bluefritz/
> >
> > Is anyone using cmtp for voice or fax services? The use cases from before 2009
> > that I could find were usually dial-up networking, but that seems pointless now
> > if the only way to get an ISDN connection is to have it routed over
> > the internet.
>
> I still have the hardware and last time I checked it worked just fine. However
> you need to set up a proper pairing with the hardware. However that has nothing
> to do with CMTP since that is just a CAPI message transport protocol.
>
> You can use it for voice and fax service as long as you have the right codecs in
> place. At the end of the day CAPI is an API for ISDN. And CMTP just being a
> transport, all ISDN services are possible given the right software / application.

That does not answer my question. It's clear that you can do all those things
with CAPI and CMTP, but what I was trying to find out is whether anyone still
does.

The gigaset driver is similar here, you can use it for any kind of wireless ISDN
communication, but apparently there is little use for that without a physical
ISDN connection.

      Arnd
