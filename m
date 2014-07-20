Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unneeded variable assignment in hmac_sha256
Date: Sun, 20 Jul 2014 17:43:07 +0200
Message-Id: <1405870987-40038-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The variable ret does not need to be assigned when declaring it. So
remove this initial assignment.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/amp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index e60603a8969f..016cdb66df6c 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -133,8 +133,8 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 /* AMP crypto key generation interface */
 static int hmac_sha256(u8 *key, u8 ksize, char *plaintext, u8 psize, u8 *output)
 {
-	int ret = 0;
 	struct crypto_shash *tfm;
+	int ret;
 
 	if (!ksize)
 		return -EINVAL;
-- 
1.9.3

