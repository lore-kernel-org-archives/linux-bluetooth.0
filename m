Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-users] Config for Socket CF card
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: digger vermont <dv_mlist@verizon.net>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1074816664.3071.60.camel@pegasus>
References: <1074566227.3670.24.camel@myrna>
	 <1074597777.7088.2.camel@pegasus>  <1074697933.3020.19.camel@myrna>
	 <1074698544.7088.102.camel@pegasus>  <1074749699.2573.17.camel@myrna>
	 <1074775827.3071.1.camel@pegasus>  <1074814697.3159.3.camel@myrna>
	 <1074816664.3071.60.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074818667.1733.27.camel@localhost>
Mime-Version: 1.0
Date: Thu, 22 Jan 2004 16:44:27 -0800
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, 2004-01-22 at 16:11, Marcel Holtmann wrote:
> Hi Digger,
> 
> > > The Com1 card is working fine with 2.6.2-rc1. I have no other 2.6 kernel
> > > running at the moment, so please check if this is also problematic.
> > 
> > I rsync'd and built 2.6.2-rc1-ben1.  I'm sorry to say there is no
> > difference here. I still get "BCSP initialization timed out".
> 
> so it seems that the new serial driver causes problems with some UART's.
I can confirm that. Xircom PC cards don't work with 2.6 anymore.
Everything seems to be ok. Serial driver recognizes UART, creates a
port, etc. But hciattach always times out and I see only one or two
interrupts on that port. Unfortunately I don't have much more details
than that, didn't have time to investigate. I tried simple stuff like
different baud rate, reset, different interrupts (ie setserial) etc.
Nothing works.

Max 
