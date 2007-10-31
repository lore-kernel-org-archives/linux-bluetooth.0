Return-Path: <hidave.darkstar@gmail.com>
Date: Wed, 31 Oct 2007 10:30:17 +0800
From: Dave Young <hidave.darkstar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, bluez-devel@lists.sourceforge.net
Subject: [PATCH]bluetooth: hci_sysfs connection bus_id add support for diffrent hci device
Message-ID: <20071031023017.GA3896@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

For multi hci devices host, connection from/to same destination
bluetooth device, add_conn will failed due to sysfs duplicate name.

sysfs: duplicate filename 'acl0018C5B6B456' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
 [<c01c0120>] sysfs_add_one+0xa0/0xe0
 [<c01c0d7b>] sysfs_create_link+0x9b/0x140
 [<c01c1671>] create_files+0x31/0x60
 [<c02b537b>] bus_add_device+0x5b/0xf0
 [<c02b391c>] device_add+0x11c/0x350
 [<f8951410>] add_conn+0x0/0x90 [bluetooth]
 [<f895141f>] add_conn+0xf/0x90 [bluetooth]
 [<c013baee>] run_workqueue+0x5e/0x110
 [<c013bc4c>] worker_thread+0xac/0x100
 [<c0140000>] autoremove_wake_function+0x0/0x50
 [<c0140000>] autoremove_wake_function+0x0/0x50
 [<c013bba0>] worker_thread+0x0/0x100
 [<c013fa39>] kthread+0x59/0xa0
 [<c013f9e0>] kthread+0x0/0xa0
 [<c0104f83>] kernel_thread_helper+0x7/0x14
 =======================
add_conn: Failed to register connection device

Add prefix hdev->name to bus_id to fix this problem.

Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 

---
net/bluetooth/hci_sysfs.c |    3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff -upr linux/net/bluetooth/hci_sysfs.c linux.new/net/bluetooth/hci_sysfs.c
--- linux/net/bluetooth/hci_sysfs.c	2007-10-31 10:21:00.000000000 +0800
+++ linux.new/net/bluetooth/hci_sysfs.c	2007-10-31 10:21:55.000000000 +0800
@@ -302,7 +302,8 @@ void hci_conn_add_sysfs(struct hci_conn 
 	conn->dev.release = bt_release;
 
 	snprintf(conn->dev.bus_id, BUS_ID_SIZE,
-			"%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
+			"%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
+			hdev->name,
 			conn->type == ACL_LINK ? "acl" : "sco",
 			ba->b[5], ba->b[4], ba->b[3],
 			ba->b[2], ba->b[1], ba->b[0]);
