Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 May 2010 23:54:58 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
	jcaden@libresoft.es, linux-bluetooth@vger.kernel.org
Subject: Re: HDP proposed API(0.5)
Message-ID: <20100523025458.GA26856@vigoh>
References: <201005171654.36923.jcaden@libresoft.es>
 <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com>
 <20100517213838.GB19907@vigoh>
 <DCEDCB0F-6BA3-4100-96F9-0A33AC440F82@signove.com>
 <20100517232056.GC19907@vigoh>
 <1274174920.2001.27.camel@mosquito>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274174920.2001.27.camel@mosquito>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

Sorry for the delay on the reply.

* Santiago Carot-Nemesio <scarot@libresoft.es> [2010-05-18 11:28:40 +0200]:

> Hello Gustavo,
> 
> > 
> > MCAP in kernel gives zero-copy communication and just one socket to the
> > HDP API. The better of both UNIX socket and pipes options.
> >  
> 
> That's right I agree with you, but the main question here is not based
> in hiding MCAP reconnection, because future profiles using MCAP may be
> concern about above reconnection. Please, remember that nothing about
> hiding reconnections are mentioned in MCAP specification. However,
> reconnection are exposed as deseable capability in MCAP that upper
> profiles can use.
> 
> In other hands, in particular case of HDP, we want to hide reconnection
> process to application layer because ISO/IEEE11073-20601 is transport
> agnostic, that means for example, a manager or agent sending or
> receiving APDUs don't be concern about such issues in transpiort layer
> (neither MCAP nor HDP). As you can see, the problem isn't in MCAP but in
> HDP<-->App to achieve reconnection transparency. That's is better
> explained in ISO/IEEE11073-20601 and some references can be found in HDP
> white paper.

Exactly. I'm not trying to make reconnection transparent at MCAP level.
What I said is that we can achieve reconnection transparency on the
HDP <--> App level doing MCAP in kernel.

I'm not saying that MCAP should be in kernel, I'm just trying to address
advantages and disadvantages of both implementation.

> 
> 
> > > That semantics would be implemented in MCAP part. The HDP profile code itself is (or should be) free from these worries.
> > > 
> > > Moving MCAP to kernel hides the complexity from userspace HDP profile, but it continues to exist. Then I worry about more complex debugging, dependency on kernel version (or need to put efforts on backporting). MCAP sits above L2CAP, not besides it.
> > 
> > The complexity will exist anyway, I'm proposing a less complex option.
> > Is not that complex change the L2CAP channels used by the MCL inside the
> > kernel. Between all the proposed options to handle reconnection it
> > looks the less complex one.
> > 
> > We should not care about backporting now. We are working directly
> > with upstream and upstream is what really matters here. :)
> > 
> > You will depend on kernel version anyway since ERTM is inside the
> > kernel. About backport if you backport ERTM, then backport MCAP will be
> > easy.
> > 
> > Also MCAP will keep sitting on top of L2CAP, that won't change.
> > 
> > > 
> > > I acknowledge that it would work, but honestly I prefer to see things being moved to the outside of the kernel than to the inside :)
> > 
> > The real question here is where MCAP will fit better. And where it adds
> > less complexity to its users.
> 
> >From my point of view we should avoid implement MCAP in kernel space 
> for the same reason exposed by Jose Antonio and Elvis in other emails.
> IMHO hidding reconnections in MCAP is not an good reason to implement it
> in kernel space because transparency is required in HDP nor in MCAP.
> 
> If you hide reconnection to upper profiles in MCAP, you are closing the
> door to future specifications if they require doing aditional precessing
> when a reconnection takes place in MCAP.
> 
> Thanks for your comments.
> 
> Regards,
> 

-- 
Gustavo F. Padovan
http://padovan.org
