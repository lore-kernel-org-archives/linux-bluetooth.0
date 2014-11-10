Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add key preference parameter to smp_sufficient_security
Date: Mon, 10 Nov 2014 13:24:54 +0200
Message-Id: <1415618695-21363-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415618695-21363-1-git-send-email-johan.hedberg@gmail.com>
References: <1415618695-21363-1-git-send-email-johan.hedberg@gmail.com>
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
 net/bluetooth/l2cap_core.c | 3 ++-
 net/bluetooth/smp.c        | 9 +++++----
 net/bluetooth/smp.h        | 8 +++++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 53af3d98a533..f396d50db73e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5388,7 +5388,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(pchan);
 
-	if (!smp_sufficient_security(conn->hcon, pchan->sec_level)) {
+	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
+				     SMP_ALLOW_STK)) {
 		result = L2CAP_CR_AUTHENTICATION;
 		chan = NULL;
 		goto response_unlock;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3ebf65b50881..1a14d101b213 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1126,7 +1126,7 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	return true;
 }
 
-bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
+bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level, int key_pref)
 {
 	if (sec_level == BT_SECURITY_LOW)
 		return true;
@@ -1137,7 +1137,8 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
 	 * security. Only exception is if we don't have an LTK (e.g.
 	 * because of key distribution bits).
 	 */
-	if (test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags) &&
+	if (key_pref == SMP_USE_LTK &&
+	    test_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags) &&
 	    hci_find_ltk_by_addr(hcon->hdev, &hcon->dst, hcon->dst_type,
 				 hcon->role))
 		return false;
@@ -1171,7 +1172,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	else
 		sec_level = authreq_to_seclevel(auth);
 
-	if (smp_sufficient_security(hcon, sec_level))
+	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
 		return 0;
 
 	if (sec_level > hcon->pending_sec_level)
@@ -1221,7 +1222,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
 		return 1;
 
-	if (smp_sufficient_security(hcon, sec_level))
+	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
 		return 1;
 
 	if (sec_level > hcon->pending_sec_level)
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 86a683a8b491..8ea14c20832f 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -133,8 +133,14 @@ static inline u8 smp_ltk_sec_level(struct smp_ltk *key)
 	return BT_SECURITY_MEDIUM;
 }
 
+/* Key preferences for smp_sufficient security */
+enum {
+	SMP_ALLOW_STK,
+	SMP_USE_LTK,
+};
+
 /* SMP Commands */
-bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level);
+bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level, int key_pref);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
 
-- 
2.1.0

