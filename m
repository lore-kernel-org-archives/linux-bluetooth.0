Return-Path: <pb@nexus.co.uk>
Subject: Re: [Bluez-devel] lmx9814
From: Philip Blundell <pb@nexus.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076866147.2840.11.camel@pegasus>
References: <1076864335.23437.70.camel@dixie.nexus.co.uk>
	 <1076865499.2840.8.camel@pegasus>
	 <1076865675.23437.73.camel@dixie.nexus.co.uk>
	 <1076866147.2840.11.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076869842.23437.75.camel@dixie.nexus.co.uk>
Mime-Version: 1.0
Date: Sun, 15 Feb 2004 18:30:42 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 2004-02-15 at 17:29, Marcel Holtmann wrote:
> if you have a 5500 that runs Windows, check is with "hcitool info ..."
> from another Linux machine. If it is a CSR chip, simply try to use the
> BCSP method of hciattach.

Hi Marcel

Here's what it says.  Can you interpret this for me?  :-)

dixie:/home/pb/gpe/base# hcitool info 08:00:17:19:EE:71
Requesting information ...
        BD Address:  08:00:17:19:EE:71
        Device Name: POCKET_PC
        LMP Version: 1.1 (0x1) LMP Subversion: 0x180
        Manufacturer: RTX Telecom A/S (21)
        Features: 0xff 0x3b 0x05 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <SCO link> <HV2 packets>
                <HV3 packets> <CVSD> <power control>
dixie:/home/pb/gpe/base#

Thanks

p.
