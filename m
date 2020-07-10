Return-Path: <SRS0=rPFF=AV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 19:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C76206A1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jul 2020 19:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGJTAn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:00:43 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38861 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJTAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jul 2020 15:00:41 -0400
Received: from classic (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 91AED200003;
        Fri, 10 Jul 2020 19:00:35 +0000 (UTC)
Message-ID: <3f9aeb5d7aa896770946a8c04bd8483e9d7ba4f3.camel@hadess.net>
Subject: Re: Temporary device removal during discovery
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Andrey Batyiev <batyiev@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date:   Fri, 10 Jul 2020 21:00:35 +0200
In-Reply-To: <CABBYNZ+y9UTv1yakyB3Z+1oa+B4dw5TmSiuhCmWQCq88sXpXgw@mail.gmail.com>
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
         <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
         <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
         <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com>
         <CAEQQxWwzzZoFiGQg7minJU6pLRY=B5-yLSOun+xksZHUAEWgRA@mail.gmail.com>
         <ddb9a0761e52a2e70e1c0dcc6fcefca02937dda6.camel@hadess.net>
         <CABBYNZ+y9UTv1yakyB3Z+1oa+B4dw5TmSiuhCmWQCq88sXpXgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 2020-07-10 at 11:06 -0700, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, Jul 9, 2020 at 1:26 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Thu, 2020-07-09 at 01:57 +0300, Andrey Batyiev wrote:
> > > Hi Luiz,
> > > 
> > > On Thu, Jul 9, 2020 at 12:14 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > > The delta logic might be a nice addition as a separate patch,
> > > > it is
> > > > more for detecting devices disappearing then actually cleanup
> > > > during
> > > > power off.
> > > No-no, it's not about adapter powering off.
> > > 
> > > I meant that (external) devices never disappear from the bluez
> > > device
> > > list during the discovery,
> > > even if the (external) devices are turned off (i.e. they should
> > > be
> > > purged by bluez).
> > > 
> > > So:
> > > - bluez is central
> > > - bluez is discovering
> > > - peripheral appear for a moment, than disappear (i.e. peripheral
> > > would be turned off)
> > > - bluez would not remove device from the list (at least until
> > > discovery is stopped)
> > > 
> > > Use case:
> > > - bluez is monitoring environment (discovering literally forever)
> > > - peripherals are brought in and out of bluez visibility range
> > > - bluez list of visible devices grows infinitely and causes
> > > problems
> > > (hundreds of devices)
> > 
> > I'd also expect devices that are recently discovered to disappear
> > if
> > they haven't replied to a discovery in 30 seconds. It would stop
> > GNOME's Bluetooth Settings's Bluetooth list forever expanding.
> > 
> > Or we need to give the ability for front-ends to do that by
> > exporting
> > the "last seen" dates.
> 
> I am fine with that as well, 30 seconds doesn't sound too bad even
> for
> cleanup temporary devices as the current 3 minutes seems awful long
> sometimes, we could perhaps have a filter for configuring that though
> so if the application wants to have its own timeout, the only problem
> is if there are multiple application doing that on parallel we would
> need a strategy on how to handle that.

In which case it might be easier to export that last seen date,
otherwise that's just a lot of moving parts inside bluetoothd when we
could filter it trivially in the front-ends.

