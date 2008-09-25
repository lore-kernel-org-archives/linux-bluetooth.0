Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 1/1] [BLUETOOTH] Disable incoming connection tracking in DUT mode
Date: Thu, 25 Sep 2008 10:59:01 +0300
Message-Id: <1222329541-4898-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth testers establish only low level connection and they won't
connect to any service. If connection tracking is enabled the connection
will drop in 10 seconds. This patch adds support for detecting DUT mode
event and disables incoming connection tracking is status code was
succesfull.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/hci.h      |    7 +++++++
 include/net/bluetooth/hci_core.h |    3 +++
 net/bluetooth/hci_event.c        |   12 ++++++++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3cc2949..1279788 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -72,6 +72,8 @@ enum {
 	HCI_INQUIRY,
 
 	HCI_RAW,
+
+	HCI_DUT_MODE,
 };
 
 /* HCI ioctl defines */
@@ -577,6 +579,11 @@ struct hci_rp_read_bd_addr {
 	bdaddr_t bdaddr;
 } __attribute__ ((packed));
 
+#define HCI_OP_ENABLE_DUT_MODE		0x1803
+struct hci_rp_enable_dut_mode {
+	__u8	status;
+} __attribute__ ((packed));
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 46a43b7..019cd93 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -355,6 +355,9 @@ static inline void hci_conn_put(struct hci_conn *conn)
 				timeo = msecs_to_jiffies(10);
 		} else
 			timeo = msecs_to_jiffies(10);
+
+		if (test_bit(HCI_DUT_MODE, &conn->hdev->flags) && !conn->out)
+			return;
 		mod_timer(&conn->disc_timer, jiffies + timeo);
 	}
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ad7a553..f2227d0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -535,6 +535,14 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, rp->status);
 }
 
+static void hci_cc_enable_dut_mode(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_enable_dut_mode *rp = (void *) skb->data;
+
+	if (!rp->status)
+		set_bit(HCI_DUT_MODE, &hdev->flags);
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1294,6 +1302,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_read_bd_addr(hdev, skb);
 		break;
 
+	case HCI_OP_ENABLE_DUT_MODE:
+		hci_cc_enable_dut_mode(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
-- 
1.5.6.3

