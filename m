Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY123-DAV15D2FDA60C18C50BB17CE3B7CC0@phx.gbl>
From: "Hiren Patel" <gop00@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 22 Dec 2006 16:53:24 -0800
MIME-Version: 1.0
Subject: [Bluez-users] hci_usb.ko segmentation fault
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Please accept my apologies if you find this message ugly!!!

I'm getting a segmentation fault error when I load hci_usb.ko module. I
compiled the modules myself so there must be something I'm missing. Can
anyone provide a hint on what's going on?

There are two areas below, the first is my command line execution and the
second is output from log file.

Thanks,

Hiren


====== at command line =====
sh-3.00# insmod /lib/modules/2.6.18.1/kernel/net/bluetooth/bluetooth.ko
sh-3.00# insmod /lib/modules/2.6.18.1/kernel/drivers/bluetooth/hci_usb.ko
Segmentation fault
sh-3.00# modinfo /lib/modules/2.6.18.1/kernel/drivers/bluetooth/hci_usb.ko
filename:       /lib/modules/2.6.18.1/kernel/drivers/bluetooth/hci_usb.ko
author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann 
<marcel@holtmann.org>
description:    Bluetooth HCI USB driver ver 2.9
version:        2.9
license:        GPL
vermagic:       2.6.18.1 mod_unload 486 gcc-3.4
depends:        bluetooth
alias:          usb:v*p*d*dcE0dsc01dp01ic*isc*ip*
alias:          usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0BDBp1002d*dc*dsc*dp*ic*isc*ip*
srcversion:     F5F3104040EC4B01BBEFAA5
parm:           reset:Send HCI reset command on initialization (bool)
parm:           force_scofix:Force fixup of wrong SCO buffers size (bool)
parm:           disable_scofix:Disable fixup of wrong SCO buffer size (bool)
parm:           ignore_sniffer:Ignore devices with id 0a12:0002 (bool)
parm:           ignore_csr:Ignore devices with id 0a12:0001 (bool)
parm:           ignore_dga:Ignore devices with id 08fd:0001 (bool)
parm:           ignore:Ignore devices from the matching table (bool)
sh-3.00# hciconfig -a
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

sh-3.00# hciconfig hci0 up
Segmentation fault
sh-3.00#


======== From log=======

