Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Fix setting host feature bits for SSP
Date: Thu, 25 Oct 2012 00:09:51 +0300
Message-Id: <1351112996-9597-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we get a successful command complete for HCI_Write_SSP_Mode we need
to update the host feature bits for the hdev struct accordingly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aae8053..dc60d31 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -440,7 +440,7 @@ static void hci_cc_host_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
-	void *sent;
+	struct hci_cp_write_ssp_mode *sent;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
@@ -448,10 +448,17 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!sent)
 		return;
 
+	if (!status) {
+		if (sent->mode)
+			hdev->host_features[0] |= LMP_HOST_SSP;
+		else
+			hdev->host_features[0] &= ~LMP_HOST_SSP;
+	}
+
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		mgmt_ssp_enable_complete(hdev, *((u8 *) sent), status);
+		mgmt_ssp_enable_complete(hdev, sent->mode, status);
 	else if (!status) {
-		if (*((u8 *) sent))
+		if (sent->mode)
 			set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 		else
 			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
-- 
1.7.10.4

