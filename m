Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IAAY31$664B7AA9753F60F7A4D5D72B66AB0F53@libero.it>
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
Date: Fri, 14 Jan 2005 11:21:01 +0100

Hi Marcel, 
 
> Hi Jers, 
>  
> > hcid was not running. I've solved t=
he inconsistency but no my problem. 
> >  
> > Hi tried to create conne=
ction on slave1 side by 
> > # hcitool cc <master_addr> 
> > and so =0D
=
> > # hcitool con 
> > lists me the established connection. 
>  
> sen=
d us the outputs of "hciconfig -a" for all of your devices. And don't =0D
=
> play with "hcitool cc". If you wanna test stuff then use l2test. 
 =0D
=
hci0:   Type: USB 
        BD Address: 00:08:E0:01:9E:86 ACL MTU: 192:8 =
 SCO MTU: 64:8 
        UP RUNNING PSCAN ISCAN 
        RX bytes:653 ac=
l:0 sco:0 events:19 errors:0 
        TX bytes:314 acl:0 sco:0 commands:=
18 errors:0 
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00 =0D
=
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link p=
olicy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
      =
  Name: 'PC A' 
        Class: 0x3e0100 
        Service Classes: Netwo=
rking, Rendering, Capturing 
        Device Class: Computer, Uncategoriz=
ed 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Sub=
ver: 0x33c 
        Manufacturer: Cambridge Silicon Radio (10) 
 
hci0=
:   Type: USB 
        BD Address: 00:E0:98:85:A1:64 ACL MTU: 192:8  SCO=
 MTU: 64:8 
        UP RUNNING PSCAN ISCAN 
        RX bytes:99 acl:0 s=
co:0 events:13 errors:0 
        TX bytes:296 acl:0 sco:0 commands:12 er=
rors:0 
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
    =
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link polic=
y: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Na=
me: 'BlueZ (0)' 
        Class: 0x3e0100 
        Service Classes: Netw=
orking, Rendering, Capturing 
        Device Class: Computer, Uncategori=
zed 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Su=
bver: 0x175 
        Manufacturer: Cambridge Silicon Radio (10) 
 
 =0D
=
hci0:   Type: USB 
        BD Address: 00:E0:98:85:A1:5F ACL MTU: 192:8 =
 SCO MTU: 64:8 
        UP RUNNING PSCAN ISCAN 
        RX bytes:99 acl=
:0 sco:0 events:13 errors:0 
        TX bytes:296 acl:0 sco:0 commands:1=
2 errors:0 
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 =0D
=
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link p=
olicy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
      =
  Name: 'BlueZ (0)' 
        Class: 0x3e0100 
        Service Classes: =
Networking, Rendering, Capturing 
        Device Class: Computer, Uncate=
gorized 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LM=
P Subver: 0x175 
        Manufacturer: Cambridge Silicon Radio (10) 
  =

 
 
> > After that, I tried to create the second connection on slave2=
 side by running the same command (hcitool cc 
<master_addr>) and I obta=
in the following error: 
> > # Can't create connectio: input/output erro=
r. 
>  
> Run "hcidump -x" as root and show us the output. 
 
HCIDump=
 - HCI packet analyzer ver 1.16 
device: hci0 snap_len: 1028 filter: 0xf=
fffffff 
 
Thanks. 
Regards. 
Jers 
 
 
>  
>  
>  
> ---------=
---------------------------------------------- 
> The SF.Net email is sp=
onsored by: Beat the post-holiday blues 
> Get a FREE limited edition So=
urceForge.net t-shirt from ThinkGeek. 
> It's fun and FREE -- well, almo=
st....http://www.thinkgeek.com/sfshirt 
> ______________________________=
_________________ 
> Bluez-users mailing list 
> Bluez-users@lists.sour=
ceforge.net 
> https://lists.sourceforge.net/lists/listinfo/bluez-users =

>  =0A=0A=0A=0A________________________________________________________=
____=0ALibero ADSL: 3 mesi gratis e navighi a 1.2 Mega. E poi hai l'Adsl =
senza limiti a meno di 1 euro al giorno. =0AAbbonati subito senza costi d=
i attivazione su http://www.libero.it=0A=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
