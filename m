Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Dec 2007 18:03:21 +0800
From: Dave Young <hidave.darkstar@gmail.com>
To: akpm@linux-foundation.org
Cc: greg@kroah.com, marcel@holtmann.org, linux-kernel@vger.kernel.org,
	bluez-devel@lists.sourceforge.net
Subject: [BUG][PATCH -mm] bluetooth : rfcomm add get/put device in del_conn
Message-ID: <20071225100321.GA2791@darkstar.te-china.tietoenator.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Due to 2.6.24-rc6-mm1 kernel changes (maybe kobject or driver core), If I exec:

rfcomm connect 0 1

kernel will oops after connect timeout.

hand copy some oops text:

EIP is at driver_sysfs_remove+0x1a/0x40
Call Trace:
 show_trace_log_lvl+0x1a/0x30
 show_stack_log_lvl+0x9a/0xc0
 show_registers+0xc7/0x270
 die+0x129/0x240
 do_page_fault+0x3a1/0x670
 error_code+0x72/0x78
 __device_release_driver+0x1e/0xa0
 device_release_driver+0x30/0x50
 bus_remove_device+0x63/0x90
 device_del+0x55/0x190
 del_conn+0xb/0x10 [bluetooth]
 run_workqueue+0xe1/0x210
 worker_thread+0x99/0xf0
 kthread+0x5c/0xa0
 kernel_thread_helper+0x7/0x18

(The remote bluetooth device is a mobile phone which is power off)

The reason is that in bus_remobe_dev, the klist_del function will release the device, so just add a get/put pair around the device_del in del_conn.

Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 

---
net/bluetooth/hci_sysfs.c |    2 ++
1 file changed, 2 insertions(+)

diff -upr linux/net/bluetooth/hci_sysfs.c linux.new/net/bluetooth/hci_sysfs.c
--- linux/net/bluetooth/hci_sysfs.c	2007-12-25 17:45:09.000000000 +0800
+++ linux.new/net/bluetooth/hci_sysfs.c	2007-12-25 17:45:51.000000000 +0800
@@ -319,7 +319,9 @@ void hci_conn_add_sysfs(struct hci_conn 
 static void del_conn(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn, work);
+	get_device(&conn->dev);
 	device_del(&conn->dev);
+	put_device(&conn->dev);
 }
 
 void hci_conn_del_sysfs(struct hci_conn *conn)
