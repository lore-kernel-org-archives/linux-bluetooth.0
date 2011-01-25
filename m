Return-Path: <cyrus@holtmann.org>
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
From: Brian Gix <bgix@codeaurora.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1295974727.2656.57.camel@ubuntuLab1>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
	 <20101203220534.GA16709@eris> <1295895817.2656.26.camel@ubuntuLab1>
	 <20110124213429.GA15121@piper>
	 <AANLkTi=uByqBUVKD8UYwt5ZByvHwu6WpapG=BtUrFkzE@mail.gmail.com>
	 <1295974727.2656.57.camel@ubuntuLab1>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 Jan 2011 09:10:51 -0800
Message-ID: <1295975451.2656.63.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Vinicius,


On Tue, 2011-01-25 at 08:58 -0800, Brian Gix wrote:
> On Tue, 2011-01-25 at 10:35 +0200, Luiz Augusto von Dentz wrote:
> > Hi Vinicius,
> > 
> > On Mon, Jan 24, 2011 at 11:34 PM, Vinicius Costa Gomes
> > <vinicius.gomes@openbossa.org> wrote:
> > > Hi Brian,
> > >
> > > On 11:03 Mon 24 Jan, Brian Gix wrote:
> > >> Hi Vinicius,
> > >>
> > >> I am sorry that it has taken so long to test the snapshot that you
> > >> placed on gitorious, but I have now done so.
> > >>
> > >> On Fri, 2010-12-03 at 19:05 -0300, Vinicius Costa Gomes wrote:
> > >> > Hi Brian,
> > >> >
> > >> > On 11:11 Fri 03 Dec, Brian Gix wrote:
> > >> > >
> > >> > > Hi Claudio, Johan & All,
> > >> > >
> > >> > > Is this LE capable kernel that Ville is working on, the development stream
> > >> > > for the LE Security Manager?  And if so, is it in a partial fleshed out
> > >> > > state?
> > >> >
> > >> > There is a simple implementation of SMP here[1] on my "devel" branch. I am
> > >> > cleaning it up for sending it for review.
> > >> >
> > >> > If you want to help, have any comments or just want to tell us what you are
> > >> > working on, please drop by #bluez on freenode, or send an email.
> > >>
> > >> I have been able to verify that the Just Works negotiation of the Short
> > >> Term Key does work against an independent implementation of the LE
> > >> Security Manager, as long as I have requested no MITM protection.  I
> > >> have the following comments:
> > >>
> > >> 1. You currently reject security if I *do* request MITM protection.
> > >> This should not be done.  The correct functionality should be to
> > >> continue the negotiation.  Even though I requested MITM, it will be
> > >> clear to both sides that JUST_WORKS methodology has been used, and so
> > >> when the Keys are generated and exchanged, both sides will indicate in
> > >> their Key Database that they are no-MITM keys. If I then actually
> > >> *needed* MITM protection, then whatever functionality requiring that
> > >> level of security will fail with an insufficient security error code.
> > >> However, security should *never* be rejected unless there is a
> > >> fundamental incompatibility such as no level of security actually
> > >> supported.  This is the only functionality that I found to be actually
> > >> incorrect.
> > >>
> > >
> > > I was assuming that the meaning of setting the MITM protection bit, was that
> > > it was *requiring* MITM protection, and when that couldn't be fulfilled the
> > > Pairing Request should be rejected.
> > >
> > > So my assumption was incorrect, going to fix it soon.
> > 
> > Well the spec says it is a requirement:
> > 
> > "If the STK generation method does not result in an STK that provides
> > sufficient security properties then the device shall send the Pairing
> > Failed command with the error code “Authentication Requirements”" -
> > 2.3.5.1 Selecting STK Generation Method - Page 608

My interpretation of the paragraph at the end of page 608 is that if a
device realizes that the security level that will results will not meet
it's minimum security requirements, then it may reject and abort the
pairing.

I think it is a bad reading, though, for a device to reject a pairing if
it thinks that the *other* device will not be satisfied.  However that
is the case here.  In this case, it was the device that did *not* have
the MITM option set (the low security device) that was rejecting the
device *with* the MITM option set.

> 
> >From Page 607:
> "If both devices have out of band authentication data, then the
> Authentication Requirements Flags shall be ignored when selecting the
> pairing method and the Out of Band pairing method shall be used. If both
> devices have not set the MITM option in the Authentication Requirements
> Flags, then the IO capabilities shall be ignored and the Just Works
> association model shall be used. Otherwise the IO capabilities of the
> devices shall be used to determine the pairing method as defined in
> Table 2.4."
> 
> In the test case I ran, only One device (i.e. NOT BOTH) had the MITM
> option set. So my reading is that the IO Capabilities should be ignored,
> and JUST_WORKS used.
> 
> Remember the phone use case: When it needs to pair with a remote device,
> it is usually a GATT client that can support any level of security. It
> does not know if this new remote device requires MITM security, or No
> security.  However as the link Master and Initiator, it has to choose
> one.  It Chooses MITM, and if the remote side supports MITM, then
> pairing proceeds with a resulting MITM protection level. If the remote
> device is a simple dumb device with no security, it also needs to
> proceed without failing, but this time it completes with NO-MITM as the
> protection level. If it fails because the remote doesn't require
> security, then there is a fundamental incompatibility between the
> devices, which in the SIG we have tried to avoid.
> 
> > 
> > In my interpretation this is exactly what should happen when MITM is
> > set but there is no way to generate an authenticated key as Table 2.4:
> > Mapping of IO Capabilities to STK Generation Method suggest, in other
> > words if one of sides has NoInputNoOutput and MITM is set we should
> > return "Authentication Requirements" error.
> > 
> 

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

