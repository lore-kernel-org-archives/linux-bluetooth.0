Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft  Mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: Jonathan Sass <jsass@magnifeye.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <450E38B8-2D19-11D9-ADC1-0005027BA2B7@magnifeye.com>
References: <450E38B8-2D19-11D9-ADC1-0005027BA2B7@magnifeye.com>
Content-Type: text/plain
Message-Id: <1099440358.7125.14.camel@pegasus>
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
Date: Wed, 03 Nov 2004 01:05:57 +0100

Hi Jonathan,

> I am trying to install the Microsoft Bluetooth mouse and keyboard.
> 
> Using a custom built 2.6.8-1.521 with uinputs enabled and the latest 
> bluetooth cvs.
> 
> The hardware I have is supported according to Marcel Holtmann's list of 
> devices.
> 
> I do not know what to do to get it to work tho.
> 
> I can run a modinfo hidp. It shows I am using ver 1.0
> 
> I can "see" the mouse and keyboard when I do a scan.
> I can "connect" using the -c <address> command
> 
> But I do not know what to do next.
> 
> I have been reading www.beuche.ch/comp/mx900/mx900_old.html
> 
> It  mentions looking for and loading uinput, but I cannot find any 
> module to load.
> I run bthid -d yet no log gets created.

using uinput and bthid is the old way. Try hidp kernel module and hidd
from the latest bluez-utils.

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
