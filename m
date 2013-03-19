Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix bogus __le16_to_cpu call
Date: Tue, 19 Mar 2013 09:37:14 +0200
Message-Id: <1363678634-15338-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The type member of struct hci_rp_read_page_scan_type is u8 so no
byte order conversion is necessary for it. This patch removes a bogus
call to __le16_to_cpu on it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8a1f511..1385807 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -641,7 +641,7 @@ static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (test_bit(HCI_INIT, &hdev->flags) && !rp->status)
-		hdev->page_scan_type = __le16_to_cpu(rp->type);
+		hdev->page_scan_type = rp->type;
 }
 
 static void hci_cc_write_page_scan_type(struct hci_dev *hdev,
-- 
1.7.10.4

