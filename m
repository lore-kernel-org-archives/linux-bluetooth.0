Return-Path: <edd@usefulinc.com>
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087818250.4328.1.camel@pegasus>
References: <1087817504.10134.16.camel@saag>
	 <1087818250.4328.1.camel@pegasus>
Date: Mon, 21 Jun 2004 13:04:24 +0100
Message-Id: <1087819464.10134.26.camel@saag>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hcid dying
Content-Type: text/plain
List-ID: <bluez-users.lists.sourceforge.net>

On Mon, 2004-06-21 at 13:44 +0200, Marcel Holtmann wrote:
> Hi Edd,
> 
> > Recently I've experienced the hcid process dying without warning.  I've
> > not yet been able to isolate why this happens, but another user reported
> > the same thing happening to me today, so I thought I'd ask if anybody
> > else was seeing this happen.
> 
> I don't saw that on my machines. What distribution? What kernel?

Debian (so I'm not excluding that this might be an error I introduced
somehow :).

For me, 2.6.6-mh3 when it last happened, iirc.

For the bug reporter I spoke to, 2.4.26-1-686 (from Debian.)

I asked for diagnostics from the reporter, and he sent me the output of
hciconfig -a, just after he restarted hcid:

hci0:   Type: USB
        BD Address: 00:0A:9A:xx:xx:xx ACL MTU: 339:4  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1978 acl:60 sco:0 events:53 errors:0
        TX bytes:1111 acl:32 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hactar-0202CC89E0E83C4EC7A99FE7ED3D12E970B...2.c'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver:
0x93
        Manufacturer: Transilica, Inc. (24)

notice the weird name.  This is with hcid.conf saying:

	name "%h-%d";

which is the default for Debian.

Looks like there might be some bug in computing the device number.  It
should be reading "hactar-0".

-- Edd
