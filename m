Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo boot-protocol issue
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200503181052.07265.mh@intellinetservices.net>
References: <200503181052.07265.mh@intellinetservices.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1111162920.9600.23.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 18 Mar 2005 17:22:00 +0100

Hi Manuel,

> this is my first time posting on this ML and I am not sure whether my p=
roblem=20
> isn=B4t more of a developer issue, if it is, please point it out and I =
will=20
> post it on the other ML.
>=20
> I recently got a Logitech diNovo and am running a Gentoo installation, =
kernel=20
> 2.6.11 with -mh patch. I=B4ve tried 2.6.10, bluez 2.10 and 2.15, all ha=
ve the=20
> same issue.
> The bluetooth transmitter (Logitech) is recognized and I can connect to=
=20
> devices, including all of the diNovo parts (keyboard, media pad, mouse)=
. The=20
> problem is that neither of the devices seems to support their enhanced =
key=20
> functions, they are all in boot-protocol mode, and I don=B4t know how t=
o get=20
> them to work with their full capacity.
> Here is some system feedback:
> # hidd
> 00:07:61:1E:04:CE HID Boot Device [046d:b3e1] connected [boot-protocol]
> 00:07:61:1D:3E:C3 HID Boot Device [046d:b001] connected [boot-protocol]
> 00:07:61:1C:EA:04 HID Boot Device [046d:b303] connected [boot-protocol]
> ---
> I can use all tree devices, but only in their basic configuration, non =
of the=20
> media keys are seen by xev.

try patch-2.6.11-mh2 which I released some minutes ago.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
