Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 3/5] Bluetooth: Add enable_le module parameter
Date: Thu, 30 Jun 2011 19:20:54 -0300
Message-Id: <1309472456-24674-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
References: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new module parameter to enable/disable host LE
support. By default host LE support is disabled.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_event.c   |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ed1de1b..5f37822 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -211,6 +211,7 @@ enum {
 #define LMP_EDR_3S_ESCO	0x80
 
 #define LMP_EXT_INQ	0x01
+#define LMP_SIMUL_LE_BR	0x02
 #define LMP_SIMPLE_PAIR	0x08
 #define LMP_NO_FLUSH	0x40
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ed59a8..298cd9b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -45,6 +45,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+static int enable_le;
+
 /* Handle HCI Event packets */
 
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -525,6 +527,20 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
 }
 
+static void hci_set_le_support(struct hci_dev *hdev)
+{
+	struct hci_cp_write_le_host_supported cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	if (enable_le) {
+		cp.le = 1;
+		cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+	}
+
+	hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp), &cp);
+}
+
 static void hci_setup(struct hci_dev *hdev)
 {
 	hci_setup_event_mask(hdev);
@@ -550,6 +566,9 @@ static void hci_setup(struct hci_dev *hdev)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES,
 							sizeof(cp), &cp);
 	}
+
+	if (hdev->features[4] & LMP_LE)
+		hci_set_le_support(hdev);
 }
 
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
@@ -3068,3 +3087,6 @@ void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 	hci_send_to_sock(hdev, skb, NULL);
 	kfree_skb(skb);
 }
+
+module_param(enable_le, bool, 0444);
+MODULE_PARM_DESC(enable_le, "Enable LE support");
-- 
1.7.4.1

