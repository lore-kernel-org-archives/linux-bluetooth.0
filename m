Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/5] Bluetooth: 6LoWPAN: Remove network devices when unloading
Date: Mon,  2 Jun 2014 13:08:24 +0300
Message-Id: <1401703704-22451-6-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1401703704-22451-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1401703704-22451-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the module is unloaded, unregister the network device
so that the system does not try to access non-existing device.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index ae0413f..13a40d0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -601,6 +601,17 @@ static void ifup(struct net_device *netdev)
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
@@ -796,6 +807,8 @@ static void bt_6lowpan_chan_close_cb(struct l2cap_chan *chan)
 
 		cancel_delayed_work_sync(&dev->notify_peers);
 
+		ifdown(dev->netdev);
+
 		if (!removed) {
 			INIT_WORK(&entry->delete_netdev, delete_netdev);
 			schedule_work(&entry->delete_netdev);
@@ -1204,6 +1217,38 @@ static void cleanup_6lowpan(void)
 		chan_close(listen_chan, 0);
 }
 
+static void disconnect_devices(void)
+{
+	struct lowpan_dev *entry, *tmp, *new_dev;
+	struct list_head devices;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&devices);
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
@@ -1220,6 +1265,8 @@ static int device_event(struct notifier_block *unused,
 		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
 					 list) {
 			if (entry->netdev == netdev) {
+				BT_DBG("Unregistered netdev %s %p",
+				       netdev->name, netdev);
 				list_del(&entry->list);
 				kfree(entry);
 				break;
-- 
1.8.3.1

