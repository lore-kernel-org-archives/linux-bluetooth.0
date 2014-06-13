Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 4/4] Bluetooth: 6LoWPAN: Remove network devices when unloading
Date: Fri, 13 Jun 2014 15:53:33 +0300
Message-Id: <1402664013-29358-5-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1402664013-29358-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1402664013-29358-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the module is unloaded, unregister the network device
so that the system does not try to access non-existing device.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index dd72ad2..5c9bc63 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -606,6 +606,17 @@ static void ifup(struct net_device *netdev)
 	rtnl_unlock();
 }
 
+static void ifdown(struct net_device *netdev)
+{
+	int err;
+
+	rtnl_lock();
+	err = dev_close(netdev);
+	if (err < 0)
+		BT_INFO("iface %s cannot be closed (%d)", netdev->name, err);
+	rtnl_unlock();
+}
+
 static void do_notify_peers(struct work_struct *work)
 {
 	struct lowpan_dev *dev = container_of(work, struct lowpan_dev,
@@ -819,6 +830,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 
 		cancel_delayed_work_sync(&dev->notify_peers);
 
+		ifdown(dev->netdev);
+
 		if (!removed) {
 			INIT_WORK(&entry->delete_netdev, delete_netdev);
 			schedule_work(&entry->delete_netdev);
@@ -1165,6 +1178,43 @@ static const struct file_operations lowpan_control_fops = {
 	.release	= single_release,
 };
 
+static void disconnect_devices(void)
+{
+	struct lowpan_dev *entry, *tmp, *new_dev;
+	struct list_head devices;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&devices);
+
+	/* We make a separate list of devices because the unregister_netdev()
+	 * will call device_event() which will also want to modify the same
+	 * devices list.
+	 */
+
+	read_lock_irqsave(&devices_lock, flags);
+
+	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
+		new_dev = kmalloc(sizeof(*new_dev), GFP_ATOMIC);
+		if (!new_dev)
+			break;
+
+		new_dev->netdev = entry->netdev;
+		INIT_LIST_HEAD(&new_dev->list);
+
+		list_add(&new_dev->list, &devices);
+	}
+
+	read_unlock_irqrestore(&devices_lock, flags);
+
+	list_for_each_entry_safe(entry, tmp, &devices, list) {
+		ifdown(entry->netdev);
+		BT_DBG("Unregistering netdev %s %p",
+		       entry->netdev->name, entry->netdev);
+		unregister_netdev(entry->netdev);
+		kfree(entry);
+	}
+}
+
 static int device_event(struct notifier_block *unused,
 			unsigned long event, void *ptr)
 {
@@ -1181,6 +1231,8 @@ static int device_event(struct notifier_block *unused,
 		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
 					 list) {
 			if (entry->netdev == netdev) {
+				BT_DBG("Unregistered netdev %s %p",
+				       netdev->name, netdev);
 				list_del(&entry->list);
 				kfree(entry);
 				break;
@@ -1217,6 +1269,8 @@ static void __exit bt_6lowpan_exit(void)
 	if (listen_chan)
 		chan_close(listen_chan, 0);
 
+	disconnect_devices();
+
 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
 }
 
-- 
1.8.3.1

