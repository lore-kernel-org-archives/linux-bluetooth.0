Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Zoom Bluetooth PCMCIA Card
From: Marcel Holtmann <marcel@holtmann.org>
To: Johnathon Meichtry <johnathon@meichtry.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41893E1D.701@meichtry.org>
References: <41893E1D.701@meichtry.org>
Content-Type: text/plain
Message-Id: <1099519948.7125.164.camel@pegasus>
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
Date: Wed, 03 Nov 2004 23:12:28 +0100

Hi Johnathon,

> Has anyone managed to get the *Zoom Bluetooth PCMCIA card* working with 
> the btuart_cs driver?  It's man.id us is the same as the CyberBlue CF 
> Card but when inserted I get the following:
> 
> *btuart_config: No usable port range found
> btuart_cs: RequestIO: No more items*
> 
> Yet i have ample resources and when inserted in the same machine (a 
> laptop) running XP the Widcomm drivers load fine so there is no hardware 
> compat. issue.
> 
> The odd thing is that on Marcel Holtmanns pages there is one with CIS 
> data (http://www.holtmann.org/linux/bluetooth/cis.html) and in there is 
> the CIS for this card yet the 2.6 kernel btuart_cs driver is unhappy for 
> some reason.  I have tried all the other drivers (by editing 
> pcmcia/config) and none work to the point where "hciconfig dev" shows a 
> valid device.  I have even edited the source for btuart_cs and added 
> some additional IO ports but that do not seemed to have helped.  I even 
> added some additional IRQ's to pcmcia/config.opts.
> 
> FYI I am running Gentoo 2.6.9-rc1 with the mh3 patch applied and 
> bluez-libs v2.1, bluez- utils v2.1-r1 and bluez-kernel v2.3.

I lately get my hands on the Zoom PCMCIA card and it works fine with the
hci_uart and serial_cs driver. Use "hciattach <dev> bcsp" and it should
also work for you.

> BTW Marcel & the team if you read this post thanks for all your work on 
> bluez, I have another laptop with a Xircom CBT card in it and for months 
> it has worked well thanks to all your effort.

Thanks. Did the Xircom card worked with a 2.6 kernel? Mine doesn't.

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
