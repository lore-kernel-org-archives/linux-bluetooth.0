Return-Path: <cyrus@holtmann.org>
Subject: Re: LE Kernel (bluetooth-le-2.6) and LE Security Manager
From: Brian Gix <bgix@codeaurora.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTi=Hzaf2Ad7=+hQFEcvMfV4_P+-ZUVg5kzxvZyJH@mail.gmail.com>
References: <001c01cb931d$dc4cb3a0$94e61ae0$@org>
	 <20101203220534.GA16709@eris> <1295895817.2656.26.camel@ubuntuLab1>
	 <AANLkTi=Hzaf2Ad7=+hQFEcvMfV4_P+-ZUVg5kzxvZyJH@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 24 Jan 2011 12:33:00 -0800
Message-ID: <1295901180.2656.45.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, 2011-01-24 at 22:09 +0200, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Jan 24, 2011 at 9:03 PM, Brian Gix <bgix@codeaurora.org> wrote:
> > Hi Vinicius,
> >
[...]
> >
> > 1. You currently reject security if I *do* request MITM protection.
> > This should not be done.  The correct functionality should be to
> > continue the negotiation.  Even though I requested MITM, it will be
> > clear to both sides that JUST_WORKS methodology has been used, and so
> > when the Keys are generated and exchanged, both sides will indicate in
> > their Key Database that they are no-MITM keys. If I then actually
> > *needed* MITM protection, then whatever functionality requiring that
> > level of security will fail with an insufficient security error code.
> > However, security should *never* be rejected unless there is a
> > fundamental incompatibility such as no level of security actually
> > supported.  This is the only functionality that I found to be actually
> > incorrect.
> 
> But the point of MITM is man in the middle protection, so if we end up
> with a key which is not MITM there is no protection why store the link
> key? Actually if we do that we can end up in a situation where
> insufficient security is always triggered and the other stack may
> attempt to repair but with current code it will never succeed to
> generate a valid MITM link key. Anyway I suppose supporting MITM is
> mandatory so obviously the only possible fix for this is to support
> MITM.

The basic use case envisioned is that the two sides do not necessarily
know what the other side can support or has available until it attempts
this "pairing" operation.  So we want to avoid this catch 22:

1. We support MITM but don't know if the other side does, nor if it
requires it. With the code I just tested, the remote side (bluez)
indicated that it doesn't not support MITM and therefore rejects
pairing.

2. However, if we support MITM but don't know if the other side does and
we *do not* request MITM, then a remote side that *requires* MITM should
reject us for *not* requesting it.

The solution is therefore to *always* request MITM, if you are capable
of supporting it.  If it turns out that neither side actually needs it,
then there is no harm in having provided it. If one side does not
support it (as bluez currently does not) and the other side requires it,
then it is up to the side that *requested* MITM to reject the pairing
attempt, if it determines that MITM is required.

A low security device like the current bluez should *never* reject a
pairing request because the other side needs MITM.  It is up to the side
that has the MITM requirement to issue the Security Failure packet.

So until bluez can support MITM, it should *accept* remote requests for
MITM, knowing that the remote side may reject it.  As long as bluez
advertises no OOB and NO_IN_NO_OUT, there will be no MITM.  It should
just not request MITM, and then provide no way to achieve it.

[...]

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

