Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4f436aae0702141300g2fc6a7dex7b074babb16eee31@mail.gmail.com>
Date: Wed, 14 Feb 2007 23:00:46 +0200
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] bluez: inconsistent lock state
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

hello,

my device (simple uart device) is discoverable but when i try pairing to it
this is what i see :(

can you please tell me what it is ?

thank you very much
choi

(PS, newest 2.6.20 kernel)

Feb 14 22:53:44 localhost hcid[2408]: HCI dev 0 registered
Feb 14 22:53:44 localhost hcid[2408]: Register path:/org/bluez/hci0 fallback:0
Feb 14 22:53:45 localhost hcid[2408]: HCI dev 0 up
Feb 14 22:53:45 localhost hcid[2408]: Device hci0 has been added
Feb 14 22:53:45 localhost hcid[2408]: Starting security manager 0
Feb 14 22:53:45 localhost hcid[2408]: Device hci0 has been activated
Feb 14 22:55:16 localhost kernel: [ 1104.748000]
Feb 14 22:55:16 localhost kernel: [ 1104.748000]
=================================
Feb 14 22:55:16 localhost kernel: [ 1104.748000] [ INFO: inconsistent
lock state ]
Feb 14 22:55:16 localhost kernel: [ 1104.748000] 2.6.20 #2
Feb 14 22:55:16 localhost kernel: [ 1104.748000]
---------------------------------
Feb 14 22:55:16 localhost kernel: [ 1104.748000] inconsistent
{softirq-on-W} -> {in-softirq-W} usage.
Feb 14 22:55:16 localhost kernel: [ 1104.748000] gnome-panel/12165
[HC0[0]:SC1[1]:HE1:SE0] takes:
Feb 14 22:55:16 localhost kernel: [ 1104.748000]
(slock-AF_BLUETOOTH){-+..}, at: [<e03c5054>]
l2cap_recv_frame+0x2e4/0xdb0 [l2cap]
Feb 14 22:55:16 localhost kernel: [ 1104.748000] {softirq-on-W} state
was registered at:
Feb 14 22:55:16 localhost kernel: [ 1104.748000]   [<c0138a1c>]
__lock_acquire+0x70c/0x1040
Feb 14 22:55:16 localhost kernel: [ 1104.748000]   [<c01393bf>]
lock_acquire+0x6f/0x90
Feb 14 22:55:16 localhost kernel: [ 1104.748000]   [<c038862b>]
_spin_lock+0x2b/0x40
Feb 14 22:55:16 localhost kernel: [ 1104.748000]   [<e03e2338>]
hci_sock_dev_event+0x68/0xe0 [bluetooth]
Feb 14 22:55:17 localhost kernel: [ 1104.748000]   [<c0129af2>]
notifier_call_chain+0x32/0x40
Feb 14 22:55:17 localhost kernel: [ 1104.748000]   [<c0129b0b>]
atomic_notifier_call_chain+0xb/0x10
Feb 14 22:55:17 localhost kernel: [ 1104.748000]   [<e03ddbbf>]
hci_notify+0xf/0x20 [bluetooth]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<e03ddf89>]
hci_unregister_dev+0x39/0x60 [bluetooth]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<e04544b1>]
hci_uart_tty_close+0x51/0x70 [hci_uart]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<c02817ff>]
tty_ioctl+0xc0f/0xe50
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<c017c5cb>]
do_ioctl+0x6b/0x80
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<c017c637>]
vfs_ioctl+0x57/0x2a0
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<c017c8e5>]
sys_ioctl+0x65/0x80
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<c0103008>]
syscall_call+0x7/0xb
Feb 14 22:55:18 localhost kernel: [ 1104.748000]   [<ffffffff>] 0xffffffff
Feb 14 22:55:18 localhost kernel: [ 1104.748000] irq event stamp: 3136438
Feb 14 22:55:18 localhost kernel: [ 1104.748000] hardirqs last
enabled at (3136438): [<c0388ad7>] _spin_unlock_irqrestore+0x47/0x60
Feb 14 22:55:18 localhost kernel: [ 1104.748000] hardirqs last
disabled at (3136437): [<c03889b6>] _spin_lock_irqsave+0x16/0x50
Feb 14 22:55:18 localhost kernel: [ 1104.748000] softirqs last
enabled at (3136388): [<c01218e1>] __do_softirq+0xe1/0x100
Feb 14 22:55:18 localhost kernel: [ 1104.748000] softirqs last
disabled at (3136433): [<c0105a15>] do_softirq+0x95/0xf0
Feb 14 22:55:18 localhost kernel: [ 1104.748000]
Feb 14 22:55:18 localhost kernel: [ 1104.748000] other info that might
help us debug this:
Feb 14 22:55:18 localhost kernel: [ 1104.748000] 2 locks held by
gnome-panel/12165:
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  #0:
(hci_task_lock){-.-+}, at: [<e03de535>] hci_rx_task+0x15/0x2a0
[bluetooth]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  #1:
(old_style_rw_init#3){-.-+}, at: [<e03c5029>]
l2cap_recv_frame+0x2b9/0xdb0 [l2cap]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]
Feb 14 22:55:18 localhost kernel: [ 1104.748000] stack backtrace:
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0103fea>]
show_trace_log_lvl+0x1a/0x30
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c01046e2>]
show_trace+0x12/0x20
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0104796>]
dump_stack+0x16/0x20
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0136cb8>]
print_usage_bug+0x158/0x160
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c01379cc>]
mark_lock+0x45c/0x5f0
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c01389f9>]
__lock_acquire+0x6e9/0x1040
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c01393bf>]
lock_acquire+0x6f/0x90
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c038862b>]
_spin_lock+0x2b/0x40
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<e03c5054>]
l2cap_recv_frame+0x2e4/0xdb0 [l2cap]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<e03c6628>]
l2cap_recv_acldata+0x2d8/0x340 [l2cap]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<e03de7a7>]
hci_rx_task+0x287/0x2a0 [bluetooth]
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0121956>]
tasklet_action+0x56/0xe0
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0121882>]
__do_softirq+0x82/0x100
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0105a15>]
do_softirq+0x95/0xf0
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0121738>]
irq_exit+0x48/0x60
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c0105b12>] do_IRQ+0xa2/0x100
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  [<c01039f2>]
common_interrupt+0x2e/0x34
Feb 14 22:55:18 localhost kernel: [ 1104.748000]  =======================
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 00
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 4b
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 4f
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 42
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 4c
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 41
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 4e
Feb 14 22:55:18 localhost kernel: [ 1105.868000] h4_recv: Unknown HCI
packet type 2d
Feb 14 22:55:18 localhost kernel: [ 1105.872000] h4_recv: Unknown HCI
packet type 30
Feb 14 22:55:18 localhost kernel: [ 1105.872000] h4_recv: Unknown HCI
packet type 00
Feb 14 22:55:19 localhost last message repeated 6 times
Feb 14 22:55:19 localhost kernel: [ 1105.876000] h4_recv: Unknown HCI
packet type 00
Feb 14 22:55:19 localhost last message repeated 77 times
Feb 14 22:55:19 localhost kernel: [ 1105.880000] h4_recv: Unknown HCI
packet type 00
Feb 14 22:55:19 localhost last message repeated 7 times
Feb 14 22:55:19 localhost kernel: [ 1105.884000] h4_recv: Unknown HCI
packet type 00
Feb 14 22:55:19 localhost last message repeated 39 times
Feb 14 22:55:19 localhost kernel: [ 1105.888000] h4_recv: Unknown HCI
packet type 00
Feb 14 22:55:19 localhost last message repeated 47 times
Feb 14 22:55:19 localhost kernel: [ 1105.892000] h4_recv: Unknown HCI
packet type 00
Feb 14 22:55:19 localhost last message repeated 29 times
Feb 14 22:55:19 localhost kernel: [ 1105.892000] h4_recv: Unknown HCI
packet type d5
Feb 14 22:55:19 localhost kernel: [ 1105.892000] h4_recv: Unknown HCI
packet type 27
Feb 14 22:55:19 localhost kernel: [ 1105.892000] h4_recv: Unknown HCI
packet type 1e
Feb 14 22:55:19 localhost kernel: [ 1105.892000] h4_recv: Unknown HCI
packet type fa
Feb 14 22:55:19 localhost kernel: [ 1105.892000] h4_recv: Unknown HCI
packet type 74
Feb 14 22:55:19 localhost kernel: [ 1105.892000] h4_recv: Unknown HCI
packet type 05

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
