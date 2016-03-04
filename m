Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/5] bluetooth: Implement Add Network Management API command
Date: Fri,  4 Mar 2016 13:40:43 +0200
Message-Id: <1457091644-21536-5-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Queue Add Network Management API command and initiate a L2CAP connect
to the destination. Reply to the command in the l2cap_ops ready callback
when the channel is successfully created and inidcate failure in both
l2cap_ops close and state callbacks when an error is indicated.

On success add the remote peer to the internal data structures and create
the network interface as before. Remove the debugfs implementation doing
the same thing.

The MGMT_OP_ADD_NETWORK command is defined as:

       Command Code:           0x0043
       Controller Index:       <controller id>
       Command Parameters:     Address (6 Octets)
                               Address_Type (1 Octet)
       Return Parameters:      Address (6 Octets)
                               Address_Type (1 Octet)
                               Interface Index (4 Octets)

       This command is used to connect to establish a network connection
       to a remote BTLE node. A pre-requisite is that LE is already
       enabled, otherwise this command will return a "rejected"
       response.

       Possible values for the Address_Type parameter:
               0       Reserved
               1       LE Public
               2       LE Random

       This command generates a Command Complete event on success
       or failure.

       Possible errors:        Busy
                               Refused
                               Invalid Parameters
                               Not Powered
                               Invalid Index
                               Already Connected

The MGMT_EV_NETWORK_ADDED event is defined as:

       Event Code:             0x0025
       Controller Index:       <controller id>
       Event Parameters:       Address (6 Octets)
                               Address_Type (1 Octet)
                               Interface Index (4 Octets)

       This event indicates that a network connection to a remote
       BTLE node has been established successfully.

       Possible values for the Address_Type parameter:
               1       LE Public
               2       LE Random

       For devices using resolvable random addresses with a known
       identity resolving key, the Address and Address_Type will
       contain the identity information.
---
 include/net/bluetooth/mgmt.h |  16 ++++
 net/bluetooth/6lowpan.c      | 205 ++++++++++++++++++++++++++++++++-----------
 net/bluetooth/mgmt.c         |   3 +
 3 files changed, 172 insertions(+), 52 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 813224b..f6bc80f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -596,6 +596,16 @@ struct mgmt_rp_network {
 	int ifindex;
 } __packed;
 
+#define MGMT_OP_ADD_NETWORK             0x0043
+#define MGMT_ADD_NETWORK_SIZE           7
+struct mgmt_cp_add_network {
+	struct mgmt_addr_info dst;
+} __packed;
+struct mgmt_rp_add_network {
+	struct mgmt_addr_info dst;
+	int ifindex;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -809,3 +819,9 @@ struct mgmt_ev_advertising_added {
 struct mgmt_ev_advertising_removed {
 	__u8    instance;
 } __packed;
+
+#define MGMT_EV_NETWORK_ADDED           0x0025
+struct mgmt_ev_network_added {
+	struct mgmt_addr_info dst;
+	int ifindex;
+} __packed;
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index a582a736..9f12eb1 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -258,6 +258,36 @@ static struct lowpan_dev *lookup_dev(struct l2cap_conn *conn)
 	return dev;
 }
 
+static struct lowpan_peer *lookup_bdaddr(struct hci_dev *hdev, bdaddr_t *dst,
+					u8 dst_type)
+{
+	struct lowpan_dev *dev;
+	struct lowpan_peer *peer, *target = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(dev, &bt_6lowpan_devices, list) {
+		if (dev->hdev != hdev)
+			continue;
+
+		list_for_each_entry_rcu(peer, &dev->peers, list) {
+			if(!peer->chan)
+				continue;
+
+			if (!bacmp(dst, &peer->chan->dst) &&
+					dst_type == peer->chan->dst_type) {
+				target = peer;
+				goto rcu_unlock;
+			}
+		}
+	}
+
+rcu_unlock:
+	rcu_read_unlock();
+
+	return target;
+}
+
 static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sk_buff *skb_cp;
@@ -854,6 +884,51 @@ out:
 	return err;
 }
 