Dec 22 16:14:52 (none) user.warn kernel: bluetooth: no version for
"struct_module" found: kernel tainted.
Dec 22 16:14:52 (none) user.warn kernel: bluetooth: No versions for exported
symbols. Tainting kernel.
Dec 22 16:14:52 (none) user.info kernel: Bluetooth: Core ver 2.10 Dec 22
16:14:53 (none) user.info kernel: NET: Registered protocol family 31 Dec 22
16:14:53 (none) user.info kernel: Bluetooth: HCI device and connection
manager initialized Dec 22 16:14:53 (none) user.info kernel: Bluetooth: HCI
socket layer initialized Dec 22 16:15:01 (none) user.info kernel: Bluetooth:
HCI USB driver ver 2.9 Dec 22 16:15:01 (none) user.emerg kernel:
skb_over_panic: text:c815ef53
len:2 put:2 head:c62a3a88 data:c62a3a8a tail:c62a3a80 end:c62a3a90
dev:<NULL> Dec 22 16:15:01 (none) user.emerg kernel: ------------[ cut here
]------------
Dec 22 16:15:01 (none) user.emerg kernel: kernel BUG at
net/core/skbuff.c:93!
Dec 22 16:15:01 (none) user.emerg kernel: invalid opcode: 0000 [#1] Dec 22
16:15:01 (none) user.warn kernel: Modules linked in: hci_usb bluetooth
usb_storage lp parport_pc parport usbhid sisfb 8139too mii sis7019 soundcore
ac97_codec i2c_sis630 i2c_core fuse unionfs nls_iso8859_1
nls_cp437 sr_mod ide_cd cdrom ohci_hcd usbcore
Dec 22 16:15:01 (none) user.emerg kernel: CPU:    0
Dec 22 16:15:01 (none) user.warn kernel: EIP:    0060:[<c02fc8c5>]    
Tainted: GF     VLI
Dec 22 16:15:01 (none) user.warn kernel: EFLAGS: 00010286   (2.6.18.1 #1)
Dec 22 16:15:01 (none) user.emerg kernel: EIP is at skb_over_panic+0x45/0x60
Dec 22 16:15:01 (none) user.emerg kernel: eax: 0000006f   ebx: c230c640   
ecx: c23d1dc0   edx: c03b0b9c
Dec 22 16:15:01 (none) user.emerg kernel: esi: 00000004   edi: c62a3a80   
ebp: c23d1e24   esp: c23d1dbc
Dec 22 16:15:01 (none) user.emerg kernel: ds: 007b   es: 007b   ss: 0068
Dec 22 16:15:01 (none) user.emerg kernel: Process insmod (pid: 2487,
ti=c23d0000 task=c297a560 task.ti=c23d0000) Dec 22 16:15:01 (none)
user.emerg kernel: Stack: c03b0b9c c815ef53 00000002
00000002 c62a3a88 c62a3a8a c62a3a80 c62a3a90
Dec 22 16:15:01 (none) user.emerg kernel:        c038dcaa c815ef5c c230c640 
00000002 c815ef53 00000004 c62a3a88 00000001
Dec 22 16:15:02 (none) user.emerg kernel:        00000000 00000001 c1cd7800 
00000001 c62a3b40 c815fa66 00000000 00000001 Dec 22 16:15:02 (none)
user.emerg kernel: Call Trace:
Dec 22 16:15:02 (none) user.warn kernel:  [<c815ef53>]
hci_si_event+0x84/0x131 [bluetooth]
Dec 22 16:15:02 (none) user.warn kernel:  [<c815ef5c>]
hci_si_event+0x8d/0x131 [bluetooth]
Dec 22 16:15:02 (none) user.warn kernel:  [<c815ef53>]
hci_si_event+0x84/0x131 [bluetooth]
Dec 22 16:15:02 (none) user.warn kernel:  [<c815fa66>]
hci_sock_dev_event+0x26/0xa8 [bluetooth] Dec 22 16:15:02 (none) user.warn
kernel:  [<c01225d8>] notifier_call_chain+0x28/0x40 Dec 22 16:15:02 (none)
user.warn kernel:  [<c0122654>] atomic_notifier_call_chain+0x14/0x20
Dec 22 16:15:02 (none) user.warn kernel:  [<c815b518>] hci_notify+0x12/0x16
[bluetooth] Dec 22 16:15:02 (none) user.warn kernel:  [<c815c515>]
hci_register_dev+0x1a4/0x1b0 [bluetooth] Dec 22 16:15:02 (none) user.warn
kernel:  [<c815c329>]
hci_alloc_dev+0x13/0x39 [bluetooth]
Dec 22 16:15:02 (none) user.warn kernel:  [<c801de19>]
hci_usb_probe+0x33a/0x38f [hci_usb] Dec 22 16:15:02 (none) user.warn kernel:
[<c803a147>] usb_match_id+0x27/0x60 [usbcore] Dec 22 16:15:02 (none)
user.warn kernel:  [<c8039f28>] usb_probe_interface+0x58/0xb0 [usbcore] Dec
22 16:15:02 (none) user.warn kernel:  [<c027fb33>]
driver_probe_device+0x53/0xa0 Dec 22 16:15:02 (none) user.warn kernel:
[<c027fc00>] __driver_attach+0x0/0x80 Dec 22 16:15:02 (none) user.warn
kernel:  [<c027fc7b>] __driver_attach+0x7b/0x80 Dec 22 16:15:02 (none)
user.warn kernel:  [<c027f078>] bus_for_each_dev+0x58/0x80 Dec 22 16:15:02
(none) user.warn kernel:  [<c0222470>] kobject_add+0x60/0x100 Dec 22
16:15:02 (none) user.warn kernel:  [<c027fc95>] driver_attach+0x15/0x20 Dec
22 16:15:02 (none) user.warn kernel:  [<c027fc00>] __driver_attach+0x0/0x80
Dec 22 16:15:02 (none) user.warn kernel:  [<c027f599>]
bus_add_driver+0x69/0xa0 Dec 22 16:15:02 (none) user.warn kernel:
[<c0280129>] driver_register+0x59/0x90 Dec 22 16:15:02 (none) user.warn
kernel:  [<c803a223>] usb_register_driver+0x53/0xb0 [usbcore] Dec 22
16:15:02 (none) user.warn kernel:  [<c01166ef>] printk+0xf/0x20 Dec 22
16:15:02 (none) user.warn kernel:  [<c80bc021>] hci_usb_init+0x21/0x3e
[hci_usb] Dec 22 16:15:02 (none) user.warn kernel:  [<c0131432>]
sys_init_module+0xe2/0x160 Dec 22 16:15:02 (none) user.warn kernel:
[<c0102f07>] syscall_call+0x7/0xb Dec 22 16:15:02 (none) user.emerg kernel:
Code: 98 00 00 00 50 8b 82 94 00 00 00 50 8b 82 90 00 00 00 50 8b 4c 24 1c
51 8b 52 60 52 8b 44 24 28 50 68 9c 0b 3b c0 e8 1b 9e e1 ff <0f> 0b 5d 00 50
ec 3a c0 83 c4 24 c3 eb 0d 90 90 90 90 90 90 90 Dec 22 16:15:02 (none)
user.emerg kernel: EIP: [<c02fc8c5>] skb_over_panic+0x45/0x60 SS:ESP
0068:c23d1dbc Dec 22 16:16:41 (none) user.emerg kernel: ------------[ cut
here
]------------
Dec 22 16:16:41 (none) user.emerg kernel: kernel BUG at
net/core/skbuff.c:93!
Dec 22 16:16:41 (none) user.emerg kernel: invalid opcode: 0000 [#2] Dec 22
16:16:41 (none) user.warn kernel: Modules linked in: hci_usb bluetooth
usb_storage lp parport_pc parport usbhid sisfb 8139too mii sis7019 soundcore
ac97_codec i2c_sis630 i2c_core fuse unionfs nls_iso8859_1
nls_cp437 sr_mod ide_cd cdrom ohci_hcd usbcore
Dec 22 16:16:41 (none) user.emerg kernel: CPU:    0
Dec 22 16:16:41 (none) user.warn kernel: EIP:    0060:[<c02fc8c5>]    
Tainted: GF     VLI
Dec 22 16:16:41 (none) user.warn kernel: EFLAGS: 00010282   (2.6.18.1 #1)
Dec 22 16:16:41 (none) user.emerg kernel: EIP is at skb_over_panic+0x45/0x60
Dec 22 16:16:41 (none) user.emerg kernel: eax: 0000006f   ebx: c1c16d20   
ecx: c1cf1e50   edx: c03b0b9c
Dec 22 16:16:41 (none) user.emerg kernel: esi: c1cd7800   edi: c62a3e40   
ebp: 00000003   esp: c1cf1e4c
Dec 22 16:16:41 (none) user.emerg kernel: ds: 007b   es: 007b   ss: 0068
Dec 22 16:16:41 (none) user.emerg kernel: Process hciconfig (pid: 2581,
ti=c1cf0000 task=c77a5ab0 task.ti=c1cf0000) Dec 22 16:16:41 (none)
user.emerg kernel: Stack: c03b0b9c c815c75c 00000003
00000003 c62a3e48 c62a3e4b c62a3e40 c62a3e50
Dec 22 16:16:41 (none) user.emerg kernel:        c038dcaa c815c765 c1c16d20 
00000003 c815c75c c4b14880 c62a3e48 000461c0
Dec 22 16:16:41 (none) user.emerg kernel:        c1cd792c c1cd7800 c1cf1ee0 
c1cd7800 c815b70c c1cd7800 00000004 00000003 Dec 22 16:16:41 (none)
user.emerg kernel: Call Trace:
Dec 22 16:16:41 (none) user.warn kernel:  [<c815c75c>]
hci_send_cmd+0x98/0x161 [bluetooth]
Dec 22 16:16:41 (none) user.warn kernel:  [<c815c765>]
hci_send_cmd+0xa1/0x161 [bluetooth]
Dec 22 16:16:41 (none) user.warn kernel:  [<c815c75c>]
hci_send_cmd+0x98/0x161 [bluetooth]
Dec 22 16:16:41 (none) user.warn kernel:  [<c815b70c>]
hci_init_req+0x72/0xed [bluetooth] Dec 22 16:16:41 (none) user.warn kernel:
[<c815b607>] __hci_request+0x6f/0xed [bluetooth] Dec 22 16:16:41 (none)
user.warn kernel:  [<c0112990>] default_wake_function+0x0/0x20 Dec 22
16:16:41 (none) user.warn kernel:  [<c801d270>]
hci_usb_bulk_rx_submit+0xb7/0x11f [hci_usb] Dec 22 16:16:41 (none) user.warn
kernel:  [<c0112990>] default_wake_function+0x0/0x20 Dec 22 16:16:41 (none)
user.warn kernel:  [<c815bbab>]
hci_dev_open+0x84/0x172 [bluetooth]
Dec 22 16:16:41 (none) user.warn kernel:  [<c815b69a>] hci_init_req+0x0/0xed
[bluetooth] Dec 22 16:16:41 (none) user.warn kernel:  [<c02f8bad>]
sock_ioctl+0xdd/0x240 Dec 22 16:16:41 (none) user.warn kernel:  [<c01634c5>]
do_ioctl+0x55/0x70 Dec 22 16:16:41 (none) user.warn kernel:  [<c0163604>]
vfs_ioctl+0x54/0x1e0 Dec 22 16:16:41 (none) user.warn kernel:  [<c01637bd>]
sys_ioctl+0x2d/0x50 Dec 22 16:16:41 (none) user.warn kernel:  [<c0102f07>]
syscall_call+0x7/0xb Dec 22 16:16:41 (none) user.emerg kernel: Code: 98 00
00 00 50 8b 82 94 00 00 00 50 8b 82 90 00 00 00 50 8b 4c 24 1c 51 8b 52 60
52 8b 44 24 28 50 68 9c 0b 3b c0 e8 1b 9e e1 ff <0f> 0b 5d 00 50 ec 3a c0 83
c4 24 c3 eb 0d 90 90 90 90 90 90 90 Dec 22 16:16:41 (none) user.emerg
kernel: EIP: [<c02fc8c5>] skb_over_panic+0x45/0x60 SS:ESP 0068:c1cf1e4c
=====



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
