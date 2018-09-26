Return-Path: <SRS0=Mlcw=MI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9AC43382
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 18:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892BB2152F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Sep 2018 18:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892BB2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeI0AlN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:41:13 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47864 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeI0AlN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Sep 2018 20:41:13 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 4E1743A8397
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Sep 2018 20:02:57 +0200 (CEST)
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2A967FF803;
        Wed, 26 Sep 2018 18:02:54 +0000 (UTC)
Message-ID: <75590dbdffee5870537a344209af185cdda5de30.camel@hadess.net>
Subject: Re: AW: hid: microsoft: Add rumble support for Xbox One S controller
From:   Bastien Nocera <hadess@hadess.net>
To:     dollinger.florian@gmx.de, andrew.smirnov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-input@vger.kernel.org
Date:   Wed, 26 Sep 2018 20:02:53 +0200
In-Reply-To: <003401d455ab$c6df5280$549df780$@gmx.de>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
                 <20180926125130.974-1-dollinger.florian@gmx.de>
         <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
         <003401d455ab$c6df5280$549df780$@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2018-09-26 at 17:15 +0200, dollinger.florian@gmx.de wrote:
> Hey Bastien,
> 
> > Probably because he didn't know about it, and how would he?
> 
> Hum, it's the first hit when you search for something like 'xbox one
> s driver linux' since half an year or longer 😊

Sure it is, but:
- it's not an "XBox One S controller", it's a variant of the "XBox One
controller" shipped with the XBox One S.
- we discussed this on the linux-bluetooth mailing-list in August 2016:
  https://www.spinics.net/lists/linux-bluetooth/msg68102.html
  revived the thread in 2017:
  https://www.spinics.net/lists/linux-bluetooth/msg72750.html
  and discussed the force feedback in particular in August this year:
  https://www.spinics.net/lists/linux-input/msg57744.html
- why would we look for a "driver" when there's already one in the
kernel that supports all the xbox controllers except this one? :)

Really, as much as it's nice to find working code for this device, it's
surprising you didn't contact any kernel developer before, rather than
us having to find you.

> > I can imagine that a large portion of the driver can be integrated
> > in the existing XBox pad driver, with each feature added in
> > individual patches.
> 
> Would be great! But ist the xpad driver really the right place?
> 
> First of all, the BT interface is using HID, USB does not.
> Furthermore, the driver is currently around 1,3k lines long - for a
> single device and only BT... (okay yes, there are a lot of comments
> in it).
> But anyway, is it really a good idea to put everything into hid-
> microsoft?
> Moreover, there is another interface which I am trying to support at
> the moment - the one which is used by the XBOX (WiFi).
> 
> I think in the end the whole hid-microsoft thingy will get blown-up a
> bit - right?
> Or, everything is scattered over many places (hid-microsoft, xpad,
> another driver fort he wifi-interface).
> 
> Isn't it possible to use "one driver per device" in the kernel too,
> like I did?

Yes, but that's not the way the drivers are usually arranged. They're
arranged by vendors, so this driver would need to be merged into the
"hid-microsoft.c" driver.

I'm pretty sure that the USB version can also be made to use HID.

I have no idea how the RF protocol would work though. I imagine it
requires a dongle, or does it actually use Wi-Fi? (that would be
surprising...).

Anyway, I don't have much time to work on it right this minute, but it
would be great if you could send your Bluetooth patch to start with,
and we can iterate on that, and fix the other problems as we clear the
priority list.

Cheers

