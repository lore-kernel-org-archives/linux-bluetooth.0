Return-Path: <sjoerd@spring.luon.net>
Date: Fri, 1 Oct 2004 20:11:43 +0200
From: Sjoerd Simons <sjoerd@spring.luon.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Sending files from phone to ppc machine fails
Message-ID: <20041001181143.GB4230@spring.luon.net>
References: <20040930161652.GA10170@spring.luon.net> <1096563173.4371.5.camel@notepaq> <20040930170602.GA13427@spring.luon.net> <1096641358.4265.8.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096641358.4265.8.camel@notepaq>
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, Oct 01, 2004 at 04:35:59PM +0200, Marcel Holtmann wrote:
> Hi Sjoerd,
> 
> > > >   Since some time i've got an Ericsson T630. Sending files via obex
> > > >   from both my ppc and x86 machine to the phone works fine. But from
> > > >   the phone i can only send stuff to the x86. When sending to my
> > > >   powerbook the phone almost immediatly indicates ``connection
> > > >   failed''.  [...]
> > > > 
> > > >   Any ideas what could be going wrong here ?
> > > 
> > > stop hidd and see if it works then.
> > 
> > That does indeed solve it (should have though about trying that). Could you
> > explain what's going wrong with hidd (yes i'm curious) ?
> 
> I already tracked this problem. The T610 has an old Bluetooth chip that
> can't do a role switch and this is forced when you run hidd. The CVS
> already contains a fixed hidd that can deal with it.

Is this only a problem when running hidd or can i also expect it when using 
other bluetooth apps (pand ?).

I've tested the cvs hidd version on my x86, but to no avail. When starting
hidd --server --master sending files from the phone start failing :(.

Do i need the -mh2 patches for this ?

For the record hcitool info on my phone says:
Requesting information ...
        BD Address:  00:0F:DE:1D:3F:75
        Device Name: Winter
        LMP Version: 1.1 (0x1) LMP Subversion: 0x503
        Manufacturer: Ericsson Technology Licensing (0)
        Features: 0x04 0xca 0x31 0x00 0x00 0x00 0x00 0x00
                <encryption> <RSSI> <SCO link> <u-law log> <A-law log> <CVSD> 

  Sjoerd
-- 
I use technology in order to hate it more properly.
		-- Nam June Paik
