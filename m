Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] TDK Bluetooth PC Card
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41E694A2.8020908@gmx.net>
References: <41E694A2.8020908@gmx.net>
Content-Type: text/plain
Message-Id: <1105631330.7961.229.camel@pegasus>
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
Date: Thu, 13 Jan 2005 16:48:50 +0100

Hi Bernhard,

> It might be just me being stupid, but it seems I cannot figure out how 
> to get the TDK Bluetooth PC Card running - even though it's listed in 
> the compatibility list as "working".
> 
> My system is a Debian Sarge box with the 2.6.10 kernel-image from the 
> unstable branch (not that unstable though).
> 
> The card as read by the cardmanager:
>    product info: "TDK", "Bluetooth PC Card", "", ""
>    manfid: 0x0105, 0x4254
> 
> Problem number one was that this card (or the seemingly identical IBM PC 
> Card II) doesn't seem to be listed in the /etc/pcmcia/bluetooth.conf 
> that comes with the Debian-Sarge standard Bluez-package and therefore 
> the cardmanager didn't have a clue what to do with it. However I don't 
> really know how that entry in the config file is supposed to look like.
> 
> I've already tried the following:
> 
> 	card "TDK PCMCIA Bluetooth Card"
> 	  manfid 0x0105, 0x4254
> 	  version "TDK", "Bluetooth PC Card", "", ""
> 	  bind "serial_cs" class "bluetooth"
> 
> with the result of (syslog):
> 
> 	cardmgr[7528]: socket 0: TDK PCMCIA Bluetooth Card
> 	cardmgr[7528]: executing: 'modprobe serial_cs'
> 	kernel: ttyS14: detected caps 00000700 should be 00000100
> 	cardmgr[7528]: executing: './bluetooth start ttyS14'
> 	kernel: ttyS14 at I/O 0x1e0 (irq = 10) is a 16C950/954
> 
> That brings me to problem number two: there is no /dev/ttyS14 in my 
> filesystem. I suppose "mknod" would be the suitable tool to create this 
> entry but I have no idea what parameters would be necessary.

install udev and the device node will be there. After that you must run
"hciattach ttyS14 tdk".

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
