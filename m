Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
To: Carl Orsborn <cjo@csr.com>
cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
In-Reply-To: <4118DAF9.2080204@csr.com>
Message-ID: <Pine.LNX.4.59.9999.0408101615190.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>     <1092071356.4564.12.camel@pegasus>
 <4117B098.5020805@dark-reality.de>     <1092073167.4564.26.camel@pegasus>
    <4117C0AB.2010609@superbug.demon.co.uk>     <1092090364.4564.46.camel@pegasus>
 <41180E64.1010007@dark-reality.de>     <1092140041.4564.96.camel@pegasus>
    <4118C562.1050300@superbug.demon.co.uk>    
 <Pine.LNX.4.59.9999.0408101435250.22497@brava.dcs.gla.ac.uk> <4118DAF9.2080204@csr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Aug 2004 16:31:54 +0100 (BST)

Hi Carl,

Thanks for adding your info to the discussion - much appreciated.

On Tue, 10 Aug 2004 3:26pm +0100, Carl Orsborn wrote:

> I can't find anything in this thread that reveals whether you're
> trying to send SCO traffic over USB or UART.  The data handling
> for the two cases have subtle differences.

As far as I'm aware, we're dealing with USB only.

> Over USB, there's an isochronous connection - the bus provides
> capacity for 8 ksamples/second in each direction.  If a CSR
> device somehow fails to receive SCO traffic from air it fills
> the embarrassing gap in the USB to-host flow with dummy
> data.  Thus, the host continues to receive 8 ksamples/second.
>
> Over UART, the same compensation mechanism applies - the CSR
> device makes up data for any from-air gaps.  This allows the
> host to match its tx sample rate to the connection's rx
> sample rate, and so removes the need for the host to maintain
> an accurate 8 kHz clock.
>
> As I noted above, the USB/SCO path is isochronous.  This means
> packets can be lost silently.  If the path is carrying 16-bit

Does this mean that it is sufficient to clock the outgoing data (with a 
packet or two of buffering) according to the data received on the SCO 
connection over USB? I suppose any dropouts due to the isochronous nature 
of the (incoming) link will complicate this...

This is what the current (hack of a) driver does at the moment, minus the 
extra buffering. Since the buffering is missing, there are dropouts which 
I assume are being caused by data not being provided in time.



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
