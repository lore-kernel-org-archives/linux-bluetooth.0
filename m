Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/8] Bluetooth: 6lowpan: Remove all 6lowpan network devices when module is unloaded
Date: Fri, 23 May 2014 12:27:28 +0300
Message-Id: <1400837248-12179-9-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 04e0501..4310eb1 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -592,6 +592,17 @@ static void ifup(struct net_device *netdev)
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
@@ -721,6 +732,9 @@ static inline void bt_6lowpan_chan_ready_cb(struct l2cap_chan *chan)
 		}
 	}
 
+	if (!try_module_get(THIS_MODULE))
+		return;
+
 	add_peer_chan(chan, dev);
 	ifup(dev->netdev);
 }
@@ -780,11 +794,15 @@ static void bt_6lowpan_chan_close_cb(struct l2cap_chan *chan)
 		}
 	}
 
+	module_put(THIS_MODULE);
+
 	if (!err && last && dev && !atomic_read(&dev->peer_count)) {
 		write_unlock_irqrestore(&devices_lock, flags);
 
 		cancel_delayed_work_sync(&dev->notify_peers);
 
+		ifdown(dev->netdev);
+
 		if (!removed) {
 			INIT_WORK(&entry->delete_netdev, delete_netdev);
 			schedule_work(&entry->delete_netdev);
@@ -1186,6 +1204,38 @@ static void lowpan_create_hci(struct hci_dev *hdev)
 	schedule_work(&check->setup_6lowpan);
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
@@ -1202,6 +1252,8 @@ static int device_event(struct notifier_block *unused,
 		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
 					 list) {
 			if (entry->netdev == netdev) {
+				BT_DBG("Unregistered netdev %s %p",
+				       netdev->name, netdev);
 				list_del(&entry->list);
 				kfree(entry);
 				break;
@@ -1237,6 +1289,8 @@ static void __exit bt_6lowpan_cleanup(void)
 
 	hci_unregister_cb(&lowpan_cb);
 
+	disconnect_devices();
+
 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
 }
 
-- 
1.8.3.1