+static void cmd_add_network_complete(struct l2cap_chan *chan, int status,
+				int ifindex)
+{
+	struct hci_dev *hdev;
+	struct mgmt_pending_cmd *cmd;
+
+	hdev = hci_get_route(NULL, &chan->src);
+
+	if (!hdev) {
+		BT_DBG("No matching hci_dev for l2cap_chan %p", chan);
+		return;
+	}
+
+	cmd = mgmt_pending_find(HCI_CHANNEL_CONTROL, MGMT_OP_ADD_NETWORK,
+				hdev);
+	BT_DBG("cmd %p status %d state %d", cmd, status, chan->state);
+
+	if (cmd) {
+		struct mgmt_cp_add_network *cp = cmd->param;
+		struct mgmt_rp_add_network rp;
+
+		rp.ifindex = ifindex;
+		bacpy(&rp.dst.bdaddr, &cp->dst.bdaddr);
+		rp.dst.type = cp->dst.type;
+
+		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+				status, &rp, sizeof(rp));
+	}
+
+	if (status == MGMT_STATUS_SUCCESS && chan->state == BT_CONNECTED) {
+		struct mgmt_ev_network_added ep;
+
+		ep.ifindex = ifindex;
+		bacpy(&ep.dst.bdaddr, &chan->dst);
+		ep.dst.type = chan->dst_type;
+
+		mgmt_send_event(MGMT_EV_NETWORK_ADDED, hdev,
+				HCI_CHANNEL_CONTROL, &ep, sizeof(ep),
+				HCI_SOCK_TRUSTED, cmd? cmd->sk: NULL);
+	}
+
+	if (cmd)
+		mgmt_pending_remove(cmd);
+}
+
 static inline void chan_ready_cb(struct l2cap_chan *chan)
 {
 	struct lowpan_dev *dev;
@@ -874,6 +949,9 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 
 	add_peer_chan(chan, dev);
 	ifup(dev->netdev);
+
+	cmd_add_network_complete(chan, MGMT_STATUS_SUCCESS,
+				dev->netdev->ifindex);
 }
 
 static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
@@ -921,6 +999,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
 		remove = false;
 	}
 
+	cmd_add_network_complete(chan, MGMT_STATUS_CONNECT_FAILED, 0);
+
 	spin_lock(&devices_lock);
 
 	list_for_each_entry_rcu(entry, &bt_6lowpan_devices, list) {
@@ -962,6 +1042,10 @@ static void chan_state_change_cb(struct l2cap_chan *chan, int state, int err)
 {
 	BT_DBG("chan %p conn %p state %s err %d", chan, chan->conn,
 	       state_to_string(state), err);
+
+	if (err < 0) {
+		cmd_add_network_complete(chan, MGMT_STATUS_CONNECT_FAILED, 0);
+	}
 }
 
 static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
@@ -1103,34 +1187,86 @@ unlock:
 	return err;
 }
 
-static inline __u8 bdaddr_type(__u8 type)
-{
-	if (type == ADDR_LE_DEV_PUBLIC)
-		return BDADDR_LE_PUBLIC;
-	else
-		return BDADDR_LE_RANDOM;
-}
-
-static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
+int bt_6lowpan_add_network(struct sock *sk, struct hci_dev *hdev,
+			void *data, u16 data_len)
 {
-	struct hci_dev *hdev;
-	struct l2cap_chan *chan;
+	struct mgmt_cp_add_network *cp = data;
+	struct mgmt_rp_add_network rp;
+	struct mgmt_pending_cmd *cmd;
 	int err;
+        struct l2cap_chan *chan;
+
+	BT_DBG("add network hdev %p data %p data len %d",
+		hdev, data, data_len);
+
+	rp.ifindex = 0;
+	bacpy(&rp.dst.bdaddr, &cp->dst.bdaddr);
+	rp.dst.type = cp->dst.type;
+
+	if (!lmp_le_capable(hdev))
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_NETWORK,
+					MGMT_STATUS_NOT_SUPPORTED, &rp,
+					sizeof(rp));
+
+	if (!bdaddr_type_is_le(cp->dst.type))
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_NETWORK,
+					MGMT_STATUS_NOT_SUPPORTED, &rp,
+					sizeof(rp));
+
+	hci_dev_lock(hdev);
+	if (mgmt_pending_find(HCI_CHANNEL_CONTROL, MGMT_OP_ADD_NETWORK,
+				hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_NETWORK,
+				MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	if (lookup_bdaddr(hdev, &rp.dst.bdaddr, rp.dst.type)) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_NETWORK,
+					MGMT_STATUS_ALREADY_CONNECTED,
+					&rp, sizeof(rp));
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_NETWORK, hdev, data, data_len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	chan = chan_create();
-	if (!chan)
-		return -EINVAL;
+	if (!chan) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_NETWORK,
+					MGMT_STATUS_NO_RESOURCES,
+					&rp, sizeof(rp));
+		goto pending_remove;
+	}
 
 	chan->ops = &bt_6lowpan_chan_ops;
 
