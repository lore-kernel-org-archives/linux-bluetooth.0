Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Krisztian Mark Szentes <office@produktivIT.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, Edd Dumbill <ejad@debian.org>
In-Reply-To: <200305161438.08919.office@produktivIT.com>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305131047.39294.office@produktivIT.com>
	<1053083095.26552.49.camel@pegasus>
	<200305161438.08919.office@produktivIT.com>
Content-Type: text/plain
Message-Id: <1053091452.2561.86.camel@gaston>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 16 May 2003 15:24:13 +0200

On Fri, 2003-05-16 at 14:38, Krisztian Mark Szentes wrote:
> {hello Ben}
> 
> On Friday 16 May 2003 13:04, Marcel Holtmann wrote:
> > > > > I have trouble with the 3COM Cardbus bluetooth card on a Powerbook
> > > > > Titanium (a powerpc notebook). I patched the 2.4.20 kernel with
> > > > > the mh-6 patch (and the benh patch which does not collide). I
> > > > > haven't found any hint on the list yet.
> ...
> > You're using a Powerbook and the 3Com is currently not supported on the
> > PowerPC architecture. The Kernel side of the driver should work fine
> > (not tested), but the bluefw have no code to load the firmware. Take a
> > look at the mailing list archive for this problem.
>
> .../...

Hrm... The problem isn't simple. You are just not supposed to tap IOs
that way from userland, especially since PPC arch doesn't have anything
like "PIO" instructions. The IO space of your card is actually mapped
somewhere in physical memory, that "somewhere" not beeing generally
available to userland.

Can you tell me more about the card ? Is it a 16 bits PCMCIA device or
is it a cardbus (PCI) one ? Why can't you tap the IOs solely from within
a kernel driver ?

Ben.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
