Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove redundant check for ACL_LINK
Date: Fri, 12 Jun 2015 13:04:47 +0300
Message-Id: <1434103487-9296-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The encryption key size is read only for BR/EDR (ACL_LINK) connections
so there's no need to check for it in the read_enc_key_size_complete()
callback.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 88c57b12a222..32363c2b7f83 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2648,8 +2648,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 
 		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 			encrypt = 0x00;
-		else if (conn->type == ACL_LINK &&
-			 test_bit(HCI_CONN_AES_CCM, &conn->flags))
+		else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
 			encrypt = 0x02;
 		else
 			encrypt = 0x01;
-- 
2.4.3

