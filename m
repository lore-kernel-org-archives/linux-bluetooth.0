Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Christoph Burger-Scheidlin <andersin@gmx.net>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200404281515.02262.andersin@gmx.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Subject: [Bluez-devel] PROBLEM: device node rfcomm0 is removed, but not created.
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
Date: Wed, 28 Apr 2004 15:15:02 +0200

Hello,

I tried to comply with the bug report guidelines found at=20
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

[1] device node rfcomm0 is removed by sysfs upon ppp disconnect, but not=20
created on connect

[2] I am connecting a palm Tungsten T to my linux box using bluetooth (blue=
z=20
stack). I am using dund to listen for incoming connections. My problem is,=
=20
that the device node rfcomm0 is not created automatically. However, if I=20
create it manually, it is removed upon termination of the connection, by=20
sysfs presumably. Creating the node manually, the connection works fine.

In my rfcommd.conf settings, I have set:
rfcomm0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0bind no;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0device <btaddr of palm>;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0channel 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comment "Tungsten";
}

which appears to be the problem. Setting "bind yes;" will cause the device=
=20
node to be created, but the connection fails, presumably because the Tungst=
en=20
does not allow binding.

I also tested bluetooth connectivity with my cellphone. issuing the command
rfcomm bind 3 <btaddr of cellphone> works and also creates the device=20
node /dev/rfcomm3.

[3] bluetooth rfcomm sysfs

[4] 2.6.5

I will be happy to provide the rest upon request, but deem it too long to p=
ost=20
it initially

Regards,

Christoph Burger-Scheidlin


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
