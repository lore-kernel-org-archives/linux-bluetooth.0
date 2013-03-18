Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] Bluetooth: remove __le16_to_cpu() from u8 var
Date: Mon, 18 Mar 2013 14:52:15 -0300
Message-Id: <1363629135-6720-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

We don't any endianness conversion in a single byte variable.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_event.c | 2 +-
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
1.8.1.4

