Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API(0.5)
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Elvis =?ISO-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>,
	=?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
	jcaden@libresoft.es, linux-bluetooth@vger.kernel.org
In-Reply-To: <20100517232056.GC19907@vigoh>
References: <201005171654.36923.jcaden@libresoft.es>
	 <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com>
	 <20100517213838.GB19907@vigoh>
	 <DCEDCB0F-6BA3-4100-96F9-0A33AC440F82@signove.com>
	 <20100517232056.GC19907@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 18 May 2010 11:28:40 +0200
Message-ID: <1274174920.2001.27.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Gustavo,

> 
> MCAP in kernel gives zero-copy communication and just one socket to the
> HDP API. The better of both UNIX socket and pipes options.
>  

That's right I agree with you, but the main question here is not based
in hiding MCAP reconnection, because future profiles using MCAP may be
concern about above reconnection. Please, remember that nothing about
hiding reconnections are mentioned in MCAP specification. However,
reconnection are exposed as deseable capability in MCAP that upper
profiles can use.

In other hands, in particular case of HDP, we want to hide reconnection
process to application layer because ISO/IEEE11073-20601 is transport
agnostic, that means for example, a manager or agent sending or
receiving APDUs don't be concern about such issues in transpiort layer
(neither MCAP nor HDP). As you can see, the problem isn't in MCAP but in
HDP<-->App to achieve reconnection transparency. That's is better
explained in ISO/IEEE11073-20601 and some references can be found in HDP
white paper.


> > That semantics would be implemented in MCAP part. The HDP profile code itself is (or should be) free from these worries.
> > 
> > Moving MCAP to kernel hides the complexity from userspace HDP profile, but it continues to exist. Then I worry about more complex debugging, dependency on kernel version (or need to put efforts on backporting). MCAP sits above L2CAP, not besides it.
> 
> The complexity will exist anyway, I'm proposing a less complex option.
> Is not that complex change the L2CAP channels used by the MCL inside the
> kernel. Between all the proposed options to handle reconnection it
> looks the less complex one.
> 
> We should not care about backporting now. We are working directly
> with upstream and upstream is what really matters here. :)
> 
> You will depend on kernel version anyway since ERTM is inside the
> kernel. About backport if you backport ERTM, then backport MCAP will be
> easy.
> 
> Also MCAP will keep sitting on top of L2CAP, that won't change.
> 
> > 
> > I acknowledge that it would work, but honestly I prefer to see things being moved to the outside of the kernel than to the inside :)
> 
> The real question here is where MCAP will fit better. And where it adds
> less complexity to its users.

>>From my point of view we should avoid implement MCAP in kernel space 
for the same reason exposed by Jose Antonio and Elvis in other emails.
IMHO hidding reconnections in MCAP is not an good reason to implement it
in kernel space because transparency is required in HDP nor in MCAP.

If you hide reconnection to upper profiles in MCAP, you are closing the
door to future specifications if they require doing aditional precessing
when a reconnection takes place in MCAP.

Thanks for your comments.

Regards,

