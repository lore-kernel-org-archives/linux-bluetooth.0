Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474C3545.3040203@pracucci.com>
Date: Tue, 27 Nov 2007 16:18:29 +0100
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4746EC10.5080509@pracucci.com> <1196058095.4217.79.camel@aeonflux>
In-Reply-To: <1196058095.4217.79.camel@aeonflux>
Content-Type: multipart/mixed; boundary="------------030700000701070604080404"
Subject: Re: [Bluez-devel] 2.6.23.8: kernel panic
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030700000701070604080404
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Marcel,
>> I have compiled linux kernel 2.6.23.8 for a single board computer based
>> on ARM architecture (EP9302 processor). I have tried to stress the
>> Bluetooth subsystem, creating repeatly a lot of RFCOMM connections to
>> other Bluetooth dongles (installed on remote computers) and I'm able to
>> get a kernel panic in few minutes.
>>     
> it would be good to know if 2.6.24-rc3 shows the same issue
I have done some tests with 2.6.24-rc3 and I get the same kernel panic.
I report again some information.

Internal error: Oops: 3 [#1]
Modules linked in:
CPU: 0 Not tainted (2.6.24-rc3 #1)
PC is at hci_get_route+0x50/0x110
LR is at 0x6
pc : [<c020986c>] lr : [<00000006>] psr: 20000013
sp : c1049e70 ip : c07c681b fp : c1049e94
r10: 00000150 r9 : 00000002 r8 : c001efe4
r7 : c0520d3e r6 : 00000067 r5 : c0520d38 r4 : e0021985
r3 : c02f5d98 r2 : 0000002a r1 : c0520d38 r0 : ffffffc3
Flags: nzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment user
Control: 4000717f Table: 01110000 DAC: 00000015
Process test (pid: 1459, stack limit = 0xc1048258)
Stack: (0xc1049e70 to 0xc104a000)
9e60: 00009ecc 00000000 c0520d3e 00000001
9e80: c0520c00 c0520d38 c1049ec8 c1049e98 c020fe98 c020982c c1049ecc
c001efe4
9ea0: 7e3ff9c4 c1103e40 0000000c c1049ecc c001efe4 c1048000 2aae7c38
c1049f70
9ec0: c1049ecc c019dc50 c020fdd0 0001001f 0d4e1d9f 0003000b c1049f08
c11344d0
9ee0: c1134478 c1103e7c c1049f08 c1049ef8 c0090d84 c00a9124 c1134478
c1049f3c
9f00: c1049f0c c019e22c c007fe9c c0240d60 00000000 00000000 c02896f8
00000008
9f20: 00000008 0003ecc4 00000066 c001efe4 c1049f58 c1049f40 c019e5b4
c007de9c
9f40: c1132b40 00000001 0003ecc0 00000001 00000000 00000003 0003ecc0
0003ecc4
9f60: 00000066 c1049fa4 c1049f74 c019f038 c019dbe8 c1048000 c1049fb0
00000008
9f80: 7e3ff9c4 0000000c c002188c c00214b0 2ab87e00 00040dc8 00000000
c1049fa8
9fa0: c001ee40 c019ef48 00040dc8 0003ecc0 00000003 7e3ff998 00000000
00000001
9fc0: 00040dc8 0003ecc0 0003ecc4 0002c470 00000001 7e3ffaec 2aae7c38
7e3ff9f4
9fe0: 00000000 7e3ff994 2ab7ed60 2ab7ed70 60000010 00000003 00000000
00000000
Backtrace: invalid frame pointer 0xc1049e94
Code: ebf8d233 e59f30c0 e5934000 ea000016 (e5943014)
Kernel panic - not syncing: Fatal exception in interrupt


I have also attached a system log.

Marco Pracucci



--------------030700000701070604080404
Content-Type: text/plain;
 name="system"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="system"

Jan  1 00:09:06   user.warn kernel: WARNING: at lib/kref.c:33 kref_get()
Jan  1 00:09:06   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c01238c8>] (kref_get+0x34/0x60)
Jan  1 00:09:06   user.warn kernel: [<c0123894>] (kref_get+0x0/0x60) from [<c01229f4>] (kobject_get+0x18/0x20)
Jan  1 00:09:06   user.warn kernel:  r4:c10f5cf0
Jan  1 00:09:06   user.warn kernel: [<c01229dc>] (kobject_get+0x0/0x20) from [<c0140fb8>] (get_device+0x1c/0x28)
Jan  1 00:09:06   user.warn kernel:  r4:c0401a00
Jan  1 00:09:06   user.warn kernel: [<c0140f9c>] (get_device+0x0/0x28) from [<c0141ccc>] (device_add+0x14/0x558)
Jan  1 00:09:06   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:06   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:06   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:06   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:06   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:06   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:06   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:06   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:06   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:11   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09EC' can not be created
Jan  1 00:09:11   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:09:11   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:09:11   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:09:11   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780d74
Jan  1 00:09:11   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:09:11   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c1161c88 r4:c1161cf0
Jan  1 00:09:11   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:09:11   user.warn kernel:  r4:c1161cf0
Jan  1 00:09:11   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:11   user.warn kernel:  r8:c1161cf0 r7:00000000 r6:c020d624 r5:c1161c88 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:11   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:11   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:11   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:11   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:11   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:11   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:11   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:11   user.err kernel: kobject_add failed for acl000B0D4E09EC with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:09:11   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:09:11   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:11   user.warn kernel:  r8:c1161cf0 r7:00000000 r6:c020d624 r5:c1161c88 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:11   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:11   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:11   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:11   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:11   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:11   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:11   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:11   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:09:11   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09DB' can not be created
Jan  1 00:09:11   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:09:11   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:09:11   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:09:11   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780d74
Jan  1 00:09:11   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:09:11   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c04f4688 r4:c04f46f0
Jan  1 00:09:11   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:09:11   user.warn kernel:  r4:c04f46f0
Jan  1 00:09:11   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:11   user.warn kernel:  r8:c04f46f0 r7:00000000 r6:c020d624 r5:c04f4688 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:11   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:11   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:11   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:11   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:11   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:11   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:11   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:11   user.err kernel: kobject_add failed for acl000B0D4E09DB with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:09:11   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:09:11   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:11   user.warn kernel:  r8:c04f46f0 r7:00000000 r6:c020d624 r5:c04f4688 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:11   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:11   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:11   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:11   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:11   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:11   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:11   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:11   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:11   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:09:27   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09EC' can not be created
Jan  1 00:09:27   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:09:27   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:09:27   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:09:27   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780ed4
Jan  1 00:09:27   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:09:27   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c10f5e88 r4:c10f5ef0
Jan  1 00:09:27   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:09:27   user.warn kernel:  r4:c10f5ef0
Jan  1 00:09:27   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:27   user.warn kernel:  r8:c10f5ef0 r7:00000000 r6:c020d624 r5:c10f5e88 r4:c0401a00
Jan  1 00:09:27   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:27   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:27   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:27   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:27   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:27   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:27   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:27   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:27   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:27   user.err kernel: kobject_add failed for acl000B0D4E09EC with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:09:27   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:09:27   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:27   user.warn kernel:  r8:c10f5ef0 r7:00000000 r6:c020d624 r5:c10f5e88 r4:c0401a00
Jan  1 00:09:27   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:27   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:27   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:27   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:27   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:27   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:27   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:27   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:27   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:27   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:09:29   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09DB' can not be created
Jan  1 00:09:29   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:09:29   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:09:29   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:09:29   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780f2c
Jan  1 00:09:29   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:09:29   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c04f4a88 r4:c04f4af0
Jan  1 00:09:29   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:09:29   user.warn kernel:  r4:c04f4af0
Jan  1 00:09:29   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:29   user.warn kernel:  r8:c04f4af0 r7:00000000 r6:c020d624 r5:c04f4a88 r4:c0401a00
Jan  1 00:09:29   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:29   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:29   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:29   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:29   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:29   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:29   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:29   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:29   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:29   user.err kernel: kobject_add failed for acl000B0D4E09DB with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:09:29   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:09:29   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:29   user.warn kernel:  r8:c04f4af0 r7:00000000 r6:c020d624 r5:c04f4a88 r4:c0401a00
Jan  1 00:09:29   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:29   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:29   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:29   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:29   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:29   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:29   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:29   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:29   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:29   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:09:46   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09EC' can not be created
Jan  1 00:09:46   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:09:46   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:09:46   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:09:46   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780c98
Jan  1 00:09:46   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:09:46   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c04f4488 r4:c04f44f0
Jan  1 00:09:46   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:09:46   user.warn kernel:  r4:c04f44f0
Jan  1 00:09:46   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:46   user.warn kernel:  r8:c04f44f0 r7:00000000 r6:c020d624 r5:c04f4488 r4:c0401a00
Jan  1 00:09:46   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:46   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:46   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:46   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:46   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:46   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:46   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:46   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:46   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:46   user.err kernel: kobject_add failed for acl000B0D4E09EC with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:09:46   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:09:46   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:46   user.warn kernel:  r8:c04f44f0 r7:00000000 r6:c020d624 r5:c04f4488 r4:c0401a00
Jan  1 00:09:46   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:46   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:46   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:46   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:46   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:46   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:46   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:46   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:46   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:46   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:09:48   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09DB' can not be created
Jan  1 00:09:48   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:09:48   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:09:48   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:09:48   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780a5c
Jan  1 00:09:48   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:09:48   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c10f5288 r4:c10f52f0
Jan  1 00:09:48   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:09:48   user.warn kernel:  r4:c10f52f0
Jan  1 00:09:48   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:48   user.warn kernel:  r8:c10f52f0 r7:00000000 r6:c020d624 r5:c10f5288 r4:c0401a00
Jan  1 00:09:48   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:48   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:48   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:48   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:48   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:48   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:48   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:48   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:48   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:48   user.err kernel: kobject_add failed for acl000B0D4E09DB with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:09:48   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:09:48   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:48   user.warn kernel:  r8:c10f52f0 r7:00000000 r6:c020d624 r5:c10f5288 r4:c0401a00
Jan  1 00:09:48   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:48   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:48   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:48   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:48   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:48   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:48   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:48   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:48   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:48   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:09:52   user.warn kernel: sysfs: duplicate filename 'acl000B0D4D5893' can not be created
Jan  1 00:09:52   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:09:52   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:09:52   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:09:52   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c17808a4
Jan  1 00:09:52   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:09:52   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c04f4488 r4:c04f44f0
Jan  1 00:09:52   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:09:52   user.warn kernel:  r4:c04f44f0
Jan  1 00:09:52   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:52   user.warn kernel:  r8:c04f44f0 r7:00000000 r6:c020d624 r5:c04f4488 r4:c0401a00
Jan  1 00:09:52   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:52   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:52   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:52   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:52   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:52   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:52   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:52   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:52   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:52   user.err kernel: kobject_add failed for acl000B0D4D5893 with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:09:52   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:09:52   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:09:52   user.warn kernel:  r8:c04f44f0 r7:00000000 r6:c020d624 r5:c04f4488 r4:c0401a00
Jan  1 00:09:52   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:09:52   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:09:52   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:09:52   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:09:52   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:09:52   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:09:52   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:09:52   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:09:52   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:09:52   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:10   user.warn kernel: sysfs: duplicate filename 'acl000B0D4D5893' can not be created
Jan  1 00:10:10   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:10   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:10   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:10   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c17808a4
Jan  1 00:10:10   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:10   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c05ace88 r4:c05acef0
Jan  1 00:10:10   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:10   user.warn kernel:  r4:c05acef0
Jan  1 00:10:10   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:10   user.warn kernel:  r8:c05acef0 r7:00000000 r6:c020d624 r5:c05ace88 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:10   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:10   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:10   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:10   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:10   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:10   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:10   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:10   user.err kernel: kobject_add failed for acl000B0D4D5893 with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:10   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:10   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:10   user.warn kernel:  r8:c05acef0 r7:00000000 r6:c020d624 r5:c05ace88 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:10   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:10   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:10   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:10   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:10   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:10   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:10   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:10   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:10   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09EC' can not be created
Jan  1 00:10:10   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:10   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:10   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:10   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780a5c
Jan  1 00:10:10   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:10   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c1161c88 r4:c1161cf0
Jan  1 00:10:10   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:10   user.warn kernel:  r4:c1161cf0
Jan  1 00:10:10   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:10   user.warn kernel:  r8:c1161cf0 r7:00000000 r6:c020d624 r5:c1161c88 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:10   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:10   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:10   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:10   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:10   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:10   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:10   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:10   user.err kernel: kobject_add failed for acl000B0D4E09EC with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:10   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:10   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:10   user.warn kernel:  r8:c1161cf0 r7:00000000 r6:c020d624 r5:c1161c88 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:10   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:10   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:10   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:10   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:10   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:10   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:10   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:10   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:10   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:11   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09DB' can not be created
Jan  1 00:10:11   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:11   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:11   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:11   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780c14
Jan  1 00:10:11   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:11   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c10f5c88 r4:c10f5cf0
Jan  1 00:10:11   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:11   user.warn kernel:  r4:c10f5cf0
Jan  1 00:10:11   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:11   user.warn kernel:  r8:c10f5cf0 r7:00000000 r6:c020d624 r5:c10f5c88 r4:c0401a00
Jan  1 00:10:11   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:11   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:11   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:11   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:11   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:11   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:11   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:11   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:11   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:11   user.err kernel: kobject_add failed for acl000B0D4E09DB with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:11   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:11   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:11   user.warn kernel:  r8:c10f5cf0 r7:00000000 r6:c020d624 r5:c10f5c88 r4:c0401a00
Jan  1 00:10:11   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:11   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:11   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:11   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:11   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:11   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:11   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:11   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:11   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:11   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:21   user.warn kernel: sysfs: duplicate filename 'acl000B0D4D5893' can not be created
Jan  1 00:10:21   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:21   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:21   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:21   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c17803a8
Jan  1 00:10:21   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:21   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c1161c88 r4:c1161cf0
Jan  1 00:10:21   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:21   user.warn kernel:  r4:c1161cf0
Jan  1 00:10:21   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:21   user.warn kernel:  r8:c1161cf0 r7:00000000 r6:c020d624 r5:c1161c88 r4:c0401a00
Jan  1 00:10:21   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:21   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:21   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:21   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:21   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:21   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:21   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:21   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:21   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:21   user.err kernel: kobject_add failed for acl000B0D4D5893 with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:21   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:21   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:21   user.warn kernel:  r8:c1161cf0 r7:00000000 r6:c020d624 r5:c1161c88 r4:c0401a00
Jan  1 00:10:21   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:21   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:21   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:21   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:21   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:21   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:21   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:21   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:21   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:21   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:22   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09EC' can not be created
Jan  1 00:10:22   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:22   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:22   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:22   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780324
Jan  1 00:10:22   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:22   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c05ac888 r4:c05ac8f0
Jan  1 00:10:22   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:22   user.warn kernel:  r4:c05ac8f0
Jan  1 00:10:22   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:22   user.warn kernel:  r8:c05ac8f0 r7:00000000 r6:c020d624 r5:c05ac888 r4:c0401a00
Jan  1 00:10:22   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:22   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:22   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:22   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:22   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:22   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:22   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:22   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:22   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:22   user.err kernel: kobject_add failed for acl000B0D4E09EC with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:22   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:22   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:22   user.warn kernel:  r8:c05ac8f0 r7:00000000 r6:c020d624 r5:c05ac888 r4:c0401a00
Jan  1 00:10:22   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:22   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:22   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:22   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:22   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:22   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:22   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:22   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:22   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:22   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:24   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09DB' can not be created
Jan  1 00:10:24   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:24   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:24   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:24   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c17808a4
Jan  1 00:10:24   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:24   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c1161088 r4:c11610f0
Jan  1 00:10:24   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:24   user.warn kernel:  r4:c11610f0
Jan  1 00:10:24   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:24   user.warn kernel:  r8:c11610f0 r7:00000000 r6:c020d624 r5:c1161088 r4:c0401a00
Jan  1 00:10:24   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:24   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:24   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:24   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:24   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:24   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:24   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:24   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:24   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:24   user.err kernel: kobject_add failed for acl000B0D4E09DB with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:24   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:24   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:24   user.warn kernel:  r8:c11610f0 r7:00000000 r6:c020d624 r5:c1161088 r4:c0401a00
Jan  1 00:10:24   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:24   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:24   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:24   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:24   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:24   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:24   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:24   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:24   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:24   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:29   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E1735' can not be created
Jan  1 00:10:29   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:29   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:29   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:29   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780248
Jan  1 00:10:29   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:29   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c04f4488 r4:c04f44f0
Jan  1 00:10:29   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:29   user.warn kernel:  r4:c04f44f0
Jan  1 00:10:29   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:29   user.warn kernel:  r8:c04f44f0 r7:00000000 r6:c020d624 r5:c04f4488 r4:c0401a00
Jan  1 00:10:29   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:29   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:29   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:29   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:29   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:29   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:29   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:29   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:29   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:29   user.err kernel: kobject_add failed for acl000B0D4E1735 with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:29   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:29   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:29   user.warn kernel:  r8:c04f44f0 r7:00000000 r6:c020d624 r5:c04f4488 r4:c0401a00
Jan  1 00:10:29   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:29   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:29   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:29   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:29   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:29   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:29   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:29   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:29   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:29   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:30   user.warn kernel: sysfs: duplicate filename 'acl000B0D4D5893' can not be created
Jan  1 00:10:30   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:30   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:30   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:30   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780248
Jan  1 00:10:30   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:30   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c10f5488 r4:c10f54f0
Jan  1 00:10:30   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:30   user.warn kernel:  r4:c10f54f0
Jan  1 00:10:30   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:30   user.warn kernel:  r8:c10f54f0 r7:00000000 r6:c020d624 r5:c10f5488 r4:c0401a00
Jan  1 00:10:30   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:30   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:30   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:30   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:30   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:30   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:30   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:30   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:30   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:30   user.err kernel: kobject_add failed for acl000B0D4D5893 with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:30   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:30   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:30   user.warn kernel:  r8:c10f54f0 r7:00000000 r6:c020d624 r5:c10f5488 r4:c0401a00
Jan  1 00:10:30   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:30   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:30   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:30   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:30   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:30   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:30   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:30   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:30   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:30   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:30   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09EC' can not be created
Jan  1 00:10:30   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:30   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:30   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:30   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780248
Jan  1 00:10:30   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:30   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c1161088 r4:c11610f0
Jan  1 00:10:30   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:30   user.warn kernel:  r4:c11610f0
Jan  1 00:10:30   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:30   user.warn kernel:  r8:c11610f0 r7:00000000 r6:c020d624 r5:c1161088 r4:c0401a00
Jan  1 00:10:30   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:30   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:30   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:30   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:30   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:30   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:30   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:30   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:30   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:30   user.err kernel: kobject_add failed for acl000B0D4E09EC with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:30   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:30   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:30   user.warn kernel:  r8:c11610f0 r7:00000000 r6:c020d624 r5:c1161088 r4:c0401a00
Jan  1 00:10:30   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:31   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:31   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:31   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:31   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:31   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:31   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:31   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:31   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:31   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:32   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E09DB' can not be created
Jan  1 00:10:32   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:32   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:32   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:32   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780b0c
Jan  1 00:10:32   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:32   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c0520a88 r4:c0520af0
Jan  1 00:10:32   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:32   user.warn kernel:  r4:c0520af0
Jan  1 00:10:32   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:32   user.warn kernel:  r8:c0520af0 r7:00000000 r6:c020d624 r5:c0520a88 r4:c0401a00
Jan  1 00:10:32   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:32   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:32   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:32   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:32   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:32   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:32   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:32   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:32   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:32   user.err kernel: kobject_add failed for acl000B0D4E09DB with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:32   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:32   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:32   user.warn kernel:  r8:c0520af0 r7:00000000 r6:c020d624 r5:c0520a88 r4:c0401a00
Jan  1 00:10:32   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:32   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:32   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:32   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:32   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:32   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:32   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:32   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:32   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:32   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:33   user.warn kernel: sysfs: duplicate filename 'acl000B0D4D8D25' can not be created
Jan  1 00:10:33   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:33   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:33   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:33   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780b0c
Jan  1 00:10:33   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:33   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c0520288 r4:c05202f0
Jan  1 00:10:33   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:33   user.warn kernel:  r4:c05202f0
Jan  1 00:10:33   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:33   user.warn kernel:  r8:c05202f0 r7:00000000 r6:c020d624 r5:c0520288 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:33   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:33   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:33   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:33   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:33   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:33   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:33   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:33   user.err kernel: kobject_add failed for acl000B0D4D8D25 with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:33   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:33   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:33   user.warn kernel:  r8:c05202f0 r7:00000000 r6:c020d624 r5:c0520288 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:33   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:33   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:33   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:33   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:33   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:33   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:33   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:33   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:33   user.warn kernel: sysfs: duplicate filename 'acl000B0D4E1706' can not be created
Jan  1 00:10:33   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:33   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:33   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:33   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780c14
Jan  1 00:10:33   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:33   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c1161488 r4:c11614f0
Jan  1 00:10:33   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:33   user.warn kernel:  r4:c11614f0
Jan  1 00:10:33   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:33   user.warn kernel:  r8:c11614f0 r7:00000000 r6:c020d624 r5:c1161488 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:33   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:33   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:33   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:33   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:33   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:33   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:33   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:33   user.err kernel: kobject_add failed for acl000B0D4E1706 with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:33   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:33   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:33   user.warn kernel:  r8:c11614f0 r7:00000000 r6:c020d624 r5:c1161488 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:33   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:33   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:33   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:33   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:33   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:33   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:33   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:33   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:33   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:34   user.warn kernel: sysfs: duplicate filename 'acl0007808103EA' can not be created
Jan  1 00:10:34   user.warn kernel: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Jan  1 00:10:34   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c00ba104>] (sysfs_add_one+0x4c/0xf8)
Jan  1 00:10:34   user.warn kernel: [<c00ba0b8>] (sysfs_add_one+0x0/0xf8) from [<c00ba670>] (create_dir+0x58/0xa8)
Jan  1 00:10:34   user.warn kernel:  r6:fffffff4 r5:c0583ed4 r4:c1780c6c
Jan  1 00:10:34   user.warn kernel: [<c00ba618>] (create_dir+0x0/0xa8) from [<c00ba6f8>] (sysfs_create_dir+0x38/0x4c)
Jan  1 00:10:34   user.warn kernel:  r8:c07c6afc r7:00000000 r6:c020d624 r5:c10f5e88 r4:c10f5ef0
Jan  1 00:10:34   user.warn kernel: [<c00ba6c0>] (sysfs_create_dir+0x0/0x4c) from [<c0122d50>] (kobject_add+0xc8/0x1a4)
Jan  1 00:10:34   user.warn kernel:  r4:c10f5ef0
Jan  1 00:10:34   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:34   user.warn kernel:  r8:c10f5ef0 r7:00000000 r6:c020d624 r5:c10f5e88 r4:c0401a00
Jan  1 00:10:34   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:34   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:34   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:34   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:34   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:34   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:34   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:34   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:34   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:34   user.err kernel: kobject_add failed for acl0007808103EA with -EEXIST, don't try to register things with the same name in the same directory.
Jan  1 00:10:34   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c0122ddc>] (kobject_add+0x154/0x1a4)
Jan  1 00:10:34   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:34   user.warn kernel:  r8:c10f5ef0 r7:00000000 r6:c020d624 r5:c10f5e88 r4:c0401a00
Jan  1 00:10:34   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:34   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:34   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:34   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:34   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:34   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:34   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:34   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:34   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000
Jan  1 00:10:34   user.err kernel: add_conn: Failed to register connection device
Jan  1 00:10:38   user.warn kernel: WARNING: at lib/kref.c:33 kref_get()
Jan  1 00:10:38   user.warn kernel: [<c0022a88>] (dump_stack+0x0/0x14) from [<c01238c8>] (kref_get+0x34/0x60)
Jan  1 00:10:38   user.warn kernel: [<c0123894>] (kref_get+0x0/0x60) from [<c01229f4>] (kobject_get+0x18/0x20)
Jan  1 00:10:38   user.warn kernel:  r4:c07c6afc
Jan  1 00:10:38   user.warn kernel: [<c01229dc>] (kobject_get+0x0/0x20) from [<c0122cf4>] (kobject_add+0x6c/0x1a4)
Jan  1 00:10:38   user.warn kernel:  r4:c10f52f0
Jan  1 00:10:38   user.warn kernel: [<c0122c88>] (kobject_add+0x0/0x1a4) from [<c0141d3c>] (device_add+0x84/0x558)
Jan  1 00:10:38   user.warn kernel:  r8:c10f52f0 r7:00000000 r6:c020d624 r5:c10f5288 r4:c0401a00
Jan  1 00:10:38   user.warn kernel: [<c0141cb8>] (device_add+0x0/0x558) from [<c020d63c>] (add_conn+0x18/0x70)
Jan  1 00:10:38   user.warn kernel: [<c020d624>] (add_conn+0x0/0x70) from [<c0048634>] (run_workqueue+0xb4/0x144)
Jan  1 00:10:38   user.warn kernel:  r5:c0582000 r4:c0401a00
Jan  1 00:10:38   user.warn kernel: [<c0048580>] (run_workqueue+0x0/0x144) from [<c0048888>] (worker_thread+0xa4/0xb8)
Jan  1 00:10:38   user.warn kernel:  r6:c00487e4 r5:c0401a00 r4:c0401a08
Jan  1 00:10:38   user.warn kernel: [<c00487e4>] (worker_thread+0x0/0xb8) from [<c004c598>] (kthread+0x5c/0x90)
Jan  1 00:10:38   user.warn kernel:  r5:c0401a00 r4:c0582000
Jan  1 00:10:38   user.warn kernel: [<c004c53c>] (kthread+0x0/0x90) from [<c003b348>] (do_exit+0x0/0x690)
Jan  1 00:10:38   user.warn kernel:  r6:00000000 r5:00000000 r4:00000000

--------------030700000701070604080404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------030700000701070604080404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030700000701070604080404--
