Return-Path: <cijoml@volny.cz>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] obexserver and t68i problem?
Date: Sun, 25 Jul 2004 14:38:08 +0200
References: <200407251403.50608.cijoml@volny.cz> <1090758097.4791.81.camel@pegasus>
In-Reply-To: <1090758097.4791.81.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200407251438.08135.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Dne ne 25. =E8ervence 2004 14:21 jste napsal(a):
Hi Marcel,

it shouldn't be...
lp hold,sniff,park,rswitch;

CSR 16.1.1

MS mouse and keyboard connected


# cat /proc/bluetooth/l2cap
D2:AE:7D:F2:50:00 92:73:80:F2:50:00 1 19 0x0041 0x0069 672 48 0x1
D2:AE:7D:F2:50:00 92:73:80:F2:50:00 1 17 0x0040 0x0068 672 48 0x1
D2:AE:7D:F2:50:00 4C:3A:7F:F2:50:00 1 19 0x0041 0x0069 672 48 0x1
D2:AE:7D:F2:50:00 4C:3A:7F:F2:50:00 1 17 0x0040 0x0068 672 48 0x1
00:00:00:00:00:00 00:00:00:00:00:00 4 1 0x0000 0x0000 672 0 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 19 0x0000 0x0000 672 0 0x1
00:00:00:00:00:00 00:00:00:00:00:00 4 17 0x0000 0x0000 672 0 0x1
00:00:00:00:00:00 00:00:00:00:00:00 4 3 0x0000 0x0000 1024 0 0x0

Channels are free I think

Michal

> Hi Michal,
>
> > after a long time I needed send photos from my phone to bluez box.
> >
> > sdpd
> > sdptool add --channel=3D10 OPUSH
> > obexserver
> >
> > Mobile finds bluez box, try send, but writes connection problem:
> >
> > here is output of hcidump
> >
> > # hcidump -x
> > HCIDump - HCI packet analyzer ver 1.9
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> >
> > > HCI Event: Connect Request (0x04) plen 10
> >
> >   51 EC FC D9 0A 00 04 02 52 01
> > < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> >   51 EC FC D9 0A 00 00
> >
> > > HCI Event: Command Status (0x0f) plen 4
> >
> >   00 01 09 04
> >
> > > HCI Event: Connect Complete (0x03) plen 11
> >
> >   1A 2F 00 51 EC FC D9 0A 00 01 00
>
> you can easily look up the error code in the Bluetooth spec. part D. It
> says that 0x1a means "unsupported remote feature":
>
> 	The Unsupported Remote Feature error code indicates that the
> 	remote device does not support the feature associated with the
> 	issued command or LMP PDU.
>
> If I remember correctly then there was an email from a CSR guy that
> explained how to interpret these LMP related error messages.
>
> Frist guess is that it is a role switch or scatternet problem.
>
> Regards
>
> Marcel
