Return-Path: <cyrus@holtmann.org>
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
From: Brian Gix <bgix@codeaurora.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimir1fqsO5EfuHN2dQtsJQ2SVDajpuANo8C05EF@mail.gmail.com>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
	 <20101203220534.GA16709@eris> <1295895817.2656.26.camel@ubuntuLab1>
	 <20110124213429.GA15121@piper>
	 <AANLkTi=uByqBUVKD8UYwt5ZByvHwu6WpapG=BtUrFkzE@mail.gmail.com>
	 <1295974727.2656.57.camel@ubuntuLab1> <20110125175922.GA16442@jh-x301>
	 <1295980540.2656.85.camel@ubuntuLab1>
	 <AANLkTimir1fqsO5EfuHN2dQtsJQ2SVDajpuANo8C05EF@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 Jan 2011 14:04:52 -0800
Message-ID: <1295993092.2656.114.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & all,

On Tue, 2011-01-25 at 23:44 +0200, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Jan 25, 2011 at 8:35 PM, Brian Gix <bgix@codeaurora.org> wrote:
> > Hi Johan,
> >
> > On Tue, 2011-01-25 at 19:59 +0200, Johan Hedberg wrote:
> >> Hi Brian,
> >>
> >> On Tue, Jan 25, 2011, Brian Gix wrote:
> >> > >From Page 607:
> >> > "If both devices have out of band authentication data, then the
> >> > Authentication Requirements Flags shall be ignored when selecting the
> >> > pairing method and the Out of Band pairing method shall be used. If both
> >> > devices have not set the MITM option in the Authentication Requirements
> >> > Flags, then the IO capabilities shall be ignored and the Just Works
> >> > association model shall be used. Otherwise the IO capabilities of the
> >> > devices shall be used to determine the pairing method as defined in
> >> > Table 2.4."
> >> >
> >> > In the test case I ran, only One device (i.e. NOT BOTH) had the MITM
> >> > option set. So my reading is that the IO Capabilities should be ignored,
> >> > and JUST_WORKS used.
> >>
> >> It certainly is an unusual form of English. It's saying "If both devices
> >> have <x>", i.e. the condition <x> needs to be fulfilled by both devices
> >> for the statement to be true. In this case the condition is "not set the
> >> MITM option", i.e. both devices need to fulfill the condition "not set
> >> the MITM option". Doesn't that then mean that it's not enough for one
> >> device to not set the MITM flag, but both devices need to have it unset
> >> for just-works to take place?
> >
> > Yes, it is very unfortunate and awkward English.
> >
> > I am going to look for any errata that might be more explicit, so that
> > an absolute truth table based on: MITM, OOB, and IO-Caps can be
> > constructed.
> >
> > But the Truth table as I understood it from conversations at UPFs and
> > WGs and in my notes was:
> >
> > 1. If BOTH devices have OOB available, it is used and results in MITM
> > 2. If NEITHER device wants MITM, JUST_WORKS used resulting in no MITM
> > 3, If One or more want MITM, the IO Caps Table 2.4 on page 608 is used
> > and MAY or MAY NOT result in MITM.
> 
> At least for ssp yapparently you are right that may or may not result
> on MITM being used, this is the code we use on BlueZ:
> 
>         if (*auth == 0x00 || *auth == 0x04) {
>                  /* If remote requests dedicated bonding follow that lead */
>                  if (device_get_auth(device) == 0x02 ||
>                                  device_get_auth(device) == 0x03) {
> 
>                          /* If both remote and local IO capabilities allow MITM
>                           * then require it, otherwise don't */
>                          if (device_get_cap(device) == 0x03 ||
>                                                          agent_cap == 0x03)
>                                 *auth = 0x02;
>                          else
>                                  *auth = 0x03;
>                  }
> 
>                  /* If remote indicates no bonding then follow that. This
>                   * is important since the kernel might give general bonding
>                   * as default. */
>                  if (device_get_auth(device) == 0x00 ||
>                                          device_get_auth(device) == 0x01)
>                          *auth = 0x00;
> 
>                  /* If remote requires MITM then also require it, unless
>                   * our IO capability is NoInputNoOutput (so some
>                   * just-works security cases can be tested) */
>                  if (device_get_auth(device) != 0xff &&
>                                          (device_get_auth(device) & 0x01) &&
>                                          agent_cap != 0x03)
>                          *auth |= 0x01;
>          }
> 
> So we only set MITM if the other side also support it, hopefully it
> works the same way on LE. I still think it is a waste of time for no
> bonding case to use just-works when MITM was marked as required by one
> of parties, but I guess pretty everybody does that way.
> 
> > In every case, MITM outcome is known, and propagated up the stack.
> >
> > I have nothing to prove this, but it appears to be what the mature
> > stacks were using at UPF in Barcelona. But it is apparent that the spec
> > is not 100% clear, and that an errata is required to explicitly spell it
> > out.
> >
> > I am going to either find the errata if it exists, or propose one to the
> > Core Working Group if it doesn't. Whatever the outcome, I will post it
> > here.

I have filed errata #4249.  This errata can be looked up on
bluetooth.org in the specifications area under number:
"4249"
title:
"Clarification of STK generation"
Part:
"Security Manager 4.0"
Paragraph:
"2.3.5.1 Selecting STK Generation Method"


The Core Working Group (CWG) is meeting this week in Israel, and our guy
on the group, Brian Redding, has told me that he will try to get some
face time for it.  So in the next day or two, we could either get a
definitive statement, or at least a few comments.  If you don't have
access to the BT Sigs errata system, let me know & I will copy the
errata here.


> 
> 

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

