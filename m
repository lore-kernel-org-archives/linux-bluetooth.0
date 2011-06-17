Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
Date: Fri, 17 Jun 2011 12:43:48 +0300
Message-Id: <1308303828-1982-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add command to management interface for enabling/disabling the
fast connectable mode.

Signed-off-by: Antti Julku <antti.julku@nokia.com>
---
 include/net/bluetooth/hci.h  |   10 +++++++
 include/net/bluetooth/mgmt.h |    5 +++
 net/bluetooth/mgmt.c         |   62 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 65345cd..d7b9600 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -698,6 +698,16 @@ struct hci_rp_read_bd_addr {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY	0x0c1c
+struct hci_cp_write_page_scan_activity {
+	__le16   interval;
+	__le16   window;
+} __packed;
+
+#define HCI_OP_WRITE_PAGE_SCAN_TYPE	0x0c47
+	#define PAGE_SCAN_TYPE_STANDARD		0x00
+	#define PAGE_SCAN_TYPE_INTERLACED	0x01
+
 #define HCI_OP_LE_SET_EVENT_MASK	0x2001
 struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 45bea25..7196d04 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -209,6 +209,11 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_SET_FAST_CONNECTABLE	0x001F
+struct mgmt_cp_set_fast_connectable {
+	__u8 enable;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 64c0418..b4bed16 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1730,6 +1730,64 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
+static int set_fast_connectable(struct sock *sk, u16 index,
+					unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_set_fast_connectable *cp;
+	struct hci_cp_write_page_scan_activity acp;
+	u8 type;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	cp = (void *) data;
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+								EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+								ENODEV);
+
+	hci_dev_lock(hdev);
+
+	if (cp->enable) {
+		type = PAGE_SCAN_TYPE_INTERLACED;
+		acp.interval = 0x0024;	/* 22.5 msec page scan interval */
+	} else {
+		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
+		acp.interval = 0x0800;	/* default 1.28 sec page scan */
+	}
+
+	acp.window = 0x0012;	/* default 11.25 msec page scan window */
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY,
+						sizeof(acp), &acp);
+	if (err < 0) {
+		err = cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+								-err);
+		goto failed;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
+	if (err < 0) {
+		err = cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+								-err);
+		goto failed;
+	}
+
+	err = cmd_complete(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+							NULL, 0);
+failed:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1850,6 +1908,10 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_SET_FAST_CONNECTABLE:
+		err = set_fast_connectable(sk, index, buf + sizeof(*hdr),
+								len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
-- 
1.7.2.5

