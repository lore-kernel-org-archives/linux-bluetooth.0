Return-Path: <DVornheder@t-online.de>
From: DVornheder@t-online.de (Dirk Vornheder)
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Some questions
Date: Tue, 15 Jun 2004 22:23:33 +0200
References: <1BYJR5-1Xq5q40@cmpmail07.bbul.t-online.de> <1086863592.1607.47.camel@pegasus>
In-Reply-To: <1086863592.1607.47.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200406152223.33329.dvornheder@t-online.de>
List-ID: <bluez-users.lists.sourceforge.net>



> > 	00:04:0E:85:35:15	Bluetooth ISDN Access Point
> > 	00:04:0E:83:3C:40	BlueZ (0)
> >                            00:02:72:44:CF:9F
> > BELKIN_PRT_44CF9F
> >
> > My questions:
> >
> > - No driver is loaded after plugin the adapter.
> >
> >    Is this ok ?
>
> I think the hci_usb is loaded, otherwise your device won't work.
>
> > - How can i open a internet connection ?
>
> Use pppd and the CAPI plugin for it. Check with capiinfo for your ISDN
> access point.
>

After loading the capi module the internet connection works.

>
> > - How can i print on my usb printer which is connected to the
> > BELKIN_PRT_44CF9F
> >
> >    bluetooth adapter ?
>
> First send me some info about this printer adapter for my list. The
> output "hcitool info ..." will be nice.
>

Here are the info:

hcitool info 00:02:72:44:CF:9F
Requesting information ...
        BD Address:  00:02:72:44:CF:9F
        Device Name: BELKIN_PRT_44CF9F
        LMP Version: 1.1 (0x1) LMP Subversion: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO>


> The CUPS printing backend for Bluetooth will help you out here.
>

After compile and install i try to print via spp and hcrp.

A connection to printer adpater is coming up but nothing is printed.

Here are some lines from my /etc/bluetooth/printers.conf:

default {
        # Bluetooth address of the device
        device 00:02:72:44:CF:9F;

        # Bluetooth printing protocol
        protocol serial;
        
        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "HP-Deskjet 960C";

The entires in  cups are:

bluetooth://00027244CF9F/spp

Under WIN-XP i can print via hcrp without any problem.

Dirk
