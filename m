Return-Path: <summetj@cc.gatech.edu>
Date: Wed, 20 Oct 2004 11:49:42 -0400 (EDT)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket CF adaptor, limited to 2-3KB/sec RFCOMM
 PPP connection?
In-Reply-To: <1098287183.13853.15.camel@pegasus>
Message-ID: <Pine.GSO.4.58.0410201148100.1094@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
 <1097752969.4640.40.camel@notepaq>  <Pine.GSO.4.58.0410141051300.8280@gaia3.cc.gatech.edu>
  <1097929292.4911.37.camel@pegasus>  <Pine.GSO.4.58.0410201018500.19016@gaia3.cc.gatech.edu>
 <1098287183.13853.15.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

> > Do you know of a newer card that they make?
>
> if it is the G version then it won't work with the dtl1_cs driver. What
> does "hciconfig -a" say?
>

Dope! You're right. I was off by a letter, it's just the "F" card.

hciconfig -a is:
hci0:   Type: PCCARD
        BD Address: 00:E0:03:25:3E:CE ACL MTU: 340:4  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:144 acl:0 sco:0 events:12 errors:0
        TX bytes:352 acl:0 sco:0 commands:12 errors:0
        Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x21a
        Manufacturer: Nokia Mobile Phones (1)


So the "G" card uses a completely different chipset (CSR) and perhaps I
should try to exchange it for that?

Jay
