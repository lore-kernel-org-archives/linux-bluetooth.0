Return-Path: <cyrus@holtmann.org>
Date: Sun, 16 May 2010 23:39:17 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: john michelle <jhnmichelle@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Software caused connection abort (103 )
Message-ID: <20100517023917.GI23754@vigoh>
References: <w2ra6ca4e821005071241w9d7d982ezb78ad0ba4480e73d@mail.gmail.com>
 <s2oa6ca4e821005071249tdfd2e197i2595b57ae2ccb705@mail.gmail.com>
 <20100507195325.GB4857@vigoh>
 <AANLkTilSynGNcpdq8h5YJQVD8e5MMyUDq55WzsB05AA2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTilSynGNcpdq8h5YJQVD8e5MMyUDq55WzsB05AA2@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonh,

First of all, don't do top posting in this mailing list. ;)

* john michelle <jhnmichelle@gmail.com> [2010-05-13 17:39:29 -0400]:

> Hi Gustavo,
> 
> Any update on the software caused connection abort issue, it's happenning more
> And more making bluez unstable for our application

In which bluez/kernel version the problem started? Any hardware update
during this time? The problem happens when you are already tranfering
SCO data?

Please post the output of hcidump when the connection abort happens.

I tried reproduce this issue in L2CAP but it is a bit hard, lets
say it happen once in a thousand, so it's not easy to track it. I have
to try reproduce that using the SCO, but I'm not used to that layer yet.
;)

Regards,

> 
> John
> 
> On Fri, May 7, 2010 at 3:53 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> > * john michelle <jhnmichelle@gmail.com> [2010-05-07 15:49:05 -0400]:
> >
> >> Hi Bluetooth hackers,
> >>
> >> i am having this consistent problem with bluez , from time to time i
> >> get the error Software caused connection abort (103 )
> >> And the bluetooth stick seems to disconnect and reconnects. this
> >> happens during an sco connection and it occurs even
> >> More when i am having the voice stream comming through the internet
> >> rather than the lan.i don't know what exact
> >> Details you need to solve this problem please tell me and i will give
> >> you an immediate reply . i have linux kernel 2.6.33 and bluez 4.62
> >
> > I get the same problem sometimes when testing ERTM with l2test. So the
> > problem is on l2cap too. I didn't have time to debug this yet. Now that
> > someone else have confirmed it too, I'll to take a look at the problem.
> >
> >>

-- 
Gustavo F. Padovan
http://padovan.org
