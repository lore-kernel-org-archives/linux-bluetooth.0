Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/11] Bluetooth: Implement automatic setup procedure for local adapters
Date: Tue,  4 Jan 2011 12:08:42 +0200
Message-Id: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch implements automatic initialization of basic information
about newly registered Bluetooth adapters. E.g. the address and features
are always needed so it makes sense for the kernel to automatically
power on adapters and read this information. A new HCI_SETUP flag is
added to track this state.

In order to not consume unnecessary amounts of power if there isn't a
user space available that could switch the adapter back off, a timer is
added to do this automatically as long as no Bluetooth user space seems
to be present. A new HCI_AUTO_OFF flag is added that user space needs to
clear to avoid the automatic power off.

Additionally, the management interface index_added event is moved to the
end of the HCI_SETUP stage so a user space supporting the managment
inteface has all the necessary information available for fetching when
it gets notified of a new adapter. The HCI_DEV_REG event is kept in the
same place as before since existing HCI raw socket based user space
versions depend on seeing the kernels initialization sequence
(hci_init_req) to determine when the adapter is ready for use.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci.h      |    3 ++
 include/net/bluetooth/hci_core.h |    6 +++
 net/bluetooth/hci_core.c         |   64 ++++++++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c             |    8 +++++
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 29a7a8c..6469d67 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -76,6 +76,9 @@ enum {
 	HCI_INQUIRY,
 
 	HCI_RAW,
+
+	HCI_SETUP,
+	HCI_AUTO_OFF,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a29feb0..dfbb325 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -114,6 +114,10 @@ struct hci_dev {
 
 	struct workqueue_struct	*workqueue;
 
+	struct work_struct	power_on;
+	struct work_struct	power_off;
+	struct timer_list	off_timer;
+
 	struct tasklet_struct	cmd_task;
 	struct tasklet_struct	rx_task;
 	struct tasklet_struct	tx_task;
@@ -436,6 +440,8 @@ int hci_inquiry(void __user *arg);
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_blacklist_clear(struct hci_dev *hdev);
 
+void hci_del_off_timer(struct hci_dev *hdev);
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8b602d8..d5a315c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -50,6 +50,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#define AUTO_OFF_TIMEOUT 2000
+
 static void hci_cmd_task(unsigned long arg);
 static void hci_rx_task(unsigned long arg);
 static void hci_tx_task(unsigned long arg);
@@ -794,6 +796,7 @@ int hci_get_dev_list(void __user *arg)
 	list_for_each(p, &hci_dev_list) {
 		struct hci_dev *hdev;
 		hdev = list_entry(p, struct hci_dev, list);
+		hci_del_off_timer(hdev);
 		(dr + n)->dev_id  = hdev->id;
 		(dr + n)->dev_opt = hdev->flags;
 		if (++n >= dev_num)
@@ -823,6 +826,8 @@ int hci_get_dev_info(void __user *arg)
 	if (!hdev)
 		return -ENODEV;
 
+	hci_del_off_timer(hdev);
+
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
@@ -891,6 +896,51 @@ void hci_free_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_free_dev);
 
+static void hci_power_on(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, power_on);
+
+	BT_DBG("%s", hdev->name);
+
+	if (hci_dev_open(hdev->id) < 0)
+		return;
+
+	if (test_bit(HCI_AUTO_OFF, &hdev->flags))
+		mod_timer(&hdev->off_timer,
+				jiffies + msecs_to_jiffies(AUTO_OFF_TIMEOUT));
+
+	if (test_and_clear_bit(HCI_SETUP, &hdev->flags))
+		mgmt_index_added(hdev->id);
+}
+
+static void hci_power_off(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, power_off);
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_close(hdev->id);
+}
+
+static void hci_auto_off(unsigned long data)
+{
+	struct hci_dev *hdev = (struct hci_dev *) data;
+
+	BT_DBG("%s", hdev->name);
+
+	clear_bit(HCI_AUTO_OFF, &hdev->flags);
+
+	queue_work(hdev->workqueue, &hdev->power_off);
+}
+
+void hci_del_off_timer(struct hci_dev *hdev)
+{
+	BT_DBG("%s", hdev->name);
+
+	clear_bit(HCI_AUTO_OFF, &hdev->flags);
+	del_timer(&hdev->off_timer);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -948,6 +998,10 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->blacklist);
 
+	INIT_WORK(&hdev->power_on, hci_power_on);
+	INIT_WORK(&hdev->power_off, hci_power_off);
+	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
+
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
 	atomic_set(&hdev->promisc, 0);
@@ -969,7 +1023,10 @@ int hci_register_dev(struct hci_dev *hdev)
 		}
 	}
 
-	mgmt_index_added(hdev->id);
+	set_bit(HCI_AUTO_OFF, &hdev->flags);
+	set_bit(HCI_SETUP, &hdev->flags);
+	queue_work(hdev->workqueue, &hdev->power_on);
+
 	hci_notify(hdev, HCI_DEV_REG);
 
 	return id;
@@ -999,7 +1056,10 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	for (i = 0; i < NUM_REASSEMBLY; i++)
 		kfree_skb(hdev->reassembly[i]);
 
-	mgmt_index_removed(hdev->id);
+	if (!test_bit(HCI_INIT, &hdev->flags) &&
+					!test_bit(HCI_SETUP, &hdev->flags))
+		mgmt_index_removed(hdev->id);
+
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f827fd9..2a88b35 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -127,6 +127,12 @@ static int read_index_list(struct sock *sk)
 	i = 0;
 	list_for_each(p, &hci_dev_list) {
 		struct hci_dev *d = list_entry(p, struct hci_dev, list);
+
+		hci_del_off_timer(d);
+
+		if (test_bit(HCI_SETUP, &d->flags))
+			continue;
+
 		put_unaligned_le16(d->id, &rp->index[i++]);
 		BT_DBG("Added hci%u", d->id);
 	}
@@ -178,6 +184,8 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 		return cmd_status(sk, MGMT_OP_READ_INFO, ENODEV);
 	}
 
+	hci_del_off_timer(hdev);
+
 	hci_dev_lock_bh(hdev);
 
 	put_unaligned_le16(hdev->id, &rp->index);
-- 
1.7.2.3

