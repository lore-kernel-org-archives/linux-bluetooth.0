Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [RFC 4/4] Bluetooth: Ignore inquiry results from periodic inquiry
Date: Mon, 19 Mar 2012 23:32:52 -0300
Message-Id: <1332210772-13806-5-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
References: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes inquiry result function handlers so they ignore
inquiry result events if periodic inquiry is enabled.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/hci_event.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4d13843..f1b9f2e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1723,6 +1723,9 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 	if (!num_rsp)
 		return;
 
+	if (test_bit(HCI_PINQUIRY, &hdev->dev_flags))
+		return;
+
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
@@ -2824,6 +2827,9 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 	if (!num_rsp)
 		return;
 
+	if (test_bit(HCI_PINQUIRY, &hdev->dev_flags))
+		return;
+
 	hci_dev_lock(hdev);
 
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
@@ -2995,6 +3001,9 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	if (!num_rsp)
 		return;
 
+	if (test_bit(HCI_PINQUIRY, &hdev->dev_flags))
+		return;
+
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
-- 
1.7.9.4

