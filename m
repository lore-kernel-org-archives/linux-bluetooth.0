Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <403AC9D1.1000902@vpop.net>
From: Matthew Reimer <mreimer@vpop.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <lists.bluez.users.1077037423.2665.72.camel@pegasus.SOMEWHERE> <lists.bluez.users.403291AD.7080601@csr.com>
In-Reply-To: <lists.bluez.users.403291AD.7080601@csr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 23 Feb 2004 21:49:37 -0600

Steven Singer wrote:
> 
[snip]
> The spec allows the link quality to be tied to anything, but module
> manufacturers will be aware that if they don't have at least some
> component of the link quality sensitive to whether DH packets are likely
> to get through, they're going to get support calls of the form "why am I
> getting only 400 kbps but get_link_quality says the link is perfect?"
> 
> However, since the logs Matt gave show him running hcitool to get
> the link quality, he must be getting it on the Linux side of the
> link which, according to his hciconfig, is a CSR device.
> 
> This tells us that the CSR device is has a BER for received packets
> that's low enough for DH5 packets to stream at 700 kbps. However, it
> tells us nothing about the BER for packets received at the Ipaq end.
> The link may not be symmetric. However, even if the link had switched
> to DM5 packets, we'd expect to see 470 kbps. To get 265 kbps the link
> would have to be atrocious (> 0.4% BER). I think it's unlikely that
> we'd have a 0.4% BER one way and < 0.0025% the other way.
> 
> There may be other issues. For example, poor choice of L2CAP MTU
> could limit the packet types that are allowed (for example, L2CAP
> MTUs sigificantly below 150 could limit the data rate). This would
> show up on an HCI trace. An HCI trace would also confirm which profile
> was being used for the connection.
> 
> It may be that the Ipaq is limited in the rate at which it can process
> data. This could cause it to assert UART flow control to the Bluetooth
> chip, stalling the data flow.
> 
> As for testing with Zeevo, it's probably safest if I say nothing. Most
> interoperability testing is covered by NDAs.
> 
> 	- Steven

I think the UART speed hypothesis is right.

I did some further tests and got up to 340kbps over PAN. I think 
Activesync might have been getting in the way in my previous tests where 
I was only getting ~265kbps.

Then I used haret to read the UART registers and this is what I found:

   BTDLL 0x40200000      0x02
   BTDLH 0x40200004      0x00

   So if the baud rate = 14.7456MHz / (16 * (BTDLH << 8 | BTDLL))

then PPC2003 is programming the UART for 460800 bps.

I also got verification from Jamey Hicks at HP/CRL that the bluetooth 
part is hooked up to the pxa255's bluetooth serial port, so there should 
be plenty of bandwidth available there (921.6kbps).

I tried setting the divisor to 1 manually, but then bluetooth wouldn't 
work. Maybe PPC2003 isn't fast enough to handle interrupts at that rate?

I've included the rest of the register dump at the end in case there's 
anything else interesting there. I don't know much about serial 
programming, so I don't know what everything means, but it was 
interesting that DMA requests are disabled. Maybe if PPC2003's 
implementation used DMA, higher throughput could be achieved?

Matt




   BTIER 0x40200004      0x5d    receiver data avail int enabled |
                                 transmit FIFO data req int disabled |
                                 receiver line status int enabled |
                                 modem status int enabled |
                                 char timeout indication int enabled |
                                 NRZ coding disabled |
                                 UART unit enabled
                                 DMA requests are disabled

   BTIIR 0x40200008      0xc1    FIFO mode enable status = reserved (?) |
                                 no int pending
   BTFCR (write only)
   BTLCR 0x4020000c      0x03    DLAB = 0 | set break = 0 | sticky 
parity = 0 |
                                 even parity select = 0 (meaning odd 
parity) |
                                 parity enable = 0 (meaning no parity) |
                                 stop bits = 0 (meaning 1 stop bit) |
                                 word length select = 0x03 (meaning 
8-bit char)

   BTMCR 0x40200010      0x0b    dtr = 1 | rts = 1 | out1 = 0 | out2 = 1 |
                                 LOOP = 0

   BTLSR 0x40200014      0x60    FIFO err status = 0 | transmitter empty 
= 1 |
                                 transmit data req = 1 | break int = 0 |
                                 framing error = 0 | parity error = 0 |
                                 overrun error = 0 | data ready = 0

   BTMSR 0x40200018      0x10    dcts = 0 | ddsr = 0 | teri = 0 | ddcd = 1 |
                                 cts = 1 | dsr = 0 | ri = 0 | dcd = 0

   BTSPR 0x4020001c      0x00
   BTISR 0x40200020      0x00    xmitir = 0 | rcveir = 0 | xmode = 0 |
                                 txpl = 0 | rxpl = 0




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
