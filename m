Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Jan 2011 18:34:29 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
Message-ID: <20110124213429.GA15121@piper>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
 <20101203220534.GA16709@eris>
 <1295895817.2656.26.camel@ubuntuLab1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295895817.2656.26.camel@ubuntuLab1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 11:03 Mon 24 Jan, Brian Gix wrote:
> Hi Vinicius,
> 
> I am sorry that it has taken so long to test the snapshot that you
> placed on gitorious, but I have now done so.
> 
> On Fri, 2010-12-03 at 19:05 -0300, Vinicius Costa Gomes wrote:
> > Hi Brian,
> > 
> > On 11:11 Fri 03 Dec, Brian Gix wrote:
> > > 
> > > Hi Claudio, Johan & All,
> > > 
> > > Is this LE capable kernel that Ville is working on, the development stream
> > > for the LE Security Manager?  And if so, is it in a partial fleshed out
> > > state?
> > 
> > There is a simple implementation of SMP here[1] on my "devel" branch. I am 
> > cleaning it up for sending it for review.
> > 
> > If you want to help, have any comments or just want to tell us what you are
> > working on, please drop by #bluez on freenode, or send an email.
> 
> I have been able to verify that the Just Works negotiation of the Short
> Term Key does work against an independent implementation of the LE
> Security Manager, as long as I have requested no MITM protection.  I
> have the following comments:
> 
> 1. You currently reject security if I *do* request MITM protection.
> This should not be done.  The correct functionality should be to
> continue the negotiation.  Even though I requested MITM, it will be
> clear to both sides that JUST_WORKS methodology has been used, and so
> when the Keys are generated and exchanged, both sides will indicate in
> their Key Database that they are no-MITM keys. If I then actually
> *needed* MITM protection, then whatever functionality requiring that
> level of security will fail with an insufficient security error code.
> However, security should *never* be rejected unless there is a
> fundamental incompatibility such as no level of security actually
> supported.  This is the only functionality that I found to be actually
> incorrect.
> 

I was assuming that the meaning of setting the MITM protection bit, was that 
it was *requiring* MITM protection, and when that couldn't be fulfilled the
Pairing Request should be rejected.

So my assumption was incorrect, going to fix it soon.

> 2. Currently, you are not exchanging any permanent keys, which I am sure
> you are aware.  This makes it impossible to test much else, such as
> command signing, or security requests that use the generated keys.
> 

This is being worked on, but nothing ready for testing yet.

> If you have a later version of SM that could be uploaded to your devel
> branch on gitorious, I would be more than happy (and in fact would love
> to be able) to test that for you as well.
> 
> This is the git configuration I used for testing, which only has your SM
> up to the end of last December, and is so about a month old:
> 
> remote.origin.url=git://gitorious.org/bluetooth-next/bluetooth-next.git
> branch.devel.remote=origin
> branch.devel.merge=refs/heads/devel
> 
> 
> Thanks for doing the SM,
> 
> -- 
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 


Cheers,
-- 
Vinicius
