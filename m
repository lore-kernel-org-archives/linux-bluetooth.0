Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cambride USB adapter not working
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099588624.4731.3.camel@anders2003.neurope.ikea.com>
References: <1099588624.4731.3.camel@anders2003.neurope.ikea.com>
Content-Type: text/plain
Message-Id: <1099742836.6919.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 06 Nov 2004 13:07:16 +0100

Hi Anders,

> I have problems with my new Cambridge USB BT adapter. Please see the
> attached log files for device details. In short, the USB subsystem
> detects the device but hciconfig does not recognize it. Again, all
> details that I suspect are needed to analyse the problem should be in
> the logs.
> 
> I can add the the adapter works great in Windoes, so I do not think that
> the hardware is defunkt...
> 
> Kernel 2.6.9-mh3

don't compress any attachments, because otherwise I can't view them
inline in my mail client and actually I going to ignore such posts.

However the lsusb output is not so much important than the content
of /proc/bus/usb/devices. Send us this one. Are there any Bluetooth or
USB related lines in the syslog or dmesg?

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
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
