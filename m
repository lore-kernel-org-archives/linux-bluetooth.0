Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix overriding higher security level in SMP
Date: Tue, 17 Jun 2014 13:07:37 +0300
Message-Id: <1402999659-4969-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
References: <1402999659-4969-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we receive a pairing request or an internal request to start
pairing we shouldn't blindly overwrite the existing pending_sec_level
value as that may actually be higher than the new one. This patch fixes
the SMP code to only overwrite the value in case the new one is higher
than the old.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ee29342980c3..513d39d5e099 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -668,7 +668,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
 	struct smp_chan *smp;
-	u8 key_size, auth;
+	u8 key_size, auth, sec_level;
 	int ret;
 
 	BT_DBG("conn %p", conn);
@@ -694,7 +694,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* We didn't start the pairing, so match remote */
 	auth = req->auth_req;
 
-	conn->hcon->pending_sec_level = authreq_to_seclevel(auth);
+	sec_level = authreq_to_seclevel(auth);
+	if (sec_level > conn->hcon->pending_sec_level)
+		conn->hcon->pending_sec_level = sec_level;
 
 	build_pairing_cmd(conn, req, &rsp, auth);
 
@@ -837,6 +839,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
 	struct smp_chan *smp;
+	u8 sec_level;
 
 	BT_DBG("conn %p", conn);
 
@@ -846,7 +849,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
 		return SMP_CMD_NOTSUPP;
 
-	hcon->pending_sec_level = authreq_to_seclevel(rp->auth_req);
+	sec_level = authreq_to_seclevel(rp->auth_req);
+	if (sec_level > hcon->pending_sec_level)
+		hcon->pending_sec_level = sec_level;
 
 	if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
 		return 0;
@@ -902,9 +907,12 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (smp_sufficient_security(hcon, sec_level))
 		return 1;
 
+	if (sec_level > hcon->pending_sec_level)
+		hcon->pending_sec_level = sec_level;
+
 	if (hcon->link_mode & HCI_LM_MASTER)
-		if (smp_ltk_encrypt(conn, sec_level))
-			goto done;
+		if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
+			return 0;
 
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return 0;
@@ -919,7 +927,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	 * requires it.
 	 */
 	if (hcon->io_capability != HCI_IO_NO_INPUT_OUTPUT ||
-	    sec_level > BT_SECURITY_MEDIUM)
+	    hcon->pending_sec_level > BT_SECURITY_MEDIUM)
 		authreq |= SMP_AUTH_MITM;
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
@@ -938,9 +946,6 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 
 	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
 
-done:
-	hcon->pending_sec_level = sec_level;
-
 	return 0;
 }
 
-- 
1.9.3

