Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <417A73C5.10907@paonline.com>
From: Dave Sailer <dsailer@paonline.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] kernel bug?
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
Date: Sat, 23 Oct 2004 10:07:49 -0500

I have been getting a kernel bug in bluetooth startup. I'm running 
gentoo 2.6.8-r7. I have tried a fresh kernel, including a 2.6.8.1 
version.  Should this be reported as a kernel bug. How do I go about that?

------------[ cut here ]------------
kernel BUG at mm/slab.c:1382!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: bluetooth nvidia snd_ens1370 snd_ak4531_codec
CPU:    0
EIP:    0060:[<c014473d>]    Tainted: P 
EFLAGS: 00010202   (2.6.8.1)
EIP is at kmem_cache_create+0x41d/0x5d0
eax: 0000002b   ebx: dff9a370   ecx: c05e0978   edx: 00000286
esi: c04c8b48   edi: e08f4664   ebp: dfdb3ce0   esp: df94bf4c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 6554, threadinfo=df94a000 task=df284250)
Stack: c0490fe4 e08f465c 00000020 00002000 df94bf70 dfdb3d38 0000000a 
c0000000
       ffffffe0 000000c0 c04e69a0 df94a000 e08f7940 c04e6984 e08ca06f 
e08f465c
       00000174 00000020 00002000 00000000 00000000 c01391f8 c05e0828 
00000001
Call Trace:
 [<e08ca06f>] bt_init+0x6f/0xc0 [bluetooth]
 [<c01391f8>] sys_init_module+0x158/0x2b0
 [<c010528b>] syscall_call+0x7/0xb
Code: 0f 0b 66 05 f8 08 49 c0 8b 0b e9 5b ff ff ff 8b 47 50 c7 04
 <6>agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
