Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] lockup problem with larger packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Erwin Authried <eauth@softsys.co.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098928778.23859.32.camel@kabel>
References: <1098480115.3258.61.camel@justakiss>
	 <1098539750.26310.17.camel@pegasus>  <1098928778.23859.32.camel@kabel>
Content-Type: text/plain
Message-Id: <1098964060.6636.15.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 28 Oct 2004 13:47:40 +0200

Hi Erwin,

> > > I have cross-compiled bluez for uClinux-2.4.20 for ARM7, with the bluez
> > > kernel patch applied, and bluez-utils 2.10. I'm using the Conceptronic
> > > CBT100C PCMCIA card on the system. The card is initialized with
> > > "hciattach ttyS2 bcsp". Basically, the system works fine, but I see
> > > occasional overrun errors on the UART, maybe because the ARM7 is running
> > > with 40MHz only. When I transmit larger packets (l2ping -s 300 ...), the
> > > number of overrun errors increases, and sometimes the system locks up.
> > > I'm getting an endless sequence of: 
> > > 
> > > bcsp_pkt_cull: Peer acked invalid packet
> > > bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
> > > bcsp_pkt_cull: Peer acked invalid packet
> > > bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
> > > bcsp_pkt_cull: Peer acked invalid packet
> > > ...
> > 
> > I am not a BCSP or uClinux expert so I think that I can't help you here,
> > but from my testing with the BCSP part of the hci_uart driver I never
> > saw any problems like this.
> > 
> After a lot of debugging, I found out that the serial irq routine calls
> tty_flip_buffer_push with the serial interrupt disabled. The processing
> of the input buffer in bcsp_recv (hci_bcsp.c) was too slow so that the
> characters that were buffered in the FIFO during that time caused an
> overrun (There is no RTS/CTS flowcontrol). I have done modifiations to
> hci_bcsp.c so that the processing is done much faster, and the problem
> seems to have gone. 

please provide us a patch with your modifications.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
