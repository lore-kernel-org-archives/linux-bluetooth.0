Return-Path: <SRS0=Tr5+=S2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D02C10F11
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 10:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A672175B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Apr 2019 10:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfDXKYo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:24:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44739 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDXKYo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Apr 2019 06:24:44 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id D4A05CF350;
        Wed, 24 Apr 2019 12:32:52 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAK8P3a1ViEZmK-+rpYgpFkJHs+7XoNCTuK1iHcgSrZXaOJedLQ@mail.gmail.com>
Date:   Wed, 24 Apr 2019 12:24:41 +0200
Cc:     "David S. Miller" <davem@davemloft.net>,
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
Message-Id: <FBF10E1F-2D3D-4FFC-8F8C-5969A2F2A475@holtmann.org>
References: <20190423151143.464992-1-arnd@arndb.de>
 <20190423.193735.412590692063607790.davem@davemloft.net>
 <CAK8P3a1ViEZmK-+rpYgpFkJHs+7XoNCTuK1iHcgSrZXaOJedLQ@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arnd,

>>> When isdn4linux came up in the context of another patch series, I
>>> remembered that we had discussed removing it a while ago.
>> 
>> This seems long overdue to me.
>> 
>> Could you please respin against net-next and I'll just apply this?
> 
> Ok. I'll send a pull request then, which should make it easier to deal with
> the file removals, as I'm never sure whether 'git format-patch -D' patches
> make it across the list correctly, at least I had problems applying them
> in the past.
> 
> I added a few fixups as in the diff below in the meantime, to deal
> with build regressions from the last patch. In particular, the BT_CMTP
> (CIP) code also needs to be moved into staging along with the CAPI
> core. From what I can find, this was originally used for dial-up
> internet connections with 'Bluefritz' ISDN hardware, but it stopped
> working many years ago and is no longer useful with after the
> public network shutdown either.
> 
>     Arnd
> 
> 
> diff --git a/drivers/staging/isdn/Kconfig b/drivers/staging/isdn/Kconfig
> index 77e1b80af716..29d13fcd9e2b 100644
> --- a/drivers/staging/isdn/Kconfig
> +++ b/drivers/staging/isdn/Kconfig
> @@ -1,5 +1,6 @@
> menuconfig ISDN_CAPI
>  tristate "CAPI 2.0 subsystem"
> + depends on NET && NETDEVICES
>  help
>    This provides CAPI (the Common ISDN Application Programming
>    Interface) Version 2.0, a standard making it easy for programs to
> @@ -23,6 +24,7 @@ source "drivers/staging/isdn/gigaset/Kconfig"
> 
> source "drivers/staging/isdn/hysdn/Kconfig"
> 
> +source "drivers/staging/isdn/cmtp/Kconfig"
> 
> endif # ISDN_CAPI

NAK.

I do not care about isdn4linux, but this is a purely CAPI based driver. So removing (or moving to staging) CAPI support seems rather premature.

Maybe someone would have started talking to us before trying to move this into staging. It is a maintained driver. That it is rather simple and hasn’t seen patches in a long time, doesn’t mean it is not maintained and staging material. I see no reason to tell any user to enable staging tree to get CMTP support.

Regards

Marcel

