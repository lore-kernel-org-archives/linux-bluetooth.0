Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix redundant encryption when receiving Security Request
Date: Tue,  1 Jul 2014 18:40:20 +0300
Message-Id: <1404229220-11760-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we're already encrypted with a good enough LTK we should just ignore
an incoming SMP Security Request. The code was already taking care of
this in the smp_conn_security function before calling smp_ltk_encrypt
but failed to do the same in smp_cmd_security_req. This patch fixes the
issue by moving up the smp_sufficient_security function and using it in
the Security Request handler before trying to request encryption.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 35f57090ddd0..6ce7785a2708 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -859,6 +859,17 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	return true;
 }
 
+bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
+{
+	if (sec_level == BT_SECURITY_LOW)
+		return true;
+
+	if (hcon->sec_level >= sec_level)
+		return true;
+
+	return false;
+}
+
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
@@ -876,6 +887,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_CMD_NOTSUPP;
 
 	sec_level = authreq_to_seclevel(rp->auth_req);
+	if (smp_sufficient_security(hcon, sec_level))
+		return 0;
+
 	if (sec_level > hcon->pending_sec_level)
 		hcon->pending_sec_level = sec_level;
 
@@ -904,17 +918,6 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
-bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level)
-{
-	if (sec_level == BT_SECURITY_LOW)
-		return true;
-
-	if (hcon->sec_level >= sec_level)
-		return true;
-
-	return false;
-}
-
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
-- 
1.9.3

