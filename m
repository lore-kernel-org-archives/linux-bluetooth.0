Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 28/49] Bluetooth: Add support for SC just-works pairing
Date: Wed,  3 Dec 2014 17:02:22 +0200
Message-Id: <1417618963-18010-29-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the just-works method was chosen we shouldn't send anything to user
space but simply proceed with sending the DHKey Check PDU. This patch
adds the necessary code for it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8c7862044e44..7fdeca7edb7c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1198,22 +1198,13 @@ static int sc_mackey_and_ltk(struct smp_chan *smp, u8 mackey[16], u8 ltk[16])
 	return smp_f5(smp->tfm_cmac, smp->dhkey, na, nb, a, b, mackey, ltk);
 }
 
-static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
+static void sc_dhkey_check(struct smp_chan *smp, __le32 passkey)
 {
 	struct hci_conn *hcon = smp->conn->hcon;
 	struct smp_cmd_dhkey_check check;
 	u8 a[7], b[7], *local_addr, *remote_addr;
 	u8 io_cap[3], r[16];
 
-	switch (mgmt_op) {
-	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
-		smp_failure(smp->conn, SMP_PASSKEY_ENTRY_FAILED);
-		return 0;
-	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		smp_failure(smp->conn, SMP_NUMERIC_COMP_FAILED);
-		return 0;
-	}
-
 	memcpy(a, &hcon->init_addr, 6);
 	memcpy(b, &hcon->resp_addr, 6);
 	a[6] = hcon->init_addr_type;
@@ -1229,13 +1220,29 @@ static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
 		memcpy(io_cap, &smp->prsp[1], 3);
 	}
 
-	memcpy(r, &passkey, sizeof(passkey));
-	memset(r + sizeof(passkey), 0, sizeof(r) - sizeof(passkey));
+	memset(r, 0, sizeof(r));
+
+	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
+		memcpy(r, &passkey, sizeof(passkey));
 
 	smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
 	       local_addr, remote_addr, check.e);
 
 	smp_send_cmd(smp->conn, SMP_CMD_DHKEY_CHECK, sizeof(check), &check);
+}
+
+static int sc_user_reply(struct smp_chan *smp, u16 mgmt_op, __le32 passkey)
+{
+	switch (mgmt_op) {
+	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
+		smp_failure(smp->conn, SMP_PASSKEY_ENTRY_FAILED);
+		return 0;
+	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
+		smp_failure(smp->conn, SMP_NUMERIC_COMP_FAILED);
+		return 0;
+	}
+
+	sc_dhkey_check(smp, passkey);
 
 	return 0;
 }
@@ -1599,6 +1606,14 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (err)
 		return SMP_UNSPECIFIED;
 
+	if (smp->method == JUST_WORKS) {
+		if (hcon->out) {
+			sc_dhkey_check(smp, passkey);
+			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
+		}
+		return 0;
+	}
+
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
 					hcon->type, hcon->dst_type,
 					passkey, 0);
-- 
2.1.0

