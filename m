Return-Path: <eiko.oltmanns@web.de>
From: Eiko Oltmanns <eiko.oltmanns@web.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Problems with PCMCIA Bluetooth card (cbt100c)
Date: Mon, 23 Feb 2004 23:35:28 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402141823.34699.eiko.oltmanns@web.de> <200402162310.11538.eiko.oltmanns@web.de> <1076972502.2840.63.camel@pegasus>
In-Reply-To: <1076972502.2840.63.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200402232335.28444.eiko.oltmanns@web.de>
Sender: eiko.oltmanns@web.de
List-ID: <bluez-users.lists.sourceforge.net>

Am Dienstag, 17. Februar 2004 00:01 schrieb Marcel Holtmann:
> Hi Eiko,
>
[...]
> > I tried the following command:
> >
> > linux:/home/eiko # hciattach /dev/ttyS17 csr
> > Initialization timed out.
> >
> > What could be wrong there?
>
> the card is CSR based, but in BCSP mode or the card has no CSR chip on
> it. Or it uses another init baud rate or or or ...
>

I did  some more research on it. The card has an CSR chip and it is in BCSP 
mode. I can execute hciattach without error messsage now:

Systemlog after inserting the card:

Feb 23 22:23:11 linux cardmgr[855]: socket 0: Serial or Modem
Feb 23 22:23:11 linux cardmgr[855]: executing: 'insmod -v /lib/
modules/2.4.21-99-eiko//pcmcia/serial_cs.o'
Feb 23 22:23:11 linux cardmgr[855]: + Using /lib/modules/2.4.21-99-eiko//
pcmcia/serial_cs.o
Feb 23 22:23:11 linux cardmgr[855]: + Symbol version prefix ''
Feb 23 22:23:11 linux kernel: ttyS17 at port 0x0100 (irq = 0) is a 16C950/954
Feb 23 22:23:11 linux cardmgr[855]: executing: './serial start ttyS17'
Feb 23 22:23:11 linux kernel: Trying to free nonexistent resource 
<00000100-00000107>
Feb 23 22:23:11 linux kernel: Trying to free nonexistent resource 
<00000100-00000107>

Then I executed 'hciattach ttyS17 bcsp' and started hcid.
Systemlog:

Feb 23 23:00:08 linux kernel: BlueZ Core ver 2.3 Copyright (C) 2000,2001 
Qualcomm Inc
Feb 23 23:00:08 linux kernel: Written 2000,2001 by Maxim Krasnyansky 
<maxk@qualcomm.com>
Feb 23 23:00:08 linux kernel: BlueZ HCI UART driver ver 2.1 Copyright (C) 
2000,2001 Qualcomm Inc
Feb 23 23:00:08 linux kernel: Written 2000,2001 by Maxim Krasnyansky 
<maxk@qualcomm.com>
Feb 23 23:00:08 linux /sbin/hotplug[1791]: no runnable /etc/hotplug/
bluetooth.agent is installed
Feb 23 23:00:25 linux hcid[1801]: HCI daemon ver 2.4 started
Feb 23 23:00:25 linux kernel: bcsp_timed_event: Timeout, retransmitting 1 pkts
Feb 23 23:00:26 linux hcid[1801]: HCI dev 0 up
Feb 23 23:00:26 linux hcid[1801]: Starting security manager 0
Feb 23 23:00:27 linux kernel: bcsp_timed_event: Timeout, retransmitting 1 pkts

Hci0 is up, but I can't use it. 'hcitool scan' doesn't find any devices. The 
output from 'hciconfig -a' is:

hci0:   Type: UART
        BD Address: 00:10:60:AA:54:47 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:257 acl:0 sco:0 events:12 errors:0
        TX bytes:767 acl:0 sco:0 commands:14 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
Can't read local name on hci0. Connection timed out(110)

The Systemlog during this command:

Feb 23 23:00:27 linux kernel: bcsp_timed_event: Timeout, retransmitting 1 pkts
Feb 23 23:04:10 linux kernel: bcsp_timed_event: Timeout, retransmitting 1 pkts
Feb 23 23:04:10 linux kernel: bcsp_recv: Error in BCSP hdr checksum
Feb 23 23:04:10 linux kernel: bcsp_timed_event: Timeout, retransmitting 1 pkts
Feb 23 23:04:10 linux kernel: bcsp_recv: Short BCSP packet
Feb 23 23:04:10 linux kernel: bcsp_recv: Error in BCSP hdr checksum
Feb 23 23:04:15 linux last message repeated 18 times
Feb 23 23:04:19 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:19 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:19 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:19 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:20 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:20 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:20 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:20 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:20 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:20 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:20 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:20 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:21 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:21 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:21 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:21 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:21 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:21 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
Feb 23 23:04:21 linux kernel: bcsp_pkt_cull: Peer acked invalid packet
Feb 23 23:04:21 linux kernel: bcsp_handle_le_pkt: Found a LE sync pkt, card 
has reset
(This mesage appears frequently until I killl hciattach)

I had a little e-Mail conversation with Antonio Maestre, who tested the card. 
He is using it successfully with kernel 2.6.1.
I am currently running the Suse kernel 2.4.21 (Suse 9.0). 

Eiko

> Regards
>
> Marcel
