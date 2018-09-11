Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Free rw_semaphore on close
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180828014830.13529-1-chenhui.zhang@axis.com>
Date: Tue, 11 Sep 2018 13:36:40 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, ronald@innovation.ch,
        Hermes Zhang <chenhuiz@axis.com>
Message-Id: <5A684F85-A068-4FEA-ADAC-DDB5EFEDFF2C@holtmann.org>
References: <20180828014830.13529-1-chenhui.zhang@axis.com>
To: Hermes Zhang <chenhui.zhang@axis.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hermes,

> The percpu_rw_semaphore is not currently freed, and this leads to
> a crash when the stale rcu callback is invoked.  DEBUG_OBJECTS
> detects this.
> 
> ODEBUG: free active (active state 1) object type: rcu_head hint: (null)
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 2024 at debug_print_object+0xac/0xc8
> PC is at debug_print_object+0xac/0xc8
> LR is at debug_print_object+0xac/0xc8
> Call trace:
> [<ffffff80082e2c2c>] debug_print_object+0xac/0xc8
> [<ffffff80082e40b0>] debug_check_no_obj_freed+0x1e8/0x228
> [<ffffff8008191254>] kfree+0x1cc/0x250
> [<ffffff80083cc03c>] hci_uart_tty_close+0x54/0x108
> [<ffffff800832e118>] tty_ldisc_close.isra.1+0x40/0x58
> [<ffffff800832e14c>] tty_ldisc_kill+0x1c/0x40
> [<ffffff800832e3dc>] tty_ldisc_release+0x94/0x170
> [<ffffff8008325554>] tty_release_struct+0x1c/0x58
> [<ffffff8008326400>] tty_release+0x3b0/0x490
> [<ffffff80081a3fe8>] __fput+0x88/0x1d0
> [<ffffff80081a418c>] ____fput+0xc/0x18
> [<ffffff80080c0624>] task_work_run+0x9c/0xc0
> [<ffffff80080a9e24>] do_exit+0x24c/0x8a0
> [<ffffff80080aa4e0>] do_group_exit+0x38/0xa0
> [<ffffff80080aa558>] __wake_up_parent+0x0/0x28
> [<ffffff8008082c00>] el0_svc_naked+0x34/0x38
> ---[ end trace bfe08cbd89098cdf ]---
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-stable tree.

Regards

Marcel
