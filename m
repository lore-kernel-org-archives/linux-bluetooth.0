Return-Path: <klaus@encephalon.dk>
Date: Wed, 25 Feb 2004 19:00:13 +0100
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund never activates pppd
Message-ID: <20040225180013.GA1700@encephalon.dk>
References: <20040223213658.GA1453@encephalon.dk> <1077573810.2791.161.camel@pegasus> <20040224085351.GA3782@encephalon.dk> <1077624875.2880.44.camel@pegasus> <20040225113847.GB1339@encephalon.dk> <1077716089.2919.86.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1077716089.2919.86.camel@pegasus>
From: klaus@encephalon.dk (Klaus Holst)
List-ID: <bluez-users.lists.sourceforge.net>


Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2004-02-25 14:34:49 +0100]:

> Hi Klaus,
> 
> > Here is the info from the PDA:
> > 
> > # hcitool info 00:04:3E:A2:2D:C9
> > Requesting information ...
> >         BD Address:  00:04:3E:A2:2D:C9
> >         Device Name: Pocket_PC
> >         LMP Version: 1.1 (0x1) LMP Subversion: 0x8d
> >         Manufacturer: Telencomm Inc. (18)
> >         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
> >                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
> >                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
> >                 <park state> <RSSI> <channel quality> <SCO link> 
> >                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
> >                 <CVSD> <power control> 
> 
> what iPAQ is this?


It is an Ipaq 2210.

> 
> > Actually the dongle (Belkin F8T001) is listed as supported in
> > http://www.holtmann.org/linux/bluetooth/devices.html.
> 
> It is fully supported, but there can be problems with the firmware you
> are using or with the interop to some other chips. We can't test this,
> because we have no access to the link manager. From the HCI layer
> onwards the Broadcom BCM2033 is fully supported.
> 
> > However in case I should try to find another dongle, can anyone recommend one 
> > which is properly supported by linux/bluez and has a reasonable range?
> 
> I had the best results with a Bluetooth chip from CSR.
> 

I went out to the store where I bought the dongle and returned it. Instead I
picked up a Belkin F8T003 dongle and now everything works flawlessly :-)!!!

Thanks for all the help.

Best regards
Klaus
