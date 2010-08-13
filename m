Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH] Bluetooth: Implement LE Set Advertise Enable cmd
Date: Fri, 13 Aug 2010 17:01:28 -0400
Message-Id: <1281733288-11184-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements LE Set Advertise Enable command for dual mode and
Low Energy hci controllers.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/hci.h |    7 +++++++
 net/bluetooth/hci_core.c    |   15 +++++++++++++++
 net/bluetooth/hci_event.c   |   27 +++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c    |    1 +
 4 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bcbdd6d..1713849 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -76,6 +76,7 @@ enum {
 	HCI_INQUIRY,
 
 	HCI_RAW,
+	HCI_LE_ADV,
 };
 
 /* HCI ioctl defines */
@@ -104,6 +105,7 @@ enum {
 #define HCIUNBLOCKADDR	_IOW('H', 231, int)
 
 #define HCIINQUIRY	_IOR('H', 240, int)
+#define HCILESETADV	_IOR('H', 241, int)
 
 /* HCI timeouts */
 #define HCI_CONNECT_TIMEOUT	(40000)	/* 40 seconds */
@@ -593,6 +595,11 @@ struct hci_rp_read_bd_addr {
 	bdaddr_t bdaddr;
 } __packed;
 
+/* --- HCI LE Commands --- */
+#define HCI_OP_LE_SET_ADVERTISE_ENABLE	0x200a
+	#define ADVERTISE_ENABLED	0x01
+	#define ADVERTISE_DISABLED	0x00
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c52f091..2bdb954 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -294,6 +294,16 @@ static void hci_linkpol_req(struct hci_dev *hdev, unsigned long opt)
 	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
 }
 
+static void hci_le_advertise_req(struct hci_dev *hdev, unsigned long opt)
+{
+	__u8 leadv = opt;
+
+	BT_DBG("%s %x", hdev->name, leadv);
+
+	/* LE Advertising mode */
+	hci_send_cmd(hdev, HCI_OP_LE_SET_ADVERTISE_ENABLE, 1, &leadv);
+}
+
 /* Get HCI device by index.
  * Device is held on return. */
 struct hci_dev *hci_dev_get(int index)
@@ -739,6 +749,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		hdev->sco_pkts = *((__u16 *) &dr.dev_opt + 0);
 		break;
 
+	case HCILESETADV:
+		err = hci_request(hdev, hci_le_advertise_req, dr.dev_opt,
+					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+		break;
+
 	default:
 		err = -EINVAL;
 		break;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bfef5ba..c86c655 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -822,6 +822,29 @@ static void hci_cs_exit_sniff_mode(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_set_advertise(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+	void *sent;
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_ADVERTISE_ENABLE);
+	if (!sent)
+		return;
+
+	if (!status) {
+		__u8 param = *((__u8 *) sent);
+
+		clear_bit(HCI_LE_ADV, &hdev->flags);
+
+		if (param & ADVERTISE_ENABLED)
+			set_bit(HCI_LE_ADV, &hdev->flags);
+	}
+
+	hci_req_complete(hdev, status);
+}
+
 static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -1310,6 +1333,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_LE_SET_ADVERTISE_ENABLE:
+		hci_cc_le_set_advertise(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 83acd16..0286d32 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -335,6 +335,7 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long a
 	case HCISETLINKMODE:
 	case HCISETACLMTU:
 	case HCISETSCOMTU:
+	case HCILESETADV:
 		if (!capable(CAP_NET_ADMIN))
 			return -EACCES;
 		return hci_dev_cmd(cmd, argp);
-- 
1.7.0.4

