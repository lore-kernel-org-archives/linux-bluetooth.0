Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 18 Jul 2006 19:21:52 +0200
MIME-Version: 1.0
Message-Id: <200607181921.52647.Kevin.Baradon@gmail.com>
From: Kevin Baradon <kevin.baradon@gmail.com>
Subject: [Bluez-devel] Lockdep: possible recursive locking detected in hidd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

[Please CC me as I'm not on the list]

Hi,

I've got a Logitech Bluetooth keyboard. 
With lockdep enabled, I've got the following message just after boot, after 
having pressed a key on keyboard : 

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
hidd/3150 is trying to acquire lock:
 (sk_lock-AF_BLUETOOTH){--..}, at: [<c038a85c>] bt_accept_dequeue+0x54/0xd3

but task is already holding lock:
 (sk_lock-AF_BLUETOOTH){--..}, at: [<c0392e5c>] l2cap_sock_accept+0x42/0x12f

other info that might help us debug this:
1 lock held by hidd/3150:
 #0:  (sk_lock-AF_BLUETOOTH){--..}, at: [<c0392e5c>] 
l2cap_sock_accept+0x42/0x12f

stack backtrace:
 [<c0103fb9>] show_trace_log_lvl+0x11d/0x137
 [<c01046b2>] show_trace+0x12/0x14
 [<c010477a>] dump_stack+0x19/0x1b
 [<c0134c31>] __lock_acquire+0x9e1/0xcf5
 [<c0135271>] lock_acquire+0x5d/0x79
 [<c02f0fa3>] lock_sock+0xb4/0xc1
 [<c038a85c>] bt_accept_dequeue+0x54/0xd3
 [<c0392eeb>] l2cap_sock_accept+0xd1/0x12f
 [<c02f013a>] sys_accept+0xd7/0x1a0
 [<c02f02c4>] sys_socketcall+0xc1/0x254
 [<c0102df5>] sysenter_past_esp+0x56/0x8d
 [<b7fea410>] 0xb7fea410
input: Bluetooth HID Boot Protocol Device as /class/input/input5

Kernel: Linux kev1 2.6.18-rc2 #2 SMP PREEMPT Tue Jul 18 11:44:18 CEST 2006 
i686 GNU/Linux

Distribution: Debian
bluez-utils 3.1-2
libbluetooth2 3.1-1

-- 
Kevin Baradon
Networks & Telecom Student
-

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
