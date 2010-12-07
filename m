Return-Path: <cyrus@holtmann.org>
From: "Brian Gix" <bgix@codeaurora.org>
To: "'Anderson Lizardo'" <anderson.lizardo@openbossa.org>
Cc: "'Vinicius Costa Gomes'" <vinicius.gomes@openbossa.org>,
	<linux-bluetooth@vger.kernel.org>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>	<1291671832-13435-6-git-send-email-vinicius.gomes@openbossa.org>	<003101cb963d$8dcd6210$a9682630$@org> <AANLkTin5TYwx8fU6B3B0hSofqNBj6R8ZgOELf4DcJ_cm@mail.gmail.com>
In-Reply-To: <AANLkTin5TYwx8fU6B3B0hSofqNBj6R8ZgOELf4DcJ_cm@mail.gmail.com>
Subject: RE: [RFC v2 5/9] Bluetooth: Add support for using the crypto subsystem
Date: Tue, 7 Dec 2010 11:21:47 -0800
Message-ID: <003701cb9643$fe1a9000$fa4fb000$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



Hi,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: 07 December, 2010 11:07 AM
> To: Brian Gix
> Cc: Vinicius Costa Gomes; linux-bluetooth@vger.kernel.org
> Subject: Re: [RFC v2 5/9] Bluetooth: Add support for using the crypto
> subsystem
> 
> Hi,
> 
> On Tue, Dec 7, 2010 at 2:35 PM, Brian Gix <bgix@codeaurora.org> wrote:
> >> This will allow using the crypto subsystem for encrypting data. As
> SMP
> >> (Security Manager Protocol) is implemented almost entirely on the
> host
> >> side and the crypto module already implements the needed methods
> >> (AES-128), it makes sense to use it.
> >
> > I do understand the desire to reuse the crypto module, but I would
> like
> > to point out that every baseband that supports any level of LE-SM, is
> > required to have implemented the HCI commands for LE-SM centric
> encryption
> > and random number generation.
> 
> Correct.
> 
> > Also, since these are processor intensive calculations, which must
> take
> > place in real-time on the baseband for encrypted links, I would argue
> > that it makes more sense to use the likely optimized functionality
> > present in the basebands.
> 
> Note that only the LTK negotiation is done on the host/kernel. The
> payload PDU encryption itself still happens on the controller.
> 
> Is it expected that LTK generation happens so often? If so, I suspect
> the request/response "overhead" would be bigger than the AES
> implemented in kernel.
> 
> Also note that the Linux kernel API uses HW engine where
> available/supported, and at least for x86 it has many optimizations.
> 
> Dunno which has better performance in the end though (we haven't
> measured it).
> 
> > That is not to say that it cannot be done on the host, just that it
> > is likely less efficient, for no gain in portability or
> functionality.
> 
> For LTK calculation I *think* Linux kernel crypto API is fast enough
> (the payloads are small, 16 bytes). Using the "built-in" AES engine on
> LE controllers would be actually a lot more efficient for low-end
> hosts though...

Yeah, but if using crypto.c is what everyone wants, I have no hard
objections,
I guess. I do also see that Gustavo also notes a CRYPTO_BLKCIPHER dependence
that wasn't there before, suggesting that this will require pulling in code
that may not otherwise be needed. The HCI commands to do that work are
pretty straight forward.


> 
> My two cents,
> --
> Anderson Lizardo
> OpenBossa Labs - INdT
> Manaus - Brazil

