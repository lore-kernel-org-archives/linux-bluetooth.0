Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add workaround for broken OS X legacy SMP pairing
Date: Sun, 15 Mar 2015 19:34:04 +0200
Message-Id: <1426440844-11908-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

OS X version 10.10.2 (and possibly older versions) doesn't support LE
Secure Connections but incorrectly copies all authentication request
bits from a Security Request to its Pairing Request. The result is that
an SC capable initiator (such as BlueZ) will think OS X intends to do SC
when in fact it's incapable of it:

< ACL Data TX: Handle 3585 flags 0x00 dlen 6
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
> ACL Data RX: Handle 3585 flags 0x02 dlen 11
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
        Max encryption key size: 16
        Initiator key distribution: EncKey (0x01)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 3585 flags 0x00 dlen 11
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
        Max encryption key size: 16
        Initiator key distribution: EncKey (0x01)
        Responder key distribution: EncKey Sign (0x05)

The pairing eventually fails when we get an unexpected Pairing Confirm
PDU instead of a Public Key PDU:

> ACL Data RX: Handle 3585 flags 0x02 dlen 21
      SMP: Pairing Confirm (0x03) len 16
        Confim value: bcc3bed31b8f313a78ec3cce32685faf

It is only at this point that we can speculate that the remote doesn't
really support SC. This patch creates a workaround for the just-works
model, however the MITM case is unsolvable because the OS X user has
already been requested to enter a PIN which we're now expected to
randomly generate and show the user (i.e. a chicken-and-egg problem).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9155840068cf..dc27bad535f2 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -818,6 +818,12 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		return 0;
 	}
 
+	/* If this function is used for SC -> legacy fallback we
+	 * can only recover the just-works case.
+	 */
+	if (test_bit(SMP_FLAG_SC, &smp->flags))
+		return -EINVAL;
+
 	/* Not Just Works/Confirm results in MITM Authentication */
 	if (smp->method != JUST_CFM) {
 		set_bit(SMP_FLAG_MITM_AUTH, &smp->flags);
@@ -1737,6 +1743,13 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	clear_bit(SMP_FLAG_INITIATOR, &smp->flags);
 
+	/* Strictly speaking we shouldn't allow Pairing Confirm for the
+	 * SC case, however some implementations incorrectly copy RFU auth
+	 * req bits from our security request, which may create a false
+	 * positive SC enablement.
+	 */
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+
 	if (test_bit(SMP_FLAG_SC, &smp->flags)) {
 		SMP_ALLOW_CMD(smp, SMP_CMD_PUBLIC_KEY);
 		/* Clear bits which are generated but not distributed */
@@ -1745,8 +1758,6 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
-	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
-
 	/* Request setup of TK */
 	ret = tk_request(conn, 0, auth, rsp.io_capability, req->io_capability);
 	if (ret)
@@ -1885,10 +1896,6 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 
 	BT_DBG("");
 
-	/* Public Key exchange must happen before any other steps */
-	if (!test_bit(SMP_FLAG_REMOTE_PK, &smp->flags))
-		return SMP_UNSPECIFIED;
-
 	if (smp->method == REQ_PASSKEY || smp->method == DSP_PASSKEY)
 		return sc_passkey_round(smp, SMP_CMD_PAIRING_CONFIRM);
 
@@ -1901,6 +1908,47 @@ static u8 sc_check_confirm(struct smp_chan *smp)
 	return 0;
 }
 
+/* Work-around for some implementations that incorrectly copy RFU bits
+ * from our security request and thereby create the impression that
+ * we're doing SC when in fact the remote doesn't support it.
+ */
+static int fixup_sc_false_positive(struct smp_chan *smp)
+{
+	struct l2cap_conn *conn = smp->conn;
+	struct hci_conn *hcon = conn->hcon;
+	struct hci_dev *hdev = hcon->hdev;
+	struct smp_cmd_pairing *req, *rsp;
+	u8 auth;
+
+	/* The issue is only observed when we're in slave role */
+	if (hcon->out)
+		return SMP_UNSPECIFIED;
+
+	if (hci_dev_test_flag(hdev, HCI_SC_ONLY)) {
+		BT_ERR("Refusing SMP SC -> legacy fallback in SC-only mode");
+		return SMP_UNSPECIFIED;
+	}
+
+	BT_ERR("Trying to fall back to legacy SMP");
+
+	req = (void *) &smp->preq[1];
+	rsp = (void *) &smp->prsp[1];
+
+	/* Rebuild key dist flags which may have been cleared for SC */
+	smp->remote_key_dist = (req->init_key_dist & rsp->resp_key_dist);
+
+	auth = req->auth_req & AUTH_REQ_MASK(hdev);
+
+	if (tk_request(conn, 0, auth, rsp->io_capability, req->io_capability)) {
+		BT_ERR("Failed to fall back to legacy SMP");
+		return SMP_UNSPECIFIED;
+	}
+
+	clear_bit(SMP_FLAG_SC, &smp->flags);
+
+	return 0;
+}
+
 static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = conn->smp;
@@ -1914,8 +1962,19 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
 	skb_pull(skb, sizeof(smp->pcnf));
 
-	if (test_bit(SMP_FLAG_SC, &smp->flags))
-		return sc_check_confirm(smp);
+	if (test_bit(SMP_FLAG_SC, &smp->flags)) {
+		int ret;
+
+		/* Public Key exchange must happen before any other steps */
+		if (test_bit(SMP_FLAG_REMOTE_PK, &smp->flags))
+			return sc_check_confirm(smp);
+
+		BT_ERR("Unexpected SMP Pairing Confirm");
+
+		ret = fixup_sc_false_positive(smp);
+		if (ret)
+			return ret;
+	}
 
 	if (conn->hcon->out) {
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
-- 
2.1.0

