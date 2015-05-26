Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 May 2015 09:46:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	gustavo@padovan.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: 3.17..4.1-rc3: bluetooth rfcomm kills kernel when trying to setup
 DUN networking
Message-ID: <20150526074400.GA3634@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I'm trying to set up DUN networking against Nokia 6151 on a
PC... fairly standard task, AFAICT. Unfortunately, it likes to kill
the kernel rather too often.

sleep .1
rfcomm unbind 0
rfcomm bind 0 $ADDRESS

pppd file /etc/ppp/gprs | tee /root/log/pppd.tmp

... when ran first time, I get garbage: (like two listeners on same
serial...? Aha, there's ModemManager interfering with my manual attempt)

pavel@duo:~$ sudo ~pavel/bin/btppp u
[sudo] password for pavel:
Can't release device: No such device
Press CTRL-C to close the connection at any stage!
defining PDP context...
ATE1 E0




Connect script failed
pavel@duo:~$

Re-running the script sometimes works, but very often it causes kernel
oops, on rather wide range of kernels. (From debian 3.17 to vanilla
4.1-rc3). Thinkpad X60.

Unfortunately, it makes me unable to get on internet using GPRS...

Best regards,
									Pavel

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 4.1.0-rc3+ (pavel@amd) (gcc version 4.9.2 (Debian 4.9.2-10) ) #80 SMP Mon May 25 09:58:35 CEST 2015
[    0.000000] Disabled fast string operations
[    0.000000] e820: BIOS-provided physical RAM map:
...
[   85.835557] Bluetooth: TIOCGSERIAL is not supported
[   87.237677] Bluetooth: TIOCGSERIAL is not supported
[   93.727304] BUG: unable to handle kernel paging request at 5a5a5b5e
[   93.727396] IP: [<c4078e3f>] __lock_acquire.isra.24+0x16f/0xca0
[   93.727467] *pdpt = 000000002bbc0001 *pde = 0000000000000000 
[   93.727534] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC 
[   93.727587] Modules linked in:
[   93.727618] CPU: 1 PID: 3465 Comm: pppd Tainted: G        W       4.1.0-rc3+ #80
[   93.727695] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 ) 03/31/2011
[   93.727778] task: ec3d7560 ti: e3dd6000 task.ti: e3dd6000
[   93.727833] EIP: 0060:[<c4078e3f>] EFLAGS: 00010006 CPU: 1
[   93.727887] EIP is at __lock_acquire.isra.24+0x16f/0xca0
[   93.727938] EAX: e5d49fb0 EBX: 00000000 ECX: 00000000 EDX: 00000000
[   93.728002] ESI: 5a5a5a5a EDI: ec3d7560 EBP: e3dd7d48 ESP: e3dd7d24
[   93.728067]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   93.728122] CR0: 80050033 CR2: 5a5a5b5e CR3: 34b5c760 CR4: 00000630
[   93.728186] Stack:
[   93.728197]  e3dd7d38 00000246 00000000 00000001 e5d49fb0 01dd7d40 00000000 00000246
[   93.728310]  e3fdec00 e3dd7d6c c40799b6 00000000 00000000 00000000 c49348cf 00000000
[   93.728422]  e5d49f7c 00000000 e3dd7db0 c49ceac8 00000000 00000001 00000000 c49348cf
[   93.728534] Call Trace:
[   93.728554]  [<c40799b6>] lock_acquire+0x46/0x70
[   93.728602]  [<c49348cf>] ? rfcomm_tty_open+0x6f/0x190
[   93.728654]  [<c49ceac8>] mutex_lock_nested+0x28/0x2e0
[   93.728703]  [<c49348cf>] ? rfcomm_tty_open+0x6f/0x190
[   93.728756]  [<c4371dd7>] ? tty_port_open+0x87/0xb0
[   93.728804]  [<c49348cf>] rfcomm_tty_open+0x6f/0x190
[   93.728851]  [<c49d0e5d>] ? _raw_spin_unlock+0x1d/0x20
[   93.728901]  [<c436ad88>] tty_open+0xd8/0x530
[   93.728942]  [<c436ad88>] ? tty_open+0xd8/0x530
[   93.728987]  [<c4102f62>] chrdev_open+0x82/0x190
[   93.729033]  [<c40fd707>] do_dentry_open.isra.15+0x137/0x2d0
[   93.729088]  [<c4102ee0>] ? cdev_put+0x20/0x20
[   93.729129]  [<c40fd90c>] vfs_open+0x3c/0x50
[   93.729170]  [<c410a02f>] do_last.isra.46+0x2df/0xc90
[   93.729220]  [<c410c44a>] ? path_openat+0x4a/0x570
[   93.729265]  [<c410c464>] path_openat+0x64/0x570
[   93.729309]  [<c410d3f7>] do_filp_open+0x27/0x80
[   93.729353]  [<c4118ec0>] ? __alloc_fd+0x80/0x100
[   93.729399]  [<c40fe86f>] do_sys_open+0x10f/0x200
[   93.729445]  [<c41008f8>] ? ____fput+0x8/0x10
[   93.729487]  [<c40fe978>] SyS_open+0x18/0x20
[   93.729527]  [<c49d161e>] syscall_call+0x7/0x7
[   93.730252] Code: 08 00 00 85 f6 75 24 90 8d 74 26 00 31 f6 8d 65 f4 89 f0 5b 5e 5f 5d c3 8d 74 26 00 8b 45 ec 8b 74 98 04 85 f6 0f 84 d3 fe ff ff <f0> ff 86 04 01 00 00 a1 d0 6d 47 c5 8b 9f 50 05 00 00 85 c0 0f
[   93.730252] EIP: [<c4078e3f>] __lock_acquire.isra.24+0x16f/0xca0 SS:ESP 0068:e3dd7d24
[   93.730252] CR2: 000000005a5a5b5e
[   93.730252] ---[ end trace 72af900b148ab0d1 ]---
[   93.752067] ------------[ cut here ]------------
[   93.752067] WARNING: CPU: 1 PID: 3465 at kernel/softirq.c:150 __local_bh_enable_ip+0x58/0x90()
[   93.752067] Modules linked in:
[   93.752067] CPU: 1 PID: 3465 Comm: pppd Tainted: G      D W       4.1.0-rc3+ #80
[   93.752067] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 ) 03/31/2011
[   93.752067]  00000001 00000000 e3dd7b04 c49c6b8f 00000000 e3dd7b20 c403dacb 00000096
[   93.752067]  c4040718 00000200 e3dd3f98 e3dd3e54 e3dd7b30 c403db6f 00000009 00000000
[   93.752067]  e3dd7b3c c4040718 e3dd3e54 e3dd7b48 c49d11ea e3dd3c80 e3dd7b70 c48dc5fd
[   93.752067] Call Trace:
[   93.752067]  [<c49c6b8f>] dump_stack+0x41/0x52
[   93.752067]  [<c403dacb>] warn_slowpath_common+0x6b/0xa0
[   93.752067]  [<c4040718>] ? __local_bh_enable_ip+0x58/0x90
[   93.752067]  [<c403db6f>] warn_slowpath_null+0xf/0x20
[   93.752067]  [<c4040718>] __local_bh_enable_ip+0x58/0x90
[   93.752067]  [<c49d11ea>] _raw_write_unlock_bh+0x2a/0x30
[   93.752067]  [<c48dc5fd>] unix_release_sock+0x6d/0x220
[   93.752067]  [<c48dc7c6>] unix_release+0x16/0x30
[   93.752067]  [<c4820544>] sock_release+0x14/0x70
[   93.752067]  [<c48205ab>] sock_close+0xb/0x10
[   93.752067]  [<c4100782>] __fput+0x82/0x1c0
[   93.752067]  [<c41008f8>] ____fput+0x8/0x10
[   93.752067]  [<c4054799>] task_work_run+0xc9/0xe0
[   93.752067]  [<c4050707>] ? pool_mayday_timeout+0x37/0x120
[   93.752067]  [<c403ed75>] do_exit+0x275/0x930
[   93.752067]  [<c408964a>] ? kmsg_dump+0xea/0x100
[   93.752067]  [<c40050d0>] oops_end+0x80/0xb0
[   93.752067]  [<c40341c5>] no_context+0xf5/0x260
[   93.752067]  [<c4062ee8>] ? update_cfs_rq_blocked_load+0xf8/0x190
[   93.752067]  [<c40343ba>] __bad_area_nosemaphore+0x8a/0x130
[   93.752067]  [<c4034615>] bad_area+0x35/0x40
[   93.752067]  [<c40348bd>] __do_page_fault+0x29d/0x3b0
[   93.752067]  [<c40349e0>] ? vmalloc_sync_all+0x10/0x10
[   93.752067]  [<c40349eb>] do_page_fault+0xb/0x10
[   93.752067]  [<c49d2197>] error_code+0x67/0x6c
[   93.752067]  [<c4078e3f>] ? __lock_acquire.isra.24+0x16f/0xca0
[   93.752067]  [<c40799b6>] lock_acquire+0x46/0x70
[   93.752067]  [<c49348cf>] ? rfcomm_tty_open+0x6f/0x190
[   93.752067]  [<c49ceac8>] mutex_lock_nested+0x28/0x2e0
[   93.752067]  [<c49348cf>] ? rfcomm_tty_open+0x6f/0x190
[   93.752067]  [<c4371dd7>] ? tty_port_open+0x87/0xb0
[   93.752067]  [<c49348cf>] rfcomm_tty_open+0x6f/0x190
[   93.752067]  [<c49d0e5d>] ? _raw_spin_unlock+0x1d/0x20
[   93.752067]  [<c436ad88>] tty_open+0xd8/0x530
[   93.752067]  [<c436ad88>] ? tty_open+0xd8/0x530
[   93.752067]  [<c4102f62>] chrdev_open+0x82/0x190
[   93.752067]  [<c40fd707>] do_dentry_open.isra.15+0x137/0x2d0
[   93.752067]  [<c4102ee0>] ? cdev_put+0x20/0x20
[   93.752067]  [<c40fd90c>] vfs_open+0x3c/0x50
[   93.752067]  [<c410a02f>] do_last.isra.46+0x2df/0xc90
[   93.752067]  [<c410c44a>] ? path_openat+0x4a/0x570
[   93.752067]  [<c410c464>] path_openat+0x64/0x570
[   93.752067]  [<c410d3f7>] do_filp_open+0x27/0x80
[   93.752067]  [<c4118ec0>] ? __alloc_fd+0x80/0x100
[   93.752067]  [<c40fe86f>] do_sys_open+0x10f/0x200
[   93.752067]  [<c41008f8>] ? ____fput+0x8/0x10
[   93.752067]  [<c40fe978>] SyS_open+0x18/0x20
[   93.752067]  [<c49d161e>] syscall_call+0x7/0x7
[   93.752067] ---[ end trace 72af900b148ab0d2 ]---

