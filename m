Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Add key preference parameter to smp_sufficient_security
Date: Thu, 13 Nov 2014 10:55:18 +0200
Message-Id: <1415868919-12040-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415868919-12040-1-git-send-email-johan.hedberg@gmail.com>
References: <1415868919-12040-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

So far smp_sufficient_security() has returned false if we're encrypted
with an STK but do have an LTK available. However, for the sake of LE
CoC servers we do want to let the incoming connection through even
though we're only encrypted with the STK.

This patch adds a key preference parameter to smp_sufficient_security()
with two possible values (enum used instead of bool for readability).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c |  3 ++-
 net/bluetooth/smp.c        | 20 +++++++++++---------
 net/bluetooth/smp.h        |  9 ++++++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 76045497eaa1..a37f809591ad 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5391,7 +5391,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(pchan);
 
-	if (!smp_sufficient_security(conn->hcon, pchan->sec_level)) {
+	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
+				     SMP_ALLOW_STK)) {
 		result = L2CAP_CR_AUTHENTICATION;
 		chan = NULL;
 		goto response_unlock;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3b63c7f09dd5..3dc5f0e66405 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1122,18 +1122,20 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	return true;
 }
 
-bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
+bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
+			     enum smp_key_pref key_pref)
 {
 	if (sec_level == BT_SECURITY_LOW)
 		return true;
 
-	/* If we're encrypted with an STK always claim insufficient
-	 * security. This way we allow the connection to be re-encrypted
-	 * with an LTK, even if the LTK provides the same level of
-	 * security. Only exception is if we don't have an LTK (e.g.
-	 * because of key distribution bits).
+	/* If we're encrypted with an STK but the caller prefers using
+	 * LTK claim insufficient security. This way we allow the
+	 * connection to be re-encrypted with an LTK, even if the LTK
+	 * provides the same level of security. Only exception is if we
+	 * don't have an LTK (e.g. because of key distribution bits).
 	 */
-	if (test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags) &&
+	if (key_pref == SMP_USE_LTK &&
+	    test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags) &&
 	    hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
 				 hcon->role))
 		return false;
@@ -1167,7 +1169,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	else
 		sec_level = authreq_to_seclevel(auth);
 
-	if (smp_sufficient_security(hcon, sec_level))
+	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
 		return 0;
 
 	if (sec_level > hcon->pending_sec_level)
@@ -1217,7 +1219,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
 		return 1;
 
-	if (smp_sufficient_security(hcon, sec_level))
+	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
 		return 1;
 
 	if (sec_level > hcon->pending_sec_level)
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 86a683a8b491..f76083b85005 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -133,8 +133,15 @@ static inline u8 smp_ltk_sec_level(struct smp_ltk *key)
 	return BT_SECURITY_MEDIUM;
 }
 
+/* Key preferences for smp_sufficient security */
+enum smp_key_pref {
+	SMP_ALLOW_STK,
+	SMP_USE_LTK,
+};
+
 /* SMP Commands */
-bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
+bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
+			     enum smp_key_pref key_pref);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
-- 
2.1.0

