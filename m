Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <I92QQS$82908F943F74AC6A26E56B7A5E562E11@libero.it>
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
Date: Tue, 21 Dec 2004 14:28:04 +0100

Hi Marcel, 
 
> Hi Jers, 
>  
> > I'm trying to create a simple picon=
et consisting of a master and two slaves. I'm using three Digicom Palladi=
o  
> > dongles.  
> > My packages list is:  
> >  - bluez-libs-2.8-1.=
i386.rpm  
> >  - bluez-bluefw-1.0-1.i386.rpm  
> >  - bluez-hcidump-1.=
10-1.i386.rpm  
> >  - bluez-sdp-1.5-1.i386.rpm  
> >  - bluez-pan-1.1-=
1.i386.rpm  
> >  - bluez-utils-2.8-1.i386.rpm  
> >  - bridge-utils-0.=
9.6-1.i386.rpm  
>  
> the bluez-sdp, bluez-pan and bluez-bluefw packag=
es are deprecated. Get 
> yourself newer versions of bluez-libs and blue=
z-utils. 
>  
 
> What is the output of "hciconfig -a" for these dongl=
es? 
>  
 
hci0:   Type: USB 
        BD Address: 00:E0:98:85:A1:5F A=
CL MTU: 192:8  SCO MTU: 64:8 
        UP RUNNING PSCAN ISCAN 
        R=
X bytes:15287 acl:102 sco:0 events:610 errors:0 
        TX bytes:38313 =
acl:383 sco:0 commands:136 errors:0 
        Features: 0xff 0xff 0x0f 0x=
00 0x00 0x00 0x00 0x00 
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1=
 HV2 HV3 
        Link policy: 
        Link mode: SLAVE ACCEPT 
     =
   Name: 'Slave1' 
        Class: 0x000000 
        Service Classes: Un=
specified 
        Device Class: Miscellaneous, 
        HCI Ver: 1.1 (=
0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175 
        Manufa=
cturer: Cambridge Silicon Radio (10) 
 
hci0:   Type: USB 
        BD =
Address: 00:E0:98:85:A1:64 ACL MTU: 192:8  SCO MTU: 64:8 
        UP RUN=
NING PSCAN ISCAN 
        RX bytes:22169 acl:233 sco:0 events:192 errors=
:0 
        TX bytes:7885 acl:92 sco:0 commands:62 errors:0 
        Fe=
atures: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
        Packet type: DM=
1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: 
        Link m=
ode: SLAVE ACCEPT 
        Name: 'Slave2' 
        Class: 0x000000 
  =
      Service Classes: Unspecified 
        Device Class: Miscellaneous,=
 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subve=
r: 0x175 
        Manufacturer: Cambridge Silicon Radio (10) 
 
 
hci=
0:   Type: USB 
        BD Address: 00:08:E0:01:9E:86 ACL MTU: 192:8  SC=
O MTU: 64:8 
        UP RUNNING PSCAN ISCAN 
        RX bytes:21366 acl=
:130 sco:0 events:217 errors:0 
        TX bytes:1668 acl:23 sco:0 comma=
nds:108 errors:0 
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0=
x00 
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        =
Link policy: 
        Link mode: SLAVE ACCEPT 
        Name: 'Master' =0D
=
        Class: 0x000000 
        Service Classes: Unspecified 
        =
Device Class: Miscellaneous, 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c =
LMP Ver: 1.1 (0x1) LMP Subver: 0x33c 
        Manufacturer: Cambridge Si=
licon Radio (10) 
 
 
Regards.  
Jers 
 
 
  =0A=0A=0A=0A_________=
___________________________________________________=0ARegala e regalati L=
ibero ADSL: 3 mesi gratis e navighi veloce. 1.2 Mega di musica, film, vid=
eo e sport. =0AAbbonati subito senza costi di attivazione su http://www.l=
ibero.it=0A=0A



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
