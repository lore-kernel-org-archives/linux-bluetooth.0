Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IA5EZL$515602A938C639AD7C0D84FB93EBFF70@libero.it>
Subject: Re: [Bluez-users] Piconet problems
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "jers@inwind.it" <jers@inwind.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
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
Date: Tue, 11 Jan 2005 11:40:33 +0100

Hi Marcel,

I'm still trying to create a simple piconet with a master a=
nd two slaves. I upgrated my bluez and, on your website, I red the firmwa=
re of my dongles (Digicom Palladio CSR) is fit for my aims.
Now the situ=
ation is as follows:

On the three sides I type

# modprobe bnep
=0D
=
On the master side:

# brctl addbr pan0
# ifconfig pan0 10.0.0.1
# br=
ctl setfd pan0 0
# brctl stp pan0 off
# pand  --listen --master --role =
GN

On the slave1 side:
# pand --connect <master bt_addr>
# ifconfig =
bnep0 10.0.0.2

In most cases I obtain the following error:

SIOCSIFA=
DDR: No such device
bnep0: unknown interface: No such device

even if =
the command
#hcitool con
shows me an active connection.

When I obtai=
n the connection I continue:

On the slave1 side:
# route add default =
gw 10.0.0.1

On the master side:
# brctl addif pan0 bnep0
# ifconfigt=
 bnep0 0.0.0.0

On the slave2 side:
# pand --connect <master bt_addr>=0D
=
# ifconfig bnep0 10.0.0.3

and I always obtain the same error:

SIOCS=
IFADDR: No such device
bnep0: unknown interface: No such device

even =
if the command
#hcitool con
shows me an active connection.

You point=
ed me out there is no link policy set  but  my file /etc/Bluetooth/hcid.c=
onf is:

# Default settings for HCI devices
device {
	# Local device =
name
	#   %d - device id
	#   %h - host name
	name "BlueZ (%d)";

	#=
 Local device class
	class 0x3e0100;

	# Default packet type
	#pkt_ty=
pe DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;=


	# Default link mode
	#   none   - no specific policy 
	#   accept =
- always accept incoming connections
	#   master - become master on inco=
ming connections,
	#            deny role switch on outgoing connections=

	#
	lm accept,master;
	#
	#lm accept;

	# Default link policy
	# =
  none    - no specific policy
	#   rswitch - allow role switch
	#   ho=
ld    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - =
allow park mode
	#
	#lp hold,sniff;
	#
	lp rswitch,hold,sniff,park;=0D
=

	# Authentication and Encryption
	#auth enable;
	#encrypt enable;
}=0D
=

How can I modify the link policy? Might this inconsistency be the cause=
 of my problems?
Apologizes for my English. 
Regards. Jers


> Hi Je=
rs,
> 
> > > What is the output of "hciconfig -a" for these dongles? =0D
=
> > >  
> >  
> > hci0:   Type: USB 
> >         BD Address: 00:E0:98:=
85:A1:5F ACL MTU: 192:8  SCO MTU: 64:8 
> >         UP RUNNING PSCAN ISC=
AN 
> >         RX bytes:15287 acl:102 sco:0 events:610 errors:0 
> >  =
       TX bytes:38313 acl:383 sco:0 commands:136 errors:0 
> >         F=
eatures: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
> >         Packet typ=
e: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> >         Link policy: 
> >  =
       Link mode: SLAVE ACCEPT 
> >         Name: 'Slave1' 
> >        =
 Class: 0x000000 
> >         Service Classes: Unspecified 
> >        =
 Device Class: Miscellaneous, 
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0=
x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175 
> >         Manufacturer: Cam=
bridge Silicon Radio (10) 
> >  
> > hci0:   Type: USB 
> >         BD=
 Address: 00:E0:98:85:A1:64 ACL MTU: 192:8  SCO MTU: 64:8 
> >         U=
P RUNNING PSCAN ISCAN 
> >         RX bytes:22169 acl:233 sco:0 events:1=
92 errors:0 
> >         TX bytes:7885 acl:92 sco:0 commands:62 errors:0=
 
> >         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
> >   =
      Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> >         Link=
 policy: 
> >         Link mode: SLAVE ACCEPT 
> >         Name: 'Slave=
2' 
> >         Class: 0x000000 
> >         Service Classes: Unspecifi=
ed 
> >         Device Class: Miscellaneous, 
> >         HCI Ver: 1.1 =
(0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175 
> >         M=
anufacturer: Cambridge Silicon Radio (10) 
> >  
> > 
> > hci0:   Type=
: USB 
> >         BD Address: 00:08:E0:01:9E:86 ACL MTU: 192:8  SCO MTU=
: 64:8 
> >         UP RUNNING PSCAN ISCAN 
> >         RX bytes:21366 =
acl:130 sco:0 events:217 errors:0 
> >         TX bytes:1668 acl:23 sco:=
0 commands:108 errors:0 
> >         Features: 0xff 0xff 0x0f 0x00 0x00 =
0x00 0x00 0x00 
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2=
 HV3 
> >         Link policy: 
> >         Link mode: SLAVE ACCEPT =0D
=
> >         Name: 'Master' 
> >         Class: 0x000000 
> >         Se=
rvice Classes: Unspecified 
> >         Device Class: Miscellaneous, =0D
=
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subv=
er: 0x33c 
> >         Manufacturer: Cambridge Silicon Radio (10) 
> =0D
=
> there is no link policy set (rswitch) and both of your slaves have
> f=
irmwares pre HCI 16.4 and so there are limitations. Check my webpage
> a=
bout CSR for more details.
> 
> Regards
> 
> Marcel
> 
> 
> 
> =0D
=
> -------------------------------------------------------
> SF email is =
sponsored by - The IT Product Guide
> Read honest & candid reviews on hu=
ndreds of IT Products from real users.
> Discover which products truly l=
ive up to the hype. Start reading now. 
> http://productguide.itmanagers=
journal.com/
> _______________________________________________
> Bluez-=
users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.=
sourceforge.net/lists/listinfo/bluez-users
> 
=0A=0A=0A=0A_____________=
_______________________________________________=0ALibero ADSL: 3 mesi gra=
tis e navighi a 1.2 Mega. E poi hai l'Adsl senza limiti a meno di 1 euro =
al giorno. =0AAbbonati subito senza costi di attivazione su http://www.li=
bero.it=0A=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
