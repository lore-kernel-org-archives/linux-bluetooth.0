Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] learning the basics
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cq6cqd$fs2$1@sea.gmane.org>
References: <cq6cqd$fs2$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1103542976.29892.92.camel@pegasus>
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
Date: Mon, 20 Dec 2004 12:42:56 +0100

Hi,

> This morning, in an attempt of auto-encourage myself, I thougth I was=20
> going to be able to compile the l2test application by my own, only from=
=20
> the l2test.c source and having all the required libraries properly=20
> installed... Of course I couldn't (crying). My fatal sin is that I'm=20
> learning programming, communications, bluetooth and Linux, all the same=
=20
> time, and all the same way (you can see that way). I hope don't bother=20
> you trying to justify myself of asking the following question:
>=20
> =BFCould you give me some ligth in the points to consider while compili=
ng=20
> a user-made source like the l2test application? I want to do this way=20
> only for learning pourposes, in order to glimpse a bit the whole pictur=
e.
> I'm getting errors of type "undefined references" like the following
>=20
> linking l2captest (libtool)
> linking l2captest (gcc)
> /home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:222:=20
> undefined reference to `strtoba'
> l2captest.o(.text+0x680):/home/soraberri/Desarrollo/estudioC/l2captest/=
src/l2captest.c:222:=20
> undefined reference to `baswap'
> /home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:328:=20
> undefined reference to `baswap'
> l2captest.o(.text+0xb54):/home/soraberri/Desarrollo/estudioC/l2captest/=
src/l2captest.c:329:=20
> undefined reference to `batostr'
> /home/soraberri/Desarrollo/estudioC/l2captest/src/l2captest.c:643:=20
> undefined reference to `hci_devba'
> l2captest.o(.text+0x14df):/home/soraberri/Desarrollo/estudioC/l2captest=
/src/l2captest.c:645:=20
> undefined reference to `str2ba'
> *** Exited with status: 2 ***
>=20
> Theese functions are defined in bluetooth.h as you know. I thougth I=20
> should link with the -L /lib/modules/2.6.9-1.667/kernel/net/bluetooth/=20
> flag, but there is the same output.

don't link anything against any kernel stuff from userspace. This will
never work. I don't understand why don't you use --enable-test from the
bluez-utils configure script. However what you are searching for is:

	gcc l2captest.c -o l2captest -lbluetooth

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
