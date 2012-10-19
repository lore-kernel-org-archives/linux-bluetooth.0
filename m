Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Remove unnecessary LE init req from HCI core
Date: Fri, 19 Oct 2012 20:15:06 +0300
Message-Id: <1350666911-6334-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The necessary LE commands will be sent through hci_event.c when the
local supported features indicates LE support.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0ec776a..23359ef 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -273,14 +273,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	}
 }
 
-static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
-{
-	BT_DBG("%s", hdev->name);
-
-	/* Read LE buffer size */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
-}
-
 static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
 {
 	__u8 scan = opt;
@@ -687,10 +679,6 @@ int hci_dev_open(__u16 dev)
 
 		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
 
-		if (lmp_host_le_capable(hdev))
-			ret = __hci_request(hdev, hci_le_init_req, 0,
-					    HCI_INIT_TIMEOUT);
-
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-- 
1.7.10.4

