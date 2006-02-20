Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <017a01c635eb$3f417940$1f1410ac@AL31>
From: "Al Chane" <al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0177_01C6362E.4D2C4420"
Subject: [Bluez-devel] BlueZ: NAP by PAND + BRIDGE
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
Date: Mon, 20 Feb 2006 14:59:51 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0177_01C6362E.4D2C4420
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,

     I'm trying to implement a BlueZ NAP by using PAND + bridge + =
iptables.
The followings are what I've done:

1. on master (NAP) Fedora Core 2:
>brctl addbr pan0
>ifconfig pan0 10.0.0.1
>brctl setfd pan0 0
>brctl stp pan0 disable
>modprobe bnep
>pand --listen --master --role=3DNAP

2. on slave side #1 Fedora Core 1:
>modprobe bnep
>pand -c xx:xx:xx:xx:xx:xx
>ifconfig bnep0 10.0.0.2 netmask 255.255.255.0
>route add default gw 10.0.0.1

3. on master (NAP):
>brctl addif pan0 bnep0
>ifconfig bnep0 0.0.0.0

so far it works fine, bnep0 is created, and adding bridge interface
bnep0 to pan0 seems ok.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Feb 20 13:32:47 AL30 hcid[1960]: link_key_request =
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :09:C5:02:00:42)
Feb 20 13:32:47 AL30 hcid[1960]: pin_code_request =
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :09:C5:02:00:42)
Feb 20 13:32:54 AL30 hcid[1960]: link_key_notify =
(sba=3D00:10:60:A2:D8:7C)
Feb 20 13:32:54 AL30 hcid[1960]: Replacing link key 00:10:60:A2:D8:7C =
00:09:C5:0 2:00:42
Feb 20 13:32:54 AL30 pand[11631]: New connection from 00:09:C5:02:00:42 =
bnep0
Feb 20 13:32:55 AL30 kernel: ip_tables: (C) 2000-2002 Netfilter core =
team
Feb 20 13:32:55 AL30 kernel: ip_tables: (C) 2000-2002 Netfilter core =
team
Feb 20 13:34:21 AL30 kernel: device bnep0 entered promiscuous mode
Feb 20 13:34:21 AL30 kernel: pan0: port 1(bnep0) entering learning state
Feb 20 13:34:21 AL30 kernel: pan0: topology change detected, propgating
Feb 20 13:34:21 AL30 kernel: pan0: port 1(bnep0) entering forwarding =
state
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


4. slave side #2 connection to NAP:
>modprobe bnep
>pand -c xx:xx:xx:xx:xx:xx
>ifconfig bnep0 10.0.0.3 netmask 255.255.255.0
>route add default gw 10.0.0.1

5. Once bnep1 is created, on master NAP side:
>brctl addif pan0 bnep1
>ifconfig bnep1 0.0.0.0


#bnep1 cannot be added to bridge pan0:
#console shows: br_add_interface: File exists
#system log shows: kernel: bnep1: attempt to add interface with same =
source ad dress.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DFeb 20 =
13:34:50 AL30 hcid[1960]: link_key_request (sba=3D00:10:60:A2:D8:7C, =
dba=3D00 :11:67:09:2B:A3)
Feb 20 13:34:50 AL30 hcid[1960]: pin_code_request =
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :11:67:09:2B:A3)
Feb 20 13:34:56 AL30 hcid[1960]: link_key_notify =
(sba=3D00:10:60:A2:D8:7C)
Feb 20 13:34:56 AL30 hcid[1960]: Replacing link key 00:10:60:A2:D8:7C =
00:11:67:0 9:2B:A3
Feb 20 13:34:59 AL30 hcid[1960]: link_key_request =
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :11:67:09:2B:A3)
Feb 20 13:35:03 AL30 hcid[1960]: link_key_request =
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :11:67:09:2B:A3)
Feb 20 13:35:04 AL30 pand[11755]: New connection from 00:11:67:09:2B:A3 =
bnep1
Feb 20 13:35:28 AL30 kernel: bnep1: attempt to add interface with same =
source ad dress.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

>ifconfig
bnep0     Link encap:Ethernet  HWaddr 00:10:60:A2:D8:7C
          inet6 addr: fe80::210:60ff:fea2:d87c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:126 errors:0 dropped:0 overruns:0 frame:0
          TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:7592 (7.4 Kb)  TX bytes:656 (656.0 b)

bnep1     Link encap:Ethernet  HWaddr 00:10:60:A2:D8:7C
          inet6 addr: fe80::210:60ff:fea2:d87c/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:49 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:5613 (5.4 Kb)  TX bytes:188 (188.0 b)

