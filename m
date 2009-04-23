Return-Path: <cyrus@holtmann.org>
Message-ID: <49F05193.7070609@nokia.com>
Date: Thu, 23 Apr 2009 14:31:31 +0300
From: Roger Quadros <ext-roger.quadros@nokia.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH] bluetooth: hci_sysfs: Ensure sysfs add/del is pre-empt
 safe
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Thu, 23 Apr 2009 14:05:19 +0300
Subject: [PATCH] bluetooth: hci_sysfs: Ensure sysfs add/del is pre-empt safe

Uses different work_struct variables for add_conn() and del_conn(). Uses
single work queue instead of two for adding and deleting connections.

It eliminates the following error on a pre-emptible kernel.

[  204.358032] Unable to handle kernel NULL pointer dereference at
virtual address 0000000c
[  204.370697] pgd = c0004000
[  204.373443] [0000000c] *pgd=00000000
[  204.378601] Internal error: Oops: 17 [#1] PREEMPT
[  204.383361] Modules linked in: vfat fat rfcomm sco l2cap sd_mod
scsi_mod iphb pvr2d drm omaplfb ps
[  204.438537] CPU: 0    Not tainted  (2.6.28-maemo2 #1)
[  204.443664] PC is at klist_put+0x2c/0xb4
[  204.447601] LR is at klist_put+0x18/0xb4
[  204.451568] pc : [<c0270f08>]    lr : [<c0270ef4>]    psr: a0000113
[  204.451568] sp : cf1b3f10  ip : cf1b3f10  fp : cf1b3f2c
[  204.463104] r10: 00000000  r9 : 00000000  r8 : bf08029c
[  204.468353] r7 : c7869200  r6 : cfbe2690  r5 : c78692c8  r4 :
00000001
[  204.474945] r3 : 00000001  r2 : cf1b2000  r1 : 00000001  r0 :
00000000
[  204.481506] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[  204.488861] Control: 10c5387d  Table: 887fc018  DAC: 00000017
[  204.494628] Process btdelconn (pid: 515, stack limit = 0xcf1b22e0)

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
  include/net/bluetooth/hci_core.h |    3 ++-
  net/bluetooth/hci_sysfs.c        |   37 ++++++++++++++++---------------------
  2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 30a5be8..988e8cb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -180,7 +180,8 @@ struct hci_conn {
  	struct timer_list disc_timer;
  	struct timer_list idle_timer;

-	struct work_struct work;
+	struct work_struct work_add;
+	struct work_struct work_del;

  	struct device	dev;

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 1a1f916..8cddc1c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -9,8 +9,7 @@
  struct class *bt_class = NULL;
  EXPORT_SYMBOL_GPL(bt_class);

-static struct workqueue_struct *btaddconn;
-static struct workqueue_struct *btdelconn;
+static struct workqueue_struct *btworkq;

  static inline char *link_typetostr(int type)
  {
@@ -88,9 +87,10 @@ static struct device_type bt_link = {

  static void add_conn(struct work_struct *work)
  {
-	struct hci_conn *conn = container_of(work, struct hci_conn, work);
+	struct hci_conn *conn = container_of(work, struct hci_conn, work_add);

-	flush_workqueue(btdelconn);
+	/* ensure previous add/del is complete */
+	flush_workqueue(btworkq);

  	if (device_add(&conn->dev) < 0) {
  		BT_ERR("Failed to register connection device");
@@ -114,9 +114,9 @@ void hci_conn_add_sysfs(struct hci_conn *conn)

  	device_initialize(&conn->dev);

-	INIT_WORK(&conn->work, add_conn);
+	INIT_WORK(&conn->work_add, add_conn);

-	queue_work(btaddconn, &conn->work);
+	queue_work(btworkq, &conn->work_add);
  }

  /*
@@ -131,9 +131,12 @@ static int __match_tty(struct device *dev, void *data)

  static void del_conn(struct work_struct *work)
  {
-	struct hci_conn *conn = container_of(work, struct hci_conn, work);
+	struct hci_conn *conn = container_of(work, struct hci_conn, work_del);
  	struct hci_dev *hdev = conn->hdev;

+	/* ensure previous add/del is complete */
+	flush_workqueue(btworkq);
+
  	while (1) {
  		struct device *dev;

@@ -156,9 +159,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
  	if (!device_is_registered(&conn->dev))
  		return;

-	INIT_WORK(&conn->work, del_conn);
+	INIT_WORK(&conn->work_del, del_conn);

-	queue_work(btdelconn, &conn->work);
+	queue_work(btworkq, &conn->work_del);
  }

  static inline char *host_typetostr(int type)
@@ -435,20 +438,13 @@ void hci_unregister_sysfs(struct hci_dev *hdev)

  int __init bt_sysfs_init(void)
  {
-	btaddconn = create_singlethread_workqueue("btaddconn");
-	if (!btaddconn)
-		return -ENOMEM;
-
-	btdelconn = create_singlethread_workqueue("btdelconn");
-	if (!btdelconn) {
-		destroy_workqueue(btaddconn);
+	btworkq = create_singlethread_workqueue("btworkq");
+	if (!btworkq)
  		return -ENOMEM;
-	}

  	bt_class = class_create(THIS_MODULE, "bluetooth");
  	if (IS_ERR(bt_class)) {
-		destroy_workqueue(btdelconn);
-		destroy_workqueue(btaddconn);
+		destroy_workqueue(btworkq);
  		return PTR_ERR(bt_class);
  	}

@@ -457,8 +453,7 @@ int __init bt_sysfs_init(void)

  void bt_sysfs_cleanup(void)
  {
-	destroy_workqueue(btaddconn);
-	destroy_workqueue(btdelconn);
+	destroy_workqueue(btworkq);

  	class_destroy(bt_class);
  }
-- 
1.5.6.3
