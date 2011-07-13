Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 3/3] Bluetooth: Implement Management command listener
Date: Wed, 13 Jul 2011 10:06:37 -0400
Message-Id: <4e1da4a9.04bfec0a.4243.00db@mx.google.com>
In-Reply-To: <1310565997-31927-1-git-send-email-y>
References: <y>
 <1310565997-31927-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements new Management commands used to make a type of
monitor for selected HCI commands. It is useful when userspace needs to
receive updates from the kernel, periodically, without the need to
actively do requests.

Userspace via management can register an HCI command and start receiving
updates from the controller. For now, the monitor can listen Read RSSI
and Read TX Power level commands. But the addition of other commands
should not be a problem. It was necessary since we have profiles that
need to monitor some connection aspects, like Proximity.

For now, the timer is constant and has a value of 2 seconds, but this
is a RFC and this value or approach can be modified.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    3 +
 include/net/bluetooth/mgmt.h     |   12 ++
 net/bluetooth/hci_core.c         |   12 ++
 net/bluetooth/mgmt.c             |  205 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 232 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 870f31f..8266505 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -211,6 +211,8 @@ struct hci_dev {
 
 	struct timer_list	le_scan_timer;
 
+	struct timer_list	cmd_listener_timer;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -873,6 +875,7 @@ int mgmt_has_pending_stop_discov(u16 index);
 int mgmt_cancel_discovery(u16 index);
 int mgmt_is_interleaved_discovery(u16 index);
 int mgmt_do_interleaved_discovery(u16 index);
+int mgmt_request_monitored_cmds(struct hci_dev *hdev);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7122aa3..4b9513f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -231,6 +231,18 @@ struct mgmt_rp_read_tx_power_level {
 	__s8 level;
 } __packed;
 
+#define MGMT_OP_ADD_LISTENER		0x0021
+struct mgmt_cp_add_listener {
+	__u16 cmd_op_code;
+	bdaddr_t bdaddr;
+} __packed;
+
+#define MGMT_OP_REMOVE_LISTENER		0x0022
+struct mgmt_cp_remove_listener {
+	__u16 cmd_op_code;
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c0c46bf..626922b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1449,6 +1449,14 @@ static void hci_disable_le_scan(unsigned long arg)
 	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
+static void hci_cmd_listener(unsigned long arg)
+{
+	struct hci_dev *hdev = (void *) arg;
+
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_request_monitored_cmds(hdev);
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1522,6 +1530,9 @@ int hci_register_dev(struct hci_dev *hdev)
 	setup_timer(&hdev->le_scan_timer, hci_disable_le_scan,
 						(unsigned long) hdev);
 
+	setup_timer(&hdev->cmd_listener_timer, hci_cmd_listener,
+			(unsigned long) hdev);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1604,6 +1615,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_del_off_timer(hdev);
 	del_timer(&hdev->adv_timer);
 	del_timer(&hdev->le_scan_timer);
+	del_timer(&hdev->cmd_listener_timer);
 
 	destroy_workqueue(hdev->workqueue);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d7bcfc6..532b4c6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -55,6 +55,18 @@ struct pending_cmd {
 
 static LIST_HEAD(cmd_list);
 
+#define CMD_MONITOR_TIMEOUT	2000
+struct monitored_cmd {
+	struct list_head list;
+	__u16 opcode;
+	int index;
+	bdaddr_t bdaddr;
+	void *cp;
+	struct sock *sk;
+};
+
+static LIST_HEAD(monitored_cmd_list);
+
 static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -2043,6 +2055,193 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
+static void mgmt_restart_monitor(u16 index)
+{
+	struct hci_dev *hdev;
+
+	hdev = hci_dev_get(index);
+	mod_timer(&hdev->cmd_listener_timer, jiffies +
+			msecs_to_jiffies(CMD_MONITOR_TIMEOUT));
+	hci_dev_put(hdev);
+}
+
+static int mgmt_monitored_add(struct sock *sk, u16 index,
+						u16 opcode, bdaddr_t *bdaddr)
+{
+	struct monitored_cmd *cmd;
+	struct mgmt_cp_read_rssi cp_rssi;
+	struct mgmt_cp_read_tx_power_level cp_tx_power;
+	int err = 0;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto out;
+	}
+	memset(cmd, 0, sizeof(*cmd));
+
+	cmd->opcode = opcode;
+	cmd->index = index;
+	bacpy(&cmd->bdaddr, bdaddr);
+
+	cmd->sk = sk;
+	sock_hold(sk);
+
+	switch(cmd->opcode) {
+	case MGMT_OP_READ_RSSI:
+		bacpy(&cp_rssi.bdaddr, bdaddr);
+		cmd->cp = kmalloc(sizeof(cp_rssi), GFP_ATOMIC);
+		if (!cmd->cp) {
+			err = -ENOMEM;
+			goto out;
+		}
+		memcpy(cmd->cp, &cp_rssi, sizeof(cp_rssi));
+		break;
+	case MGMT_OP_READ_TX_POWER_LEVEL:
+		bacpy(&cp_tx_power.bdaddr, bdaddr);
+		cmd->cp = kmalloc(sizeof(cp_tx_power), GFP_ATOMIC);
+		if (!cmd->cp) {
+			err = -ENOMEM;
+			goto out;
+		}
+		memcpy(cmd->cp, &cp_tx_power, sizeof(cp_tx_power));
+		break;
+	default:
+		BT_DBG("Unknown op %u", opcode);
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (!list_empty(&cmd->list))
+		mgmt_restart_monitor(index);
+
+	list_add(&cmd->list, &monitored_cmd_list);
+
+out:
+	if (err) {
+		sock_put(sk);
+		kfree(cmd->cp);
+		kfree(cmd);
+	}
+	return err;
+}
+
+static struct monitored_cmd *mgmt_monitored_cmd_find(u16 index,
+					u16 opcode, bdaddr_t *bdaddr)
+{
+	struct monitored_cmd *cmd;
+
+	list_for_each_entry(cmd, &monitored_cmd_list, list) {
+
+		if (cmd->opcode != opcode)
+			continue;
+
+		if (index >= 0 && cmd->index != index)
+			continue;
+
+		if (bacmp(&cmd->bdaddr, bdaddr) != 0)
+			continue;
+
+		return cmd;
+	}
+
+	return NULL;
+}
+
+static int mgmt_monitored_remove(u16 index, u16 opcode, bdaddr_t *bdaddr)
+{
+	struct monitored_cmd *cmd;
+	struct hci_dev *hdev;
+
+	cmd = mgmt_monitored_cmd_find(index, opcode, bdaddr);
+	if (!cmd)
+		return -EINVAL;
+
+	list_del_init(&cmd->list);
+	sock_put(cmd->sk);
+	kfree(cmd->cp);
+
+	hdev = hci_dev_get(index);
+	if (list_empty(&cmd->list) && hdev) {
+		del_timer(&hdev->cmd_listener_timer);
+		hci_dev_put(hdev);
+	}
+
+	kfree(cmd);
+
+	return 0;
+}
+
+static int add_listener(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct mgmt_cp_add_listener *cp;
+
+	BT_DBG("hci%u", index);
+
+	cp = (void *) data;
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_ADD_LISTENER, EINVAL);
+
+	return mgmt_monitored_add(sk, index, cp->cmd_op_code, &cp->bdaddr);
+}
+
+static int remove_listener(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct mgmt_cp_remove_listener *cp;
+	int err = 0;
+
+	BT_DBG("hci%u", index);
+
+	cp = (void *) data;
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_REMOVE_LISTENER, EINVAL);
+
+	err = mgmt_monitored_remove(index, cp->cmd_op_code, &cp->bdaddr);
+
+	return err;
+}
+
+int mgmt_request_monitored_cmds(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+	int err;
+
+	err = 0;
+
+	list_for_each_safe(p, n, &monitored_cmd_list) {
+		struct monitored_cmd *cmd;
+
+		cmd = list_entry(p, struct monitored_cmd, list);
+
+		if (hdev->id >= 0 && cmd->index != hdev->id)
+			continue;
+
+		switch(cmd->opcode) {
+		case MGMT_OP_READ_RSSI:
+			err = read_rssi(cmd->sk, cmd->index, cmd->cp,
+					sizeof(struct mgmt_cp_read_rssi));
+			break;
+		case MGMT_OP_READ_TX_POWER_LEVEL:
+			err = read_tx_power_level(cmd->sk, cmd->index, cmd->cp,
+				sizeof(struct mgmt_cp_read_tx_power_level));
+			break;
+		default:
+			BT_DBG("Unknown op %u", cmd->opcode);
+			err = cmd_status(cmd->sk, cmd->index, cmd->opcode, 0x01);
+			break;
+		}
+	}
+
+	if (!err)
+		mgmt_restart_monitor(hdev->id);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -2163,6 +2362,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_ADD_LISTENER:
+		err = add_listener(sk, index, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_REMOVE_LISTENER:
+		err = remove_listener(sk, index, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
-- 
1.7.4.1

