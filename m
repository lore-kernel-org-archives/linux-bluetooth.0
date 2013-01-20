Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10 v2] Bluetooth: Fix checking for correct mgmt_load_link_keys parameters
Date: Sun, 20 Jan 2013 14:27:13 +0200
Message-Id: <1358684842-4441-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
References: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The debug_keys parameter is only allowed to have the values 0x00 and
0x01. Any other value should result in a proper command status with
MGMT_STATUS_INVALID_PARAMS.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 36b2310..d9b042e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1519,6 +1519,10 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 				  MGMT_STATUS_INVALID_PARAMS);
 	}
 
+	if (cp->debug_keys != 0x00 && cp->debug_keys != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	BT_DBG("%s debug_keys %u key_count %u", hdev->name, cp->debug_keys,
 	       key_count);
 
-- 
1.7.10.4

