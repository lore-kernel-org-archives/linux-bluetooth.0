Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Delgado, Monica (ERZIA)" <monica.delgado@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 12:31:23 +0200
MIME-Version: 1.0
In-Reply-To: <mailman.56464.1160122795.16222.bluez-users@lists.sourceforge.net>
Message-Id: <20061019102818.11A17215448@mrelay1.st2.lyceu.net>
Subject: Re: [Bluez-users] PAND Network
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hi all, =


I have been performing test during the last two weeks with my PAN network
topology and I get always the same result.

I have been looking for information in this forum and I have found this
message:


	From: Max Krasnyansky <maxk@qu...>
	Re: Multiple PAN/BNEP connections from 1 machine  =

	2003-06-12 12:02

	 At 10:56 AM 6/12/2003, MUSSON MICHAEL JOHN wrote:
 =

	 >Hello all,
	 >
	 >I just want to know if it"s possible to have one machine with two
	 >BT adapters establish 2 BNEP connections to a separate machine
with 	1
	 >adapter. =

	 No it"s not.
 =

 	>If this is not possible, how hard would it be
	 >to hack the code to make it possible?
	 First we"d have to learn how to plug _two_ Ethernet cables
	 into a _single_ port ;-).
 =

	 Max
 =

 This is exactly my situation, I have two BT adapters in the same PC trying
to establish two BNEP connections to a separate machine with 1 adapter. As
this message is also quite old, isn't it possible now to have one machine
with two BT adapters establish 2 BNEP connections to a separate machine with
1 adapter?.
 =

Thanks and best regards,  =



M=F3nica Delgado
 =


Message: 1
Date: Fri, 6 Oct 2006 10:22:14 +0200
From: "Delgado, Monica (ERZIA)" <monica.delgado@erzia.com>
Subject: Re: [Bluez-users] PAND Network
To: <bluez-users@lists.sourceforge.net>
Message-ID: <20061006081935.B9EFA215616@mrelay1.st2.lyceu.net>
Content-Type: text/plain; charset=3D"us-ascii"

 Hi Marcel,
 =

 >  >  > I'm trying to configure a PAN network and I have a problem in this
 >  >  > specific scenario:
 >  >  > =

 >  >  >             -I have one BT device  (BT1) connected to a linux PC,
 >  >  > which is configured as master
 >  >  > =

 >  >  >             -I have two BT devices more connected to another Linux
PC,
 >  >  > in different USB ports ( BT2, BT3).
 >  >  > =

 >  >  > When I create a pan connection between BT2 and master (BT1)
everything
 >  >  > works ok, but when I try to create a second connection to the same
 >  >  > master from the BT device BT3, I get this error
 >  >  > =

 >  >  >             "File exists (17)"
 >  >  > =

 >  >  > I have tried to configure first BT3 and second BT2 and I have got
the
 >  >  > same error with BT2, which means that only the first pan connection
is
 >  >  > configured without problems. =

 >  >  > =

 >  >  > Is it possible to create two simultaneous PAN connections from two
BT
 >  >  > devices connected to the same PC? Have anyone of you ever done it?
 >  >  =

 >  >  >>>>>> yes, but you must sure to use "pand -i hciX" to use the
correct   =

 >  >  >>>>>> adapter for the BNEP connection.
 >  > =

 >  > =

 >  > =

 >  > =

 >  > Thank you very much for your answer. I'm configuring the PAN
connection
 >  > using the "pand" function as you say "pand -i hciX" , but I still get
the
 >  > same error. In some message posted in this forum (30-09-2002) I have
read
 >  > this:
 >  > =

 >  > =

 >  > "You cannot have more than one BNEP/PAN
 >  >  connection to the _same_ bd address. In other words this
 >  >           bd:ad:dr:1 --> bd:ad:dr:2 <-- bd:ad:dr:3
 >  >  is not allowed _if_ bd:ad:dr:1 and bd:ad:dr:3 are on the same machine
"
 >  > =

 >  > =

 >  > This is exactly my case, I have the 2 slaves in the same machine, and
they
 >  > both try to connect to the same master device. As this message is
quite old,
 >  > I don't know if this is real nowadays. I'm using Fedora Core 4 in both
PC's.
 =

 >  this is still valid, but your case is different, because you are using
 >  two adapters. However you must make sure that they are used. So make
 >  sure for one connection you use hci0 and for the other hci1. And you
 >  might wanna have "hcidump -i hciX -X -V" running to see the actual error
 >  message.

 =


 =


 I have made sure that each connection is associated with the correct hci
interface with hcidump. I have made this test:

 =


 =


