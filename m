Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Catalin Drula <catalin.drula@imag.fr>
Message-ID: <loom.20050317T164923-411@post.gmane.org>
References: <Pine.GSO.4.33.0503171103450.12042-100000@horus.imag.fr> <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Handling a Hardware Error event on iPAQ h5550
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Mar 2005 15:59:06 +0000 (UTC)

Peter Wippich <pewi <at> gw-instruments.de> writes:
 
> It may be much simpler trying to find the cause of the data corruption.
> Do you have hardware handshake enabled ??
> Have you tried different baud rates ??
> Do you get any errors from the UART driver (like FiFo overruns) ??
> Have you tried to modify the UART FiFo settings ??

Well, I'm over 5 weeks into finding the cause of the data corruption. 
At first there were indeed overruns when receving. It turns out that 
on the processor of this device (Intel XScale PXA255) there's a HWUART 
(a UART with HW flow control capabilities) connected to the same lines 
as the "default" UART for communicating with the BT controller 
(this default UART is called BTUART). Changing to the HWUART solved the 
overruns problem. 
 
The problems now occur on the sending direction (host to controller). 
There is hardware flow control although the controller never deasserts 
the RTS (never tells the host to stop sending). There are no FIFO 
overruns, the FIFO does not overfill or anything like that. 

The speed of communication and the parameter appear to be hard coded in 
the BT module as 921600, 8N1 so there's not much to do there.

In fact even with an artificial slow-down of the sending stream (down to 
a few K/sec) these corrupted bytes still show. I could not correlate them
with anything else even after weeks of testing and instrumenting the 
kernel. There's really not much else that I can think of that could be 
wrong on the host side. I am unsure if the same problem occurs under 
Windows CE on this device, but apparently it does not. 

Catalin









-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
