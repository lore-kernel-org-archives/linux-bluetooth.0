Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix error handling in the function hci_inquiry_cache_update
Date: Wed, 19 Aug 2015 12:36:30 -0400
Message-Id: <1440002190-24683-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error handling in the function hci_inquiry_cache_update
for checking if the call to the function hci_remove_oob_data has
failed by returning the error code -ENOENT and if so exit immediately
to the caller of the function hci_inquiry_cache_update by returning
the error code -ENOENT to signal that the call to this function has
failed.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2f8fb33..ae1bb3d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1136,7 +1136,8 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 	BT_DBG("cache %p, %pMR", cache, &data->bdaddr);
 
-	hci_remove_remote_oob_data(hdev, &data->bdaddr, BDADDR_BREDR);
+	if (hci_remove_remote_oob_data(hdev, &data->bdaddr, BDADDR_BREDR))
+		return -ENOENT;
 
 	if (!data->ssp_mode)
 		flags |= MGMT_DEV_FOUND_LEGACY_PAIRING;
-- 
2.1.4
