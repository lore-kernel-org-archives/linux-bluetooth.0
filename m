Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 23/26] Bluetooth: Fix updating page scan parameters when not necessary
Date: Fri, 15 Mar 2013 17:07:13 -0500
Message-Id: <1363385236-25704-24-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the current page scan parameters are stored in struct hci_dev
we should check against those values before sending new HCI commands to
change them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 98f6295..7783b8d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1002,6 +1002,7 @@ failed:
 
 static void write_fast_connectable(struct hci_request *req, bool enable)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_write_page_scan_activity acp;
 	u8 type;
 
@@ -1019,8 +1020,13 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 
 	acp.window = __constant_cpu_to_le16(0x0012);
 
-	hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY, sizeof(acp), &acp);
-	hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
+	if (__cpu_to_le16(hdev->page_scan_interval) != acp.interval ||
+	    __cpu_to_le16(hdev->page_scan_window) != acp.window)
+		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY,
+			    sizeof(acp), &acp);
+
+	if (hdev->page_scan_type != type)
+		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
 static void set_connectable_complete(struct hci_dev *hdev, u8 status)
-- 
1.7.10.4

