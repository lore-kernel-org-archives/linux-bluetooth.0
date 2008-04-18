Return-Path: <cyrus@holtmann.org>
Message-ID: <30973884.1208493027183.JavaMail.tomcat@fe-ps03>
Date: Fri, 18 Apr 2008 01:30:27 -0300 (UYT)
From: "fpml@adinet.com.uy" <fpml@adinet.com.uy>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] inconsistent lock state (II)
Reply-To: "fpml@adinet.com.uy" <fpml@adinet.com.uy>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Fresh boot, lockdep complained on cc or auth.

hcid[790]: link_key_request (sba=00:09:DD:10:0C:5C, dba=00:02:5B:10:9D:E4)
=================================
[ INFO: inconsistent lock state ]
2.6.25 #1
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
krfcommd/812 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (slock-AF_BLUETOOTH){-+..}, at: [<c807abf8>] rfcomm_sk_state_change+0x28/0xe0 
[rfcomm]
{in-softirq-W} state was registered at:
  [<c0137d42>] __lock_acquire+0x372/0x1010
  [<c0138a45>] lock_acquire+0x65/0x90
  [<c02cb28a>] _spin_lock+0x1a/0x30
  [<c8032524>] l2cap_recv_frame+0x674/0x1110 [l2cap]
  [<c80339e0>] l2cap_recv_acldata+0x2c0/0x330 [l2cap]
  [<c805f819>] hci_rx_task+0x1d9/0x260 [bluetooth]
  [<c011e548>] tasklet_action+0x38/0x80
  [<c011e3b7>] __do_softirq+0x57/0xb0
  [<c011e456>] do_softirq+0x46/0x50
  [<c011e8c5>] irq_exit+0x65/0x80
  [<c01068bd>] do_IRQ+0x4d/0x90
  [<c0104eae>] common_interrupt+0x2e/0x40
  [<c0102998>] cpu_idle+0x38/0x80
  [<c02c4423>] rest_init+0x43/0x50
  [<ffffffff>] 0xffffffff
irq event stamp: 429
hardirqs last  enabled at (429): [<c0103f23>] restore_nocheck+0x12/0x15
hardirqs last disabled at (428): [<c0104ea4>] common_interrupt+0x24/0x40
softirqs last  enabled at (426): [<c011e3ff>] __do_softirq+0x9f/0xb0
softirqs last disabled at (393): [<c011e456>] do_softirq+0x46/0x50

other info that might help us debug this:
2 locks held by krfcommd/812:
 #0:  (rfcomm_mutex){--..}, at: [<c8078e63>] rfcomm_run+0x123/0x1380 [rfcomm]
 #1:  (&d->lock){--..}, at: [<c8078a3d>] rfcomm_dlc_accept+0x2d/0x80 [rfcomm]

stack backtrace:
Pid: 812, comm: krfcommd Not tainted 2.6.25 #1
 [<c013666a>] print_usage_bug+0x11a/0x130
 [<c013723d>] mark_lock+0x3cd/0x530
 [<c0137d88>] __lock_acquire+0x3b8/0x1010
 [<c0137569>] ? trace_hardirqs_on+0xb9/0x140
 [<c0103f23>] ? restore_nocheck+0x12/0x15
 [<c0138a45>] lock_acquire+0x65/0x90
 [<c807abf8>] ? rfcomm_sk_state_change+0x28/0xe0 [rfcomm]
 [<c02cb28a>] _spin_lock+0x1a/0x30
 [<c807abf8>] ? rfcomm_sk_state_change+0x28/0xe0 [rfcomm]
 [<c807abf8>] rfcomm_sk_state_change+0x28/0xe0 [rfcomm]
 [<c8078a4e>] rfcomm_dlc_accept+0x3e/0x80 [rfcomm]
 [<c80799ae>] rfcomm_run+0xc6e/0x1380 [rfcomm]
 [<c0137c50>] ? __lock_acquire+0x280/0x1010
 [<c02cb638>] ? _spin_unlock_irqrestore+0x38/0x40
 [<c0137569>] ? trace_hardirqs_on+0xb9/0x140
 [<c01167b7>] ? hrtick_set+0x87/0xc0
 [<c02c9582>] ? schedule+0x182/0x2e0
 [<c8078d40>] ? rfcomm_run+0x0/0x1380 [rfcomm]
 [<c012b406>] kthread+0x36/0x60
 [<c012b3d0>] ? kthread+0x0/0x60
 [<c0105097>] kernel_thread_helper+0x7/0x10
 =======================


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
