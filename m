Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] GhostSong
From: Marcel Holtmann <marcel@holtmann.org>
To: the White Rabbit in Wonderland <ghostsong@aliceposta.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084655065.19124.3.camel@alice.wonderland>
References: <1084655065.19124.3.camel@alice.wonderland>
Content-Type: text/plain
Message-Id: <1084708779.4184.7.camel@pegasus>
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
Date: Sun, 16 May 2004 13:59:39 +0200

Hi,

> Cardctl ident 3Com "3CRWB6096B Bluetooth PC CARD","",""
> mandfid 0x0101,0x0041
> function : 2 (serial)
> ttyS16|I/O ox100 irq3 FUNCID=2 / 8 8250 16c960 
> 
> 3.3V 16bit PCCARD Function 0 [ready]
> 
> All i have to do is to test now

so this is a serial port based Bluetooth card. You must run hciattach to
attach that serial port through the hci_uart driver to the BlueZ stack.
I don't own that card, so you must try by yourself which is the correct
command line.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
