Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <407C4B88.1010102@thomae-privat.de>
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Oops with 2.6.5-mh3
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
Date: Tue, 13 Apr 2004 22:20:24 +0200

Hello Marcel et al,

I get a kernel Oops with 2.6.5-mh3 (with and without preempt) and an 
Acer BT-700 USB dongle on a Vaio Notebook, not when unplugging it, but 
when plugging it back in.

 > lspci
...
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
...

Anything I can do?

Regards.
Matthias

-----------------------------------------------------------------

Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
d10b7e64
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[pg0+281624164/1069391872]    Not tainted
EFLAGS: 00010292   (2.6.5-mh3)
EIP is at usb_disable_interface+0x14/0x50 [usbcore]
eax: cf6544c0   ebx: 00000000   ecx: cf806000   edx: cffef0a0
esi: 00000001   edi: 00000000   ebp: cfe10000   esp: cf807d1c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 70, threadinfo=cf806000 task=cf80b1a0)
Stack: 00001388 0000a48c 00000002 00000001 cf95a6d0 cfe10000 d10b8158 
cfe10000
        cf6544c0 0000000b 00000001 00000002 00000001 00000000 00000000 
00001388
        00000000 cf6544c0 00000000 cf95a820 cf95a8d8 c8168e60 d110ab4c 
cfe10000
Call Trace:
  [pg0+281624920/1069391872] usb_set_interface+0xb8/0x1c0 [usbcore]
  [pg0+281963340/1069391872] hci_usb_probe+0x23c/0x4b0 [hci_usb]
  [__wake_up_common+58/112] __wake_up_common+0x3a/0x70
  [dput+49/544] dput+0x31/0x220
  [pg0+281596121/1069391872] usb_probe_interface+0xb9/0xe0 [usbcore]
  [bus_match+63/112] bus_match+0x3f/0x70
  [device_attach+79/160] device_attach+0x4f/0xa0
  [bus_add_device+91/160] bus_add_device+0x5b/0xa0
  [device_add+161/304] device_add+0xa1/0x130
  [pg0+281626005/1069391872] usb_set_configuration+0x235/0x2e0 [usbcore]
  [pg0+281600847/1069391872] usb_new_device+0x2df/0x5c0 [usbcore]
  [pg0+281609143/1069391872] hub_port_connect_change+0x1d7/0x2e0 [usbcore]
  [pg0+281610340/1069391872] hub_events+0x3a4/0x470 [usbcore]
  [pg0+281610597/1069391872] hub_thread+0x35/0x110 [usbcore]
  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
  [default_wake_function+0/32] default_wake_function+0x0/0x20
  [pg0+281610544/1069391872] hub_thread+0x0/0x110 [usbcore]
  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 80 7b 04 00 74 26 31 f6 8d 74 26 00 8b 43 0c 47 0f b6 44 30




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
