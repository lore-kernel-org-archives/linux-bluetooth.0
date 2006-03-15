Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001f01c64810$1e4ff130$0300a8c0@akira>
From: "Sir Graham (Terra)" <sir__graham@terra.es>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Problem With the Inquiry and RFCOMM conexions
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=response
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
Date: Wed, 15 Mar 2006 10:08:46 +0100



Hi Marcel,

Thanks very much for you answer....

"limitation of the hardware"..?   I use modules BT 2.0 for this ....

Info of hciconfig hci0 version:

hci0:   Type: UART
        BD Address: 00:07:80:XX:XX:XX ACL MTU: 384:8 SCO MTU: 64:8
        HCI Ver: 2.0 (0x3) HCI Rev: 0xa42 LMP Ver: 2.0 (0x3) LMP Subver:
0xa42
        Manufacturer: Cambridge Silicon Radio (10)


The inquiry and the RFCOMM in blueZ have diferent handles. I understand t=
he
calls hci to module don=C2=B4t mixed ....

Why if I send data over RFCOMM channels the inquiry don=C2=B4t find any d=
evice?
I don=C2=B4t send any data, mantaint the conexion, the inquiry works with=
 any
problem.... =C2=BF=C2=BF???

The Inquiry works in a independient thread, and every conexion RFCOMM hav=
e
his own thread also....

Any idea?

Regards,
Sir Graham.




----- Original Message -----=20
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <bluez-devel@lists.sourceforge.net>
Sent: Monday, March 13, 2006 2:32 PM
Subject: Re: [Bluez-devel] Problem With the Inquiry and RFCOMM conexions


Hi,

> I have a problem with make a Inquiry and RFCOMM conexions at the same
> time and don=C2=B4t understand why.....(with BlueZ).

this is a limitation of the hardware. What does "hciconfig hci0 version"
tell you?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dk&kid=110944&bid$1720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dk&kid=110944&bid$1720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel=20



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
