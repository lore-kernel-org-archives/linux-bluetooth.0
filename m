Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT3030
From: Marcel Holtmann <marcel@holtmann.org>
To: =?koi8-r?Q?=E8=C5=C4=C9=CE?= <hedin@hiervard.ru>
Cc: bluez-users@lists.sf.net
In-Reply-To: <200405232027.52861.hedin@hiervard.ru>
References: <200405232027.52861.hedin@hiervard.ru>
Content-Type: text/plain
Message-Id: <1085321952.8309.17.camel@pegasus>
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
Date: Sun, 23 May 2004 16:19:12 +0200

Hi,

> I'm still stuck with my BT3030 dongle. Nobody can help me on my quest :(
> What does this error mean: 
> 
> Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> usbcore: registered new driver bcm203x
> usb 1-1: new full speed USB device using address 2
> bcm203x_probe: Mini driver request failed
> bcm203x: probe of 1-1:1.0 failed with error -5.
> 
> I have everything installed, what I need.

I actually don't think so, because this error only occurs when the
request_firmware() call for BCM2033-MD.hex fails. This is not a kernel
error. It is is a problem of your hotplug setup. You must have a working
firmware.agent for loading firmware from userspace into the kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
