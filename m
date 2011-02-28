Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Feb 2011 14:40:06 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [bluetooth-next 04/15] Bluetooth: Add support for using the
 crypto subsystem
Message-ID: <20110228174006.GA2460@piper>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
 <02fa778ab4292dffba1330e829b0d4029517a21e.1298307667.git.vinicius.gomes@openbossa.org>
 <20110227202041.GG2166@joana>
 <AANLkTi=j3REcNM4bXfFJPamPwqazS5k4eGAJf3BpB_Ya@mail.gmail.com>
 <20110228172801.GB2165@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110228172801.GB2165@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 14:28 Mon 28 Feb, Gustavo F. Padovan wrote:
> Hi Vinicius,
> 
> * Vinicius Gomes <vinicius.gomes@openbossa.org> [2011-02-27 21:49:39 -0300]:
> 

[ ... ]

> > 
> > I have a couple of points against it:
> > 
> > 1. it's only used for one purpose, it says whether to try or not to
> > allocate the block cypher, which is done during the adapter
> > registration;
> > 
> > 2. If the current way is ok, it would mean that I would need to export
> > another method from smp.c, that was something that I tried to
> > minimize;
> > 
> > 3. and my weakest argument, seems that there are other similar uses,
> > for example enable_mgmt.
> 
> A similar example here is enable_ertm inside l2cap_core.c. It's a L2CAP
> related option and should reside inside L2CAP code.
> 
> > 
> > But if you think the code will be clearer moving that to smp.c, will
> > be glad to change.
> 
> I don't see the point on have it on hci code. SMP and Block cypher has
> not much to do with HCI. I prefer it on smp.c

Fair enough. Will change.

> 
> -- 
> Gustavo F. Padovan
> http://profusion.mobi


Cheers,
-- 
Vinicius
