Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Holland <ah160@student.cs.york.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404191639.48612.ah160@student.cs.york.ac.uk>
References: <200404182321.55431.dvornheder@t-online.de>
	 <200404191441.53945.ah160@student.cs.york.ac.uk>
	 <1082382899.4403.46.camel@pegasus>
	 <200404191639.48612.ah160@student.cs.york.ac.uk>
Content-Type: text/plain
Message-Id: <1082391148.4403.57.camel@pegasus>
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
Date: Mon, 19 Apr 2004 18:12:29 +0200

Hi Alex,

> > check the path for the firmware files in the firmware.agent script.
> > Is the script is executable? Is /sys mounted? What are the
> > permissions of your firmware files?
> 
> firmware.agent is executable. The firmware permissions are as follows:
> 
> -rw-r--r--    1 root     root       114688 Apr 19 12:29 BCM2033-FW.bin
> -rw-r--r--    1 root     root         3245 Apr 19 12:29 BCM2033-MD.hex
> 
> This should be okay, I'd imagine - no need to execute or write to them. 
> For the other questions, I've attached firmware.agent, but everything 
> looks correct to me.
> 
> > You need CONFIG_FW_LOADER, but this should be done automaticly by the
> > bcm203x driver and lsmod must show you a firmware_class module.
> 
> Yup, this seems to be working; lsmod has the following:
> 
> firmware_class          7616  1 bcm203x

so far so good. Everything seems to look fine, but actually the bcm203x
driver can't load the BCM2033-MD.hex firmware file from the userspace.
Add some debugging lines to firmware.agent to see if it got really
called by the hotplug system.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
