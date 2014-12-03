Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 31/49] Bluetooth: Fix DHKey Check sending order for slave role
Date: Wed,  3 Dec 2014 17:02:25 +0200
Message-Id: <1417618963-18010-32-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

According to the LE SC specification the initiating device sends its
DHKey check first and the non-initiating devices sends its DHKey check
as a response to this. It's also important that the non-initiating
device doesn't send the response if it's still waiting for user input.
In order to synchronize all this a new flag is added.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 60 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7a9b491ffa1a..458d07d5603b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -56,6 +56,7 @@ enum {
 	SMP_FLAG_REMOTE_PK,
 	SMP_FLAG_DEBUG_KEY,
 	SMP_FLAG_WAIT_USER,
+	SMP_FLAG_DHKEY_PENDING,
 };
 
 struct smp_chan {
@@ -994,6 +995,29 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 }
 
+static void sc_add_ltk(struct smp_chan *smp)
+{
+	struct hci_conn *hcon = smp->conn->hcon;
+	u8 key_type, auth;
+
+	if (test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags))
+		key_type = SMP_LTK_P256_DEBUG;
+	else
+		key_type = SMP_LTK_P256;
+
+	if (hcon->pending_sec_level == BT_SECURITY_FIPS)
+		auth = 1;
+	else
+		auth = 0;
+
+	memset(smp->tk + smp->enc_key_size, 0,
+	       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
+
+	smp->ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
+			       key_type, auth, smp->tk, smp->enc_key_size,
+			       0, 0);
+}
+
 static void sc_generate_link_key(struct smp_chan *smp)
 {
 	/* These constants are as specified in the core specification.
@@ -1312,12 +1336,10 @@ static u8 sc_passkey_round(struct smp_chan *smp, u8 smp_op)
 		if (!hcon->out) {
 			smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM,
 				     sizeof(smp->prnd), smp->prnd);
-			if (smp->passkey_round == 20) {
-				sc_dhkey_check(smp);
+			if (smp->passkey_round == 20)
 				SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
-			} else {
+			else
 				SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
-			}
 			return 0;
 		}
 
@@ -1394,7 +1416,14 @@ static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 		return 0;
 	}
 
-	sc_dhkey_check(smp);
+	/* Initiator sends DHKey check first */
+	if (hcon->out) {
+		sc_dhkey_check(smp);
+		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+	} else if (test_and_clear_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags)) {
+		sc_dhkey_check(smp);
+		sc_add_ltk(smp);
+	}
 
 	return 0;
 }
@@ -2262,7 +2291,6 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	u8 a[7], b[7], *local_addr, *remote_addr;
 	u8 io_cap[3], r[16], e[16];
-	u8 key_type, auth;
 	int err;
 
 	BT_DBG("conn %p", conn);
@@ -2298,19 +2326,17 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (memcmp(check->e, e, 16))
 		return SMP_DHKEY_CHECK_FAILED;
 
-	if (test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags))
-		key_type = SMP_LTK_P256_DEBUG;
-	else
-		key_type = SMP_LTK_P256;
+	if (!hcon->out) {
+		if (test_bit(SMP_FLAG_WAIT_USER, &smp->flags)) {
+			set_bit(SMP_FLAG_DHKEY_PENDING, &smp->flags);
+			return 0;
+		}
 
-	if (hcon->pending_sec_level == BT_SECURITY_FIPS)
-		auth = 1;
-	else
-		auth = 0;
+		/* Slave sends DHKey check as response to master */
+		sc_dhkey_check(smp);
+	}
 
-	smp->ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-			       key_type, auth, smp->tk, smp->enc_key_size,
-			       0, 0);
+	sc_add_ltk(smp);
 
 	if (hcon->out) {
 		hci_le_start_enc(hcon, 0, 0, smp->tk);
-- 
2.1.0

