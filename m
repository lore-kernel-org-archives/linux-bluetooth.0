Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4118DAF9.2080204@csr.com>
From: Carl Orsborn <cjo@csr.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
References: <4117AB9A.9010909@dark-reality.de>
    <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
    <1092073167.4564.26.camel@pegasus>
    <4117C0AB.2010609@superbug.demon.co.uk>
    <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
    <1092140041.4564.96.camel@pegasus>
    <4118C562.1050300@superbug.demon.co.uk>
    <Pine.LNX.4.59.9999.0408101435250.22497@brava.dcs.gla.ac.uk>
In-Reply-To: <Pine.LNX.4.59.9999.0408101435250.22497@brava.dcs.gla.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 10 Aug 2004 15:26:01 +0100

I know nothing of snd-bt-sco or alsa, so some of my comments
below will doubtless expose my ignorance, but I know something
of how CSR devices handle SCO traffic (or, at least, how
they're *supposed* to handle SCO traffic).

I can't find anything in this thread that reveals whether you're
trying to send SCO traffic over USB or UART.  The data handling
for the two cases have subtle differences.

Over USB, there's an isochronous connection - the bus provides
capacity for 8 ksamples/second in each direction.  If a CSR
device somehow fails to receive SCO traffic from air it fills
the embarrassing gap in the USB to-host flow with dummy
data.  Thus, the host continues to receive 8 ksamples/second.

Over UART, the same compensation mechanism applies - the CSR
device makes up data for any from-air gaps.  This allows the
host to match its tx sample rate to the connection's rx
sample rate, and so removes the need for the host to maintain
an accurate 8 kHz clock.

The Bluetooth device has a pair of *small* ring buffers for each
SCO connection - one for each direction.  They are small to
keep audio latency low; manufacturers of audio devices insist
on low latency.  Keeping latency low for audio traffic flowing
over HCI (USB or UART) is hard.  Most of our customers route
SCO traffic over the Bluetooth device's separate audio interface
(PCM port), bypassing the HCI transport.

As I noted above, the USB/SCO path is isochronous.  This means
packets can be lost silently.  If the path is carrying 16-bit
samples (the normal case), and if a USB packet can hold an
odd number of bytes, this can lead to a 1 byte offset in
the audio stream.  This sounds ghastly.  We fixed this in the
Bluetooth device's firmware ages ago - spotting the loss of
sync by looking for SCO packet headers.  However, many host
USB device drivers can still suffer this problem.

Much of this is discussed in CSR's "HCI Implementation" document,
bcore-me-026, though this is normally only made available to
CSR's (direct) customers.

Regards,

Carl

Jonathan Paisley wrote:

> On Tue, 10 Aug 2004 1:53pm +0100, James Courtier-Dutton wrote:
> 
>> 4) SCO then waits until SCO has finished (2), and only then takes X 
>> samples from the ring buffer, creates a SCO packet, and sends it to 
>> the hardware...then repeats.
>> 5) Add a SCO api call, so that the higher level module can find out 
>> how much of the SCO packet has been output, and thus return accurate 
>> hardware pointer values.
> 
> 
> Is this additional api call necessary? Suppose packets are about 24 
> bytes (that's what I remember them to be). So the suggestion is to have 
> two of these in flight at a time. Given 8000 Hz sampling rate (equating 
> to 8000 or 16000 bytes per second if using 8bit or 16bit PCM, 
> respectively), those 24 bytes correspond to between 1.5 and 3ms.
> 
> In summary: isn't it sufficient to just keep track of what packets have 
> been sent? This gives 3ms accuracy.
> 
> Thanks.




**********************************************************************
The information transmitted is intended only for the person or
entity to which it is addressed and may contain confidential 
and/or privileged material. 
Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by 
persons or entities other than the intended recipient is 
prohibited. 
If you received this in error, please contact the sender and 
delete the material from any computer.
**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
