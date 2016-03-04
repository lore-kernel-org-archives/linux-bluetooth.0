Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/5] bluetooth: Implement Remove Network Management API command
Date: Fri,  4 Mar 2016 13:40:44 +0200
Message-Id: <1457091644-21536-6-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Queue Remove Network Management API command and disconnect the L2CAP
channel. Once the channel has been removed, reply to the command in
l2cap_ops close callback. On error reply with a failure in the
l2cap_ops status callback.

Remove the remaining part of the debugfs code handling the control
file.

The MGMT_OP_REMOVE_NETWORK command is defined as:

       Command Code:           0x0044
       Controller Index:       <controller id>
       Command Parameters:     Address (6 Octets)
                               Address_Type (1 Octet)
       Return Parameters:      Address (6 Octets)
                               Address_Type (1 Octet)

       This command is used to disconnect a network connection from a
       remote BTLE node. A pre-requisite is that LE is already
       enabled, otherwise this command will return a "rejected"
       response.

       Possible values for the Address_Type parameter:
               0       Reserved
               1       LE Public
               2       LE Random

       This command generates a Command Complete event on success
       or failure.

       Possible errors:        Busy
                               Not Connected
                               Invalid Parameters
                               Not Powered
                               Invalid Index

The MGMT_EV_NETWORK_REMOVED event is defined as:

       Event Code:             0x0026
       Controller Index:       <controller id>
       Event Parameters:       Address (6 Octets)
                               Address_Type (1 Octet)

       This event indicates that the BTLE network connection to a remote
       node has been lost.

       Possible values for the Address_Type parameter:
               1       LE Public
               2       LE Random

       For devices using resolvable random addresses with a known
       identity resolving key, the Address and Address_Type will
       contain the identity information.
---
 include/net/bluetooth/mgmt.h |  14 ++++
 net/bluetooth/6lowpan.c      | 174 ++++++++++++++++++++++---------------------
 net/bluetooth/mgmt.c         |   3 +
 3 files changed, 106 insertions(+), 85 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f6bc80f..62d0583 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -606,6 +606,15 @@ struct mgmt_rp_add_network {
 	int ifindex;
 } __packed;
 
+#define MGMT_OP_REMOVE_NETWORK          0x0044
+#define MGMT_REMOVE_NETWORK_SIZE        7
+struct mgmt_cp_remove_network {
+	struct mgmt_addr_info dst;
+} __packed;
+struct mgmt_rp_remove_network {
+	struct mgmt_addr_info dst;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -825,3 +834,8 @@ struct mgmt_ev_network_added {
 	struct mgmt_addr_info dst;
 	int ifindex;
 } __packed;
+
+#define MGMT_EV_NETWORK_REMOVED         0x0026
+struct mgmt_ev_network_removed {
+	struct mgmt_addr_info dst;
+} __packed;
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 9f12eb1..f62ac14 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -33,7 +33,6 @@
 #define VERSION "0.1"
 
 static struct dentry *lowpan_enable_debugfs;
-static struct dentry *lowpan_control_debugfs;
 
 #define IFACE_NAME_TEMPLATE "bt%d"
 
@@ -929,6 +928,46 @@ static void cmd_add_network_complete(struct l2cap_chan *chan, int status,
 		mgmt_pending_remove(cmd);
 }
 
+static void cmd_remove_network_complete(struct l2cap_chan *chan, int status)
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
+	cmd = mgmt_pending_find(HCI_CHANNEL_CONTROL, MGMT_OP_REMOVE_NETWORK,
+				hdev);
+	if (cmd) {
+		struct mgmt_cp_remove_network *cp = cmd->param;
+		struct mgmt_rp_remove_network rp;
+
+		bacpy(&rp.dst.bdaddr, &cp->dst.bdaddr);
+		rp.dst.type = cp->dst.type;
+
+		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+				status, &rp, sizeof(rp));
+	}
+
+	if (status == MGMT_STATUS_SUCCESS && chan->state == BT_DISCONN) {
+		struct mgmt_ev_network_removed ep;
+
+		bacpy(&ep.dst.bdaddr, &chan->dst);
+		ep.dst.type = chan->dst_type;
+
+		mgmt_send_event(MGMT_EV_NETWORK_REMOVED, hdev,
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
@@ -1000,6 +1039,7 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	}
 
 	cmd_add_network_complete(chan, MGMT_STATUS_CONNECT_FAILED, 0);
+	cmd_remove_network_complete(chan, MGMT_STATUS_SUCCESS);
 
 	spin_lock(&devices_lock);
 
@@ -1045,6 +1085,7 @@ static void chan_state_change_cb(struct l2cap_chan *chan, int state, int err)
 
 	if (err < 0) {
 		cmd_add_network_complete(chan, MGMT_STATUS_CONNECT_FAILED, 0);
+		cmd_remove_network_complete(chan, MGMT_STATUS_CONNECT_FAILED);
 	}
 }
 
@@ -1270,21 +1311,60 @@ unlock:
 	return err;
 }
 
-static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
+int bt_6lowpan_remove_network(struct sock *sk, struct hci_dev *hdev,
+			void *data, u16 data_len)
 {
+	struct mgmt_cp_remove_network *cp = data;
+	int err = 0;
 	struct lowpan_peer *peer;
+	struct mgmt_pending_cmd *cmd;
 
-	BT_DBG("conn %p dst type %d", conn, dst_type);
+	BT_DBG("remove network hdev %p data %p data len %d",
+		hdev, data, data_len);
 
-	peer = lookup_peer(conn);
-	if (!peer)
-		return -ENOENT;
+	if (!lmp_le_capable(hdev)) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_NETWORK,
+					MGMT_STATUS_NOT_SUPPORTED, cp,
+					sizeof(*cp));
+		goto failed;
+	}
 
