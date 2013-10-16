Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] Bluetooth: Rename create_ad into create_adv_data
Date: Wed, 16 Oct 2013 00:16:46 -0700
Message-Id: <1381907811-33872-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rename the create_ad function into create_adv_data to make it clear
that it is used to create the advertising data. This is important
since later on a function adding the scan response data will be
added.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 90d9353..54f1454 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -536,7 +536,7 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
-static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
+static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
 	size_t name_len;
@@ -605,7 +605,7 @@ static void update_ad(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	len = create_ad(hdev, cp.data);
+	len = create_adv_data(hdev, cp.data);
 
 	if (hdev->adv_data_len == len &&
 	    memcmp(cp.data, hdev->adv_data, len) == 0)
-- 
1.8.3.1

