Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 199111] BCM4324B5: bt connection to paired devices is only
 established when discovery/scan is enabled
Date: Mon, 16 Apr 2018 08:52:34 +0000
Message-ID: <bug-199111-62941-WFOamUwtIc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199111-62941@https.bugzilla.kernel.org/>
References: <bug-199111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=199111

--- Comment #3 from Stefan Assmann (sassmann@redhat.com) ---
Still in 4.17-rc1
[   16.978701] ======================================================
[   16.981638] WARNING: possible circular locking dependency detected
[   16.984548] 4.17.0-rc1 #74 Not tainted
[   16.987449] ------------------------------------------------------
[   16.990308] kworker/u8:0/6 is trying to acquire lock:
[   16.993062] 00000000be6488d6 (bcm_device_lock){+.+.}, at:
bcm_recv+0x68/0x110 [hci_uart]
[   16.995928]
               but task is already holding lock:
[   17.001493] 0000000091379733 (&buf->lock){+.+.}, at:
flush_to_ldisc+0x20/0xa0
[   17.004356]
               which lock already depends on the new lock.

[   17.012791]
               the existing dependency chain (in reverse order) is:
[   17.018356]
               -> #3 (&buf->lock){+.+.}:
[   17.023850]        tty_buffer_flush+0x2f/0x90
[   17.026602]        tty_ldisc_flush+0x1d/0x40
[   17.029347]        vt_ioctl+0x56b/0x11c0
[   17.032086]        tty_ioctl+0xef/0x950
[   17.034839]        do_vfs_ioctl+0xa5/0x6e0
[   17.037586]        ksys_ioctl+0x70/0x80
[   17.037589]        __x64_sys_ioctl+0x16/0x20
[   17.037594]        do_syscall_64+0x60/0x200
[   17.037599]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   17.037601]
               -> #2 (&tty->ldisc_sem){++++}:
[   17.037609]        tty_ldisc_lock+0x12/0x30
[   17.037612]        tty_init_dev+0x90/0x1e0
[   17.037614]        tty_open+0x295/0x450
[   17.037617]        chrdev_open+0xa7/0x1d0
[   17.037621]        do_dentry_open+0x1c7/0x370
[   17.037623]        path_openat+0x592/0xd00
[   17.037625]        do_filp_open+0x9b/0x110
[   17.037628]        do_sys_open+0x1bd/0x250
[   17.037632]        kernel_init_freeable+0x243/0x2d0
[   17.037636]        kernel_init+0xa/0x110
[   17.037638]        ret_from_fork+0x3a/0x50
[   17.037639]
               -> #1 (&tty->legacy_mutex){+.+.}:
[   17.037645]        tty_init_dev+0x52/0x1e0
[   17.037649]        ttyport_open+0x37/0x150
[   17.037661]        bcm_open+0x88/0x1e0 [hci_uart]
[   17.037667]        hci_uart_register_device+0x31/0x200 [hci_uart]
[   17.037671]        driver_probe_device+0x30b/0x480
[   17.037674]        __driver_attach+0xbc/0xe0
[   17.037676]        bus_for_each_dev+0x79/0xc0
[   17.037679]        driver_attach_async+0xe/0x40
[   17.037682]        async_run_entry_fn+0x39/0x160
[   17.037686]        process_one_work+0x266/0x6b0
[   17.037689]        worker_thread+0x3a/0x390
[   17.037691]        kthread+0x121/0x140
[   17.037693]        ret_from_fork+0x3a/0x50
[   17.037694]
               -> #0 (bcm_device_lock){+.+.}:
[   17.037701]        __mutex_lock+0x7f/0xa40
[   17.037708]        bcm_recv+0x68/0x110 [hci_uart]
[   17.037715]        hci_uart_receive_buf+0x49/0x70 [hci_uart]
[   17.037717]        ttyport_receive_buf+0x50/0xd0
[   17.037720]        flush_to_ldisc+0x81/0xa0
[   17.037723]        process_one_work+0x266/0x6b0
[   17.037726]        worker_thread+0x3a/0x390
[   17.037728]        kthread+0x121/0x140
[   17.037730]        ret_from_fork+0x3a/0x50
[   17.037731]
               other info that might help us debug this:

[   17.037732] Chain exists of:
                 bcm_device_lock --> &tty->ldisc_sem --> &buf->lock

[   17.037738]  Possible unsafe locking scenario:

[   17.037739]        CPU0                    CPU1
[   17.037740]        ----                    ----
[   17.037741]   lock(&buf->lock);
[   17.037744]                                lock(&tty->ldisc_sem);
[   17.037746]                                lock(&buf->lock);
[   17.037748]   lock(bcm_device_lock);
[   17.037750]
                *** DEADLOCK ***

[   17.037753] 3 locks held by kworker/u8:0/6:
[   17.037753]  #0: 000000000601b32c ((wq_completion)"events_unbound"){+.+.},
at: process_one_work+0x1da/0x6b0
[   17.037762]  #1: 00000000a7b86b78 ((work_completion)(&buf->work)){+.+.}, at:
process_one_work+0x1da/0x6b0
[   17.037769]  #2: 0000000091379733 (&buf->lock){+.+.}, at:
flush_to_ldisc+0x20/0xa0
[   17.037776]
               stack backtrace:
[   17.037780] CPU: 1 PID: 6 Comm: kworker/u8:0 Not tainted 4.17.0-rc1 #74
[   17.037782] Hardware name: LENOVO 20C10026UK/20C10026UK, BIOS GWET46WW
(1.46) 02/01/2018
[   17.037787] Workqueue: events_unbound flush_to_ldisc
[   17.037789] Call Trace:
[   17.037801]  dump_stack+0x85/0xcb
[   17.037807]  print_circular_bug.isra.40+0x1ce/0x1db
[   17.037812]  __lock_acquire+0x1299/0x1340
[   17.037822]  ? lock_acquire+0x9f/0x200
[   17.037825]  lock_acquire+0x9f/0x200
[   17.037834]  ? bcm_recv+0x68/0x110 [hci_uart]
[   17.037843]  ? bcm_recv+0x68/0x110 [hci_uart]
[   17.037847]  __mutex_lock+0x7f/0xa40
[   17.037855]  ? bcm_recv+0x68/0x110 [hci_uart]
[   17.037858]  ? trace_hardirqs_on_caller+0xed/0x180
[   17.037889]  ? hci_recv_frame+0x5e/0x90 [bluetooth]
[   17.037897]  ? h4_recv_buf+0x184/0x300 [hci_uart]
[   17.037906]  ? bcm_recv+0x68/0x110 [hci_uart]
[   17.037914]  bcm_recv+0x68/0x110 [hci_uart]
[   17.037922]  hci_uart_receive_buf+0x49/0x70 [hci_uart]
[   17.037927]  ttyport_receive_buf+0x50/0xd0
[   17.037932]  flush_to_ldisc+0x81/0xa0
[   17.037937]  process_one_work+0x266/0x6b0
[   17.037943]  worker_thread+0x3a/0x390
[   17.037947]  ? process_one_work+0x6b0/0x6b0
[   17.037950]  kthread+0x121/0x140
[   17.037954]  ? kthread_create_worker_on_cpu+0x70/0x70
[   17.037957]  ret_from_fork+0x3a/0x50

-- 
You are receiving this mail because:
You are the assignee for the bug.