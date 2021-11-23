Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 08:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhKWI5T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:57:19 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:46785 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhKWI5R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 03:57:17 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5A46CD308C
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 08:49:13 +0000 (UTC)
Received: (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 8BC67C0007;
        Tue, 23 Nov 2021 08:48:51 +0000 (UTC)
Message-ID: <189034533844f15d220ece574427956c42a4b16e.camel@hadess.net>
Subject: Re: [PATCH v2] uhid: Remove local copy of uhid header
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 23 Nov 2021 09:48:50 +0100
In-Reply-To: <CABBYNZJgpB8Y9gc92BupiBBkjyPf5SNkOBpp6B1qtYktxmAb_g@mail.gmail.com>
References: <20211122211707.2219208-1-luiz.dentz@gmail.com>
         <45caaa82b56528fed03e534103f55f2ebbdc3885.camel@hadess.net>
         <CABBYNZJgpB8Y9gc92BupiBBkjyPf5SNkOBpp6B1qtYktxmAb_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2021-11-22 at 15:46 -0800, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Mon, Nov 22, 2021 at 3:06 PM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Mon, 2021-11-22 at 13:17 -0800, Luiz Augusto von Dentz wrote:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > 
> > > uhid.h is part of kernel uapi nowadays so it can be included
> > > directly from linux/uhid.h so this removes the local copy to use
> > > it
> > > instead.
> > 
> > This will cause the same problems that importing those headers into
> > the
> > repository was supposed to solve. If you remove those headers, then
> > older distributions will be stuck on old kernel headers, and bluez
> > compilations will regularly fail when it uses new structs, struct
> > members, functions, or constants that are in the upstream uapi
> > headers
> > but not yet propagated to the user's distribution.
> 
> I'm not following you on this, the distros don't have uapi headers
> that match their kernel release? Afaik being a kernel uapi means
> these
> APIs are considered stable and I suspect they haven't been changed in
> a while, you are right that this introduces a kernel dependency if we
> were to use new members but I still think this is better than having
> copies that at some point goes out of sync, specially when nothing
> indicates that things like input_event was not accepted by the
> kernel.

Let's say you want to use a KEY_* definition that was recently added to
the kernel, what would you do?

> > Strong NAK on this one and the uinput header change too.
> 
> I didn't introduce the usage of any new symbols, so the only new
> requirement is that linux/uinput.h and linux/uhid.h headers exist, I
> could however rollback if we have another way to check if those
> headers exists use then otherwise we can keep using copies, perhaps
> move then under linux/ directory, anyway it is not like we don't have
> kernel dependencies already and we actually have been debating on
> having the bluetooth socket definitions as part of the uapi instead
> of
> libbluetooth, so we will need to sort out how we can update the
> userspace parts with new kernel interface without breaking the build
> on systems that don't actually ship with e.g. linux/bluetooth.h.

You're talking about the state of things now, I'm talking about the
compilation failures once you rely on a slightly newer header that
isn't shipped with a distribution.

But if you're willing to react to the compilation failure in the
future, I can't really stand in your way. It just seems weird to do
this now just to undo it the moment you'll need a slightly newer kernel
header.

Cheers
