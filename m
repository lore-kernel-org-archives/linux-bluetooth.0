Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 23/49] Bluetooth: Track authentication method in SMP context
Date: Wed,  3 Dec 2014 17:02:17 +0200
Message-Id: <1417618963-18010-24-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For Secure Connections we'll select the authentication method as soon as
we receive the public key, but only use it later (both when actually
triggering the method as well as when determining the quality of the
resulting LTK). Store the method therefore in the SMP context.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 816cbb63b68b..651963f26da0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -79,6 +79,7 @@ struct smp_chan {
 	struct smp_irk	*remote_irk;
 	u8		*link_key;
 	unsigned long	flags;
+	u8		method;
 
 	/* Secure Connections variables */
 	u8			local_pk[64];
@@ -688,7 +689,6 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
-	u8 method;
 	u32 passkey = 0;
 	int ret = 0;
 
@@ -705,26 +705,28 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	 * table.
 	 */
 	if (!(auth & SMP_AUTH_MITM))
-		method = JUST_CFM;
+		smp->method = JUST_CFM;
 	else
-		method = get_auth_method(smp, local_io, remote_io);
+		smp->method = get_auth_method(smp, local_io, remote_io);
 
 	/* Don't confirm locally initiated pairing attempts */
-	if (method == JUST_CFM && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
-		method = JUST_WORKS;
+	if (smp->method == JUST_CFM && test_bit(SMP_FLAG_INITIATOR,
+						&smp->flags))
+		smp->method = JUST_WORKS;
 
 	/* Don't bother user space with no IO capabilities */
-	if (method == JUST_CFM && hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
-		method = JUST_WORKS;
+	if (smp->method == JUST_CFM &&
+	    hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
+		smp->method = JUST_WORKS;
 
 	/* If Just Works, Continue with Zero TK */
-	if (method == JUST_WORKS) {
+	if (smp->method == JUST_WORKS) {
 		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 		return 0;
 	}
 
 	/* Not Just Works/Confirm results in MITM Authentication */
-	if (method != JUST_CFM) {
+	if (smp->method != JUST_CFM) {
 		set_bit(SMP_FLAG_MITM_AUTH, &smp->flags);
 		if (hcon->pending_sec_level < BT_SECURITY_HIGH)
 			hcon->pending_sec_level = BT_SECURITY_HIGH;
@@ -733,15 +735,15 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	/* If both devices have Keyoard-Display I/O, the master
 	 * Confirms and the slave Enters the passkey.
 	 */
-	if (method == OVERLAP) {
+	if (smp->method == OVERLAP) {
 		if (hcon->role == HCI_ROLE_MASTER)
-			method = CFM_PASSKEY;
+			smp->method = CFM_PASSKEY;
 		else
-			method = REQ_PASSKEY;
+			smp->method = REQ_PASSKEY;
 	}
 
 	/* Generate random passkey. */
-	if (method == CFM_PASSKEY) {
+	if (smp->method == CFM_PASSKEY) {
 		memset(smp->tk, 0, sizeof(smp->tk));
 		get_random_bytes(&passkey, sizeof(passkey));
 		passkey %= 1000000;
@@ -750,10 +752,10 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
 	}
 
-	if (method == REQ_PASSKEY)
+	if (smp->method == REQ_PASSKEY)
 		ret = mgmt_user_passkey_request(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type);
-	else if (method == JUST_CFM)
+	else if (smp->method == JUST_CFM)
 		ret = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
 						hcon->type, hcon->dst_type,
 						passkey, 1);
-- 
2.1.0

