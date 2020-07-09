Return-Path: <SRS0=bebH=AU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C609C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jul 2020 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00DC1206A1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jul 2020 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgGII0J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:26:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41779 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGII0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jul 2020 04:26:09 -0400
Received: from classic (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E4FFB24000E;
        Thu,  9 Jul 2020 08:26:06 +0000 (UTC)
Message-ID: <ddb9a0761e52a2e70e1c0dcc6fcefca02937dda6.camel@hadess.net>
Subject: Re: Temporary device removal during discovery
From:   Bastien Nocera <hadess@hadess.net>
To:     Andrey Batyiev <batyiev@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date:   Thu, 09 Jul 2020 10:26:06 +0200
In-Reply-To: <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com>
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
         <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
         <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
         <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com>
         <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2020-07-09 at 01:57 +0300, Andrey Batyiev wrote:
> Hi Luiz,
> 
> On Thu, Jul 9, 2020 at 12:14 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > The delta logic might be a nice addition as a separate patch, it is
> > more for detecting devices disappearing then actually cleanup
> > during
> > power off.
> No-no, it's not about adapter powering off.
> 
> I meant that (external) devices never disappear from the bluez device
> list during the discovery,
> even if the (external) devices are turned off (i.e. they should be
> purged by bluez).
> 
> So:
> - bluez is central
> - bluez is discovering
> - peripheral appear for a moment, than disappear (i.e. peripheral
> would be turned off)
> - bluez would not remove device from the list (at least until
> discovery is stopped)
> 
> Use case:
> - bluez is monitoring environment (discovering literally forever)
> - peripherals are brought in and out of bluez visibility range
> - bluez list of visible devices grows infinitely and causes problems
> (hundreds of devices)

I'd also expect devices that are recently discovered to disappear if
they haven't replied to a discovery in 30 seconds. It would stop
GNOME's Bluetooth Settings's Bluetooth list forever expanding.

Or we need to give the ability for front-ends to do that by exporting
the "last seen" dates.

Cheers

