Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/12] Bluetooth: Add discovery type validity helper
Date: Tue, 10 Nov 2015 20:14:31 +0200
Message-Id: <1447179274-12276-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

As preparation for moving the discovery HCI commands behind
req_workqueue, add a helper and do the validity checks of the given
discovery type before proceeding further. This way we don't need to do
them again in hci_request.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2594f551ef9d..9d98be5c9604 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4375,6 +4375,33 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static bool discovery_type_is_valid(struct hci_dev *hdev, uint8_t type,
+				    uint8_t *mgmt_status)
+{
+	switch (type) {
+	case DISCOV_TYPE_LE:
+		*mgmt_status = mgmt_le_support(hdev);
+		if (*mgmt_status)
+			return false;
+		break;
+	case DISCOV_TYPE_INTERLEAVED:
+		*mgmt_status = mgmt_le_support(hdev);
+		if (*mgmt_status)
+			return false;
+		/* Intentional fall-through */
+	case DISCOV_TYPE_BREDR:
+		*mgmt_status = mgmt_bredr_support(hdev);
+		if (*mgmt_status)
+			return false;
+		break;
+	default:
+		*mgmt_status = MGMT_STATUS_INVALID_PARAMS;
+		return false;
+	}
+
+	return true;
+}
+
 static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
@@ -4403,6 +4430,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (!discovery_type_is_valid(hdev, cp->type, &status)) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					status, &cp->type, sizeof(cp->type));
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -4502,6 +4535,13 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (!discovery_type_is_valid(hdev, cp->type, &status)) {
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					status, &cp->type, sizeof(cp->type));
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
 			       hdev, data, len);
 	if (!cmd) {
-- 
2.5.0

