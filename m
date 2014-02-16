Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Restrict long term keys to public and static addresses
Date: Sun, 16 Feb 2014 12:59:05 -0800
Message-Id: <1392584346-64921-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The long term keys should be associated with an identity address. Valid
identity addresses are public addresses or static addresses. So only
allow these two as valid address information for long term keys.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ce7ef339b1c4..70bef3d5db57 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4162,9 +4162,19 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
 	if (key->master != 0x00 && key->master != 0x01)
 		return false;
-	if (!bdaddr_type_is_le(key->addr.type))
-		return false;
-	return true;
+
+	switch (key->addr.type) {
+	case BDADDR_LE_PUBLIC:
+		return true;
+
+	case BDADDR_LE_RANDOM:
+		/* Two most significant bits shall be set */
+		if ((key->addr.bdaddr.b[5] & 0xc0) != 0xc0)
+			return false;
+		return true;
+	}
+
+	return false;
 }
 
 static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
-- 
1.8.5.3

