Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10 v2] Bluetooth: Fix returning proper mgmt status for Load LTKs
Date: Sun, 20 Jan 2013 14:27:14 +0200
Message-Id: <1358684842-4441-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
References: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Failures of mgmt commands should be indicated with valid mgmt status
codes, and EINVAL is not one of them. Instead MGMT_STATUS_INVALID_PARAMS
should be returned.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d9b042e..a050eee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2716,7 +2716,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		BT_ERR("load_keys: expected %u bytes, got %u bytes",
 		       len, expected_len);
 		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
-				  EINVAL);
+				  MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	BT_DBG("%s key_count %u", hdev->name, key_count);
-- 
1.7.10.4

