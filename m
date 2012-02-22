Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Remove unneeded hci_cc_read_ssp_mode function
Date: Wed, 22 Feb 2012 13:12:51 +0200
Message-Id: <1329909172-19958-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
References: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The kernel has no need to track the hci_read_ssp_mode command since it
has the hci_sent_cmd_data function to check what value was set when
hci_write_ssp_mode completes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5fb1ee5..1b1c348 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -420,21 +420,6 @@ static void hci_cc_host_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_HOST_BUFFER_SIZE, status);
 }
 
-static void hci_cc_read_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_rp_read_ssp_mode *rp = (void *) skb->data;
-
-	BT_DBG("%s status 0x%x", hdev->name, rp->status);
-
-	if (rp->status)
-		return;
-
-	if (rp->mode)
-		set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
-	else
-		clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
-}
-
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2201,10 +2186,6 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_host_buffer_size(hdev, skb);
 		break;
 
-	case HCI_OP_READ_SSP_MODE:
-		hci_cc_read_ssp_mode(hdev, skb);
-		break;
-
 	case HCI_OP_WRITE_SSP_MODE:
 		hci_cc_write_ssp_mode(hdev, skb);
 		break;
-- 
1.7.9

