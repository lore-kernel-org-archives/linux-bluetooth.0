Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: nicolas <n1c0l4s.l3@wanadoo.fr>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: inactivity of my Bt
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr> <200406240028.07415.n1c0l4s.l3@wanadoo.fr> <1088029418.4296.9.camel@pegasus>
In-Reply-To: <1088029418.4296.9.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200406240047.38462.n1c0l4s.l3@wanadoo.fr>
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
Date: Thu, 24 Jun 2004 00:47:38 +0200

Le jeudi 24 Juin 2004 00:23, Marcel Holtmann a =E9crit=A0:
> Hi Nicolas,
>
> > > > i have with your advices installed my bluetooth  but i have a big
> > > > problem, if i let my bluetooth alone a time too long 10-15 min   i
> > > > lost my bluetooth and i have to use a ps/2 or usb keyboard/ mouse to
> > > > reinstall ( hcitool inq  scan and hidd -c )
> > > >
> > > > there is a way to keep it alive ?
> > >
> > > mostly every HID will disconnect after some time. Start "hidd --serve=
r"
> > > at boot time and your mouse or keyboard will reconnect after a
> > > keypress.
> >
> > and how can i start "hidd --server" at boot time?
>
> the bluez-utils-2.7 (and also the Debian package) contains an init
> script that will do this for you.

i have all installed this rpm from my distrib

bluez-bluefw-1.0-1mdk
bluez-utils-2.7-4mdk
bluez-hciemu-1.0-2mdk
libbluez1-2.7-1mdk
bluez-hcidump-1.8-1mdk
libbluez1-devel-2.7-1mdk

and there is no bluetooth service in my mcc but service bluetooth start   w=
ork

so  what have i to do?
there is a packaging bug?  ( in this case i will mail the packager rapidly)



thanks
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
> digital self defense, top technical experts, no vendor pitches,
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

=2D-=20
Ce mail a =E9t=E9 =E9crit sous linux mandrake cooker (www.linux-mandrake.co=
m/fr)
avec KMail 1.6.2 (www.kde.org)

Kernel: 2.6.7-2mdk
Kde 3.2.3


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
