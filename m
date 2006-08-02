Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: neci <robo.neci@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Wed, 2 Aug 2006 22:26:19 +0200
References: <200608021725.01649.robo.neci@gmail.com>
	<200608022158.27059.robo.neci@gmail.com>
	<44D10743.6080800@ibdcon.org.br>
In-Reply-To: <44D10743.6080800@ibdcon.org.br>
MIME-Version: 1.0
Message-Id: <200608022226.21020.robo.neci@gmail.com>
Cc: Paulo Wollny <paulo.wollny@ibdcon.org.br>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Connection refused
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

doing something wrong? i can upload files with OBEX object push client.

linux:/dev # cd /dev && mknod rfcomm0 c 216 0 && mknod rfcomm1 c 216 1
linux:/dev # chmod 666 /dev/rfcomm*
linux:/dev # ls | grep rfcomm
rfcomm0
rfcomm1
linux:/dev # hcitool scan
Scanning ...
        00:01:E3:58:23:EA       Neci
linux:/dev # rfcomm bind 0 00:01:E3:58:23:EA 1
Can't create device: Address already in use

Paulo Wollny write:
>sorry, was wrong... :-)
>striping the * from the mknod shall work.
>see if there are the /dev/rfcomm* files
>after that, issue rfcomm bind 0 xx:xx:xx:xx:xx:xx 1 as root.
>this shall work.
>neci schrieb:
> yes i know, and?
>
> Paulo Wollny write:
> =A0 =

>> the initial # is the prompt from the command line.
>>
>> neci schrieb:
>> =A0 =A0 =

>>> it is wrong command?
>>> #cd /dev && *mknod rfcomm0* c 216 0 && *mknod* rfcomm1 c 216 1
>>> bash: *mknod: command not found
>>>
>>> i edit him
>>>
>>> # cd /dev && mknod rfcomm0 c 216 0 && mknod rfcomm1 c 216 1
>>> # chmod 666 /dev/rfcomm*
>>> # rfcomm connect rfcomm0
>>> Can't connect RFCOMM socket: Connection refused
>>>
>>> Paulo Wollny write:
>>> =A0 =A0 =A0 =

>>>> As root, issue the following command:
>>>> cd /dev && *mknod rfcomm0* c 216 0 && *mknod* rfcomm1 c 216 1
>>>> then, chmod 666 /dev/rfcomm*
>>>>
>>>> neci schrieb:
>>>> =A0 =A0 =A0 =A0 =

