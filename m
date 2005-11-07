Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Antti =?utf-8?b?TcOka2Vsw6Q=?= <zarhan@cs.tut.fi>
Message-ID: <loom.20051107T122754-207@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] =?utf-8?b?QlQzQ19DUw==?= broken in kernel 2.6.14?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 7 Nov 2005 11:29:17 +0000 (UTC)

Hi,

  After upgrading to Kernel 2.6.14 my 3Com bluetooth card does not work 
anymore. I tried applying the mh2 patch at bluez.org. On 2.6.13 it works just 
fine.

  Now, when I insert the PCMCIA card, the card does not work and I get the 
following error at the console:

kernel BUG at fs/sysfs/symlink.c:87!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: bt3c_cs rfcomm hidp l2cap 3c59x
CPU:    0
EIP:    0060:[<c01a9f58>]    Not tainted VLI
EFLAGS: 00010202   (2.6.14-ck1)
EIP is at sysfs_create_link+0x58/0x70
eax: fac7df01   ebx: 00000000   ecx: dfb84c80   edx: da41cd00
esi: da41cd20   edi: e0871640   ebp: dfb84c80   esp: da5b58bc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 7867, threadinfo=da5b4000 task=dfaa2540)
Stack: da563910 c05b3865 e08716a8 c05b3865 c034190d e08716a8 da41cd28 dfb84c80
       da41cd28 00000000 c0631f00 da41cda0 da41cd20 e0871640 da5b5938 c0344e42
       da41cd20 e08716dc 00000014 0000000a c15fac00 dffda0c0 00000286 dfb84fc0
Call Trace:
 [<c034190d>] class_device_add+0x21d/0x240
 [<c0344e42>] fw_register_class_device+0x112/0x190
 [<c0344ef5>] fw_setup_class_device+0x35/0x110
 [<c034503e>] _request_firmware+0x6e/0x180
 [<e086f790>] bt3c_hci_send_frame+0x0/0x120 [bt3c_cs]
 [<c0345178>] request_firmware+0x28/0x30
 [<e086fd32>] bt3c_open+0xc2/0x190 [bt3c_cs]
 [<e08703be>] bt3c_config+0x26e/0x390 [bt3c_cs]
 [<c0146af5>] prep_new_page+0x45/0x70
 [<c0147000>] buffered_rmqueue+0x10/0x240
 [<c0147498>] __alloc_pages+0x1b8/0x510
 [<c014ef06>] lru_cache_add_active+0x36/0x60
 [<c0155640>] do_anonymous_page+0x110/0x190
 [<c015572c>] do_no_page+0x6c/0x380
 [<c0155d30>] __handle_mm_fault+0x1d0/0x200
 [<c05793f9>] do_page_fault+0x1b9/0x61d
 [<c0579240>] do_page_fault+0x0/0x61d
 [<c0103d5b>] error_code+0x4f/0x54
 [<c018d81a>] __mark_inode_dirty+0xea/0x1e0
 [<c01195e3>] activate_task+0x123/0x1e0
 [<c03ab239>] pccard_get_next_tuple+0x209/0x310
 [<c03aad41>] pccard_get_first_tuple+0x91/0x150
 [<e0870540>] bt3c_event+0x0/0xf0 [bt3c_cs]
 [<e087061f>] bt3c_event+0xdf/0xf0 [bt3c_cs]
 [<c03af5a1>] pcmcia_register_client+0x211/0x2d0
 [<c05779d2>] preempt_schedule+0x42/0x60
 [<c012f551>] queue_work+0x91/0xa0
 [<e086ff12>] bt3c_attach+0xb2/0xf0 [bt3c_cs]
 [<c03ae272>] pcmcia_device_probe+0xc2/0x180
 [<c03405f8>] driver_probe_device+0x38/0xd0
 [<c0340710>] __driver_attach+0x0/0x50
 [<c0340751>] __driver_attach+0x41/0x50
 [<c033fabd>] bus_for_each_dev+0x5d/0x80
 [<c0340785>] driver_attach+0x25/0x30
 [<c0340710>] __driver_attach+0x0/0x50
 [<c0340064>] bus_add_driver+0x84/0xf0
 [<c0340c1d>] driver_register+0x3d/0x50
 [<c0340bc0>] klist_devices_get+0x0/0x10
 [<c0340bd0>] klist_devices_put+0x0/0x10
 [<c03ae0f4>] pcmcia_register_driver+0x14/0x50
 [<e087300f>] init_bt3c_cs+0xf/0x11 [bt3c_cs]
 [<c013bc17>] sys_init_module+0x167/0x240
 [<c010326b>] sysenter_past_esp+0x54/0x75
Code: 00 00 89 4c 24 04 8b 44 24 18 89 1c 24 89 44 24 08 e8 cd fe ff ff 
89 c1 8b 53 08 ff 42 70 0f 8e c6 02 00 00 83 c4 0c 89 c8 5b c3 <0f> 0b 
57 00 2c c5 59 c0 eb c1 8d b4 26 00 00 00 00 8d bc 27 00





-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
