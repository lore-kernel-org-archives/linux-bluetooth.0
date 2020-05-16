Return-Path: <SRS0=p+wm=66=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFAFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ADB2075F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 07:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589615624;
	bh=w/eVMhe7gI1UD2s3GDWka1wQNF2N7YmaR7vyERqFhrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XEJjTvniHzN/jNqqeyfL9qh9NVjaDV+5SNh83ESRIxUTd3+pYVE4uk4j8iA9vEUfV
	 hw6Qd76Mp+w38kPjDUgENJC5n46H/6pSnkXpljINQwYZyl/QRHjfciIYujGDZNFhKm
	 0F+xJdjZYt8CRa9P/eSGZsEb4yL1qZX7y+XyWWiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgEPHxo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 May 2020 03:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgEPHxn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 May 2020 03:53:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DD820709;
        Sat, 16 May 2020 07:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589615623;
        bh=w/eVMhe7gI1UD2s3GDWka1wQNF2N7YmaR7vyERqFhrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5sDZWHl7UaU4LsuOrW1DpsB0p+sxfXVAQlEudX5bSqWWy4W/0OwVotjXhB2CHJ70
         C8lFF5Bk/9iBpVwdcWEboXZ8WYnISR2O2z1j0zN4tj6ePn2EiPYMrOGWN9012t0D1t
         7NXk8Uq2U/PuArmPC2b/yGXLGGqShPX+6JZ5y0hg=
Received: by pali.im (Postfix)
        id 070C69FC; Sat, 16 May 2020 09:53:40 +0200 (CEST)
Date:   Sat, 16 May 2020 09:53:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Andrew Fuller <mactalla.obair@gmail.com>,
        Aleksandar Kostadinov <akostadi@redhat.com>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
Message-ID: <20200516075340.3z37ejs3fuhctunl@pali>
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz>
 <20200419234937.4zozkqgpt557m3o6@pali>
 <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
 <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
 <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 15 May 2020 16:08:45 Luiz Augusto von Dentz wrote:
> Hi Andrew, Aleksandar,
> 
> On Fri, May 15, 2020 at 3:46 PM Andrew Fuller <mactalla.obair@gmail.com> wrote:
> >
> > On Thu, 14 May 2020 at 13:09, Aleksandar Kostadinov <akostadi@redhat.com> wrote:
> > >
> > > Pali Rohár wrote on 20.04.20 г. 2:49 ч.:
> > > <...>
> > > > Please let me know what do you think about it. Thanks
> > >
> > > <...>
> > > Thus I and I assume all headphones users will appreciate very much any
> > > support to get things moving forward.
> >
> > To add to what Aleksandar said, a number of us would be more than
> > willing to help out in any way we can.  Certainly myself, but I expect
> > a number of others, too.  We have bluetooth cards in our computers
> > with wideband speech support.  We have bluetooth headsets with
> > wideband speech support.  Many of the links in the chain are in place.
> > If we can continue building that chain then we can have a higher
> > quality experience in this era of teleconferencing in particular.
> >
> > So if there's anything we can lend a hand with, then please let us
> > know and we can see this through.
> 
> Just to be clear here, WBS is already supported what is not supported
> is hardware based codecs,

Luiz, this is not truth. What is not supported are also custom
parameters and custom codecs; including hardware mSBC support.

Last year I started this thread because kernel blocks usage of
AuriStream codec in any form (software or hardware).

And AuriStream is supported by many bluetooth headsets and should have
better quality than CVSD codec.

> we spend a lot of time enabling WBS on oFono
> but it looks like people are now trying to come with their own
> solutions and complaining about lack of WBS is not really justified
> since the combination of BlueZ + oFono has been in use by the car
> industry for years but desktop folks has not been interested in a
> proper HFP solution so instead we have modem manager, network manager,
> etc, which doesn't even cover all desktop use cases properly as you
> are experience first hand here.

Apparently all people who are periodically writing me private emails are
not interested in car industry, but are ordinary desktop / laptop users
and ofono is not ready for these use cases and are not going to fix it.
I guess that Aleksander and Andrew too are desktop / laptop users and
not from car industry.
