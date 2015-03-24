Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: Broadcom 43340 BT support
From: =?iso-8859-1?q?J=FCrgen_Bausa?= <Juergen.Bausa@online.de>
Date: Tue, 24 Mar 2015 22:37:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201503242237.07923.Juergen.Bausa@online.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a laptop (asus x205ta / intel-baytrail) with the broadcom 43340 
chipset. However, while wireless is working now, bluetooth is not. I am 
running debian jessie 32 bit with kernel 4.0rc4:

root@lina:/home/jba# hciconfig --all
hci0:   Type: BR/EDR  Bus: SDIO
        BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
        DOWN 
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1 
        Link policy: 
        Link mode: SLAVE ACCEPT 
        
root@lina:/home/jba# grep Bluetooth /var/log/messages
Mar 24 21:30:44 lina kernel: [    6.521598] Bluetooth: Core ver 2.20
Mar 24 21:30:44 lina kernel: [    6.521634] Bluetooth: HCI device and 
connection manager initialized
Mar 24 21:30:44 lina kernel: [    6.521642] Bluetooth: HCI socket layer 
initialized
Mar 24 21:30:44 lina kernel: [    6.521649] Bluetooth: L2CAP socket layer 
initialized
Mar 24 21:30:44 lina kernel: [    6.521664] Bluetooth: SCO socket layer 
initialized
Mar 24 21:30:44 lina kernel: [    6.557743] Bluetooth: Generic Bluetooth SDIO 
driver ver 0.1
Mar 24 21:30:45 lina kernel: [   10.922564] Bluetooth: BNEP (Ethernet 
Emulation) ver 1.3
Mar 24 21:30:45 lina kernel: [   10.922571] Bluetooth: BNEP filters: protocol 
multicast
Mar 24 21:30:45 lina kernel: [   10.922579] Bluetooth: BNEP socket layer 
initialized
 
        
I have no idea where to start in order to enable BT. is there a driver yet? Do 
I need a firmware file? Where to get it, where to put it?

Any hints welcome.

Regards,

Juergen
