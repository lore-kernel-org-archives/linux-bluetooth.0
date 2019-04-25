Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77306C282E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 11:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C42217FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 11:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfDYLVC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:21:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45140 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDYLVC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 07:21:02 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7C4D4CEE14;
        Thu, 25 Apr 2019 13:29:11 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAK8P3a2bZpnv+NGQxiA3t_LB8e+so4Nkab5kuTcGjgn8i+f=BA@mail.gmail.com>
Date:   Thu, 25 Apr 2019 13:21:00 +0200
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
Content-Transfer-Encoding: 8BIT
Message-Id: <18657552-9507-448D-8C3C-7092B448DC8C@holtmann.org>
References: <20190423151143.464992-1-arnd@arndb.de>
 <20190423.193735.412590692063607790.davem@davemloft.net>
 <CAK8P3a1ViEZmK-+rpYgpFkJHs+7XoNCTuK1iHcgSrZXaOJedLQ@mail.gmail.com>
 <FBF10E1F-2D3D-4FFC-8F8C-5969A2F2A475@holtmann.org>
 <CAK8P3a2FLrGXh9iv4eWBX8D_zb7rq5YDErkzDjjHbA5JENHVGw@mail.gmail.com>
 <D5B4825C-88DE-4011-8C2C-141214486861@holtmann.org>
 <CAK8P3a2bZpnv+NGQxiA3t_LB8e+so4Nkab5kuTcGjgn8i+f=BA@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arnd,

>>>>>>> When isdn4linux came up in the context of another patch series, I
>>>>>>> remembered that we had discussed removing it a while ago.
>>>> 
>>>> NAK.
>>>> 
>>>> I do not care about isdn4linux, but this is a purely CAPI based driver. So removing (or moving to staging)
>>>> CAPI support seems rather premature.
>>>> 
>>>> Maybe someone would have started talking to us before trying to move this into staging. It is a
>>>> maintained driver. That it is rather simple and hasn’t seen patches in a long time, doesn’t mean
>>>> it is not maintained and staging material. I see no reason to tell any user to enable staging tree
>>>> to get CMTP support.
>>> 
>>> I can definitely leave out the last patch from the series if we know
>>> that there are
>>> still users on CMTP. I searched around for a bit but could not find
>>> any indication
>>> what this is still used for, if anything.
>> 
>> I would prefer if we leave CAPI support and with that CMTP mainstream and not move
>> that to staging. For isdn4linux, I have no objections to move that to staging since
>> mISDN was suppose to replace it anyway.
> 
> Sure, I can rework the patch to leave the CAPI subsystem and only move the
> other three drivers (avm, hysdn, gigaset) into staging to see if
> anyone uses them.

awesome. Thanks.

>>> What I found were a couple of references of the driver no longer working
>>> about 10 years ago:
>>> 
>>> https://wiki.ubuntuusers.de/Archiv/Bluetooth/BlueFritz%21/
>>> https://www.opensuse-forum.de/thread/2776-erledigt-suse-11-2-und-bluefritz/
>>> 
>>> Is anyone using cmtp for voice or fax services? The use cases from before 2009
>>> that I could find were usually dial-up networking, but that seems pointless now
>>> if the only way to get an ISDN connection is to have it routed over
>>> the internet.
>> 
>> I still have the hardware and last time I checked it worked just fine. However
>> you need to set up a proper pairing with the hardware. However that has nothing
>> to do with CMTP since that is just a CAPI message transport protocol.
>> 
>> You can use it for voice and fax service as long as you have the right codecs in
>> place. At the end of the day CAPI is an API for ISDN. And CMTP just being a
>> transport, all ISDN services are possible given the right software / application.
> 
> That does not answer my question. It's clear that you can do all those things
> with CAPI and CMTP, but what I was trying to find out is whether anyone still
> does.
> 
> The gigaset driver is similar here, you can use it for any kind of wireless ISDN
> communication, but apparently there is little use for that without a physical
> ISDN connection.

You need a ISDN line or a telephone system that speaks ISDN via S0 bus. Consumer ISDN lines are pretty much extinct in Germany due to the movement towards all IP based DSL lines. However there are S0 busses on the Fritz!Boxes and you can just hang the CMTP capable gateways on the S0 bus. At least that is how I have this at home. If you asked me for what other people are still doing, I have no idea.

Regards

Marcel

