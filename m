Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexander Holler <holler@ahsoftware.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <10800000.1071618502@[192.168.207.2]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Patch for kernel oops while disconnecting devices (hci_usb.c)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 00:48:22 +0100

Hi,

I've a small patch for hci_usb.c (from 2.6-test11 and maybe below) which 
removes the kernel oops when disconnecting a csr-usb-devices (in my case 
with a button on my laptop).

----------------
--- hci_usb.c.orig      2003-12-15 18:03:24.000000000 +0100
+++ hci_usb.c   2003-12-17 00:10:29.000000000 +0100
@@ -781,7 +781,7 @@
        struct hci_dev *hdev;
        int i, a, e, size, ifn, isoc_ifnum, isoc_alts;

-       BT_DBG("udev %p ifnum %d", udev, ifnum);
+/*     BT_DBG("udev %p ifnum %d", udev, ifnum); */

        iface = udev->actconfig->interface[0];

@@ -934,10 +934,10 @@
        BT_DBG("%s", hdev->name);

        hci_usb_close(hdev);
-
+/*
        if (husb->isoc_iface)
                usb_driver_release_interface(&hci_usb_driver, 
husb->isoc_iface);
-
+*/
        if (hci_unregister_dev(hdev) < 0)
                BT_ERR("Can't unregister HCI device %s", hdev->name);
 }
----------------

I've also commented out a nonfunctional BT_DBG.

I haven't identified the real cause for the oops, but according to the 
documentation for usb_driver_release_interface() this call isn't necessary 
and is called automatically when a driver is disconnected.

According /proc/bus/usb/devices the interface is removed, even without a 
call to usb_driver_release_interface in disconnect().

Maybe this should be forwarded to one of the usb-devels for examing.
I think they will find the real cause for the oops much faster than I (I 
almost know nothing about the usb subsystem). ;)

Regards,

Alexander



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