eth0      Link encap:Ethernet  HWaddr 00:01:29:4C:06:46
          inet addr:172.16.20.30  Bcast:172.16.20.255  =
Mask:255.255.255.0
          inet6 addr: fe80::201:29ff:fe4c:646/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:782 errors:0 dropped:0 overruns:0 frame:0
          TX packets:577 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:622359 (607.7 Kb)  TX bytes:81575 (79.6 Kb)
          Interrupt:11 Base address:0x1000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:2672 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2672 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1994880 (1.9 Mb)  TX bytes:1994880 (1.9 Mb)

pan0      Link encap:Ethernet  HWaddr 00:10:60:A2:D8:7C
          inet addr:10.0.0.1  Bcast:10.255.255.255  Mask:255.0.0.0
          inet6 addr: fe80::200:ff:fe00:0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:108 errors:0 dropped:0 overruns:0 frame:0
          TX packets:17 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:6496 (6.3 Kb)  TX bytes:994 (994.0 b)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Why the bnep1 cannot be added to bridge pan0? Please note that bnep0 and =
bnep1
's BT addresses refer to the same address as pan0's address. Is it =
normal?


Thanks for the helps,

Al








------=_NextPart_000_0177_01C6362E.4D2C4420
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>
<DIV><FONT size=3D2>
<P><FONT size=3D2>Hi,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp; I'm trying to =
implement a=20
BlueZ NAP by using PAND + bridge + iptables.<BR>The followings are what =
I've=20
done:<BR><BR>1. on master (NAP) Fedora Core 2:<BR>&gt;brctl addbr=20
pan0<BR>&gt;ifconfig pan0 10.0.0.1<BR>&gt;brctl setfd pan0 =
0<BR>&gt;brctl stp=20
pan0 disable<BR>&gt;modprobe bnep<BR>&gt;pand --listen --master=20
--role=3DNAP<BR><BR>2. on slave side #1 Fedora Core 1:<BR>&gt;modprobe=20
bnep<BR>&gt;pand -c xx:xx:xx:xx:xx:xx<BR>&gt;ifconfig bnep0 10.0.0.2 =
netmask=20
255.255.255.0<BR>&gt;route add default gw 10.0.0.1<BR><BR>3. on master=20
(NAP):<BR>&gt;brctl addif pan0 bnep0<BR>&gt;ifconfig bnep0 =
0.0.0.0<BR><BR>so far=20
it works fine, bnep0 is created, and adding bridge interface<BR>bnep0 to =
pan0=20
seems=20
ok.<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>Feb 20=20
13:32:47 AL30 hcid[1960]: link_key_request (sba=3D00:10:60:A2:D8:7C, =
dba=3D00=20
:09:C5:02:00:42)<BR>Feb 20 13:32:47 AL30 hcid[1960]: pin_code_request=20
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :09:C5:02:00:42)<BR>Feb 20 13:32:54 =
AL30=20
hcid[1960]: link_key_notify (sba=3D00:10:60:A2:D8:7C)<BR>Feb 20 13:32:54 =
AL30=20
hcid[1960]: Replacing link key 00:10:60:A2:D8:7C 00:09:C5:0 =
2:00:42<BR>Feb 20=20
13:32:54 AL30 pand[11631]: New connection from 00:09:C5:02:00:42 =
bnep0<BR>Feb 20=20
13:32:55 AL30 kernel: ip_tables: (C) 2000-2002 Netfilter core =
team<BR>Feb 20=20
13:32:55 AL30 kernel: ip_tables: (C) 2000-2002 Netfilter core =
team<BR>Feb 20=20
13:34:21 AL30 kernel: device bnep0 entered promiscuous mode<BR>Feb 20 =
13:34:21=20
AL30 kernel: pan0: port 1(bnep0) entering learning state<BR>Feb 20 =
13:34:21 AL30=20
kernel: pan0: topology change detected, propgating<BR>Feb 20 13:34:21 =
AL30=20
kernel: pan0: port 1(bnep0) entering forwarding=20
state<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<BR><BR>4.=20
slave side #2 connection to NAP:<BR>&gt;modprobe bnep<BR>&gt;pand -c=20
xx:xx:xx:xx:xx:xx<BR>&gt;ifconfig bnep0 10.0.0.3 netmask=20
255.255.255.0<BR>&gt;route add default gw 10.0.0.1<BR><BR>5. Once bnep1 =
is=20
created, on master NAP side:<BR>&gt;brctl addif pan0 =
bnep1<BR>&gt;ifconfig bnep1=20
0.0.0.0<BR><BR><BR>#bnep1 cannot be added to bridge pan0:<BR>#console =
shows:=20
br_add_interface: File exists<BR>#system log shows: kernel: bnep1: =
attempt to=20
add interface with same source ad=20
dress.<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3DFeb=20
20 13:34:50 AL30 hcid[1960]: link_key_request (sba=3D00:10:60:A2:D8:7C, =
dba=3D00=20
:11:67:09:2B:A3)<BR>Feb 20 13:34:50 AL30 hcid[1960]: pin_code_request=20
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :11:67:09:2B:A3)<BR>Feb 20 13:34:56 =
AL30=20
hcid[1960]: link_key_notify (sba=3D00:10:60:A2:D8:7C)<BR>Feb 20 13:34:56 =
AL30=20
hcid[1960]: Replacing link key 00:10:60:A2:D8:7C 00:11:67:0 =
9:2B:A3<BR>Feb 20=20
13:34:59 AL30 hcid[1960]: link_key_request (sba=3D00:10:60:A2:D8:7C, =
dba=3D00=20
:11:67:09:2B:A3)<BR>Feb 20 13:35:03 AL30 hcid[1960]: link_key_request=20
(sba=3D00:10:60:A2:D8:7C, dba=3D00 :11:67:09:2B:A3)<BR>Feb 20 13:35:04 =
AL30=20
pand[11755]: New connection from 00:11:67:09:2B:A3 bnep1<BR>Feb 20 =
13:35:28 AL30=20
kernel: bnep1: attempt to add interface with same source ad=20
dress.<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<BR><BR>&gt;ifconfig<BR>bnep0&nbsp;&nbsp;&nbsp;&nbsp=
;=20
Link encap:Ethernet&nbsp; HWaddr=20
00:10:60:A2:D8:7C<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
inet6 addr: fe80::210:60ff:fea2:d87c/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:126 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:19=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RX=20
bytes:7592 (7.4 Kb)&nbsp; TX bytes:656 (656.0=20
b)<BR><BR>bnep1&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; HWaddr =

