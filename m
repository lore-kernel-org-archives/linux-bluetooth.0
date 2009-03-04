Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 4 Mar 2009 11:53:11 +0800
Message-ID: <a172fe730903031953r60e50248n5188455d98424e5c@mail.gmail.com>
Subject: bluez kernel patch for 2.6.25
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
    Is there a patch for 2.6.25? And I can't find it in the website. I
migrate the 2.6.27 bluez driver/protocol to 2.6.25, and apply the
2.6.27-mh1 patch, but there's a error when connecting HSP. So, i want
to try it on 2.6.25. Thanks.

-------------------------------------------log
start-------------------------------------------------------------
[  134.440000] sysfs: duplicate filename 'hci0:1' can not be created
[  134.440000] ------------[ cut here ]------------
[  134.450000] WARNING: at fs/sysfs/dir.c:424 sysfs_add_one+0x44/0xd8()
[  134.450000] Modules linked in:
[  134.470000] [<c002b32c>] (dump_stack+0x0/0x14) from [<c003d5e0>]
(warn_on_slowpath+0x4c/0x60)
[  134.470000] [<c003d594>] (warn_on_slowpath+0x0/0x60) from
[<c00d7d98>] (sysfs_add_one+0x44/0xd8)
[  134.480000]  r6:c5c4de68 r5:c5dc15a8 r4:c5c4de68
[  134.500000] [<c00d7d54>] (sysfs_add_one+0x0/0xd8) from [<c00d830c>]
<3>h4_recv: Unknown HCI packet type 80
[  134.520000] (create_dir+0x58/0xac)
[  134.520000]  r6:c3cb44f0 r5:c5dc15a8 r4:c5c4de68
[  134.520000] [<c00d82b4>] (create_dir+0x0/0xac) from [<c00d83a4>]
(sysfs_create_dir+0x44/0x64)
[  134.530000]  r8:c02a56d0 r7:c3cb44f0<3>h4_recv: Unknown HCI packet type 07
[  134.540000] h4_recv: Unknown HCI packet type e5
[  134.540000] h4_recv: Unknown HCI packet type 3c
[  134.550000] h4_recv: Unknown HCI packet type 0d
[  134.550000] h4_recv: Unknown HCI packet type 00
[  134.560000] h4_recv: Unknown HCI packet type 00
[  134.560000] h4_recv: Unknown HCI packet type 69
[  134.570000] h4_recv: Unknown HCI packet type 2e
[  134.570000] h4_recv: Unknown HCI packet type 54
[  134.580000] h4_recv: Unknown HCI packet type 65
[  134.580000] h4_recv: Unknown HCI packet type 63
[  134.590000] h4_recv: Unknown HCI packet type 68
[  134.590000] h4_recv: Unknown HCI packet type 20
[  134.590000] h4_recv: Unknown HCI packet type 43
[  134.600000] h4_recv: Unknown HCI packet type 6c
[  134.600000] h4_recv: Unknown HCI packet type 69
[  134.610000] h4_recv: Unknown HCI packet type 70
[  134.610000] h4_recv: Unknown HCI packet type 20
[  134.620000] h4_recv: Unknown HCI packet type 52
[  134.620000] h4_recv: Unknown HCI packet type 61
[  134.630000] h4_recv: Unknown HCI packet type 64
[  134.630000]  r6:c5edf700 r5:c5edf700 r4:c3cb44f0
[  134.640000] [<c00d8360>] (sysfs_create_dir+0x0/0x64) from
[<c0175bfc>] (create_dir+0x24/0x4c)
[  134.640000]  r4:c3cb44f0
[  134.660000] [<c0175bd8>] (create_dir+0x0/0x4c) from [<c01760d4>]
(kobject_add_internal+0x88/0x100)
[  134.670000]  r5:c5edf700 r4:c3cb44f0
[  134.670000] [<c017604c>] (kobject_add_internal+0x0/0x100) from
[<c0176260>] (kobject_add_varg+0x48/0x5c)
[  134.680000]  r6:c5edf700 r5:00000000 r4:c3cb44f0
[  134.690000] [<c0176218>] (kobject_add_varg+0x0/0x5c) from
[<c01765b4>] (kobject_add+0x58/0x64)
[  134.700000]  r6:c5ca3720 r5:c5edf698 r4:c3cb4488
[  134.700000] [<c017655c>] (kobject_add+0x0/0x64) from [<c01a48a8>]
(device_add+0x54/0x280)
[  134.710000]  r3:c3cb4514 r2:c0360614
[  134.710000] [<c01a4854>] (device_add+0x0/0x280) from [<c02a56f8>]
(add_conn+0x28/0x4c)
[  134.720000]  r7:c3cb4478 r6:c5ca3720 r5:c5c4c000 r4:c3cb4478
[  134.730000] [<c02a56d0>] (add_conn+0x0/0x4c) from [<c004fa94>]
(run_workqueue+0xe4/0x1a4)
[  134.730000]  r4:c3cb447c
[  134.740000] [<c004f9b0>] (run_workqueue+0x0/0x1a4) from
[<c0050638>] (worker_thread+0xa8/0xbc)
[  134.750000] [<c0050590>] (worker_thread+0x0/0xbc) from [<c0053d84>]
(kthread+0x5c/0x94)
[  134.750000]  r7:00000000 r6:c0050590 r5:c5ca3720 r4:c5c4c000
[  134.760000] [<c0053d28>] (kthread+0x0/0x94) from [<c00417e0>]
(do_exit+0x0/0x2f4)
[  134.770000]  r6:00000000 r5:00000000 r4:00000000
[  134.770000] ---[ end trace f3f894b623f88e25 ]---
[  134.780000] kobject_add_internal failed for hci0:1 with -EEXIST,
don't try to register things with the same name in the same directory.
[  134.790000] [<c002b32c>] (dump_stack+0x0/0x14) from [<c0176134>]
(kobject_add_internal+0xe8/0x100)
[  134.800000] [<c017604c>] (kobject_add_internal+0x0/0x100) from
[<c0176260>] (kobject_add_varg+0x48/0x5c)
[  134.810000]  r6:c5edf700 r5:00000000 r4:c3cb44f0
[  134.810000] [<c0176218>] (kobject_add_varg+0x0/0x5c) from
[<c01765b4>] (kobject_add+0x58/0x64)
[  134.820000]  r6:c5ca3720 r5:c5edf698 r4:c3cb4488
[  134.830000] [<c017655c>] (kobject_add+0x0/0x64) from [<c01a48a8>]
(device_add+0x54/0x280)
[  134.830000]  r3:c3cb4514 r2:c0360614
[  134.840000] [<c01a4854>] (device_add+0x0/0x280) from [<c02a56f8>]
(add_conn+0x28/0x4c)
[  134.850000]  r7:c3cb4478 r6:c5ca3720 r5:c5c4c000 r4:c3cb4478
[  134.850000] [<c02a56d0>] (add_conn+0x0/0x4c) from [<c004fa94>]
(run_workqueue+0xe4/0x1a4)
[  134.870000]  r4:c3cb447c
[  134.870000] [<c004f9b0>] (run_workqueue+0x0/0x1a4) from
[<c0050638>] (worker_thread+0xa8/0xbc)
[  134.880000] [<c0050590>] (worker_thread+0x0/0xbc) from [<c0053d84>]
(kthread+0x5c/0x94)
[  134.890000]  r7:00000000 r6:c0050590 r5:c5ca3720 r4:c5c4c000
[  134.890000] [<c0053d28>] (kthread+0x0/0x94) from [<c00417e0>]
(do_exit+0x0/0x2f4)
[  134.900000]  r6:00000000 r5:00000000 r4:00000000
[  134.910000] add_conn: Failed to register connection device
-------------------------------------------log
end-------------------------------------------------------------
