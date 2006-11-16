Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061115150540.GB16156@suse.de>
References: <4410090A.3070706@kernelconcepts.de>
	<1141912311.4605.9.camel@aeonflux.holtmann.net>
	<44104DD5.80109@kernelconcepts.de>
	<1141923373.4605.39.camel@aeonflux.holtmann.net>
	<loom.20060412T215427-611@post.gmane.org>
	<444CAE4F.70404@kernelconcepts.de>
	<1145876694.21987.28.camel@localhost>
	<4451F478.3070204@kernelconcepts.de>
	<455B1164.5050607@kernelconcepts.de>
	<1163598433.4678.0.camel@localhost>  <20061115150540.GB16156@suse.de>
Date: Thu, 16 Nov 2006 11:35:58 +0100
Message-Id: <1163673358.5169.31.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] New HCI-USB device, no MAC?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> > > Then I created a small shell script which sets a "more correct" address
> > > than the default 11:11:11:11:11:11. I assume in this script that an
> > > ethernet device is present in the system as eth0 and use its MAC for the
> > > Bluetooth dongle too.
> > > 
> > > I did this for two reasons:
> > > 1. On the same machine I always want to have the same BDADDR, so random
> > > was no choice.
> > > 2. The ethernet addresses also have to follow the same rules as
> > > Bluetooth MAC addresses, i.e. they have to be unique. So the probability
> > > of a collision is very low.
> > 
> > and now PAN will stop working, because the eth0 and bnep0 will have the
> > same MAC address. Not a good idea.
> 
> Well, after reading http://en.wikipedia.org/wiki/MAC_address i guess that
> we just could set bit 1 of the 6th byte to signal "locally administered"
> _and_ distinguish that address from the ethernet MAC address.
> 
> Or is this totally wrong?
> 
> But then, what happens if you plug two of those adapters into one machine?

the problem is that this address suppose to be unique and these guys
screwed it up. Period. Whatever you try to solve this will have its
downside somewhere. However using the hostid and actually storing the
value for later use after reboot could maybe a valid solution.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
