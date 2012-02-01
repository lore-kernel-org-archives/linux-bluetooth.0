Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/6] Bluetooth: MGMT start discovery LE-Only support
Date: Wed,  1 Feb 2012 19:34:51 -0300
Message-Id: <1328135692-24255-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
References: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds LE-Only discovery procedure support to MGMT Start
Discovery command.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |   13 ++++++++++++-
 net/bluetooth/mgmt.c      |   20 +++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bcfeca..448c7af 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1032,6 +1032,13 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1050,8 +1057,12 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
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
index 8970799..0a1fa4c 100644
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
@@ -1897,6 +1906,7 @@ static int start_discovery(struct sock *sk, u16 index,
 						unsigned char *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = (void *) data;
+	unsigned long discov_type = cp->type;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -1932,7 +1942,15 @@ static int start_discovery(struct sock *sk, u16 index,
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

