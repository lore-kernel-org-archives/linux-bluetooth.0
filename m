Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40CDE884.8080809@plausible.org>
From: Andy Ross <andy@plausible.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------030002070806090604000206"
Subject: [Bluez-devel] Oops in hci_usb when disconnecting built-in controller
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
Date: Mon, 14 Jun 2004 11:03:48 -0700

This is a multi-part message in MIME format.
--------------030002070806090604000206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I have a new laptop, a Compaq R3000Z (AMD64, but currently running a
32 bit kernel).  It has a built-in USB Bluetooth device, which
identifies itself as ID 049f:0086.  It works great with the hci_usb
driver from boot.

The laptop also has a "wireless enable/disable" switch, which is a
hardware switch that when pressed drops power to the internal 802.11b
antenna and (apparently) disconnects the HCI controller from the USB
bus.  When I use this, I get a 100% repeatable oops in the hci_usb
driver.  The driver then locks up and refuses to unload, although the
rest of the kernel appears to be unaffected.

Andy


--------------030002070806090604000206
Content-Type: text/plain;
 name="usb-oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb-oops.txt"

usb 3-2: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
c018661f
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c018661f>]    Tainted: P
EFLAGS: 00010246   (2.6.6)
EIP is at sysfs_hash_and_remove+0x2f/0x9b
eax: 00000000   ebx: 00000068   ecx: 00000068   edx: ffff0001
esi: 00000000   edi: f7550520   ebp: f88a39c0   esp: c1981e48
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=c1980000 task=f7f7a030)
Stack: c02f541a 00000077 f88a39c0 f7134530 f88a3960 c020f3fa f7550520 c0307cda
       c020f7fd f7134530 00000042 f88a39ac f7134400 f7134400 f72a97a4 f7428c24
       f889bd13 f7134530 f72a98a4 f73652e8 f887b855 f7134400 f72a9894 f887c8c0
Call Trace:
 [<c020f3fa>] class_device_dev_unlink+0x1a/0x20
 [<c020f7fd>] class_device_del+0x8d/0xd0
 [<f889bd13>] hci_unregister_dev+0x13/0x80 [bluetooth]
 [<f887b855>] hci_usb_disconnect+0x35/0x80 [hci_usb]
 [<c025ad7a>] usb_unbind_interface+0x7a/0x80
 [<c020ea34>] device_release_driver+0x64/0x70
 [<c020eba3>] bus_remove_device+0x73/0xc0
 [<c020da0c>] device_del+0x6c/0xb0
 [<c020da63>] device_unregister+0x13/0x30
 [<c0260b1f>] usb_disable_device+0x6f/0xb0
 [<c025b94b>] usb_disconnect+0xbb/0x110
 [<c025d9af>] hub_port_connect_change+0x27f/0x290
 [<c025d373>] hub_port_status+0x43/0xb0
 [<c025dc60>] hub_events+0x2a0/0x300
 [<c025dced>] hub_thread+0x2d/0xf0
 [<c0119c30>] default_wake_function+0x0/0x20
 [<c025dcc0>] hub_thread+0x0/0xf0
 [<c0104291>] kernel_thread_helper+0x5/0x14
 
Code: ff 4e 68 78 67 89 3c 24 8b 44 24 1c 89 44 24 04 e8 3c ff ff

--------------030002070806090604000206--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
