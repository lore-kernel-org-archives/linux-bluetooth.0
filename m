Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B4C3BCF.8030501@xenontk.org>
References: <4B4C3BCF.8030501@xenontk.org>
Date: Tue, 12 Jan 2010 13:58:26 +0200
Message-ID: <2d5a2c101001120358g6f2a320cm358c71d910933296@mail.gmail.com>
Subject: Re: BUG: Commit 9e726b17 (Bluetooth: Fix rejected connection not
	disconnecting ACL link) causes trace
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davidjon@xenontk.org
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 12, 2010 at 11:07 AM, David John <davidjon@xenontk.org> wrote:
> Hi,
>
> The commit 9e726b17 (Bluetooth: Fix rejected connection not
> disconnecting ACL link) causes the following trace:
>
> BUG: sleeping function called from invalid context at net/core/sock.c:1897
> in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swapper
> Pid: 0, comm: swapper Tainted: P а а а а а 2.6.32 #31
> Call Trace:
> а<IRQ> а[<ffffffff81036455>] __might_sleep+0xf8/0xfa
> а[<ffffffff8138ef1d>] lock_sock_nested+0x29/0xc4
> а[<ffffffffa03921b3>] lock_sock+0xb/0xd [l2cap]
> а[<ffffffffa03948e6>] l2cap_sock_shutdown+0x1c/0x76 [l2cap]
> а[<ffffffff8106adea>] ? clockevents_program_event+0x75/0x7e
> а[<ffffffff8106bea2>] ? tick_dev_program_event+0x37/0xa5
> а[<ffffffffa0394967>] l2cap_sock_release+0x27/0x67 [l2cap]
> а[<ffffffff8138c971>] sock_release+0x1a/0x67
> а[<ffffffffa03d2492>] rfcomm_session_del+0x34/0x53 [rfcomm]
> а[<ffffffffa03d24c5>] rfcomm_session_put+0x14/0x16 [rfcomm]
> а[<ffffffffa03d28b4>] rfcomm_session_timeout+0xe/0x1a [rfcomm]
> а[<ffffffff810554a8>] run_timer_softirq+0x1e2/0x29a
> а[<ffffffffa03d28a6>] ? rfcomm_session_timeout+0x0/0x1a [rfcomm]
> а[<ffffffff8104e0f6>] __do_softirq+0xfe/0x1c5
> а[<ffffffff8100e8ce>] ? timer_interrupt+0x1a/0x21
> а[<ffffffff8100cc4c>] call_softirq+0x1c/0x28
> а[<ffffffff8100e05b>] do_softirq+0x33/0x6b
> а[<ffffffff8104daf6>] irq_exit+0x36/0x85
> а[<ffffffff8100d7a9>] do_IRQ+0xa6/0xbd
> а[<ffffffff8100c493>] ret_from_intr+0x0/0xa
> а<EOI> а[<ffffffff812585b3>] ? acpi_idle_enter_bm+0x269/0x294
> а[<ffffffff812585a9>] ? acpi_idle_enter_bm+0x25f/0x294
> а[<ffffffff81373ddc>] ? cpuidle_idle_call+0x97/0x107
> а[<ffffffff8100aca0>] ? cpu_idle+0x53/0xaa
> а[<ffffffff81429006>] ? rest_init+0x7a/0x7c
> а[<ffffffff8177bc8c>] ? start_kernel+0x389/0x394
> а[<ffffffff8177b29c>] ? x86_64_start_reservations+0xac/0xb0
> а[<ffffffff8177b384>] ? x86_64_start_kernel+0xe4/0xeb
>
> since lock_sock is called from the timer function rfcomm_session_timeout.

So it is not possible while in timer context? I guess not.

@Marcel: Any idea how we can possibly fix this? iirc we do a similar
thing for rfcomm_dlc_timeout, but that doesn't cause a sleep so I
guess we need a different approach for rfcomm_session_timeout.

-- 
Luiz Augusto von Dentz
Engenheiro de Computaчуo
