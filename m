Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex Holland <ah160@student.cs.york.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404191419.59021.ah160@student.cs.york.ac.uk>
References: <200404182321.55431.dvornheder@t-online.de>
	 <200404190935.34433.ah160@student.cs.york.ac.uk>
	 <1082370224.4403.33.camel@pegasus>
	 <200404191419.59021.ah160@student.cs.york.ac.uk>
Content-Type: text/plain
Message-Id: <1082381412.4403.42.camel@pegasus>
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
Date: Mon, 19 Apr 2004 15:30:12 +0200

Hi Alex,

> The dongle's a Belkin F8T001, the original model. Bluefw works very 
> temprementally; sometimes it just doesn't, for no apparent reason, with 
> the dongle timing out. Blue-fw was uninstalled before trying out the 
> Blutonium kernel module, and BCM-LEGAL.txt, BCM2033-FW.bin and 
> BCM2033-MD.hex placed in /usr/lib/hotplug/firmware/
> 
> Athlon T-Bird 900Mhz
> Gentoo stable, gentoo-dev-sources-2.6.5-r2. 
> bluez-hcidump-1.8
> bluez-libs-2.5
> bluez-sdp-1.5
> bluez-utils-2.5
> latest CVS KDE Bluetooth
> 
> dmesg excerpts:
> ---------------------------------------------
> ...blah...
> Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> Bluetooth: Core ver 2.4
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: HCI USB driver ver 2.5
> ...blah...
> bcm203x_probe: Mini driver request failed

that is the problematic line and it means that the request_firmware()
call can't load the file BCM2033-MD.hex. Do you have installed the
hotplug scripts and is the firmware.agent script present?

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