>>>>> Hello,
>>>>> i can't create /dev/rfcomm. What is wrong? attach config files and out
>>>>> from hcidump.
>>>>>
>>>>> # rfcomm connect rfcomm0
>>>>> Can't connect RFCOMM socket: Connection refused
>>>>>
>>>>> # hcidump
>>>>> HCI sniffer - Bluetooth packet analyzer ver 1.24
>>>>> device: hci0 snap_len: 1028 filter: 0xffffffff
>>>>>
>>>>> linux:/etc # hcidump
>>>>> HCI sniffer - Bluetooth packet analyzer ver 1.24
>>>>> device: hci0 snap_len: 1028 filter: 0xffffffff
>>>>> < HCI Command: Create Connection (0x01|0x0005) plen 13
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>> HCI Event: Connect Complete (0x03) plen 11
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> < ACL data: handle 42 flags 0x02 dlen 12
>>>>> =A0 =A0 L2CAP(s): Connect req: psm 3 scid 0x0040
>>>>> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> HCI Event: Max Slots Change (0x1b) plen 3
>>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>>> ACL data: handle 42 flags 0x02 dlen 16
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 statu=
s 0
>>>>> =A0 =A0 =A0 Connection successful
>>>>> < ACL data: handle 42 flags 0x02 dlen 16
>>>>> =A0 =A0 L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>>>>> =A0 =A0 =A0 MTU 1024
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> ACL data: handle 42 flags 0x02 dlen 17
>>>>>> ACL data: handle 42 flags 0x01 dlen 1
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
>>>>> =A0 =A0 =A0 Success
>>>>> =A0 =A0 =A0 MTU 335
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> ACL data: handle 42 flags 0x02 dlen 16
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>>>>> =A0 =A0 =A0 MTU 335
>>>>> < ACL data: handle 42 flags 0x02 dlen 14
>>>>> =A0 =A0 L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>>>>> =A0 =A0 =A0 Success
>>>>> < ACL data: handle 42 flags 0x02 dlen 8
>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> ACL data: handle 42 flags 0x02 dlen 8
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>>>>> < ACL data: handle 42 flags 0x02 dlen 18
>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 14 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_=
len 8
>>>>> =A0 =A0 =A0 dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
>>>>> =A0 =A0 =A0 frame_size 330 max_retrans 0 credits 7
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> ACL data: handle 42 flags 0x02 dlen 18
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 14 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_=
len 8
>>>>> =A0 =A0 =A0 dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
>>>>> =A0 =A0 =A0 frame_size 330 max_retrans 0 credits 4
>>>>> < ACL data: handle 42 flags 0x02 dlen 8
>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>>>>>> HCI Event: Role Change (0x12) plen 8
>>>>>> HCI Event: Max Slots Change (0x1b) plen 3
>>>>>> HCI Event: Link Key Request (0x17) plen 6
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Command Complete (0x0e) plen 10
>>>>>> ACL data: handle 42 flags 0x02 dlen 8
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
>>>>> < ACL data: handle 42 flags 0x02 dlen 8
>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
>>>>> < ACL data: handle 42 flags 0x02 dlen 12
>>>>> =A0 =A0 L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>>> ACL data: handle 42 flags 0x02 dlen 8
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(d): cid 0x0040 len 4 [psm 3]
>>>>> =A0 =A0 =A0 RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> ACL data: handle 42 flags 0x02 dlen 12
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>>> =A0 =A0 L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
>>>>> < HCI Command: Disconnect (0x01|0x0006) plen 3
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =

