Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco - unknown symbol snd_hwdep_new
	undefined!
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200411270038.51554.ruben@hotheads.de>
References: <200411270038.51554.ruben@hotheads.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1101524868.6514.67.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 27 Nov 2004 04:07:47 +0100

Hi Ruben,

> I have problems compiling the snd-bt-sco module aginst
> gentoo-dev-sources-2.6.9-r6.
> Does anyone knows what's the reason for this warning?
> - Is it due to a change in the kernel or in the btsco sources?
>=20
>=20
> >> modprobe snd-bt-sco
>=20
> FATAL: Error inserting snd_bt_sco=20
> (/lib/modules/2.6.9-gentoo-r6/extra/snd-bt-sco.ko): Unknown symbol in m=
odule,=20
> or unknown parameter (see dmesg)
>=20
>=20
> >>dmesg:
>=20
> snd_bt_sco: Unknown symbol snd_hwdep_new

you may need to make "depmod -e" first or simply load the "snd-hwdep"
kernel module.

> >>compile process of the kernel module:
>=20
> 22:57 root [/home/ruben/temp/btsco/btsco/kernel] : make
> make[1]: Entering directory `/usr/src/linux-2.6.9-gentoo-r6'
>   CC [M]  /home/ruben/temp/btsco/btsco/kernel/btsco.o
> /home/ruben/temp/btsco/btsco/kernel/btsco.c: In Funktion=20
> =BBsnd_card_bt_sco_thread=AB:
> /home/ruben/temp/btsco/btsco/kernel/btsco.c:809: Warnung: ISO C90 forbi=
ds=20
> mixed declarations and code

This one is now fixed in CVS.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
