Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with Billionton PCMCIA card
From: Marcel Holtmann <marcel@holtmann.org>
To: marcin@telscom.ch
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4187865E.12078.5F52B9D@localhost>
References: <418775F2.13601.5B50785@localhost>
	 <4187865E.12078.5F52B9D@localhost>
Content-Type: text/plain
Message-Id: <1099399565.10948.43.camel@pegasus>
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
Date: Tue, 02 Nov 2004 13:46:05 +0100

Hi Marcin,

> > about what kernel version and what platform are we talking? Actually
> > using hci_uart with BCSP and hciattach works perfect with the Zoom card.
> > The btuart_cs is not the way to go and I will remove this driver in the
> > future.
> 
>  I compiled kernel 2.6.9 with the latest patch (mh3). Platform is 
> laptop with Pentium IV.
> After removing btuart.conf I get:
> 
> cs: memory probe 0xa0000000-0xa0ffffff: clean.
> ttyS10 at I/O 0x100 (irq = 10) is a 16C950/954
> 
>  What command should I use? I loaded hci_uart (modprobe) and tried 
> hciattach with bcsp, but the system hangs completely:-( No reaction, 
> nothing...

with the Zoom card I used a simple command like "hciattach ttyS10 bcsp".
However my serial port got IRQ 3 and device ttyS6 assigned, but that
shouldn't be a problem. May you wanna give 2.6.10-rc1-bk11 a try or get
the oops when the systems hangs.

Another thing you can try is to check the *.inf file that comes with the
Windows driver for useful information and if this card really uses BCSP
by default and not H4.

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
