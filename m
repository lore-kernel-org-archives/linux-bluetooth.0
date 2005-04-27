Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Phil Stopford <philstopford@hotmail.com>
Message-ID: <loom.20050427T142840-221@post.gmane.org>
References: <loom.20050427T005347-298@post.gmane.org> <1114598331.10706.392.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Belkin F8T002 PCMCIA - how to get working?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 27 Apr 2005 12:34:43 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Phil,
> 

I had to prune quoted entries to get this to post from gmane.org. Sorry.

> 
> is this a PCMCIA, Compact Flash or CardBus card? Do you see another ttyS
> device when calling dmesg?
> 

Cardbus. A quick search on the dmesg
output, after inserting the card, for 'serial' turned up this :

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
PCI: Found IRQ 11 for device 0000:00:03.1
PCI: Sharing IRQ 11 with 0000:00:03.0

Searching for ttyS doesn't turn up anything in the dmesg output at all.

I've posted the before and after dmesg output to the following URLs :

http://ldex.terica.net/before
http://ldex.terica.net/after

> Regards
> 
> Marcel
> 

Thanks for the quick response,

Phil.




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
