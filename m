Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix expected key count debug logs
Date: Fri,  7 Mar 2014 15:04:13 +0200
Message-Id: <1394197453-7912-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The debug logs for reporting a discrepancy between the expected amount
of keys and the actually received amount of keys got these value mixed
up. This patch fixes the issue.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 98e9df3556e7..f2397e7ad385 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2351,7 +2351,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 					sizeof(struct mgmt_link_key_info);
 	if (expected_len != len) {
 		BT_ERR("load_link_keys: expected %u bytes, got %u bytes",
-		       len, expected_len);
+		       expected_len, len);
 		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
 				  MGMT_STATUS_INVALID_PARAMS);
 	}
@@ -4427,7 +4427,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	expected_len = sizeof(*cp) + irk_count * sizeof(struct mgmt_irk_info);
 	if (expected_len != len) {
 		BT_ERR("load_irks: expected %u bytes, got %u bytes",
-		       len, expected_len);
+		       expected_len, len);
 		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
 				  MGMT_STATUS_INVALID_PARAMS);
 	}
@@ -4507,7 +4507,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 					sizeof(struct mgmt_ltk_info);
 	if (expected_len != len) {
 		BT_ERR("load_keys: expected %u bytes, got %u bytes",
-		       len, expected_len);
+		       expected_len, len);
 		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
 				  MGMT_STATUS_INVALID_PARAMS);
 	}
-- 
1.8.5.3