-	hdev = hci_get_route(addr, NULL);
+	hci_dev_unlock(hdev);
+
 	err = l2cap_chan_connect(chan, hdev, cpu_to_le16(L2CAP_PSM_IPSP), 0,
-				 addr, dst_type);
+				&cp->dst.bdaddr, cp->dst.type);
 
-	BT_DBG("chan %p err %d", chan, err);
-	if (err < 0)
+	if (err < 0) {
 		l2cap_chan_put(chan);
 
+		hci_dev_lock(hdev);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_NETWORK,
+					MGMT_STATUS_REJECTED,
+					&rp, sizeof(rp));
+		goto pending_remove;
+	}
+
+	return err;
+
+pending_remove:
+	mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+
 	return err;
 }
 
@@ -1326,41 +1462,6 @@ static ssize_t lowpan_control_write(struct file *fp,
 
 	buf[buf_size] = '\0';
 
-	if (memcmp(buf, "connect ", 8) == 0) {
-		ret = get_l2cap_conn(&buf[8], &addr, &addr_type, &conn);
-		if (ret == -EINVAL)
-			return ret;
-
-		if (listen_chan) {
-			l2cap_chan_close(listen_chan, 0);
-			l2cap_chan_put(listen_chan);
-			listen_chan = NULL;
-		}
-
-		if (conn) {
-			struct lowpan_peer *peer;
-
-			if (!is_bt_6lowpan(conn->hcon))
-				return -EINVAL;
-
-			peer = lookup_peer(conn);
-			if (peer) {
-				BT_DBG("6LoWPAN connection already exists");
-				return -EALREADY;
-			}
-
-			BT_DBG("conn %p dst %pMR type %d user %d", conn,
-			       &conn->hcon->dst, conn->hcon->dst_type,
-			       addr_type);
-		}
-
-		ret = bt_6lowpan_connect(&addr, addr_type);
-		if (ret < 0)
-			return ret;
-
-		return count;
-	}
-
 	if (memcmp(buf, "disconnect ", 11) == 0) {
 		ret = get_l2cap_conn(&buf[11], &addr, &addr_type, &conn);
 		if (ret < 0)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 722cc17..2c2824e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_GET_ADV_SIZE_INFO,
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_GET_NETWORKS,
+	MGMT_OP_ADD_NETWORK,
 };
 
 static const u16 mgmt_events[] = {
@@ -143,6 +144,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_LOCAL_OOB_DATA_UPDATED,
 	MGMT_EV_ADVERTISING_ADDED,
 	MGMT_EV_ADVERTISING_REMOVED,
+	MGMT_EV_NETWORK_ADDED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -6339,6 +6341,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ get_adv_size_info,       MGMT_GET_ADV_SIZE_INFO_SIZE },
 	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
 	{ bt_6lowpan_get_networks, MGMT_GET_NETWORKS_SIZE },
+	{ bt_6lowpan_add_network,  MGMT_ADD_NETWORK_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.1.4

