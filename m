Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Intellimouse Explorer not working
	after reboot
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Vollmer <maven@maven.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <167432047.20040823200031@maven.de>
References: <167432047.20040823200031@maven.de>
Content-Type: text/plain
Message-Id: <1093285155.26717.25.camel@pegasus>
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
Date: Mon, 23 Aug 2004 20:19:16 +0200

Hi Daniel,

> I am quite unsure where to report this problem, I suspect it's in
> the init-scripts, but neither am I sure it is a bug so I haven't
> filed one against bluez-utils.
> 
> I'm using an Microsoft Intellimouse Explorer for Bluetooth with
> debian/unstable (kernel 2.6.8-mh1 on a Dell Inspiron with internal
> bluetooth) and it works fine. But if I reboot the system, the mouse is
> not working anymore and I find the following (repeated) in my kern.log:
> kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 46
> 
> The mouse starts workin again if I remove and reinsert its batteries.
> I suspect the HID connection is not properly severed on shutting down
> the system.

it looks like such a problem. Try to put a "hidd -K" in the init script
and see if that helps. Maybe you also need to set the device to non
pageable with "hciconfig hci0 noscan" on shutdown.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
