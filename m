Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 7/8] Bluetooth: Update supported_flags for AD features
Date: Wed, 25 Mar 2015 18:53:45 -0700
Message-Id: <1427334826-14858-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1427334826-14858-1-git-send-email-armansito@chromium.org>
References: <1427334826-14858-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the "supported_flags" parameter returned from the
"Read Advertising Features" command. Add Advertising will now return
an error if an unsupported flag is provided.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fd41b20..71d4130 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6540,6 +6540,21 @@ done:
 	return err;
 }
 
+static u32 get_supported_adv_flags(struct hci_dev *hdev)
+{
+	u32 flags = 0;
+
+	flags |= MGMT_ADV_FLAG_CONNECTABLE;
+	flags |= MGMT_ADV_FLAG_DISCOV;
+	flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
+	flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
+
+	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID)
+		flags |= MGMT_ADV_FLAG_TX_POWER;
+
+	return flags;
+}
+
 static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 			     void *data, u16 data_len)
 {
@@ -6547,9 +6562,14 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	size_t rp_len;
 	int err;
 	bool instance;
+	u32 supported_flags;
 
 	BT_DBG("%s", hdev->name);
 
+	if (!lmp_le_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_ADV_FEATURES,
+				       MGMT_STATUS_REJECTED);
+
 	hci_dev_lock(hdev);
 
 	rp_len = sizeof(*rp);
@@ -6567,7 +6587,9 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 		return -ENOMEM;
 	}
 
-	rp->supported_flags = cpu_to_le32(0);
+	supported_flags = get_supported_adv_flags(hdev);
+
+	rp->supported_flags = cpu_to_le32(supported_flags);
 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
 	rp->max_instances = 1;
@@ -6689,6 +6711,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_cp_add_advertising *cp = data;
 	struct mgmt_rp_add_advertising rp;
 	u32 flags;
+	u32 supported_flags;
 	u8 status;
 	u16 timeout;
 	int err;
@@ -6705,8 +6728,11 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	flags = __le32_to_cpu(cp->flags);
 	timeout = __le16_to_cpu(cp->timeout);
 
-	/* The current implementation only supports adding one instance */
-	if (cp->instance != 0x01)
+	/* The current implementation only supports adding one instance and only
+	 * a subset of the specified flags.
+	 */
+	supported_flags = get_supported_adv_flags(hdev);
+	if (cp->instance != 0x01 || (flags & ~supported_flags))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-- 
2.2.0.rc0.207.ga3a616c

