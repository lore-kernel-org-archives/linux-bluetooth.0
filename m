Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Dave Sailer <dave.sailer@paytec.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1098441508.11708.12.camel@dsailer>
Mime-Version: 1.0
Subject: [Bluez-users] problem with keyboard/mouse
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
Date: Fri, 22 Oct 2004 06:38:28 -0400

Can't get Microsoft keyboard/mouse to work on gentoo 2.6.8.1. With
patch-2.6.8-mh2.gz, I noticed the following out of dmesg...

bluetooth: Unknown parameter `l2cap' 
Bluetooth: Core ver 2.6 
kmem_cache_create: duplicate cache bt_sock 
------------[ cut here ]------------ 
kernel BUG at mm/slab.c:1382! 
invalid operand: 0000 [#1] 
PREEMPT SMP 
Modules linked in: bluetooth nvidia 
CPU: 0 
EIP: 0060:[<c014473d>] Tainted: P 
EFLAGS: 00010202 (2.6.8.1) 
EIP is at kmem_cache_create+0x41d/0x5d0 
eax: 0000002b ebx: dff9a370 ecx: c05e0978 edx: df04c000 
esi: c04c8b48 edi: e08e0848 ebp: dfdd2ce0 esp: df04df4c 
ds: 007b es: 007b ss: 0068 
Process modprobe (pid: 6384, threadinfo=df04c000 task=df694770) 
Stack: c0490fe4 e08e0840 00000020 00002000 df04df70 dfdd2d38 0000000a
c0000000 
ffffffe0 000000c0 c04e69a0 df04c000 e08e3bc0 c04e6984 e08e506f e08e0840 
00000174 00000020 00002000 00000000 00000000 c01391f8 c05e0828 00000001 
Call Trace: 
[<e08e506f>] bt_init+0x6f/0xc0 [bluetooth] 
[<c01391f8>] sys_init_module+0x158/0x2b0 
[<c010528b>] syscall_call+0x7/0xb 
Code: 0f 0b 66 05 f8 08 49 c0 8b 0b e9 5b ff ff ff 8b 47 50 c7 04 
<4>l2cap: Unknown symbol bt_accept_unlink 
Bluetooth: HIDP (Human Interface Emulation) ver 1.0-mh1


Without the patch, it's a similar message but with this at the end...

<3>l2cap_init: L2CAP socket registration failed.

I'm a bit confused about the patch - there are gentoo users claiming to
use bluetooth without it. Does anyone know if the patch is in the gentoo
kernel, and with what version?






-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
