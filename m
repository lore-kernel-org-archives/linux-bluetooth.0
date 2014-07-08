Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Use the correct flag to decide to disable advertising
Date: Tue,  8 Jul 2014 15:07:51 +0300
Message-Id: <1404821273-28005-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When deciding to call disable_advertising() we're interested in the real
state instead of the mgmt setting. Use therefore HCI_LE_ADV instead of
the HCI_ADVERTISING flag.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 68c0698124fb..9549d7366da2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1301,7 +1301,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+	if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
 		disable_advertising(&req);
 
 	hci_stop_discovery(&req);
@@ -2230,7 +2230,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		hci_cp.le = val;
 		hci_cp.simul = lmp_le_br_capable(hdev);
 	} else {
-		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+		if (test_bit(HCI_LE_ADV, &hdev->dev_flags))
 			disable_advertising(&req);
 	}
 
-- 
1.9.3

