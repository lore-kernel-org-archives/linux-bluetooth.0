Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] New bc203x driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Nosve <nosve@libero.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <AGELIJDLJNOPFNMOHHIFAECHCAAA.nosve@libero.it>
References: <AGELIJDLJNOPFNMOHHIFAECHCAAA.nosve@libero.it>
Content-Type: text/plain
Message-Id: <1073582894.2563.11.camel@pegasus>
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
Date: Thu, 08 Jan 2004 18:28:15 +0100

Hi,

> excuse the easy questions but i never use usb devices with linux and
> hotplug; how it is intended to use the bcm203x driver? Has the firmware to
> be put in some particular location?

my setup has it this way

	/etc/hotplug/firmware.agent
	/usr/lib/hotplug/firmware/BCM2033-MD.hex
	/usr/lib/hotplug/firmware/BCM2033-FW.bin

> Also, the hotplug configuration which started the bluefw program has to be
> removed? And how?

Check /etc/hotplug/usb.usermap or /etc/hotplug/usb/* for the bluefw
entry.

> Am I missing some documentation? Or I'm i the wrong place? :-)

The place is right, but I haven't written any documentation about this
new driver. I only wrote this driver for myself and made it public.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