1-       I have configured hci0 to connect to the master:

 =


[root@localhost bt_config]# pand  -r PANU --autozap -i hci0 -c
00:07:80:80:4B:04 -n =


pand[6043]: Bluetooth PAN daemon version 2.15

pand[6043]: Connecting to 00:07:80:80:4B:04

pand[6043]: bnep0 connected

 =


            So the connection from hci0  has been created without problem.

 =


 =


2-       I have configured hci1 to connect from the same PC to the master:

 =


[root@localhost bt_config]# pand  -r PANU --autozap -i hci1 -c
00:07:80:80:4B:04 -n

pand[6071]: Bluetooth PAN daemon version 2.15

pand[6071]: Connecting to 00:07:80:80:4B:04

pand[6071]: Connect to 00:07:80:80:4B:04 failed. File exists(17)

 =


 =


And in the hcidump of hci1 I get this:

 =


[root@localhost bt_config]# hcidump -i hci1 -X -V

HCI sniffer - Bluetooth packet analyzer ver 1.18

device: hci1 snap_len: 1028 filter: 0xffffffff

< HCI Command: Create Connection (0x01|0x0005) plen 13

    bdaddr 00:07:80:80:4B:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000

    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

> HCI Event: Command Status (0x0f) plen 4

    Create Connection (0x01|0x0005) status 0x00 ncmd 1

> HCI Event: Role Change (0x12) plen 8

    status 0x00 bdaddr 00:07:80:80:4B:04 role 0x01

    Role: Slave

> HCI Event: Connect Complete (0x03) plen 11

    status 0x00 handle 41 bdaddr 00:07:80:80:4B:04 type ACL encrypt 0x00

< ACL data: handle 41 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 15 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

    handle 41 policy 0x0f

    Link policy: RSWITCH HOLD SNIFF PARK

> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7

  0000: 04 4b 80 80 07 00 01                              .K.....

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> HCI Event: Max Slots Change (0x1b) plen 3

  0000: 29 00 05                                          )..

> HCI Event: Command Complete (0x0e) plen 6

    Write Link Policy Settings (0x02|0x000d) ncmd 1

    status 0x00 handle 41

> ACL data: handle 41 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

      Connection successful

< ACL data: handle 41 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 1691

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> ACL data: handle 41 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0

      Success

> ACL data: handle 41 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 1691

< ACL data: handle 41 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0

      Success

< ACL data: handle 41 flags 0x02 dlen 11

    L2CAP(d): cid 0x0040 len 7 [psm 15]

      BNEP: Control(0x01|0)

        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> ACL data: handle 41 flags 0x02 dlen 8

    L2CAP(d): cid 0x0040 len 4 [psm 15]

      BNEP: Control(0x01|0)

        Setup Rsp(0x02) res 0x0000

< ACL data: handle 41 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

    handle 41

> ACL data: handle 41 flags 0x02 dlen 12

    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< HCI Command: Disconnect (0x01|0x0006) plen 3

    handle 41 reason 0x13

    Reason: Remote User Teminated Connection

> HCI Event: Command Status (0x0f) plen 4

    Disconnect (0x01|0x0006) status 0x00 ncmd 1

> HCI Event: Disconn Complete (0x05) plen 4

    status 0x00 handle 41 reason 0x16

    Reason: Connection Terminated by Local Host

 =


      =


After this I have tried to connect hci1 to another master device diferent
from the master device used for hci0 connection and the connection is
created correctly, so the problem seems to be when the two devices in the
same PC try to connect to the same master. Would it be necessary to add some
other argument in the "pand" command in this situation?

 =


 =


Thank you and best regards,

 =


 =


Monica Delgado

Radio Software Architect

 =


Email:  <mailto:monica.delgado@erzia.com> monica.delgado@erzia.com

Tel:   +34 942 29 13 45

Fax : +34 942 29 13 47 =


 =


ERZIA Technologies S.L.

Eduardo Benot 5

Spain-39003 Santander

 <http://www.erzia.com/> www.erzia.com

------------------------------------------

The information contained in this e-mail and any attachments is confidential
to ERZIA Technologies S.L. and must not be passed to any third party without
permission. This communication is for information only and shall not create
or change any contractual relationship. ERZIA Technologies S.L. is
registered in Spain C.I.F. ESB39540927

 =


 =


-------------- next part --------------
An HTML attachment was scrubbed...
URL:
http://sourceforge.net/mailarchive/forum.php?forum=3Dbluez-users/attachment=
s/2
0061006/c14cd08a/attachment.html =


------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV

------------------------------

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


End of Bluez-users Digest, Vol 6, Issue 7
*****************************************


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