00:10:60:A2:D8:7C<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
inet6 addr: fe80::210:60ff:fea2:d87c/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX =
packets:49=20
errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:5=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RX=20
bytes:5613 (5.4 Kb)&nbsp; TX bytes:188 (188.0=20
b)<BR><BR>eth0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; =
HWaddr=20
00:01:29:4C:06:46<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; inet=20
addr:172.16.20.30&nbsp; Bcast:172.16.20.255&nbsp;=20
Mask:255.255.255.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
inet6 addr: fe80::201:29ff:fe4c:646/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:782 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:577=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:1000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RX=20
bytes:622359 (607.7 Kb)&nbsp; TX bytes:81575 (79.6=20
Kb)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Interrupt:11 Base=20
address:0x1000<BR><BR>lo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link=20
encap:Local =
Loopback<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
inet addr:127.0.0.1&nbsp;=20
Mask:255.0.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
inet6=20
addr: ::1/128=20
Scope:Host<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP =
LOOPBACK=20
RUNNING&nbsp; MTU:16436&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:2672 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX=20
packets:2672 errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RX=20
bytes:1994880 (1.9 Mb)&nbsp; TX bytes:1994880 (1.9=20
Mb)<BR><BR>pan0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link encap:Ethernet&nbsp; =
HWaddr=20
00:10:60:A2:D8:7C<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; inet=20
addr:10.0.0.1&nbsp; Bcast:10.255.255.255&nbsp;=20
Mask:255.0.0.0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
inet6=20
addr: fe80::200:ff:fe00:0/64=20
Scope:Link<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP=20
BROADCAST RUNNING MULTICAST&nbsp; MTU:1500&nbsp;=20
Metric:1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX=20
packets:108 errors:0 dropped:0 overruns:0=20
frame:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX =
packets:17=20
errors:0 dropped:0 overruns:0=20
carrier:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
collisions:0=20
txqueuelen:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RX=20
bytes:6496 (6.3 Kb)&nbsp; TX bytes:994 (994.0=20
b)<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<BR><BR>Why=20
the bnep1 cannot be added to bridge pan0? Please note that bnep0 and =
bnep1<BR>'s=20
BT addresses refer to the same address as pan0's address. Is it=20
normal?<BR><BR><BR>Thanks for the=20
helps,<BR><BR>Al<BR><BR><BR><BR><BR><BR><BR></FONT></P></FONT><FONT=20
size=3D2></DIV></FONT></FONT></DIV></BODY></HTML>

------=_NextPart_000_0177_01C6362E.4D2C4420--




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
