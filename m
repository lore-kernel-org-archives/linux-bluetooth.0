Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <416D745B.7020208@users.sourceforge.net>
From: Pander <pander@users.sourceforge.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] modprobe: FATAL: Error inserting hci_usb
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
Date: Wed, 13 Oct 2004 20:30:51 +0200

Hi all,

I'm have build linux kernel 2.6.8.1 with Debian testing distro on a 
PowerPC (PowerBook G4). All went well and booted oke except for 
bleutooth support:

Bluetooth: HCI device and connection manager initialized
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb
modprobe: FATAL: Error inserting hci_usb 
(/lib/modules/2.6.8.1-pbg4/kernel/drivers/bluetooth/hci_usb.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)

modprobe: FATAL: Error inserting hci_usb 
(/lib/modules/2.6.8.1-pbg4/kernel/drivers/bluetooth/hci_usb.ko): Unknown 
symbol in module, or unknown parameter (see dmesg)

I also patched the 2.6.8.1 kernel source with patch-2.6.8-mh2 but that 
resulted in the same error. dmesg says the same as above. Does anyone 
know how to fix this?

Regards,

Pander


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
