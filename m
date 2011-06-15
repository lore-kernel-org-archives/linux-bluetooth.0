Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH 2/2] Bluetooth: Add blacklisting support for mgmt interface
Date: Wed, 15 Jun 2011 12:01:15 +0300
Message-Id: <1308128475-11670-2-git-send-email-antti.julku@nokia.com>
In-Reply-To: <1308128475-11670-1-git-send-email-antti.julku@nokia.com>
References: <1308128475-11670-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Management interface commands for blocking and unblocking devices.

Signed-off-by: Antti Julku <antti.julku@nokia.com>
---
 include/net/bluetooth/mgmt.h |   10 ++++++
 net/bluetooth/mgmt.c         |   70 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4899286..45bea25 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -199,6 +199,16 @@ struct mgmt_cp_remove_remote_oob_data {
 
 #define MGMT_OP_STOP_DISCOVERY		0x001C
 
+#define MGMT_OP_BLOCK_DEVICE		0x001D
+struct mgmt_cp_block_device {
+	bdaddr_t bdaddr;
+} __packed;
+
+#define MGMT_OP_UNBLOCK_DEVICE		0x001E
+struct mgmt_cp_unblock_device {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d192089..64c0418 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1666,6 +1666,70 @@ failed:
 	return err;
 }
 
+static int block_device(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_block_device *cp;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	cp = (void *) data;
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
+							EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
+							ENODEV);
+
+	err = hci_blacklist_add(hdev, &cp->bdaddr);
+
+	if (err < 0)
+		err = cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE, -err);
+	else
+		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
+							NULL, 0);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
+static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_unblock_device *cp;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	cp = (void *) data;
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
+								EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
+								ENODEV);
+
+	err = hci_blacklist_del(hdev, &cp->bdaddr);
+
+	if (err < 0)
+		err = cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE, -err);
+	else
+		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
+								NULL, 0);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1780,6 +1844,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_STOP_DISCOVERY:
 		err = stop_discovery(sk, index);
 		break;
+	case MGMT_OP_BLOCK_DEVICE:
+		err = block_device(sk, index, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_UNBLOCK_DEVICE:
+		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
-- 
1.7.2.5

