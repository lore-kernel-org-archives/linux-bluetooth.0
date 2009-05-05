Return-Path: <cyrus@holtmann.org>
From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: linux-bluetooth@vger.kernel.org
Subject: BT git version triggers BUG: scheduling while atomic: swapper/0/0x10000100
Date: Tue, 5 May 2009 03:01:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200905050301.37528.Hugo.Mildenberger@namir.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When I tried to get a mobile phone connected to asterisk via bluetooth, the 
current git version of the linux bluetooth stack triggers a kernel bug:

	BUG: scheduling while atomic: swapper/0/0x10000100

This is triggered the moment when asterisk tries to pair the phone and leaves 
at least the BT subsystem in an unusable state. 

Commented excerpt from dmesg:

Linux version 2.6.30-rc4-00009-g953cdaa (root@localhost) (gcc version 4.3.2 
(Gentoo 4.3.2-r2 p1.5, pie-10.1.5) ) #2 Tue May 5 01:51:57 CEST 2009

[connecting a Cambridge Silicon Radio USB Bluetooth-Adapter ... ]

usb 4-1: new full speed USB device using ohci_hcd and address 2
usb 4-1: New USB device found, idVendor=0a12, idProduct=0001
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: configuration #1 chosen from 1 choice
Bluetooth: Core ver 2.15
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: Generic Bluetooth USB driver ver 0.5
usbcore: registered new interface driver btusb
Bluetooth: L2CAP ver 2.14
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.6
Bluetooth: SCO socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.11

[ now asterisk pairs a Nokia GSM phone via chan_mobile ...  ]

BUG: scheduling while atomic: swapper/0/0x10000100

Modules linked in: rfcomm bnep sco l2cap btusb bluetooth radeon drm i2c_core 
xt_time xt_connlimit xt_realm iptable_raw xt_comment xt_recent ipt_ULOG 
ipt_REJECT ipt_REDIRECT ipt_NETMAP ipt_MASQUERADE ipt_LOG ipt_ECN ipt_ecn 
ipt_CLUSTERIP ipt_ah ipt_addrtype nf_nat_tftp nf_nat_snmp_basic nf_nat_sip 
nf_nat_pptp nf_nat_proto_gre nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda 
ts_kmp nf_conntrack_amanda nf_conntrack_sane nf_conntrack_tftp 
nf_conntrack_sip nf_conntrack_proto_sctp nf_conntrack_pptp 
nf_conntrack_proto_gre nf_conntrack_netlink nf_conntrack_netbios_ns 
nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp xt_tcpmss xt_pkttype 
xt_owner xt_NFQUEUE xt_NFLOG nfnetlink_log xt_multiport xt_MARK xt_mark 
xt_mac xt_limit xt_length xt_iprange xt_helper xt_hashlimit xt_dscp xt_dccp 
xt_conntrack xt_connmark xt_CLASSIFY xt_tcpudp xt_state iptable_nat nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack iptable_mangle nfnetlink 
iptable_filter ip_tables x_tables arc4 ecb snd_atiixp snd_atiixp_modem 
snd_ac97_codec ac97_bus b43 snd_pcm snd_timer serio_raw snd snd_page_alloc 
mac80211 yenta_socket rsrc_nonstatic pcmcia_core 8139too ati_agp cfg80211

Pid: 0, comm: swapper Not tainted (2.6.30-rc4-00009-g953cdaa #2) Compaq nx9110 
(PG661ES#ABD)   
EIP: 0060:[<c01084f4>] EFLAGS: 00000246 CPU: 0
EIP is at default_idle+0x3b/0x3d
EAX: c04b8000 EBX: c04e55c0 ECX: 8c2de300 EDX: 00000027
ESI: 0009fe00 EDI: c04b2000 EBP: c04b9fb4 ESP: c04b9fb4
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
CR0: 8005003b CR2: b9c5b01c CR3: 183d1000 CR4: 000006d0
DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
DR6: ffff0ff0 DR7: 00000400 
Call Trace:
 [<c0101ed6>] cpu_idle+0x31/0x5b
 [<c0389b1d>] rest_init+0x4d/0x51
 [<c04baa0d>] start_kernel+0x27d/0x2e0
 [<c04ba544>] ? unknown_bootoption+0x0/0x1fb
 [<c04ba324>] i386_start_kernel+0x74/0x81
