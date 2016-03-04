Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/5] bluetooth: Implement Get Networks Management API command
Date: Fri,  4 Mar 2016 13:40:41 +0200
Message-Id: <1457091644-21536-3-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement MGMT_OP_GET_NETWORKS command by replying with the addresses
and address types of all 6LowPAN peers. If none are found, return
peer count and interface as zero.

Remove the debugfs implementation for achieving the same thing.

The MGMT_OP_GET_NETWORKS command is defined as:
       Command Code:           0x0042
       Controller Index:       <controller id>
       Command Parameters:
       Return Parameters:      Connection_Count (2 Octets)
                               Network1 {
                                       Address (6 Octets)
                                       Address_Type (1 Octet)
                                       Interface Index (4 Octets)
                               }
                               Network2 { }
                               ...

       This command is used to retrieve a list of BTLE network
       connections. A pre-requisite is that LE is already
       enabled, otherwise this command will return a "rejected"
       response.

       Possible values for the Address_Type parameter:
               0       Reserved
               1       LE Public
               2       LE Random

       For devices using resolvable random addresses with a known
       identity resolving key, the Address and Address_Type will
       contain the identity information.

       This command can only be used when the controller is powered.

       This command generates a Command Complete event on success or
       a Command Status event on failure.

       Possible errors:        Invalid Parameters
                               Not Powered
                               Invalid Index

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 include/net/bluetooth/mgmt.h |  10 ++++
 net/bluetooth/6lowpan.c      | 110 +++++++++++++++++++++++++++++++++----------
 net/bluetooth/mgmt.c         |   3 ++
 3 files changed, 98 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ea73e08..813224b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -586,6 +586,16 @@ struct mgmt_rp_get_adv_size_info {
 
 #define MGMT_OP_START_LIMITED_DISCOVERY	0x0041
 
+#define MGMT_OP_GET_NETWORKS            0x0042
+#define MGMT_GET_NETWORKS_SIZE          0
+struct mgmt_rp_get_networks {
+	__u16 count;
+} __packed; /* followed by zero or more struct mgmt_rp_network */
+struct mgmt_rp_network {
+	struct mgmt_addr_info dst;
+	int ifindex;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index b675448..198e158 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -24,6 +24,9 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/mgmt.h>
+
+#include "mgmt_util.h"
 
 #include <net/6lowpan.h> /* for the compression support */
 
@@ -1018,6 +1021,88 @@ static const struct l2cap_ops bt_6lowpan_chan_ops = {
 	.set_shutdown		= l2cap_chan_no_set_shutdown,
 };
 
+int bt_6lowpan_get_networks(struct sock *sk, struct hci_dev *hdev,
+			void *data, u16 data_len)
+{
+	int err = 0;
+	struct mgmt_rp_get_networks *rp = NULL;
+	size_t size;
+	struct lowpan_dev *dev;
+	struct lowpan_peer *peer;
+
+	hci_dev_lock(hdev);
+
+	if (!lmp_le_capable(hdev)) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_GET_NETWORKS,
+					MGMT_STATUS_NOT_SUPPORTED, NULL, 0);
+		goto unlock;
+	}
+
+	spin_lock(&devices_lock);
+
+	list_for_each_entry(dev, &bt_6lowpan_devices, list) {
+		int count;
+		struct mgmt_rp_network *nw;
+
+		if (dev->hdev != hdev)
+			continue;
+
+		count = atomic_read(&dev->peer_count);
+
+		size = sizeof(*rp) + count * sizeof(*nw);
+		rp = kmalloc(size, GFP_ATOMIC);
+		if (!rp) {
+			err = -ENOMEM;
+			goto spin_unlock;
+		}
+
+		memset(rp, 0, size);
+		rp->count = count;
+
+		if (!rp->count)
+			break;
+
+		nw = (struct mgmt_rp_network *)(rp + 1);
+
+		list_for_each_entry(peer, &dev->peers, list) {
+			if (!peer->chan)
+				continue;
+
+			bacpy(&nw->dst.bdaddr, &peer->chan->dst);
+			nw->dst.type = peer->chan->dst_type;
+			nw->ifindex = dev->netdev->ifindex;
+			nw++;
+		}
+
+		break;
+	}
+
+	if (!rp) {
+		size = sizeof(*rp);
+		rp = kmalloc(size, GFP_ATOMIC);
+		if (!rp)
+			goto spin_unlock;
+
+		rp->count = 0;
+	}
+
+	BT_DBG("rp %p size %zd count %d", rp, size, rp->count);
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_NETWORKS,
+				MGMT_STATUS_SUCCESS, rp, size);
+
+	kfree(rp);
+
+spin_unlock:
+	spin_unlock(&devices_lock);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static inline __u8 bdaddr_type(__u8 type)
 {
 	if (type == ADDR_LE_DEV_PUBLIC)
@@ -1289,32 +1374,7 @@ static ssize_t lowpan_control_write(struct file *fp,
 	return count;
 }
 
-static int lowpan_control_show(struct seq_file *f, void *ptr)
-{
-	struct lowpan_dev *entry;
-	struct lowpan_peer *peer;
-
-	spin_lock(&devices_lock);
-
-	list_for_each_entry(entry, &bt_6lowpan_devices, list) {
-		list_for_each_entry(peer, &entry->peers, list)
-			seq_printf(f, "%pMR (type %u)\n",
-				   &peer->chan->dst, peer->chan->dst_type);
-	}
-
-	spin_unlock(&devices_lock);
-
-	return 0;
-}
-
-static int lowpan_control_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, lowpan_control_show, inode->i_private);
-}
-
 static const struct file_operations lowpan_control_fops = {
-	.open		= lowpan_control_open,
-	.read		= seq_read,
 	.write		= lowpan_control_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5a5089c..722cc17 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -31,6 +31,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/6lowpan.h>
 #include <net/bluetooth/mgmt.h>
 
 #include "hci_request.h"
@@ -104,6 +105,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_REMOVE_ADVERTISING,
 	MGMT_OP_GET_ADV_SIZE_INFO,
 	MGMT_OP_START_LIMITED_DISCOVERY,
+	MGMT_OP_GET_NETWORKS,
 };
 
 static const u16 mgmt_events[] = {
@@ -6336,6 +6338,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ remove_advertising,	   MGMT_REMOVE_ADVERTISING_SIZE },
 	{ get_adv_size_info,       MGMT_GET_ADV_SIZE_INFO_SIZE },
 	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
+	{ bt_6lowpan_get_networks, MGMT_GET_NETWORKS_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.1.4

