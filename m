Return-Path: <meh1@rts.at>
Message-ID: <001901c417c1$c5690e60$4000fe0a@rtsviec64>
From: "Harald Meier" <meh1@rts.at>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <003201c4161f$d37a2050$4000fe0a@rtsviec64> <1080630888.4094.5.camel@pegasus> <004501c417b0$76df38c0$4000fe0a@rtsviec64> <1080803375.2565.7.camel@pegasus>
Subject: Re: [Bluez-users] PAND and RFCOMM simultaneously
Date: Thu, 1 Apr 2004 10:17:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel!

Thank you for this information!

Should I be able to update this chipset firmware with the bluez-fw package?

Thanks for help,
Harald.

----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Harald Meier" <meh1@rts.at>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Sent: Thursday, April 01, 2004 9:09 AM
Subject: Re: [Bluez-users] PAND and RFCOMM simultaneously


> Hi Harald,
>
> > the output of hciconfig -a is:
> >     hci0: Type: PCIBD Address: 00:02:78:02:2E:C3 ACL MTU: 192:8 SCO MTU:
> > 64:8
> >     UP RUNNING PSCAN ISCAN
> >     RX bytes:70 acl:0 sco:0 events:7 errors:0
> >     TX bytes:34 acl:0 sco:0 commands:7 errors:0
> >     Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >     Link policy:
> >     Link mode: SLAVE ACCEPT
> >     Name: 'ka0009 (0)'
> >     Class: 0x000000
> >     Service Classes: Unspecified
> >     Device Class: Miscellaneous,
> >     HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:
> >     0x175
> >     Manufacturer: Cambridge Silicon Radio (10)
> >
> > Sorry for the last unformatted output, I pressed accidentally the send
> > button.
>
> I thought I already answered this, but it seems that I didn't :(
>
> To run an inquiry while you already have an ACL link open, you need at
> least the HCI 16.4 firmware on your Bluetooth chip.
>
> Regards
>
> Marcel
>
