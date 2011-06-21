Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 3/3] Bluetooth: Add MGMT_OP_SET_LE_SUPPORT command
Date: Tue, 21 Jun 2011 17:07:50 -0300
Message-Id: <1308686870-26101-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new command to management interface to enable/
disable LE support. This command will be used to set LE support
according to the host configuration.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |    5 +++
 net/bluetooth/hci_event.c        |    2 +
 net/bluetooth/mgmt.c             |   73 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c4f595c..35b3109 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -211,6 +211,7 @@ enum {
 #define LMP_EDR_3S_ESCO	0x80
 
 #define LMP_EXT_INQ	0x01
+#define LMP_SIMUL_LE_BR	0x02
 #define LMP_SIMPLE_PAIR	0x08
 #define LMP_NO_FLUSH	0x40
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cd65f0e..00cbe03 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -835,6 +835,7 @@ int mgmt_device_found(u16 index, bdaddr_t *bdaddr, u8 *dev_class, s8 rssi,
 								u8 *eir);
 int mgmt_remote_name(u16 index, bdaddr_t *bdaddr, u8 *name);
 int mgmt_discovering(u16 index, u8 discovering);
+int mgmt_set_le_support_complete(u16 index, u8 status);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 45bea25..880b2e2 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -209,6 +209,11 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_SET_LE_SUPPORT		0x001F
+struct mgmt_cp_set_le_support {
+	__u8 enable_le;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index afe1bc8..a2195ff 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -917,6 +917,8 @@ static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
+	mgmt_set_le_support_complete(hdev->id, status);
+
 	if (status)
 		return;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 64c0418..748b8bb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1730,6 +1730,54 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
+static int set_le_support(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct mgmt_cp_set_le_support *mgmt_cp = (void *) data;
+	struct hci_cp_write_le_host_supported hci_cp;
+	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
+	int err;
+
+	BT_DBG("hci%u ", index);
+
+	if (len != sizeof(*mgmt_cp))
+		return cmd_status(sk, index, MGMT_OP_SET_LE_SUPPORT, EINVAL);
+
+	if (mgmt_pending_find(MGMT_OP_SET_LE_SUPPORT, index))
+		return cmd_status(sk, index, MGMT_OP_SET_LE_SUPPORT,
+								EINPROGRESS);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_SET_LE_SUPPORT, ENODEV);
+
+	if (mgmt_cp->enable_le && !lmp_le_capable(hdev)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LE_SUPPORT,
+								EOPNOTSUPP);
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LE_SUPPORT, index, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	hci_cp.le = mgmt_cp->enable_le;
+	hci_cp.simul = (hdev->features[6] & LMP_SIMUL_LE_BR) ? 0x01 : 0x00;
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+						sizeof(hci_cp),	&hci_cp);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+failed:
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1850,6 +1898,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_SET_LE_SUPPORT:
+		err = set_le_support(sk, index, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
@@ -2256,3 +2307,25 @@ int mgmt_discovering(u16 index, u8 discovering)
 	return mgmt_event(MGMT_EV_DISCOVERING, index, &discovering,
 						sizeof(discovering), NULL);
 }
+
+int mgmt_set_le_support_complete(u16 index, u8 status)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_find(MGMT_OP_SET_LE_SUPPORT, index);
+	if (!cmd)
+		return -ENOENT;
+
+	if (status) {
+		err = cmd_status(cmd->sk, index, MGMT_OP_SET_LE_SUPPORT, EIO);
+		goto out;
+	}
+
+	err = cmd_complete(cmd->sk, index, MGMT_OP_SET_LE_SUPPORT, NULL, 0);
+
+out:
+	mgmt_pending_remove(cmd);
+
+	return err;
+}
-- 
1.7.4.1