>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>> HCI Event: Disconn Complete (0x05) plen 4
>>>>>>
>>>>>> --------------------------------------------------------------------=
--
>>>>>> --
>>>>>>
>>>>>> #
>>>>>> # HCI daemon configuration file.
>>>>>> #
>>>>>> # $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
>>>>>> #
>>>>>>
>>>>>> # HCId options
>>>>>> options {
>>>>>> =A0# Automatically initialize new devices
>>>>>> =A0autoinit yes;
>>>>>>
>>>>>> =A0# Security Manager mode
>>>>>> =A0# =A0 none - Security manager disabled
>>>>>> =A0# =A0 auto - Use local PIN for incoming connections
>>>>>> =A0# =A0 user - Always ask user for a PIN
>>>>>> =A0#
>>>>>> =A0security auto;
>>>>>>
>>>>>> =A0# Pairing mode
>>>>>> =A0# =A0 none =A0- Pairing disabled
>>>>>> =A0# =A0 multi - Allow pairing with already paired devices
>>>>>> =A0# =A0 once =A0- Pair once and deny successive attempts
>>>>>> =A0pairing multi;
>>>>>>
>>>>>> =A0# PIN helper
>>>>>> =A0# if you want a interactiv query of your pin use /usr/bin/bluepin
>>>>>> =A0# /bin/bluepincat is using the pin in the /etc/bluetooth/pin file
>>>>>> =A0# pin_helper /usr/bin/bluepin;
>>>>>> =A0pin_helper /bin/bluepincat;
>>>>>>
>>>>>> =A0# D-Bus PIN helper
>>>>>> =A0#dbus_pin_helper;
>>>>>> }
>>>>>>
>>>>>> # Default settings for HCI devices
>>>>>> device {
>>>>>> =A0# Local device name
>>>>>> =A0# =A0 %d - device id
>>>>>> =A0# =A0 %h - host name
>>>>>> =A0name "PC";
>>>>>>
>>>>>> =A0# Local device class
>>>>>> =A0# e.g.
>>>>>> =A0# =A00xsss100 =3D Computer
>>>>>> =A0# =A00xsss104 =3D Computer Desktop
>>>>>> =A0# =A00xsss108 =3D Computer Server
>>>>>> =A0# =A00xsss10c =3D Computer Laptop
>>>>>> =A0# The 'sss' above defines the service-class (not quite, only the
>>>>>> =A0# first 11 bits, the next 11 define the device-class, than 2 form=
at
>>>>>> bits.) # See
>>>>>> https://www.bluetooth.org/foundry/assignnumb/document/baseband # for
>>>>>> more information.
>>>>>> =A0# 0x100bbb stands for "Object Transfer =A0(v-Inbox, v-Folder, ...=
)"
>>>>>> =A0# 0x020bbb stands for "Networking (LAN, Ad hoc, ...)"
>>>>>> =A0class 0xdb0100;
>>>>>>
>>>>>> =A0# Default packet type
>>>>>> =A0#pkt_type DH1,DM1,HV1;
>>>>>>
>>>>>> =A0# Inquiry and Page scan
>>>>>> =A0# valid parameters: enable | disable
>>>>>> =A0iscan enable;
>>>>>> =A0pscan enable;
>>>>>>
>>>>>> =A0# Default link mode
>>>>>> =A0# =A0 none =A0 - no specific policy
>>>>>> =A0# =A0 accept - always accept incoming connections
>>>>>> =A0# =A0 master - become master on incoming connections,
>>>>>> =A0# =A0 =A0 =A0 =A0 =A0 =A0deny role switch on outgoing connections
>>>>>> =A0lm accept;
>>>>>>
>>>>>> =A0# Default link policy
>>>>>> =A0# =A0 none =A0 =A0- no specific policy
>>>>>> =A0# =A0 rswitch - allow role switch
>>>>>> =A0# =A0 hold =A0 =A0- allow hold mode
>>>>>> =A0# =A0 sniff =A0 - allow sniff mode
>>>>>> =A0# =A0 park =A0 =A0- allow park mode
>>>>>> =A0lp rswitch,hold,sniff,park;
>>>>>>
>>>>>> =A0# Authentication and Encryption (Security Mode 3)
>>>>>> =A0auth disable;
>>>>>> =A0encrypt disable;
>>>>>> }
>>>>>>
>>>>>> --------------------------------------------------------------------=
--
>>>>>> --
>>>>>>
>>>>>> #
>>>>>> # RFCOMM configuration file.
>>>>>> #
>>>>>> # $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
>>>>>> #
>>>>>>
>>>>>> rfcomm0 {
>>>>>> =A0# Automatically bind the device at startup
>>>>>> =A0bind yes;
>>>>>>
>>>>>> =A0# Bluetooth address of the device
>>>>>> =A0device 00:01:E3:58:23:EA;
>>>>>>
>>>>>> =A0# RFCOMM channel for the connection
>>>>>> =A0channel=A01;
>>>>>>
>>>>>> =A0# Description of the connection
>>>>>> =A0comment "Mobil";
>>>>>> }
>>>>>>
>>>>>> --------------------------------------------------------------------=
--
>>>>>> --
>>>>>>
>>>>>> --------------------------------------------------------------------=
--
>>>>>> -- - Take Surveys. Earn Cash. Influence the Future of IT
>>>>>> Join SourceForge.net's Techsay panel and you'll get the chance to
>>>>>> share your opinions on IT & business topics through brief surveys --
>>>>>> and earn cash
>>>>>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&C=
ID=3DDEV
>>>>>> DE V
>>>>>> --------------------------------------------------------------------=
--
>>>>>> --
>>>>>>
>>>>>> _______________________________________________
>>>>>> Bluez-users mailing list
>>>>>> Bluez-users@lists.sourceforge.net
>>>>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =

>>>> ----------------------------------------------------------------------=
--
>>>> - Take Surveys. Earn Cash. Influence the Future of IT
>>>> Join SourceForge.net's Techsay panel and you'll get the chance to share
>>>> your opinions on IT & business topics through brief surveys -- and earn
>>>> cash
>>>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDE
>>>> V _______________________________________________
>>>> Bluez-users mailing list
>>>> Bluez-users@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>> =A0 =A0 =A0 =A0 =

>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> =A0 =



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
