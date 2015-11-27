Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 3/5] Bluetooth: hci_intel: Add status parameter to inject_cmd_complete
Date: Fri, 27 Nov 2015 19:56:01 +0100
Message-Id: <1448650563-9075-3-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
References: <1448650563-9075-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add possibility to pass a status/error code to the injected command
complete event.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 2dcf9b0..98beacb 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -447,7 +447,7 @@ static int intel_flush(struct hci_uart *hu)
 	return 0;
 }
 
-static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
+static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode, __u8 status)
 {
 	struct sk_buff *skb;
 	struct hci_event_hdr *hdr;
@@ -465,7 +465,7 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	evt->ncmd = 0x01;
 	evt->opcode = cpu_to_le16(opcode);
 
-	*skb_put(skb, 1) = 0x00;
+	*skb_put(skb, 1) = status;
 
 	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
 
@@ -1150,7 +1150,7 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
 		 * control working inject that event here.
 		 */
 		if (opcode == 0xfc01)
-			inject_cmd_complete(hu->hdev, opcode);
+			inject_cmd_complete(hu->hdev, opcode, 0x00);
 	}
 
 	/* Prepend skb with frame type */
-- 
1.9.1
