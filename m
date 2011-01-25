Return-Path: <cyrus@holtmann.org>
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
From: Brian Gix <bgix@codeaurora.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20110125175922.GA16442@jh-x301>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
	 <20101203220534.GA16709@eris> <1295895817.2656.26.camel@ubuntuLab1>
	 <20110124213429.GA15121@piper>
	 <AANLkTi=uByqBUVKD8UYwt5ZByvHwu6WpapG=BtUrFkzE@mail.gmail.com>
	 <1295974727.2656.57.camel@ubuntuLab1>  <20110125175922.GA16442@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 Jan 2011 10:35:40 -0800
Message-ID: <1295980540.2656.85.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, 2011-01-25 at 19:59 +0200, Johan Hedberg wrote:
> Hi Brian,
> 
> On Tue, Jan 25, 2011, Brian Gix wrote:
> > >From Page 607:
> > "If both devices have out of band authentication data, then the
> > Authentication Requirements Flags shall be ignored when selecting the
> > pairing method and the Out of Band pairing method shall be used. If both
> > devices have not set the MITM option in the Authentication Requirements
> > Flags, then the IO capabilities shall be ignored and the Just Works
> > association model shall be used. Otherwise the IO capabilities of the
> > devices shall be used to determine the pairing method as defined in
> > Table 2.4."
> > 
> > In the test case I ran, only One device (i.e. NOT BOTH) had the MITM
> > option set. So my reading is that the IO Capabilities should be ignored,
> > and JUST_WORKS used.
> 
> It certainly is an unusual form of English. It's saying "If both devices
> have <x>", i.e. the condition <x> needs to be fulfilled by both devices
> for the statement to be true. In this case the condition is "not set the
> MITM option", i.e. both devices need to fulfill the condition "not set
> the MITM option". Doesn't that then mean that it's not enough for one
> device to not set the MITM flag, but both devices need to have it unset
> for just-works to take place?

Yes, it is very unfortunate and awkward English.

I am going to look for any errata that might be more explicit, so that
an absolute truth table based on: MITM, OOB, and IO-Caps can be
constructed. 

But the Truth table as I understood it from conversations at UPFs and
WGs and in my notes was:

1. If BOTH devices have OOB available, it is used and results in MITM
2. If NEITHER device wants MITM, JUST_WORKS used resulting in no MITM
3, If One or more want MITM, the IO Caps Table 2.4 on page 608 is used
and MAY or MAY NOT result in MITM.

In every case, MITM outcome is known, and propagated up the stack.

I have nothing to prove this, but it appears to be what the mature
stacks were using at UPF in Barcelona. But it is apparent that the spec
is not 100% clear, and that an errata is required to explicitly spell it
out.

I am going to either find the errata if it exists, or propose one to the
Core Working Group if it doesn't. Whatever the outcome, I will post it
here.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

