Return-Path: <Lutz.Pressler@SerNet.DE>
Date: Tue, 18 May 2004 12:07:50 +0200 (CEST)
From: Lutz Pressler <Lutz.Pressler@SerNet.DE>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Peter Stephenson <pws@csr.com>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for security
 reasons"
In-Reply-To: <1084874021.5833.80.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <E1BQ1Vm-0006dh-00@intern.SerNet.DE>
List-ID: <bluez-users.lists.sourceforge.net>

> > > > Requesting information ...
> > > >         BD Address:  00:E0:03:39:C9:AB
> > > >         Device Name: Nokia 6230 LP
> > > >         LMP Version: 1.1 (0x1) LMP Subversion: 0x380
> > > >         Manufacturer: Cambridge Silicon Radio (10)
> > > >         Features: 0xbf 0xee 0x00 0x09
> > > >                 <3-slot packets> <5-slot packets> <encryption> <slot offset
> > > >
> > > >                 <timing accuracy> <role switch> <sniff mode> <RSSI>
> > > >                 <channel quality> <SCO link> <HV3 packets> <u-law log>
> > > >                 <A-law log>
> > >
> > > please install bluez-libs-2.7 and bluez-utils-2.7, because it looks like
> > > that this phone already contains some Bluetooth 1.2 features and I need
> > > to know the full 8 bytes of the remote features.
> >
> > Below HCI, at least, it's 1.1 only.  I'm surprised you're not seeing
> > at least CVSD and almost certainly power control --- could the third and
> > fourth bytes be scrambled somehow?
>
> please show us "hcidump -x" while requesting the remote information. We
> can decode the information by hand and you don't have to install new
> BlueZ packages.

HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
  AB C9 39 03 E0 00 18 00 00 00 00 00 00
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete(0x03) plen 11
  00 00 00 AB C9 39 03 E0 00 01 00
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  00 00 0F 00
> HCI Event: Command Complete(0x0e) plen 3
  01 00 00
< HCI Command: Remote Name Request(0x01|0x0019) plen 10
  AB C9 39 03 E0 00 00 00 00 00
> HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 00 00
> HCI Event: Command Status(0x0f) plen 4
  00 01 19 04
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 AB C9 39 03 E0 00 4E 6F 6B 69 61 20 36 32 33 30 20 4C 50
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
< HCI Command: Read Remote Version Information(0x01|0x001d) plen 2
  00 00
> HCI Event: Command Complete(0x0e) plen 3
  01 00 00
> HCI Event: Command Status(0x0f) plen 4
  00 01 1D 04
> HCI Event: Read Remote Ver Info Complete(0x0c) plen 8
  00 00 00 01 0A 00 80 03
> HCI Event: Command Complete(0x0e) plen 3
  01 00 00
< HCI Command: Read Remote Supported Features(0x01|0x001b) plen 2
  00 00
> HCI Event: Command Status(0x0f) plen 4
  00 01 1B 04
> HCI Event: Read Remote Supported Features(0x0b) plen 11
  00 00 00 BF EE 00 00 00 00 00 00
> HCI Event: Command Complete(0x0e) plen 3
  01 00 00
< HCI Command: Disconnect(0x01|0x0006) plen 3
  00 00 13
> HCI Event: Command Status(0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete(0x05) plen 4
  00 00 00 16
> HCI Event: Command Complete(0x0e) plen 3
  01 00 00


-- 
  _              |  Lutz Pressler          |  Tel: ++49-551-3700002
 |_     |\ |     |  Service Network GmbH   |  FAX: ++49-551-3700009
 ._|ER  | \|ET   |  Bahnhofsallee 1b       |   mailto:lp@SerNet.DE
Service Network  |  D-37081 Goettingen     |  http://www.SerNet.DE/
