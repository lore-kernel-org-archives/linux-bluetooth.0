Return-Path: <klaus@encephalon.dk>
Date: Wed, 25 Feb 2004 12:38:47 +0100
From: Klaus Holst <klaus@encephalon.dk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund never activates pppd
Message-ID: <20040225113847.GB1339@encephalon.dk>
References: <20040223213658.GA1453@encephalon.dk> <1077573810.2791.161.camel@pegasus> <20040224085351.GA3782@encephalon.dk> <1077624875.2880.44.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1077624875.2880.44.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>


> > > show us "hciconfig -a" after you plugged in the dongle.
> > >
> >
> > hci0:   Type: USB
> >         BD Address: 00:03:C9:2E:6C:F6 ACL MTU: 377:10  SCO MTU: 16:0
> >         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
> >         RX bytes:647 acl:0 sco:0 events:18 errors:0
> >         TX bytes:314 acl:0 sco:0 commands:18 errors:0
> >         Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >         Link policy: HOLD SNIFF PARK
> >         Link mode: ACCEPT MASTER
> >         Name: 'MINI (linux)'
> >         Class: 0x000100
> >         Service Classes: Unspecified
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 0x1007
> >         Manufacturer: Broadcom Corporation (15)
>
> and what Bluetooth chip is in your PDA? Use "hcitool info <bdaddr>".
> 
> Do you have any other Bluetooth dongle to test this with? Maybe the
> Broadcom dongle is problematic.

> Regards

> Marcel

Here is the info from the PDA:

# hcitool info 00:04:3E:A2:2D:C9
Requesting information ...
        BD Address:  00:04:3E:A2:2D:C9
        Device Name: Pocket_PC
        LMP Version: 1.1 (0x1) LMP Subversion: 0x8d
        Manufacturer: Telencomm Inc. (18)
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> 
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
                <CVSD> <power control> 


Actually the dongle (Belkin F8T001) is listed as supported in
http://www.holtmann.org/linux/bluetooth/devices.html.

However in case I should try to find another dongle, can anyone recommend one 
which is properly supported by linux/bluez and has a reasonable range?

Best regards
Klaus
