Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <acb0c1690601130450sef926f5w4f0f4d8d58495269@mail.gmail.com>
From: Paulo Matias <syscoder@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] NAP connection suddenly stops to response without disconnecting
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
Date: Fri, 13 Jan 2006 10:50:25 -0200

Hi all,

Please help me with my problem. Thanks a lot if someone can help me with th=
is.

I've recently bought 2 Bluetooth USB dongles for connecting my
notebook to my little Gentoo Linux server, for getting Internet
access.

Yeah, it works. I've tested by downloading a Linux kernel for
measuring the download speed.  When the notebook is next to the
server, it downloads at ~ 60kb/s, my link speed. When the notebook is
at the other room, it downloads at ~ 30kb/s.

The problem is that when I request some URLs, the connection suddenly
stops to response (but doesn't disconnects the bnep interface), and
the only way to get it to work again is to unplug the two bluetooth
USB dongles, reconnect it, and restart the hcid, sdpd and pand in the
BlueZ server.

In the notebook, I've tried to use the default Windows XP
installation, with the software that comes with the USB Dongle. I've
tried a modified Gentoo Minimal Installation LiveCD too, in which I've
included the bluez-libs and bluez-utils packages I've compiled in the
server.

I've tried a lot of configurations: with medium security and a PIN,
without any security, changing device/lm to master, to accept, to
accept,master, and the same problem occurs. The problem occurs no
matter I use Linux or Windows in the notebook, connecting to the Linux
server.

Some information of my server system:
$ uname -a
Linux 1 2.6.14-gentoo-r4 #8 PREEMPT Wed Jan 11 09:22:03 BRST 2006 i686
Intel(R) Celeron(TM) CPU                1100MHz GenuineIntel GNU/Linux
$ grep BT /usr/src/linux/.config
CONFIG_BT=3Dy
CONFIG_BT_L2CAP=3Dy
CONFIG_BT_SCO=3Dy
CONFIG_BT_RFCOMM=3Dy
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dy
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_HIDP=3Dy
CONFIG_BT_HCIUSB=3Dy
CONFIG_BT_HCIUSB_SCO=3Dy
CONFIG_BT_HCIUART=3Dy
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_BCSP_TXCRC=3Dy
CONFIG_BT_HCIBCM203X=3Dy
CONFIG_BT_HCIBPA10X=3Dy
CONFIG_BT_HCIBFUSB=3Dy
CONFIG_BT_HCIVHCI=3Dy
$ echo /var/db/pkg/net-wireless/bluez-*
/var/db/pkg/net-wireless/bluez-firmware-1.1
/var/db/pkg/net-wireless/bluez-hcidump-1.27
/var/db/pkg/net-wireless/bluez-libs-2.22
/var/db/pkg/net-wireless/bluez-utils-2.22-r1

I've tried both versions 2.19 (masked as stable in Gentoo Portage) and
2.22 (masked as unstable) of bluez-libs and bluez-utils.

The 2 Bluetooth USB dongles are of the same manufacturer. The lsusb
command gives the following information:

Bus 002 Device 003: ID 1131:1001 Integrated System Solution Corp.

My actual /etc/bluetooth/hcid.conf is the following:

options {
        autoinit yes;
        security none;
        pairing multi;
        pin_helper /etc/bluetooth/pin-helper;
}
device {
        name "BlueZ at %h (%d)";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm accept,master;
        lp rswitch,hold,sniff,park;
}

My server already acts as a gateway for a local Ethernet network in
eth0. I've a ADSL connection via PPPoE in eth1. Some configuration
follows:

ifconfig:
eth0      Link encap:Ethernet  HWaddr 00:0A:E6:28:24:89
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
eth1      Link encap:Ethernet  HWaddr 00:E0:7D:FC:79:50
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
ppp0      Link encap:Point-to-Point Protocol
          inet addr:201.1.185.80  P-t-P:200.100.11.72  Mask:255.255.255.255

iptables:
iptables -A POSTROUTING -o ppp0 -j MASQUERADE
iptables -A FORWARD -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss
--mss 1400:1536 -j TCPMSS --clamp-mss-to-pmtu

# cat /proc/sys/net/ipv4/ip_forward
1

Some photos of my system:
The Bluetooth USB Dongle plugged into the notebook:
http://img227.imageshack.us/img227/5949/dsc021699yi.jpg
The Gentoo Server (note the Bluetooth Dongle lightning at the back):
http://img224.imageshack.us/img224/8045/dsc021713dz.jpg
The notebook acessing IRC at the other room via Bluetooth:
http://img219.imageshack.us/img219/4483/dsc021731mi.jpg

One thing I've perceived is that when I try to login into GMail in the
browser in the notebook, I can reproduce the problem. So, I've done a
log with the hcidump tool:

*** In the server, I do:
/etc/init.d/bluetooth start
pand --listen --role NAP --master --autozap
hcidump
****

HCI sniffer - Bluetooth packet analyzer ver 1.27
device: hci0 snap_len: 1028 filter: 0xffffffff

*** Now I request SDP discovery from the notebook to the server ***

> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0047
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0047 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x0100 (L2CAP)
          max 32
          cont 00
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0047 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          count 1
          handle 0x10000
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x1 len 0xe
          handle 0x10000
          max 300
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 1 flags 0x02 dlen 106
    L2CAP(d): cid 0x0047 len 102 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x61
          count 94
          aid 0x0000 (SrvRecHndl)
             uint 0x10000
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1116 (NAP) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0xf > <
             uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint 0x806 > > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1116 (NAP) uint 0x100 > >
          aid 0x0100 (SrvName)
             str "Network Access Point"
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0047
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0047
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4

*** Now I connect in the NAP and request some URLs in the browser of
the notebook. The connection in the notebook is ok by now. ***

*** In the server, I do:

ifconfig bnep0 192.168.0.1

In the notebook, it's already configured to use 192.168.0.2 as local
ip, 192.168.0.1 as gateway and 200.204.0.10 / 200.204.0.138 as DNS
servers.
***

[...]

> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 536
    L2CAP(d): cid 0x0040 len 532 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0800]
