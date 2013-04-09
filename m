Return-Path: <cyrus@holtmann.org>
From: Feng Hong <hongfeng@marvell.com>
To: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, Feng Hong <hongfeng@marvell.com>
Subject: [PATCH] Bluetooth: Avoid dumplicate conn dev register
Date: Tue, 9 Apr 2013 14:43:46 +0800
Message-ID: <1365489826-30652-1-git-send-email-hongfeng@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Once hit dumplicate connection device register:

[  651.865509] WARNING: at lib/kobject.c:198
kobject_add_internal+0x1f4/0x264()
[  651.872894] kobject_add_internal failed for hci0:1 with -EEXIST,
don't try to register things with the same name in the same directory.
[  651.885650] Modules linked in: runcase_sysfs(O) sd8xxx(O) mlan(O)
bt8xxx(O) cidatattydev(O) gs_diag(O) diag(O) gs_modem(O) ccinetdev(O)
cci_datastub(O) citty(O) msocketk(O) smsmdtv seh(O) cploaddev(O) blcr(O)
blcr_imports(O) geu(O) galcore(O)
[  651.910125] [<c011991c>] (unwind_backtrace+0x0/0x11c) from
[<c0134d3c>] (warn_slowpath_common+0x4c/0x64)
[  651.920013] [<c0134d3c>] (warn_slowpath_common+0x4c/0x64) from
[<c0134dd4>] (warn_slowpath_fmt+0x2c/0x3c)
[  651.930053] [<c0134dd4>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c02d91e0>] (kobject_add_internal+0x1f4/0x264)
[  651.940246] [<c02d91e0>] (kobject_add_internal+0x1f4/0x264) from
[<c02d95f0>] (kobject_add+0x68/0x8c)
[  651.949890] [<c02d95f0>] (kobject_add+0x68/0x8c) from [<c03323c8>]
(device_add+0x104/0x5b8)
[  651.958831] [<c03323c8>] (device_add+0x104/0x5b8) from [<c0547484>]
(hci_conn_add_sysfs+0x4c/0x80)
[  651.968109] [<c0547484>] (hci_conn_add_sysfs+0x4c/0x80) from
[<c053996c>] (hci_event_packet+0x530/0x6428)
[  651.978149] [<c053996c>] (hci_event_packet+0x530/0x6428) from
[<c05342a8>] (hci_rx_work+0xd0/0x390)
[  651.987640] [<c05342a8>] (hci_rx_work+0xd0/0x390) from [<c014ce24>]
(process_one_work+0x280/0x488)
[  651.996978] [<c014ce24>] (process_one_work+0x280/0x488) from
[<c014d240>] (worker_thread+0x214/0x3b4)
[  652.006652] [<c014d240>] (worker_thread+0x214/0x3b4) from
[<c01511b4>] (kthread+0x80/0x8c)
[  652.015228] [<c01511b4>] (kthread+0x80/0x8c) from [<c0113ed8>]
(kernel_thread_exit+0x0/0x8)
[  652.023925] ---[ end trace 7d6ac73956376f0a ]---
[  652.035034] Bluetooth: Failed to register connection device

 dev->device_private struct will be freed in device_add, later on anyone
go through father/child list will meet panic like this:

[  668.902984] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[  668.903015] pgd = c0104000
[  668.903015] [00000004] *pgd=00000000
[  668.903045] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[  668.903106] Modules linked in: runcase_sysfs(O) sd8xxx(O) mlan(O)
bt8xxx(O) cidatattydev(O) gs_diag(O) diag(O) gs_modem(O) ccinetdev(O)
cci_datastub(O) citty(O) msocketk(O) smsmdtv seh(O
) cploaddev(O) blcr(O) blcr_imports(O) geu(O) galcore(O)
[  668.903228] CPU: 1    Tainted: G        W  O  (3.4.5+ #1)
[  668.903259] PC is at klist_release+0x30/0xe0
[  668.903289] LR is at warn_slowpath_null+0x18/0x1c
[  668.908081] [<c059d028>] (klist_release+0x30/0xe0) from [<c059d10c>]
(klist_dec_and_del+0x34/0x44)
[  668.908142] [<c059d10c>] (klist_dec_and_del+0x34/0x44) from
[<c059d148>] (klist_next+0x2c/0xd8)
[  668.908172] [<c059d148>] (klist_next+0x2c/0xd8) from [<c03317f4>]
(device_for_each_child+0x44/0x70)
[  668.908233] [<c03317f4>] (device_for_each_child+0x44/0x70) from
[<c033a5ec>] (__device_suspend+0x20/0x340)
[  668.908294] [<c033a5ec>] (__device_suspend+0x20/0x340) from
[<c033b1e8>] (dpm_suspend+0xa8/0x210)
[  668.908325] [<c033b1e8>] (dpm_suspend+0xa8/0x210) from [<c0168770>]
(suspend_devices_and_enter+0xd4/0x390)
[  668.908386] [<c0168770>] (suspend_devices_and_enter+0xd4/0x390) from
[<c0168b7c>] (pm_suspend+0x150/0x234)
[  668.908416] [<c0168b7c>] (pm_suspend+0x150/0x234) from [<c0168cf4>]
(try_to_suspend+0x64/0xa8)
[  668.908477] [<c0168cf4>] (try_to_suspend+0x64/0xa8) from [<c014ce24>]
(process_one_work+0x280/0x488)
[  668.908508] [<c014ce24>] (process_one_work+0x280/0x488) from
[<c014d240>] (worker_thread+0x214/0x3b4)
[  668.908569] [<c014d240>] (worker_thread+0x214/0x3b4) from
[<c01511b4>] (kthread+0x80/0x8c)
[  668.908630] [<c01511b4>] (kthread+0x80/0x8c) from [<c0113ed8>]
(kernel_thread_exit+0x0/0x8)

This patch is trying to add protection in this case.

Change-Id: I028d9bda88139bdaba475a5cebbf27acbcaf3a05
Signed-off-by: Feng Hong <hongfeng@marvell.com>
---
 net/bluetooth/hci_sysfs.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 23b4e24..5c23d13 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -116,6 +116,11 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
+	if (device_is_registered(&conn->dev)) {
+		BT_ERR("Duplicate register connection device");
+		return;
+	}
+
 	BT_DBG("conn %p", conn);
 
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
-- 
1.7.0.4
