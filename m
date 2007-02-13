Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4f436aae0702130743p6a976c79s8c65db3e3972dfa6@mail.gmail.com>
Date: Tue, 13 Feb 2007 17:43:09 +0200
From: "Choi Sonim" <choisonim@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] bluez problem while pairing
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

I have a problem,
I setup the device ok,
and it is discoverable,
but when I try to connect to it I get the following...

what can I do ?

i use 2.6.20-rc5 and FC6.

thanks
choi

Feb 13 19:23:06 localhost hcid[2360]: HCI dev 0 registered
Feb 13 19:23:06 localhost hcid[2360]: Register path:/org/bluez/hci0 fallback:0
Feb 13 19:23:06 localhost hcid[2360]: HCI dev 0 up
Feb 13 19:23:06 localhost hcid[2360]: Device hci0 has been added
Feb 13 19:23:06 localhost hcid[2360]: Starting security manager 0
Feb 13 19:23:06 localhost hcid[2360]: Device hci0 has been activated
Feb 13 19:27:55 localhost kernel: [ 1500.680000]
Feb 13 19:27:55 localhost kernel: [ 1500.680000]
=================================
Feb 13 19:27:55 localhost kernel: [ 1500.680000] [ INFO: inconsistent
lock state ]
Feb 13 19:27:55 localhost kernel: [ 1500.680000] 2.6.20-rc5 #1
Feb 13 19:27:55 localhost kernel: [ 1500.680000]
---------------------------------
Feb 13 19:27:55 localhost kernel: [ 1500.680000] inconsistent
{softirq-on-W} -> {in-softirq-W} usage.
Feb 13 19:27:55 localhost kernel: [ 1500.680000] swapper/0
[HC0[0]:SC1[1]:HE1:SE0] takes:
Feb 13 19:27:55 localhost kernel: [ 1500.680000]
(slock-AF_BLUETOOTH){-+..}, at: [<e03c7054>]
l2cap_recv_frame+0x2e4/0xdb0 [l2cap]
Feb 13 19:27:55 localhost kernel: [ 1500.680000] {softirq-on-W} state
was registered at:
Feb 13 19:27:55 localhost kernel: [ 1500.680000]   [<c0138df4>]
__lock_acquire+0x6c4/0xdc0
Feb 13 19:27:55 localhost kernel: [ 1500.680000]   [<c013955f>]
lock_acquire+0x6f/0x90
Feb 13 19:27:55 localhost kernel: [ 1500.680000]   [<c0391a25>]
_spin_lock+0x35/0x50
Feb 13 19:27:55 localhost kernel: [ 1500.680000]   [<e00c6498>]
hci_sock_dev_event+0x68/0xe0 [bluetooth]
Feb 13 19:27:55 localhost kernel: [ 1500.680000]   [<c0394212>]
notifier_call_chain+0x32/0x40
Feb 13 19:27:55 localhost hcid[2360]: pin_code_request
(sba=00:xx:xx:xx:xx:xx, dba=00:yy:yy:yy:yy:yy)
Feb 13 19:27:55 localhost kernel: [ 1500.680000]   [<c039424f>]
atomic_notifier_call_chain+0x2f/0x70
Feb 13 19:27:55 localhost kernel: [ 1500.680000]   [<e00c1c1f>]
hci_notify+0xf/0x20 [bluetooth]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<e00c1fd9>]
hci_unregister_dev+0x39/0x60 [bluetooth]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<e00e9e86>]
hci_usb_disconnect+0x46/0x80 [hci_usb]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02e294b>]
usb_unbind_interface+0x3b/0x80
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02a800a>]
__device_release_driver+0x6a/0x90
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02a84e0>]
device_release_driver+0x30/0x50
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02a7942>]
bus_remove_device+0x62/0x90
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02a5cfd>]
device_del+0x17d/0x1e0
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02e026e>]
usb_disable_device+0x7e/0xf0
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02dc696>]
usb_disconnect+0xa6/0x120
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c02dd369>]
hub_thread+0x1d9/0xb30
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c0130a57>]
kthread+0xb7/0xe0
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<c0103e27>]
kernel_thread_helper+0x7/0x10
Feb 13 19:27:56 localhost kernel: [ 1500.680000]   [<ffffffff>] 0xffffffff
Feb 13 19:27:56 localhost kernel: [ 1500.680000] irq event stamp: 7108370
Feb 13 19:27:56 localhost kernel: [ 1500.680000] hardirqs last
enabled at (7108370): [<c03920a5>] _spin_unlock_irqrestore+0x55/0x70
Feb 13 19:27:56 localhost kernel: [ 1500.680000] hardirqs last
disabled at (7108369): [<c0391cd6>] _spin_lock_irqsave+0x16/0x60
Feb 13 19:27:56 localhost kernel: [ 1500.680000] softirqs last
enabled at (7108358): [<c0121a44>] __do_softirq+0xf4/0x110
Feb 13 19:27:56 localhost kernel: [ 1500.680000] softirqs last
disabled at (7108365): [<c01055d8>] do_softirq+0x98/0xf0
Feb 13 19:27:56 localhost kernel: [ 1500.680000]
Feb 13 19:27:56 localhost kernel: [ 1500.680000] other info that might
help us debug this:
Feb 13 19:27:56 localhost kernel: [ 1500.680000] 2 locks held by swapper/0:
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  #0:
(hci_task_lock){-.-+}, at: [<e00c25c5>] hci_rx_task+0x15/0x2a0
[bluetooth]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  #1:
(old_style_rw_init#3){-.-+}, at: [<e03c7029>]
l2cap_recv_frame+0x2b9/0xdb0 [l2cap]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]
Feb 13 19:27:56 localhost kernel: [ 1500.680000] stack backtrace:
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c01041fa>]
show_trace_log_lvl+0x1a/0x30
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c01048d2>]
show_trace+0x12/0x20
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c01049c6>]
dump_stack+0x16/0x20
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c01371d8>]
print_usage_bug+0x158/0x160
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c0137ea1>]
mark_lock+0x441/0x520
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c0138dd1>]
__lock_acquire+0x6a1/0xdc0
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c013955f>]
lock_acquire+0x6f/0x90
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c0391a25>]
_spin_lock+0x35/0x50
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<e03c7054>]
l2cap_recv_frame+0x2e4/0xdb0 [l2cap]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<e03c8628>]
l2cap_recv_acldata+0x2d8/0x340 [l2cap]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<e00c2837>]
hci_rx_task+0x287/0x2a0 [bluetooth]
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c0121ac4>]
tasklet_action+0x64/0xe0
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c01219d3>]
__do_softirq+0x83/0x110
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  [<c01055d8>]
do_softirq+0x98/0xf0
Feb 13 19:27:56 localhost kernel: [ 1500.680000]  =======================
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_check_data_len:
Data length is too large
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 00
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 0c
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 00
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 01
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 00
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 01
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 00
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 01
Feb 13 19:27:56 localhost kernel: [ 1500.728000] h4_recv: Unknown HCI
packet type 00
Feb 13 19:27:56 localhost kernel: [ 1501.032000] h4_recv: Unknown HCI
packet type 00
Feb 13 19:27:56 localhost last message repeated 27 times
Feb 13 19:27:56 localhost kernel: [ 1501.036000] h4_recv: Unknown HCI
packet type 00
Feb 13 19:27:56 localhost last message repeated 10 times
Feb 13 19:27:56 localhost kernel: [ 1501.036000] h4_recv: Unknown HCI
packet type 55
Feb 13 19:27:56 localhost kernel: [ 1501.036000] h4_recv: Unknown HCI
packet type 27
Feb 13 19:27:56 localhost kernel: [ 1501.036000] h4_recv: Unknown HCI
packet type 1a
Feb 13 19:27:58 localhost hcid[2360]: Can't read name for hci0:
Connection timed out (110)
Feb 13 19:27:58 localhost kernel: [ 1503.012000] hci_cmd_task: hci0
command tx timeout
Feb 13 19:28:25 localhost kernel: [ 1530.776000] h4_recv: Unknown HCI
packet type 05
Feb 13 19:28:25 localhost kernel: [ 1530.776000] h4_recv: Unknown HCI
packet type 13
Feb 13 19:28:26 localhost kernel: [ 1531.592000] hci_cmd_task: hci0
command tx timeout

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
