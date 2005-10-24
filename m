Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <94e407f00510240944k24a3f4f1re75377a1bffb8a7@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Link Quality between 2 Bluetooth USB Dongles
In-Reply-To: <1130164983.19317.54.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11943_30073012.1130172277841"
References: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
	 <1130164983.19317.54.camel@blade>
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
Date: Tue, 25 Oct 2005 00:44:37 +0800

------=_Part_11943_30073012.1130172277841
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel
 Thanks for the reply.
 [root@174-242 ~]# hciconfig hci0 version
hci0: Type: USB
BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0
HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
Manufacturer: Broadcom Corporation (15)
[root@174-242 ~]# hciconfig -a
hci0: Type: USB
BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0
UP RUNNING PSCAN ISCAN
RX bytes:412 acl:0 sco:0 events:19 errors:0
TX bytes:318 acl:0 sco:0 commands:19 errors:0
Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: '174-242.priv19.nus.edu.sg-0'
Class: 0x120104
Service Classes: Networking
Device Class: Computer, Desktop workstation
HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
Manufacturer: Broadcom Corporation (15)
 What is the HCI build version in this case?And how does this help me?
 Regards
Arpit

------=_Part_11943_30073012.1130172277841
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Marcel</div>
<div>&nbsp;</div>
<div>Thanks for the reply.</div>
<div>&nbsp;</div>
<div>[root@174-242 ~]# hciconfig hci0 version<br>hci0: &nbsp; Type: USB<br>=
&nbsp; &nbsp; &nbsp; &nbsp;BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SC=
O MTU: 16:0<br>&nbsp; &nbsp; &nbsp; &nbsp;HCI Ver: 1.2 (0x2) HCI Rev: 0x0 L=
MP Ver: 1.2 (0x2) LMP Subver: 0x309<br>&nbsp; &nbsp; &nbsp; &nbsp;Manufactu=
rer: Broadcom Corporation (15)
<br>[root@174-242 ~]# hciconfig -a<br>hci0: &nbsp; Type: USB<br>&nbsp; &nbs=
p; &nbsp; &nbsp;BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0=
<br>&nbsp; &nbsp; &nbsp; &nbsp;UP RUNNING PSCAN ISCAN<br>&nbsp; &nbsp; &nbs=
p; &nbsp;RX bytes:412 acl:0 sco:0 events:19 errors:0<br>&nbsp; &nbsp; &nbsp=
; &nbsp;TX bytes:318 acl:0 sco:0 commands:19 errors:0
<br>&nbsp; &nbsp; &nbsp; &nbsp;Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00=
 0x00<br>&nbsp; &nbsp; &nbsp; &nbsp;Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV=
1 HV2 HV3<br>&nbsp; &nbsp; &nbsp; &nbsp;Link policy: RSWITCH HOLD SNIFF PAR=
K<br>&nbsp; &nbsp; &nbsp; &nbsp;Link mode: SLAVE ACCEPT<br>&nbsp; &nbsp; &n=
bsp; &nbsp;Name: '174-242.priv19.nus.edu.sg-0
'<br>&nbsp; &nbsp; &nbsp; &nbsp;Class: 0x120104<br>&nbsp; &nbsp; &nbsp; &nb=
sp;Service Classes: Networking<br>&nbsp; &nbsp; &nbsp; &nbsp;Device Class: =
Computer, Desktop workstation<br>&nbsp; &nbsp; &nbsp; &nbsp;HCI Ver: 1.2 (0=
x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309<br>&nbsp; &nbsp; &nbs=
p; &nbsp;Manufacturer: Broadcom Corporation (15)
</div>
<div>&nbsp;</div>
<div>What is the HCI build version in this case?And how does this help me?<=
/div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Arpit</div>

------=_Part_11943_30073012.1130172277841--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