Happens on 3.17, too:

[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.17.0+ (pavel@duo) (gcc version 4.9.1 (Debian 4.9.1-16) ) #2 SMP Mon Oct 13 23:14:42 CEST 2014
[    0.000000] Disabled fast string operations
...
[   72.927912] Bluetooth: TIOCGSERIAL is not supported
[   76.766721] Bluetooth: TIOCGSERIAL is not supported
[   80.607053] BUG: unable to handle kernel paging request at f0d71fc4
[   80.607143] IP: [<c4765254>] rfcomm_dlc_open+0x44/0x340
[   80.607205] *pde = 052ed067 *pte = 30d71060 
[   80.607251] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
[   80.607304] Modules linked in:
[   80.607334] CPU: 0 PID: 3281 Comm: pppd Not tainted 3.17.0+ #2
[   80.607392] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 ) 03/31/2011
[   80.607476] task: e4d8d580 ti: ef79a000 task.ti: ef79a000
[   80.607532] EIP: 0060:[<c4765254>] EFLAGS: 00010293 CPU: 0
[   80.607587] EIP is at rfcomm_dlc_open+0x44/0x340
[   80.607630] EAX: 00000000 EBX: ef79bd94 ECX: 00000001 EDX: 0000009a
[   80.607695] ESI: 00000001 EDI: f0d71f00 EBP: ef79bd80 ESP: ef79bd50
[   80.607758]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   80.607811] CR0: 80050033 CR2: f0d71fc4 CR3: 2c447000 CR4: 00000710
[   80.607874] Stack:
[   80.607885]  e6873e1a e6873e14 e6873d4c f5799c00 ef79bda0 c47ef8b8 00000000 00000001
[   80.607996]  00000000 00000001 f5799c00 ef79bd94 ef79bda0 c476a368 ef79bda0 e6873d4c
[   80.608107]  c476a368 00000001 e6873c00 f5799c00 ef79bdb8 c43175e8 e4d6dec0 f5799c00
[   80.608218] Call Trace:
[   80.608242]  [<c47ef8b8>] ? mutex_lock_nested+0x28/0x2c0
[   80.608296]  [<c476a368>] rfcomm_dev_activate+0x28/0x40
[   80.608349]  [<c476a368>] ? rfcomm_dev_activate+0x28/0x40
[   80.608405]  [<c43175e8>] tty_port_open+0x68/0xb0
[   80.608452]  [<c476a0b1>] rfcomm_tty_open+0x41/0x190
[   80.608501]  [<c47f27bd>] ? _raw_spin_unlock+0x1d/0x20
[   80.608553]  [<c430fab9>] tty_open+0x149/0x5b0
[   80.608596]  [<c430fab9>] ? tty_open+0x149/0x5b0
[   80.608642]  [<c40f29b2>] chrdev_open+0x82/0x190
[   80.608687]  [<c40ecfa4>] do_dentry_open.isra.16+0x184/0x2c0
[   80.608744]  [<c40f2930>] ? cdev_put+0x20/0x20
[   80.608786]  [<c40ed186>] finish_open+0x16/0x30
[   80.608831]  [<c40faccf>] do_last.isra.53+0x5ef/0xc60
[   80.608883]  [<c40fb3d8>] path_openat+0x98/0x580
[   80.608928]  [<c40fc837>] do_filp_open+0x27/0x80
[   80.608973]  [<c41082e0>] ? __alloc_fd+0x80/0x100
[   80.609020]  [<c40ee1ff>] do_sys_open+0x10f/0x200
[   80.609067]  [<c40ee308>] SyS_open+0x18/0x20
[   80.609108]  [<c47f30de>] syscall_call+0x7/0x7
[   80.609147] Code: c4 83 ec 24 89 55 d4 31 d2 89 4d d0 8b 33 e8 54 a6 08 00 f6 05 5a 7e b9 c4 04 0f 85 1f 01 00 00 8d 46 ff 3c 1d 0f 87 3e 01 00 00 <8b> 87 c4 00 00 00 83 f8 09 74 29 83 f8 02 c7 45 d8 00 00 00 00
[   80.609617] EIP: [<c4765254>] rfcomm_dlc_open+0x44/0x340 SS:ESP 0068:ef79bd50
[   80.609979] CR2: 00000000f0d71fc4
[   80.609979] ---[ end trace 82e6395426152cad ]---
[   80.609979] ------------[ cut here ]------------
[   80.609979] WARNING: CPU: 0 PID: 3281 at kernel/softirq.c:146 __local_bh_enable_ip+0x58/0x90()
[   80.609979] Modules linked in:
[   80.609979] CPU: 0 PID: 3281 Comm: pppd Tainted: G      D        3.17.0+ #2
[   80.609979] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 ) 03/31/2011
[   80.609979]  00000000 00000000 ef79bb08 c47eb2ad 00000000 ef79bb24 c4037652 00000092
[   80.609979]  c403a108 00000200 e4d03f84 e4d03e44 ef79bb34 c40376df 00000009 00000000
[   80.609979]  ef79bb40 c403a108 e4d03e44 ef79bb4c c47f2b4a e4d03c80 ef79bb74 c471b72d
[   80.609979] Call Trace:
[   80.609979]  [<c47eb2ad>] dump_stack+0x41/0x52
[   80.609979]  [<c4037652>] warn_slowpath_common+0x62/0x80
[   80.609979]  [<c403a108>] ? __local_bh_enable_ip+0x58/0x90
[   80.609979]  [<c40376df>] warn_slowpath_null+0xf/0x20
[   80.609979]  [<c403a108>] __local_bh_enable_ip+0x58/0x90
[   80.609979]  [<c47f2b4a>] _raw_write_unlock_bh+0x2a/0x30
[   80.609979]  [<c471b72d>] unix_release_sock+0x6d/0x220
[   80.609979]  [<c4109d00>] ? mnt_get_count+0x50/0x50
[   80.609979]  [<c471b8f6>] unix_release+0x16/0x30
[   80.609979]  [<c466a2b4>] sock_release+0x14/0x70
[   80.609979]  [<c466a31b>] sock_close+0xb/0x10
[   80.609979]  [<c40f01b2>] __fput+0x82/0x1c0
[   80.609979]  [<c40f0328>] ____fput+0x8/0x10
[   80.609979]  [<c404d329>] task_work_run+0x99/0xb0
[   80.609979]  [<c40387ef>] do_exit+0x2ef/0x930
[   80.609979]  [<c407e6fa>] ? kmsg_dump+0xea/0x100
[   80.609979]  [<c4004fe0>] oops_end+0x80/0xb0
[   80.609979]  [<c402ec91>] no_context+0x101/0x220
[   80.609979]  [<c402ee3a>] __bad_area_nosemaphore+0x8a/0x130
[   80.609979]  [<c402f710>] ? vmalloc_sync_all+0x100/0x100
[   80.609979]  [<c402eeed>] bad_area_nosemaphore+0xd/0x10
[   80.609979]  [<c402f43c>] __do_page_fault+0x26c/0x440
[   80.609979]  [<c406e61a>] ? __lock_acquire.isra.24+0x2ea/0xc10
[   80.609979]  [<c402f710>] ? vmalloc_sync_all+0x100/0x100
[   80.609979]  [<c402f71b>] do_page_fault+0xb/0x10
[   80.609979]  [<c47f39d7>] error_code+0x67/0x6c
[   80.609979]  [<c4765254>] ? rfcomm_dlc_open+0x44/0x340
[   80.609979]  [<c47ef8b8>] ? mutex_lock_nested+0x28/0x2c0
[   80.609979]  [<c476a368>] rfcomm_dev_activate+0x28/0x40
[   80.609979]  [<c476a368>] ? rfcomm_dev_activate+0x28/0x40
[   80.609979]  [<c43175e8>] tty_port_open+0x68/0xb0
[   80.609979]  [<c476a0b1>] rfcomm_tty_open+0x41/0x190
[   80.609979]  [<c47f27bd>] ? _raw_spin_unlock+0x1d/0x20
[   80.609979]  [<c430fab9>] tty_open+0x149/0x5b0
[   80.609979]  [<c430fab9>] ? tty_open+0x149/0x5b0
[   80.609979]  [<c40f29b2>] chrdev_open+0x82/0x190
[   80.609979]  [<c40ecfa4>] do_dentry_open.isra.16+0x184/0x2c0
[   80.609979]  [<c40f2930>] ? cdev_put+0x20/0x20
[   80.609979]  [<c40ed186>] finish_open+0x16/0x30
[   80.609979]  [<c40faccf>] do_last.isra.53+0x5ef/0xc60
[   80.609979]  [<c40fb3d8>] path_openat+0x98/0x580
[   80.609979]  [<c40fc837>] do_filp_open+0x27/0x80
[   80.609979]  [<c41082e0>] ? __alloc_fd+0x80/0x100
[   80.609979]  [<c40ee1ff>] do_sys_open+0x10f/0x200
[   80.609979]  [<c40ee308>] SyS_open+0x18/0x20
[   80.609979]  [<c47f30de>] syscall_call+0x7/0x7
[   80.609979] ---[ end trace 82e6395426152cae ]---


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
