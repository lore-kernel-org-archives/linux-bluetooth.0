Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <404A2A86.2090706@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Toshiba Portege M200 internal bluetooth adapter
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
Date: Sat, 06 Mar 2004 12:46:14 -0700

Hi

I'm not totally sure how to use the internal bluetooth on my toshiba
portege m200. I saw reports of "hci_usb + toshiba" for similar models
but I have no idea what that means. usbfs doesn't show anything that
looks like bluetooth but lspci -v reports one device I'm not sure about.
Maybe that's it...

02:0d.0 System peripheral: Toshiba America Info Systems: Unknown device
0805 (rev 05)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Flags: medium devsel, IRQ 11
	Memory at 20000c00 (32-bit, non-prefetchable) [disabled] [size=512]
	Capabilities: [80] Power Management version 2

Does anyone know if there's a chance it's supported?

Brad



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
