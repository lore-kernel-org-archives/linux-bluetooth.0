Return-Path: <dcbw@redhat.com>
Subject: Re: SCO MTU fix needed for Kensington Bluetooth USB Adapter
From: Dan Williams <dcbw@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1152895158.25660.37.camel@localhost>
References: <1152893105.14037.21.camel@localhost.localdomain>
	 <1152894124.25660.33.camel@localhost>
	 <1152894617.14037.45.camel@localhost.localdomain>
	 <1152895158.25660.37.camel@localhost>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 12:48:09 -0400
Message-Id: <1152895689.14037.50.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2006-07-14 at 18:39 +0200, Marcel Holtmann wrote:
> Hi Dan,
> 
> > > > It's a dongle, already listed in the blacklist, but might need more
> > > > quirks.
> > > > 
> > > > "Kensington Bluetooth USB Adapter"
> > > > Model #33085
> > > > FCCID: QVZ10350001
> > > > 
> > > > lsusb
> > > > --------------------------
> > > > Bus 002 Device 009: ID 0a5c:3535 Broadcom Corp. 
> > > > 
> > > > hciconfig -a
> > > > --------------------------
> > > > hci0:   Type: USB
> > > >         BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
> > > >         UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
> > > >         RX bytes:379 acl:0 sco:0 events:17 errors:0
> > > >         TX bytes:318 acl:0 sco:0 commands:17 errors:0
> > > 
> > > please give us the full "hciconfig -a" to check the HCI version and
> > > revision of the chip.
> > 
> > Sorry...
> > 
> > hci0:   Type: USB
> >         BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
> >         UP RUNNING PSCAN ISCAN AUTH ENCRYPT 
> >         RX bytes:379 acl:0 sco:0 events:17 errors:0
> >         TX bytes:318 acl:0 sco:0 commands:17 errors:0
> >         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> >         Link policy: RSWITCH HOLD SNIFF PARK 
> >         Link mode: SLAVE ACCEPT 
> >         Name: 'localhost.localdomain-0'
> >         Class: 0x120104
> >         Service Classes: Networking
> >         Device Class: Computer, Desktop workstation
> >         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x6965
> >         Manufacturer: Broadcom Corporation (15)

For reference, kernel is:

2.6.17-1.2364.fc6 #1 SMP Mon Jul 10 12:40:21 EDT 2006 i686

> please also send "hciconfig hci0 features" (I don't like to decode that

[localhost ~]# /usr/sbin/hciconfig hci0 features
hci0:   Type: USB
        BD Address: xx:xx:xx:xx:xx:xx ACL MTU: 377:10 SCO MTU: 16:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
                <transparent SCO> <enhanced iscan> <interlaced iscan> 
                <interlaced pscan> <AFH cap. slave> <AFH cap. master> 


> by hand). And check if "hciconfig hci0 inqmode 1" succeeds.

[localhost ~]# /usr/sbin/hciconfig hci0 inqmode 1
[localhost ~]# 

(ie, nothing printed out)

Thanks,
Dan

> Regards
> 
> Marcel
> 
> 
