Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Chris S <chrisspen@gmail.com>
In-Reply-To: <beb7688e0609180642i50453bdel671fb81cb50a053b@mail.gmail.com>
References: <beb7688e0609150702x738ad4d8re64815d12f457a76@mail.gmail.com>
	<1158329592.5233.32.camel@localhost> <450B3B01.2060801@gmail.com>
	<1158397207.6839.1.camel@localhost> <450D7E04.6080107@gmail.com>
	<1158561481.30486.30.camel@localhost>
	<beb7688e0609180621m46e4c37al76d0dac7b7803b67@mail.gmail.com>
	<1158585929.25125.5.camel@localhost>
	<beb7688e0609180642i50453bdel671fb81cb50a053b@mail.gmail.com>
Date: Mon, 18 Sep 2006 16:18:44 +0200
Message-Id: <1158589124.25125.10.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Celluon Laserkey Bluetooth Keyboard
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

Hi Chris,

> > > > > >> Please let me know if you need any other information, or if there's
> > > > > >> anything I can do to help get this working.
> > > > > >
> > > > > > this looks like the third of these. Please also run "hcitool inq" and
> > > > > > "hcitool info ..." (as root) for this.
> > > > >
> > > > > What do mean by the "third of these"? Is it going to be difficult to
> > > > > make a driver?
> > > >
> > > > run "hcidump -X -V" and then connect to RFCOMM channel 1 with the rfcomm
> > > > tool and then start pressing keys and see what hcidump shows you. Maybe
> > > > it is a simple key mapping.
> > >
> > > Ok, I'll do that as soon as I get home today.
> > >
> > > > Check the Smart Keyboard support for an
> > > > example on how to add support for this keyboard.
> > >
> > > What do you mean by this? I Googled for <bluez smart keyboard support>
> > > but didn't find anything. Is this code in CVS or documentation?
> >
> > it is in the CVS now. Maybe it is even the same key mapping. I looked
> > the keyboard up on eBay and this one is too expensive to buy for testing
> > and so I have to wait for donation to add it to my device library.
> 
> Btw, where in CVS is the Smart Keyboard example?

check the utils repository and then hidd/fakehid.c

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
