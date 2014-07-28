Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] Bluetooth: Fix incorrectly disabling page scan when toggling connectable
Date: Mon, 28 Jul 2014 15:10:16 +0300
Message-Id: <1406549416-9229-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1406549416-9229-1-git-send-email-johan.hedberg@gmail.com>
References: <1406549416-9229-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have entries in the whitelist we shouldn't disable page scanning
when disabling connectable mode. This patch adds the necessary check to
the Set Connectable command handler.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4d96913484cd..b2741db957f6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1881,7 +1881,12 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (cp->val) {
 			scan = SCAN_PAGE;
 		} else {
-			scan = 0;
+			if (list_empty(&hdev->whitelist))
+				scan = SCAN_DISABLED;
+			else if (test_bit(HCI_ISCAN, &hdev->flags))
+				scan = SCAN_PAGE;
+			else
+				goto no_scan_update;
 
 			if (test_bit(HCI_ISCAN, &hdev->flags) &&
 			    hdev->discov_timeout > 0)
@@ -1891,6 +1896,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
+no_scan_update:
 	/* If we're going from non-connectable to connectable or
 	 * vice-versa when fast connectable is enabled ensure that fast
 	 * connectable gets disabled. write_fast_connectable won't do
-- 
1.9.3

