Return-Path: <sjoerd@spring.luon.net>
Date: Fri, 1 Oct 2004 11:58:14 +0200
From: Sjoerd Simons <sjoerd@spring.luon.net>
To: Marcel Holtmann <marcel@holtmann.org>, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Sending files from phone to ppc machine fails
Message-ID: <20041001095814.GA5611@spring.luon.net>
References: <20040930161652.GA10170@spring.luon.net> <1096563173.4371.5.camel@notepaq> <20040930170602.GA13427@spring.luon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040930170602.GA13427@spring.luon.net>
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, Sep 30, 2004 at 07:06:02PM +0200, Sjoerd Simons wrote:
> On Thu, Sep 30, 2004 at 06:52:53PM +0200, Marcel Holtmann wrote:
> > Hi Sjoerd,
> > 
> > >   Since some time i've got an Ericsson T630. Sending files via obex from
> > >   both my ppc and x86 machine to the phone works fine. But from the phone
> > >   i can only send stuff to the x86. When sending to my powerbook the
> > >   phone almost immediatly indicates ``connection failed''.  [...]
> > > 
> > >   Any ideas what could be going wrong here ?
> > 
> > stop hidd and see if it works then.
> 
> That does indeed solve it (should have though about trying that).

Seems i was a little too fast. Now it works ``sometimes'', but most of the
times it takes three or four tries to send a file over. Incidentally i'm
working on another x86 machine today and that also works fine ?

The moment it goes wrong is a little different though. I get this when
it fails the first time:

HCIDump - HCI packet analyzer ver 1.10
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  75 3F 1D DE 0F 00 04 02 52 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  75 3F 1D DE 0F 00 01 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Link Key Request (0x17) plen 6
  75 3F 1D DE 0F 00 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  75 3F 1D DE 0F 00 F4 D8 1D 5D 52 C4 28 CB 63 65 02 03 CD BC 
  00 C3 
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 75 3F 1D DE 0F 00 
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 75 3F 1D DE 0F 00 01 01 
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00 
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  75 3F 1D DE 0F 00 01 
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00 
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  29 00 18 CC 
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04 
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  75 3F 1D DE 0F 00 01 00 00 00 
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 29 00 18 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04 
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  75 3F 1D DE 0F 00 01 00 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 00 19 04 

  Sjoerd
-- 
Nothing is as simple as it seems at first
	Or as hopeless as it seems in the middle
		Or as finished as it seems in the end.
