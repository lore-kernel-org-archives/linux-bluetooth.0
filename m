Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Belkin F8T002 PCMCIA - how to get working?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20050427T005347-298@post.gmane.org>
References: <loom.20050427T005347-298@post.gmane.org>
Content-Type: text/plain
Message-Id: <1114598331.10706.392.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 27 Apr 2005 12:38:51 +0200

Hi Phil,

> I'm new to this and, having done a lot of search on google (this list could
> really use a .mbox archive :) ), it seems that there is no documented way of
> getting this card up and running. I'm hoping someone in here might be able to
> help. I'm running an updated, but otherwise stock, SUSE 9.3 Pro. Naturally the
> card works fine under Windows and I'm trying to avoid dumping what, outwardly,
> is a perfectly functional bit of hardware. I had hoped that serial_cs and
> hci_uart might be workable, but so far it's proving fairly futile.
> 
> cardctl ident provides :
> 
> Socket 0:
>   product info: "OXSEMI", "OXCB950", "Rev A"
>   manfid: 0x0279, 0x0001
>   function: 2 (serial)
> 
> dmesg only shows the following on inserting the card :
> 
> PCI: Enabling device 0000:02:00.0 (0000 -> 0003)

is this a PCMCIA, Compact Flash or CardBus card? Do you see another ttyS
device when calling dmesg?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