< ACL data: handle 1 flags 0x02 dlen 47
    L2CAP(d): cid 0x0049 len 43 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0800]
< ACL data: handle 1 flags 0x02 dlen 47
    L2CAP(d): cid 0x0049 len 43 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0800]
> HCI Event: Number of Completed Packets (0x13) plen 5

[...]

*** Now I request to login into GMail ***

[...]

> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 1 flags 0x02 dlen 47
    L2CAP(d): cid 0x0049 len 43 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0800]
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 1 flags 0x02 dlen 35
    L2CAP(d): cid 0x0049 len 31 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0806]
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 1 flags 0x02 dlen 35
    L2CAP(d): cid 0x0049 len 31 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0806]
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 1 flags 0x02 dlen 35
    L2CAP(d): cid 0x0049 len 31 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0806]
> HCI Event: Number of Completed Packets (0x13) plen 5

*** At this time, I don't receive anything in the hcidump that is
running in the server, no matter if I try to access URLs in the
notebook, if I try to ping the server. However, in the notebook, the
Dongle manufacturer's software informs it is sending packets. But in
the server, no packets are received until I request to close
connection. Now, I request to close connection in the notebook ***

> HCI Event: Disconn Complete (0x05) plen 4

*** Ok, let's try to do l2ping 00:11:67:0C:6C:31 in the server ***

< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
< ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
< ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
> HCI Event: Number of Completed Packets (0x13) plen 5
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4

*** And in the l2ping out, I get:
Ping: 00:11:67:0C:6C:31 from 00:11:67:0C:98:FE (data size 44) ...
no response from 00:11:67:0C:6C:31: id 0
1 sent, 0 received, 100% loss
***

*** Now I try to request again a SDP discovery from the notebook to
the server ***

> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Disconn Complete (0x05) plen 4

*** And in the notebook I get "Discovery failed" ***

As I've said, the only way to get Bluetooth communication working
correctly after this is to reconnect the USB Dongle and to restart the
BlueZ services in the server.

Has someone idea of what is happening? Which other data/information
could be useful to help identifying the problem? Please, help me. I
was very impressed with BlueZ and the Bluetooth technology, and really
want to get this working soon... =3D)

Thanks a lot,
Paulo Matias


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
