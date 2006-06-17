Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <448DB88D.8080306@stfw.eu>
References: <448DB88D.8080306@stfw.eu>
Date: Sat, 17 Jun 2006 12:32:27 +0200
Message-Id: <1150540347.17539.28.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hidd error 14 (Bad address) on ubuntu ppc
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> I'm trying to connect my bluetooth apple keyboard and my logitech MX900 
> to the internal dongle of my mac G5 with the latest ubuntu and I have 
> some troubles: The hidd program failed in a call to ioctl that set errno 
> to 14.
> I tried the brand new version 3.0 as well and I still have the same 
> problem. This bug has been confirmed in ubuntu but nobody seems to want 
> to work on it:
> https://launchpad.net/distros/ubuntu/+source/bluez-utils/+bug/32415
> The current solution is to remove bluez, which mean the bluetooth dongle 
> stays in HID mode (used to have the keyboard in bootloader) and every 
> mouse/keyboard device paired with OSX are working fine (except the mouse 
> wheel and eject button).
> This is not a solution for me since I would like to use the dongle for 
> phone transfer and a bluetooth headset as well.
> It seems nobody else care about this bug because they are fine with the 
> hid mode. Also, most researches on the subject are hidden by people who 
> just want to pair with there devices.
> 
> Pairing works fine for me and file transfer as well. The bluetooth 
> headset is also making a ioctl error. And I've got the same error with 3 
> other bluetooth dongles.
> 
> I tried to understand how the program works but it is not easy since it 
> is not commented. I think I can fix the bug by myself but I need some 
> help to run proper debugging sessions. Since this problem seems to only 
> happen on linux ppc, I suspect there is a big-endian problem somewhere 
> in the structures but I have no idea of where to start looking at. Maybe 
> someone has a better idea of what the problem is and can tell me where 
> to look.

run "hcidump -X -V" and show us the results.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
