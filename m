Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with Billionton PCMCIA card
From: Marcel Holtmann <marcel@holtmann.org>
To: marcin@telscom.ch
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4187903F.16859.61AB28E@localhost>
References: <1099394605.10948.33.camel@pegasus>
	 <4187903F.16859.61AB28E@localhost>
Content-Type: text/plain
Message-Id: <1099401399.10948.47.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 02 Nov 2004 14:16:39 +0100

Hi Marcin,

> > > about what kernel version and what platform are we talking? Actually
> > > using hci_uart with BCSP and hciattach works perfect with the Zoom card.
> > > The btuart_cs is not the way to go and I will remove this driver in the
> > > future.
> > 
> >  I compiled kernel 2.6.9 with the latest patch (mh3). Platform is 
> > laptop with Pentium IV.
> > After removing btuart.conf I get:
> > 
> > cs: memory probe 0xa0000000-0xa0ffffff: clean.
> > ttyS10 at I/O 0x100 (irq = 10) is a 16C950/954
> > 
> 
>  It works with kernel 2.4.20 from RedHat 9, and doesn't hang. Still, 
> no idea why it hangs on the other one.

the serial drivers in 2.6 has changed and this might be the problem. Do
you used the same hciattach command that I used for the Zoom card?

>  Thanks for the tip, you can change it on Hardware support list. The 
> card is very cheap for PCMCIA and it is Class 1.

I thought of creating a new page for the serial based Bluetooth PCMCIA
and CF cards. I need to add the information about hciattach and with
what kernel version they work or not.

Do you wanna donate one of these cards so that I can take a look at it?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
