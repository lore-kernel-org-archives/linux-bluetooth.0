Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Marco Trudel" <soapy@gmx.ch>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <26398.1100503129@www2.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Subject: [Bluez-devel] combination keys support? [5]
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Nov 2004 08:18:49 +0100 (MET)

> this is really weird. The error code 0x29 means "pairing with unit key
> not supported",

Yes, that's what i found on google..
check
out:
http://davesipaq.com/forum/showthread.php?s=b489a378fa8fe7e09f2cf7fdccea2a48&p=14360#post14360

or a german one (your name sounds german :-)):
http://www.pocket.at/forum/nokia6230.htm

the first link tells that it's a firmware topic...
what do you think in this case:
is it a firmware topic of my usb dongle (so below bluez) or does this fall
into the bluez field?

btw, maybe interesting:
trying to pair my nokia6230 on windows fails badly (with "pairing and
connection refused for security reason"). pairing one of a friend (an older
model) works withhout problems...

> but actually it sends out the link key notification.
> It tell us that the link key is a local unit key. Whatever local means
> in this case. And the PIN code request happens before the SABM on
> the control DLCI 0. There is something fundamental wrong.

yes...
but i'm not that familiar with the bluetooth basics...
so i can't do that much with this information...
 

> What device do you use (hciconfig -a)?
It's a acer BT-500
hci0:   Type: USB
        BD Address: 00:04:3E:C0:C3:49 ACL MTU: 1356:5  SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN
        RX bytes:87 acl:0 sco:0 events:11 errors:0
        TX bytes:290 acl:0 sco:0 commands:11 errors:0
        Features: 0xff 0x07 0x04 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BLUEZ'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver: 0x86
        Manufacturer: Zeevo, Inc. (18)

> What kind of phone is this (hcitool info <bdaddr>)?
it's a nokia 6230i
i'll send you tonight a "hcitool info <bd>" if you're interestet, currently
i haven't the phone with me...

regards
Marco

PS: sorry for always breaking the thread, but i'm not on the mailinglist. if
you hit "reply all", i could directly answer and the thread wouldn't be
broken...

-- 
NEU +++ DSL Komplett von GMX +++ http://www.gmx.net/de/go/dsl
GMX DSL-Netzanschluss + Tarif zum supergünstigen Komplett-Preis!


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
