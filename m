Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A01C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 07:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CF561544
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 07:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhKQH2N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232674AbhKQH2N (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 02:28:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 699D063215;
        Wed, 17 Nov 2021 07:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637133914;
        bh=Tz8Q0T4hS7DypzRr8M0WEK+KGrSDlGMLdT3MX7wDdps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwjMyLOPhedKBqTHsrXmY+skZd9VGyLwpGKyBvAsu6jOGJ+1ulq+768f5BBUOHZ5T
         S1BlnANV7zZ5xIFzeZ/tECf7I6YkXBaTG6iiAqSa5u+x3Zy7MtyIUHzkMx/HAQHFr1
         587LY3q8lmShZzILcz/4GzPG4xxhLX3C6LFVUYJ8=
Date:   Wed, 17 Nov 2021 08:25:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Message-ID: <YZSuWHB6YCtGclLs@kroah.com>
References: <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com>
 <YYZr14zwHnd52rQ7@kroah.com>
 <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com>
 <YYePw07y2DzEPSBR@kroah.com>
 <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
 <20211116090128.17546-1-redecorating@protonmail.com>
 <e75bf933-9b93-89d2-d73f-f85af65093c8@leemhuis.info>
 <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B8E16FA-97BF-40E5-9149-BBC3E2A245FE@live.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 17, 2021 at 03:28:29AM +0000, Aditya Garg wrote:
> 
> 
> > On 16-Nov-2021, at 2:56 PM, Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> > 
> > On 16.11.21 10:02, Orlando Chamberlain wrote:
> >>> Bluetooth maintainers, what's the status here? The proposed patch is
> >>> fixing a regression. It's not a recent one (it afaics was introduced in
> >>> v5.11-rc1). Nevertheless it would be good to get this finally resolved.
> >>> But this thread seems inactive for more than a week now. Or was progress
> >>> made, but is only visible somewhere else?
> >> 
> >> I think the best solution is getting broadcom to update their firmware,
> >> I've just sent them a message through a form on their website, I couldn't
> >> seem to get it to tell me "Your message has been sent", so it's possible
> >> that it didn't submit (more likely I've sent the same message several times).
> >> 
> >> If I hear back from them I'll send something here.
> > 
> > Thx for that. But FWIW: from the point of the regression tracker that's
> > not the best solution, as according to your report this is a regression.
> > IOW: we deal with something that used to up to a certain kernel version
> > and was broken by a change to the kernel. That is something frown upon
> > in Linux kernel development, hence changes introducing regression are
> > often quickly reverted, if they can't get fixed by follow up change quickly.
> > 
> > That sentence has two "quickly", as we want to prevent more people
> > running into the issue, resulting in a loss of trust. But that's what
> > will happen if we wait for a firmware update to get developed, tested,
> > published, and rolled out. And even then we can't expect users to have
> > the latest firmware installed when they switch to a new kernel.
> > 
> > Hence the best solution *afaics* might be: fix this in the kernel
> > somehow now with a workaround; once the firmware update is out, change
> > the kernel again to only apply the workaround if the old firmware is in use.
> I have an idea. Can we make LE Read Transmit Power as a module parameter and users can turn it off if it is causing trouble. I have a patch for the same but haven't tested it yet.

Module parameters are for the 1990's, please never add new ones as they
modify code, not data, and you want to do something like this on a
per-device basis, not on "all devices in the system", right?

thanks,

greg k-h
