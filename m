Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 7/8] Bluetooth: Update supported_flags for AD features
Date: Wed, 25 Mar 2015 18:14:15 -0700
Message-Id: <1427332456-7148-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1427332456-7148-1-git-send-email-armansito@chromium.org>
References: <1427332456-7148-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the "supported_flags" parameter returned from the
"Read Advertising Features" command. Add Advertising will now return
an error if an unsupported flag is provided.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4a5d2fb..4d9d467 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6542,6 +6542,15 @@ done:
 	return err;
 }
 
+static u32 get_supported_adv_flags(void)
+{
+	return MGMT_ADV_FLAG_CONNECTABLE |
+		MGMT_ADV_FLAG_DISCOV |
+		MGMT_ADV_FLAG_LIMITED_DISCOV |
+		MGMT_ADV_FLAG_MANAGED_FLAGS |
+		MGMT_ADV_FLAG_TX_POWER;
+}
+
 static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 			     void *data, u16 data_len)
 {
@@ -6569,7 +6578,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 		return -ENOMEM;
 	}
 
-	rp->supported_flags = cpu_to_le32(0);
+	rp->supported_flags = cpu_to_le32(get_supported_adv_flags());
 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
 	rp->max_instances = 1;
@@ -6707,8 +6716,10 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	flags = __le32_to_cpu(cp->flags);
 	timeout = __le16_to_cpu(cp->timeout);
 
-	/* The current implementation only supports adding one instance */
-	if (cp->instance != 0x01)
+	/* The current implementation only supports adding one instance and only
+	 * a subset of the specified flags.
+	 */
+	if (cp->instance != 0x01 || (flags & ~get_supported_adv_flags()))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-- 
2.2.0.rc0.207.ga3a616c

