Return-Path: <n1c0l4s.l3@wanadoo.fr>
From: nicolas <n1c0l4s.l3@wanadoo.fr>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: inactivity of my Bt
Date: Thu, 24 Jun 2004 19:32:24 +0200
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr> <200406240050.30749.n1c0l4s.l3@wanadoo.fr> <1088030785.4296.17.camel@pegasus>
In-Reply-To: <1088030785.4296.17.camel@pegasus>
Cc: Marcel Holtmann <marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200406241932.24780.n1c0l4s.l3@wanadoo.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

Le jeudi 24 Juin 2004 00:46, Marcel Holtmann a =E9crit=A0:
> Hi Nicolas,
>
> > > the bluez-utils-2.7 (and also the Debian package) contains an init
> > > script that will do this for you.
> >
> > i have all installed this rpm from my distrib
> >
> > bluez-bluefw-1.0-1mdk
> > bluez-utils-2.7-4mdk
> > bluez-hciemu-1.0-2mdk
> > libbluez1-2.7-1mdk
> > bluez-hcidump-1.8-1mdk
> > libbluez1-devel-2.7-1mdk
> >
> > and there is no bluetooth service in my mcc but service bluetooth start=
 =20
> > work
> >
> > so  what have i to do?
> > there is a packaging bug?  ( in this case i will mail the packager
> > rapidly)
>
> check /etc/default/* for a Bluetooth configuration file. In general you
> must set a variable to start hidd at boot time.
>
> Regards
>
> Marcel
>
>
>
>
Hi Marcel,=20

if i enter Hidd --server  the console    tell me:=20

# hidd --server
Can't listen on HID control channel: Address already in use

and if i push the connect but or use the mouse or the keyboard nothing work=
  i=20
have to use a ps2 one and do hcitool inq  & hidd -c=20


what have i forgotten?


regards,=20
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
