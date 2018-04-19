Return-Path: <cmcvista@gmail.com>
From: Chriz Chow <cmcvista@gmail.com>
To: marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: Chriz Chow <chriz.chow@aminocom.com>
Subject: [PATCH] Bluetooth: Prevent buffer overflow for large advertisement data
Date: Thu, 19 Apr 2018 19:03:09 +0800
Message-Id: <1524135789-25968-1-git-send-email-chriz.chow@aminocom.com>
List-ID: <linux-bluetooth.vger.kernel.org>

In the Bluetooth Core Specifications 5.0 it has no limitation of
the length of Advertising or Scan Response Data. Therefore,
there are some devices sending out advertising data longer than
HCI_MAX_AD_LENGTH, causing the buffer last_adv_data overflows.

It prevents the issue by checking the data length before copying.

Signed-off-by: Chriz Chow <chriz.chow@aminocom.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 139707c..1300bb0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1118,6 +1118,9 @@ static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct discovery_state *d = &hdev->discovery;
 
+	if (len > HCI_MAX_AD_LENGTH)
+		return;
+
 	bacpy(&d->last_adv_addr, bdaddr);
 	d->last_adv_addr_type = bdaddr_type;
 	d->last_adv_rssi = rssi;
-- 
2.7.4
