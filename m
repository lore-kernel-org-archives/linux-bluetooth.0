Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: nicolas <n1c0l4s.l3@wanadoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200406240028.07415.n1c0l4s.l3@wanadoo.fr>
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr>
	 <1088028819.4296.7.camel@pegasus>
	 <200406240028.07415.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1088029418.4296.9.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: inactivity of my Bt
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Jun 2004 00:23:38 +0200

Hi Nicolas,

> > > i have with your advices installed my bluetooth  but i have a big
> > > problem, if i let my bluetooth alone a time too long 10-15 min   i lost
> > > my bluetooth and i have to use a ps/2 or usb keyboard/ mouse to reinstall
> > >  ( hcitool inq  scan and hidd -c )
> > >
> > > there is a way to keep it alive ?
> >
> > mostly every HID will disconnect after some time. Start "hidd --server"
> > at boot time and your mouse or keyboard will reconnect after a keypress.
> >
> 
> and how can i start "hidd --server" at boot time?

the bluez-utils-2.7 (and also the Debian package) contains an init
script that will do this for you.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
