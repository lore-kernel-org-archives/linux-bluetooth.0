Return-Path: <cyrus@holtmann.org>
Message-ID: <1309005872.69060.YahooMailClassic@web26503.mail.ukl.yahoo.com>
Date: Sat, 25 Jun 2011 13:44:32 +0100 (BST)
From: Mark Hobley <markhobley@yahoo.co.uk>
Reply-To: markhobley@yahoo.co.uk
Subject: How do I make the computer visible to the mobile phone?
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am using Debian (Mixed/Unstable) and I have a Nano Tiny Bluetooth adapter
that uses an Accel Semiconductor microchip. The mobile phone is visible to
the computer, but I cannot see the computer from the mobile phone. How do I
make the computer visible to my mobile phone?

I have enabled both pscan and iscan as follows:

 hciconfig hci0 piscan

The hciconfig tool reveals the following configuration:

hciconfig -a                                                       
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:1F:81:00:01:1C  ACL MTU: 1021:4  SCO MTU: 180:1
        UP RUNNING PSCAN ISCAN 
        RX bytes:2273 acl:0 sco:0 events:59 errors:0
        TX bytes:479 acl:0 sco:0 commands:45 errors:0
        Features: 0xff 0x3e 0x09 0x76 0x80 0x01 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF 
        Link mode: SLAVE ACCEPT 
        Name: 'Accel-OB2'
        Class: 0x4a0100
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Uncategorized
        HCI Version: 2.0 (0x3)  Revision: 0x44
        LMP Version: 2.0 (0x3)  Subversion: 0x3
        Manufacturer: Cambridge Silicon Radio (10)

Does anyone know what the class codes are? Should I change the class code 
in the /etc/bluetooth/main.conf configuration file?

Mark.

