Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Manuel Harnisch <mh@intellinetservices.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Logitech diNovo boot-protocol issue
References: <200503181052.07265.mh@intellinetservices.net> <1111162920.9600.23.camel@pegasus>
In-Reply-To: <1111162920.9600.23.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503181208.01419.mh@intellinetservices.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 18 Mar 2005 12:08:01 -0500

And that=B4s why I love linux, thank you so much, it worked.

I=B4ll request to have this merged into the current gentoo-dev kernel.

Thanks again,

Manuel

On Friday 18 March 2005 11:22 am, Marcel Holtmann wrote:
> Hi Manuel,
>
> > this is my first time posting on this ML and I am not sure whether my
> > problem isn=B4t more of a developer issue, if it is, please point it out
> > and I will post it on the other ML.
> >
> > I recently got a Logitech diNovo and am running a Gentoo installation,
> > kernel 2.6.11 with -mh patch. I=B4ve tried 2.6.10, bluez 2.10 and 2.15,=
 all
> > have the same issue.
> > The bluetooth transmitter (Logitech) is recognized and I can connect to
> > devices, including all of the diNovo parts (keyboard, media pad, mouse).
> > The problem is that neither of the devices seems to support their
> > enhanced key functions, they are all in boot-protocol mode, and I don=
=B4t
> > know how to get them to work with their full capacity.
> > Here is some system feedback:
> > # hidd
> > 00:07:61:1E:04:CE HID Boot Device [046d:b3e1] connected [boot-protocol]
> > 00:07:61:1D:3E:C3 HID Boot Device [046d:b001] connected [boot-protocol]
> > 00:07:61:1C:EA:04 HID Boot Device [046d:b303] connected [boot-protocol]
> > ---
> > I can use all tree devices, but only in their basic configuration, non =
of
> > the media keys are seen by xev.
>
> try patch-2.6.11-mh2 which I released some minutes ago.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3DClick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

=2D-=20
Manuel Harnisch, IntellinetServices
Systems Administrator &
Web Developer

Mobile: (267) 237-7080
Email: mh@intellinetservices.net


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