-	BT_DBG("peer %p chan %p", peer, peer->chan);
+	if (!bdaddr_type_is_le(cp->dst.type)) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_NETWORK,
+					MGMT_STATUS_INVALID_PARAMS, cp,
+					sizeof(*cp));
+		goto failed;
+	}
 
-	l2cap_chan_close(peer->chan, ENOENT);
+	hci_dev_lock(hdev);
 
-	return 0;
+	if (mgmt_pending_find(HCI_CHANNEL_CONTROL, MGMT_OP_REMOVE_NETWORK,
+				hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_NETWORK,
+				MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	peer = lookup_bdaddr(hdev, &cp->dst.bdaddr, cp->dst.type);
+	if (!peer) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_NETWORK,
+					MGMT_STATUS_FAILED,
+					cp, sizeof(*cp));
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_NETWORK, hdev,
+			data, data_len);
+	if (!cmd)
+		err = -ENOMEM;
+
+	l2cap_chan_close(peer->chan, 0);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+failed:
+	return err;
 }
 
 static struct l2cap_chan *bt_6lowpan_listen(void)
@@ -1318,40 +1398,6 @@ static struct l2cap_chan *bt_6lowpan_listen(void)
 	return chan;
 }
 
-static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
-			  struct l2cap_conn **conn)
-{
-	struct hci_conn *hcon;
-	struct hci_dev *hdev;
-	bdaddr_t *src = BDADDR_ANY;
-	int n;
-
-	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
-		   &addr->b[5], &addr->b[4], &addr->b[3],
-		   &addr->b[2], &addr->b[1], &addr->b[0],
-		   addr_type);
-
-	if (n < 7)
-		return -EINVAL;
-
-	hdev = hci_get_route(addr, src);
-	if (!hdev)
-		return -ENOENT;
-
-	hci_dev_lock(hdev);
-	hcon = hci_conn_hash_lookup_le(hdev, addr, *addr_type);
-	hci_dev_unlock(hdev);
-
-	if (!hcon)
-		return -ENOENT;
-
-	*conn = (struct l2cap_conn *)hcon->l2cap_data;
-
-	BT_DBG("conn %p dst %pMR type %d", *conn, &hcon->dst, hcon->dst_type);
-
-	return 0;
-}
-
 static void disconnect_all_peers(void)
 {
 	struct lowpan_dev *entry;
@@ -1445,44 +1491,6 @@ static int lowpan_enable_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(lowpan_enable_fops, lowpan_enable_get,
 			lowpan_enable_set, "%llu\n");
 
-static ssize_t lowpan_control_write(struct file *fp,
-				    const char __user *user_buffer,
-				    size_t count,
-				    loff_t *position)
-{
-	char buf[32];
-	size_t buf_size = min(count, sizeof(buf) - 1);
-	int ret;
-	bdaddr_t addr;
-	u8 addr_type;
-	struct l2cap_conn *conn = NULL;
-
-	if (copy_from_user(buf, user_buffer, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-
-	if (memcmp(buf, "disconnect ", 11) == 0) {
-		ret = get_l2cap_conn(&buf[11], &addr, &addr_type, &conn);
-		if (ret < 0)
-			return ret;
-
-		ret = bt_6lowpan_disconnect(conn, addr_type);
-		if (ret < 0)
-			return ret;
-
-		return count;
-	}
-
-	return count;
-}
-
-static const struct file_operations lowpan_control_fops = {
-	.write		= lowpan_control_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static void disconnect_devices(void)
 {
 	struct lowpan_dev *entry, *tmp, *new_dev;
@@ -1555,9 +1563,6 @@ int bt_6lowpan_init(void)
 	lowpan_enable_debugfs = debugfs_create_file("6lowpan_enable", 0644,
 						    bt_debugfs, NULL,
 						    &lowpan_enable_fops);
-	lowpan_control_debugfs = debugfs_create_file("6lowpan_control", 0644,
-						     bt_debugfs, NULL,
-						     &lowpan_control_fops);
 
 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
 }
@@ -1565,7 +1570,6 @@ int bt_6lowpan_init(void)
 void bt_6lowpan_exit(void)
 {
 	debugfs_remove(lowpan_enable_debugfs);
-	debugfs_remove(lowpan_control_debugfs);
 
 	if (listen_chan) {
 		l2cap_chan_close(listen_chan, 0);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2c2824e..909c723 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -107,6 +107,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_GET_NETWORKS,
 	MGMT_OP_ADD_NETWORK,
+	MGMT_OP_REMOVE_NETWORK,
 };
 
 static const u16 mgmt_events[] = {
@@ -145,6 +146,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_ADVERTISING_ADDED,
 	MGMT_EV_ADVERTISING_REMOVED,
 	MGMT_EV_NETWORK_ADDED,
+	MGMT_EV_NETWORK_REMOVED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -6342,6 +6344,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
 	{ bt_6lowpan_get_networks, MGMT_GET_NETWORKS_SIZE },
 	{ bt_6lowpan_add_network,  MGMT_ADD_NETWORK_SIZE },
+	{ bt_6lowpan_remove_network, MGMT_REMOVE_NETWORK_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.1.4

