Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IMLKX2$E2762436C0892017786DF70B8B6FD8B7@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "cicciobueomarcio@inwind.it" <cicciobueomarcio@inwind.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] NAP Linux, Clients Window, Problem
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
Date: Sat, 10 Sep 2005 12:53:26 +0200

Hi, first of all... sorry for may english..


I have a lot oh problem =
whit to configure NAP Bluetooth.

My server (NAP) i connect to internet=
 whit eth1 e to lan whit eth0, I add a bluetooth dongle (sitecom cn502), =
to configure a NAP.

I use gentoo linux whit kernel 2.6.12 and bluez-ut=
ils 2.19, bluez-libs 2.19.

My hcid.conf:

options {
        autoini=
t yes;
        security auto;
        pairing multi;
        pin_helpe=
r /etc/bluetooth/pin-helper;
}
device {
        name "NAP Bluetooth %h=
";
        class 0x020104;
       iscan enable; pscan enable;
        =
lm master;
        lp rswitch,hold,sniff,park;
}

My pand conf:

--=
listen --role NAP --ethernet bnep0 --master --autozap --persist


Bnep=
 is builtin kernel (but I have the same problem whit module).

Ok.... t=
he problem:

I can see the windows client whit "hcitool scan"
and the =
client see my NAP, when I try to connect from win, no have error but not =
start the connection, BNEP not was created....

 # hcidump

HCI sniff=
er - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filt=
er: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Comman=
d: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:10:60:A6=
:A2:D4 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) pl=
en 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Comple=
te (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d=
) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF =
PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI =
Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection P=
acket Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet t=
ype: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4=0D
=
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: M=
ax Slots Change (0x1b) plen 3
> HCI Event: Link Key Request (0x17) plen =
6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdadd=
r 00:10:60:A6:A2:D4 key FC35D674A6515DA3FCF32831AF74998D
> HCI Event: Co=
mmand Complete (0x0e) plen 10
> HCI Event: Disconn Complete (0x05) plen =
4

 # lsusb
Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, =
Ltd Bluetooth Dongle

 # lsmod
Module                  Size  Used by=0D
=
hidp                   11968  -
ohci_hcd               19172  -
ehci_hc=
d               29352  -

 # l2ping 00:10:60:A6:A2:D4
Ping: 00:10:60:A=
6:A2:D4 from 00:10:60:A5:BD:11 (data size 44) ...
0 bytes from 00:10:60:=
A6:A2:D4 id 0 time 47.65ms
0 bytes from 00:10:60:A6:A2:D4 id 1 time 28.8=
1ms
0 bytes from 00:10:60:A6:A2:D4 id 2 time 37.79ms
3 sent, 3 received=
, 0% loss


thanks...



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
