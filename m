Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Stefan <stv_vt@yahoo.com>
Date: Fri, 2 Jun 2006 14:53:25 +0000 (UTC)
Message-ID: <loom.20060602T160736-77@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] PAN over bluetooth - no TCP/IP activity
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I'm trying to create a PAN between a laptop and a desktop computer. 

I carefully followed the instructions for creating a PAN network
(http://bluez.sourceforge.net/contrib/HOWTO-PAN).

Right now I am able to connect, ending up with correct and configured "bnep0"
interfaces on both computers.

The problem is, that I can not even ping them. After a lot of tries, I figured
out, that if I put the bnep0 interface in promiscuous mode, using 

ifconfig bnep0 promisc (at the NAP side)

then ICMP packets starts flowing, and the both nodes are able to ping each
other. But that's all. 

On both nodes hcid & sdpd are running, bnep module is loaded, kernel version is
2.6.16 (Fedora Core 4), bluez-utils 2.15

Here is what I do:

@NAP: # pand -s -r NAP
@PANU: # pand -Q -r PANU -d NAP
@Both (after a while): # ifconfig bnep0 10.0.0.x netmask 255.255.255.0 up
@both: # ifconfig bnep0
bnep0     Link encap:Ethernet  HWaddr 11:11:11:11:11:11
          inet addr:10.0.0.x  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:478 (478.0 b)  TX bytes:64 (64.0 b)


Accoring to all docs I read, at this poing both nodes should be able to ping
each other. But they are not!

I don't know how important is, but just in case, here is the output of

# hciconfig hci0 -a

@Desktop NAP (USB dongle):

hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:1076 acl:25 sco:0 events:42 errors:0
        TX bytes:657 acl:19 sco:0 commands:17 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'experta'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe
        Manufacturer: Integrated System Solution Corp. (57)

@Laptop PANU (IBM/Lenovo Z60m):

hci0:   Type: USB
        BD Address: 00:14:A4:DF:2D:C8 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:133516 acl:2949 sco:0 events:6546 errors:0
        TX bytes:108738 acl:3185 sco:0 commands:1594 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'lenovo'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x206c LMP Ver: 2.0 (0x3) LMP Subver: 0x4132
        Manufacturer: Broadcom Corporation (15)

Could you please help me!

Regards,
Stefan




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
