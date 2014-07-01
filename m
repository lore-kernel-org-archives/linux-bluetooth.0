Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use bool for smp_ltk_encrypt return value
Date: Tue,  1 Jul 2014 10:59:24 +0200
Message-Id: <1404205164-46988-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of smp_ltk_encrypt is simple boolean, so just use
bool and make the code a bit more readable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 414c5151aa46..35f57090ddd0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -837,7 +837,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	return smp_random(smp);
 }
 
-static u8 smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
+static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 {
 	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
@@ -845,18 +845,18 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	key = hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
 				   hcon->out);
 	if (!key)
-		return 0;
+		return false;
 
 	if (sec_level > BT_SECURITY_MEDIUM && !key->authenticated)
-		return 0;
+		return false;
 
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
-		return 1;
+		return true;
 
 	hci_le_start_enc(hcon, key->ediv, key->rand, key->val);
 	hcon->enc_key_size = key->enc_size;
 
-	return 1;
+	return true;
 }
 
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
-- 
1.9.3

