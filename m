Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Belkin F8T002 PC Card problem with Bluez
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: "Alexandre Jousset@NL" <mid@gtmp.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F4F6BF2.6080303@gtmp.org>
References: <3F4F6BF2.6080303@gtmp.org>
Message-Id: <1062170277.27784.138.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 29 Aug 2003 17:17:51 +0200
Content-Type: text/plain

Hi Alexandre,

> 	I am trying for 3 days to configure this card on my laptop. I am 
> running Mandrake 9.2beta with a hand-compiled kernel 2.4.22.
> 
> 	First, to make my card recognized by the hardware, I have to enter 
> "cardctl insert". It does not do this automatically. Is this normal ? 
> But when I remove the card it beeps and knows that the card is no more 
> here. But this is not the most important problem... Here it is...
> 
> 	I succeeded to know what to do to have the card recognized by the 
> kernel (compile with CONFIG_SERIAL as a module) and now when I do the 
> "cardctl insert"command, I have the new /dev/ttyS4 device that appears. 
> OK. But then, when I try to hciattach it with "hciattach /dev/ttyS4 any 
> flow", the CPU is loaded and in the /var/log/messages logfile is 
> appended a lot of lines, all the same, saying "h4_recv: Unknown HCI 
> packet type ef", with the last "ef" changed with "0f", "18", etc... each 
> time a different hexadecimal number.

try "hciattach /dev/ttyS4 bcsp".

> 	I patched the drivers/char/serial.c module source and the 
> include/linux/pci_ids.h to have the chip recognized by the serial module.

Send the patch (diff -urN) to the mailing list.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
