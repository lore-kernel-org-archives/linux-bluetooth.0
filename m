Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 5/6] Bluetooth: MGMT start discovery LE-Only support
Date: Fri,  3 Feb 2012 17:48:01 -0300
Message-Id: <1328302082-17405-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
References: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds LE-Only discovery procedure support to MGMT Start
Discovery command.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |   13 ++++++++++++-
 net/bluetooth/mgmt.c      |   20 +++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 97152d9..ad5f37b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1033,6 +1033,13 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
 	hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_PARAM, status);
+
+	if (status) {
+		hci_dev_lock(hdev);
+		mgmt_start_discovery_failed(hdev, status);
+		hci_dev_unlock(hdev);
+		return;
+	}
 }
 
 static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
@@ -1051,8 +1058,12 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 	case LE_SCANNING_ENABLED:
 		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
 
-		if (status)
+		if (status) {
+			hci_dev_lock(hdev);
+			mgmt_start_discovery_failed(hdev, status);
+			hci_dev_unlock(hdev);
 			return;
+		}
 
 		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9e5dead..8c9de58 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,6 +35,15 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+/*
+ * These LE scan and inquiry parameters were chosen according to LE General
+ * Discovery Procedure specification.
+ */
+#define LE_SCAN_TYPE			0x01
+#define LE_SCAN_WIN			0x12
+#define LE_SCAN_INT			0x12
+#define LE_SCAN_TIMEOUT_LE_ONLY		10240	/* TGAP(gen_disc_scan_min) */
+
 #define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
 
 #define SERVICE_CACHE_TIMEOUT (5 * 1000)
@@ -1916,6 +1925,7 @@ static int start_discovery(struct sock *sk, u16 index,
 						void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
+	unsigned long discov_type = cp->type;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -1951,7 +1961,15 @@ static int start_discovery(struct sock *sk, u16 index,
 		goto failed;
 	}
 
-	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+	if (test_bit(MGMT_ADDR_BREDR, &discov_type))
+		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+	else if (test_bit(MGMT_ADDR_LE_PUBLIC, &discov_type) &&
+				test_bit(MGMT_ADDR_LE_RANDOM, &discov_type))
+		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
+					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
+	else
+		err = -EINVAL;
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
-- 
1.7.9

