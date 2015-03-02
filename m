Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>
Subject: Blocking ops when !TASK_RUNNING in bnep
Date: Mon, 02 Mar 2015 15:20:49 +0100
Message-ID: <1491385.CDOh5cxHec@leonov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

While running android-tester on bluetooth-next I've noticed following trace
when running PAN tests.

I'm not sure how to fix this properly but those seem to be somewhat similar to 
accept fixes from few weeks back by Peter.


[  444.282000] ------------[ cut here ]------------
[  444.282032] WARNING: CPU: 1 PID: 10389 at kernel/sched/core.c:7354 
__might_sleep+0x7a/0x90()
[  444.282039] do not call blocking ops when !TASK_RUNNING; state=1 set at 
[<ffffffff8187aef8>] bnep_session+0xa8/0x910
[  444.282041] Modules linked in:
[  444.282047] CPU: 1 PID: 10389 Comm: kbnepd bt-pan Not tainted 3.19.0+ #21
[  444.282050] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  444.282052]  ffffffff81cd56e1 ffff880012863b58 ffffffff81962fa5 
0000000000000000
[  444.282058]  ffff880012863ba8 ffff880012863b98 ffffffff8104eff5 
ffff880012863bd8
[  444.282062]  ffffffff81d6f747 0000000000000939 0000000000000000 
ffff88001c220000
[  444.282067] Call Trace:
[  444.282071]  [<ffffffff81962fa5>] dump_stack+0x4c/0x65
[  444.282075]  [<ffffffff8104eff5>] warn_slowpath_common+0x85/0xc0
[  444.282079]  [<ffffffff8104f071>] warn_slowpath_fmt+0x41/0x50
[  444.282081]  [<ffffffff8187aef8>] ? bnep_session+0xa8/0x910
[  444.282084]  [<ffffffff8187aef8>] ? bnep_session+0xa8/0x910
[  444.282086]  [<ffffffff810729aa>] __might_sleep+0x7a/0x90
[  444.282089]  [<ffffffff816f8eda>] lock_sock_nested+0x2a/0xb0
[  444.282093]  [<ffffffff81862191>] l2cap_sock_sendmsg+0x61/0x110
[  444.282097]  [<ffffffff816f4f9f>] do_sock_sendmsg+0x7f/0xa0
[  444.282100]  [<ffffffff816f5023>] kernel_sendmsg+0x53/0x70
[  444.282102]  [<ffffffff8187b39c>] bnep_session+0x54c/0x910
[  444.282105]  [<ffffffff81072b59>] ? finish_task_switch+0x49/0x100
[  444.282108]  [<ffffffff8107a260>] ? wake_up_state+0x10/0x10
[  444.282111]  [<ffffffff8187ae50>] ? bnep_rx_control+0x400/0x400
[  444.282113]  [<ffffffff8187ae50>] ? bnep_rx_control+0x400/0x400
[  444.282116]  [<ffffffff8106d3ea>] kthread+0xea/0x100
[  444.282119]  [<ffffffff8106d300>] ? kthread_create_on_node+0x220/0x220
[  444.282123]  [<ffffffff8196fcac>] ret_from_fork+0x7c/0xb0
[  444.282125]  [<ffffffff8106d300>] ? kthread_create_on_node+0x220/0x220
[  444.282127] ---[ end trace 4a98530915b46f89 ]---

-- 
BR
Szymon Janc
