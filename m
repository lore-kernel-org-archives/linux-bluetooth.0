Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 1/2] Bluetooth: Add basic discovery commands to the management interface
Date: Thu, 21 Apr 2011 20:00:29 -0400
Message-Id: <4db0c543.0f44970a.646e.62f6@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds start_discovery and stop_discovery commands to the
management interface. Right now their implementation is fairly
simplistic and the parameters are fixed to what user space has
defaulted to so far.
This is the very initial phase for discovery implementation into
the kernel. Next steps include name resolution, LE scanning and
bdaddr type handling.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/mgmt.h |    4 ++
 net/bluetooth/mgmt.c         |   76 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 6b6ff92..be93dd0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -195,6 +195,10 @@ struct mgmt_cp_remove_remote_oob_data {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_START_DISCOVERY		0x001B
+
+#define MGMT_OP_STOP_DISCOVERY		0x001C
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c304688..dbc248f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1569,6 +1569,75 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 	return err;
 }
 
+static int start_discovery(struct sock *sk, u16 index)
+{
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	struct hci_cp_inquiry cp;
+	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, index, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.lap, lap, 3);
+	cp.length  = 0x08;
+	cp.num_rsp = 0x00;
+
+	err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+failed:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
+static int stop_discovery(struct sock *sk, u16 index)
+{
+	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, index, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+failed:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1677,7 +1746,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = remove_remote_oob_data(sk, index, buf + sizeof(*hdr),
 									len);
 		break;
-
+	case MGMT_OP_START_DISCOVERY:
+		err = start_discovery(sk, index);
+		break;
+	case MGMT_OP_STOP_DISCOVERY:
+		err = stop_discovery(sk, index);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
-- 
1.7.1

