Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IA90PC$632BFAAAF7249FD9F21D4DC661567C69@libero.it>
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
Date: Thu, 13 Jan 2005 10:22:24 +0100

> Hi Jers,
>
> >
> > # Default link mode
> > #   none   - no specific=
 policy
> > #   accept - always accept incoming connections
> > #   mas=
ter - become master on incoming connections,
> > #            deny role =
switch on outgoing connections
> > #
> > lm accept,master;
> > #
> > =
#lm accept;
>
> you changed this. Why? There can't be two device with a=
 master role in
> the same a piconet.

I know that. Maybe I wasn't acc=
urate in the description of my problem. I'm
sorry...
The above script i=
s the hcid.conf file of the master. For slaves I have "lm
accept".

I =
want to create a piconet with a single master and two slaves.
In a previ=
ous corrispondance, you suggested me:
- to upgrade my bluez packages. I =
did that.
- to check the limitation for firmware pre HCI 16.4. I did tha=
t.

- to check the link policy because the "hciconfig -a" command showe=
d it no
set for any device. This is my current problem.

"hciconfig -a=
" still shows me that there is no link policy set for any
device but, fo=
r all dongles,  in the hcid.conf I have

# Default link policy
#   non=
e    - no specific policy
#   rswitch - allow role switch
#   hold    -=
 allow hold mode
#   sniff   - allow sniff mode
#   park    - allow par=
k mode
#
#lp hold,sniff;
#
lp rswitch,hold,sniff,park;

so I suppos=
e, but I'm not sure, that this can be the cause of my problem.
Is it pos=
sible? If so, what can I do to solve this inconsistency?
Otherwise, what=
 do you suggest me to do?
Thank you so much.
Regards. Jers



>hci0=
:   Type: USB 
>        BD Address: 00:E0:98:85:A1:5F ACL MTU: 192:8  SC=
O MTU: 64:8 
>        UP RUNNING PSCAN ISCAN 
>        RX bytes:15287 a=
cl:102 sco:0 events:610 errors:0 
>        TX bytes:38313 acl:383 sco:0 =
commands:136 errors:0 
>        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 =
0x00 0x00 
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 =0D
=
>        Link policy: 
>        Link mode: SLAVE ACCEPT 
>        Name:=
 'Slave1' 
>        Class: 0x000000 
>        Service Classes: Unspecif=
ied 
>        Device Class: Miscellaneous, 
>        HCI Ver: 1.1 (0x1)=
 HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175 
>        Manufactu=
rer: Cambridge Silicon Radio (10) 
> 
>hci0:   Type: USB 
>        BD =
Address: 00:E0:98:85:A1:64 ACL MTU: 192:8  SCO MTU: 64:8 
>        UP RU=
NNING PSCAN ISCAN 
>        RX bytes:22169 acl:233 sco:0 events:192 erro=
rs:0 
>        TX bytes:7885 acl:92 sco:0 commands:62 errors:0 
>      =
  Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
>        Packet typ=
e: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>        Link policy: 
>       =
 Link mode: SLAVE ACCEPT 
>        Name: 'Slave2' 
>        Class: 0x00=
0000 
>        Service Classes: Unspecified 
>        Device Class: Mis=
cellaneous, 
>        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x=
1) LMP Subver: 0x175 
>        Manufacturer: Cambridge Silicon Radio (10=
) 
> 
> 
>hci0:   Type: USB 
>        BD Address: 00:08:E0:01:9E:86 A=
CL MTU: 192:8  SCO MTU: 64:8 
>        UP RUNNING PSCAN ISCAN 
>       =
 RX bytes:21366 acl:130 sco:0 events:217 errors:0 
>        TX bytes:166=
8 acl:23 sco:0 commands:108 errors:0 
>        Features: 0xff 0xff 0x0f =
0x00 0x00 0x00 0x00 0x00 
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 =
HV1 HV2 HV3 
>        Link policy: 
>        Link mode: SLAVE ACCEPT =0D
=
>        Name: 'Master' 
>        Class: 0x000000 
>        Service Cla=
sses: Unspecified 
>        Device Class: Miscellaneous, 
>        HCI =
Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c 
>   =
     Manufacturer: Cambridge Silicon Radio (10) 
>
=0A=0A=0A=0A________=
____________________________________________________=0ALibero ADSL: 3 mes=
i gratis e navighi a 1.2 Mega. E poi hai l'Adsl senza limiti a meno di 1 =
euro al giorno. =0AAbbonati subito senza costi di attivazione su http://w=
ww.libero.it=0A=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
