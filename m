Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix re-setting RPA as expired when deferring update
Date: Fri, 12 Sep 2014 09:31:52 -0700
Message-Id: <1410539512-3473-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_update_random_address will clear the RPA_EXPIRED flag and
proceed with setting a new one if the flag was set. However, the
set_random_addr() function that is called may choose to defer the update
to a later moment. In such a case the flag would incorrectly remain
unset unless set_random_addr() re-sets it. This patch fixes the issue.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0d3782ad9a5b..067526d9680d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3872,6 +3872,7 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	if (test_bit(HCI_LE_ADV, &hdev->dev_flags) ||
 	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
 		BT_DBG("Deferring random address update");
+		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
 		return;
 	}
 
-- 
1.9.3

