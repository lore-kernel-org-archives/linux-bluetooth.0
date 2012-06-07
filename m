Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix SMP security elevation from medium to high
Date: Thu,  7 Jun 2012 14:58:37 +0800
Message-Id: <1339052318-11423-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1339052318-11423-1-git-send-email-johan.hedberg@gmail.com>
References: <1339052318-11423-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have an unauthenticated key it is not sufficient to acheive high
security. Therefore, when deciding whether to encrypt the link or
request pairing, it is essential to in addition to checking the
existence of a key to also check whether it is authenticated or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1885697..16ef0dc 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -704,7 +704,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
-static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
+static u8 smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 {
 	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
@@ -713,6 +713,9 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 	if (!key)
 		return 0;
 
+	if (sec_level > BT_SECURITY_MEDIUM && !key->authenticated)
+		return 0;
+
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
 		return 1;
 
@@ -733,7 +736,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	hcon->pending_sec_level = authreq_to_seclevel(rp->auth_req);
 
-	if (smp_ltk_encrypt(conn))
+	if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 		return 0;
 
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
@@ -772,7 +775,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		return 1;
 
 	if (hcon->link_mode & HCI_LM_MASTER)
-		if (smp_ltk_encrypt(conn))
+		if (smp_ltk_encrypt(conn, sec_level))
 			goto done;
 
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
-- 
1.7.10

