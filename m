Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 01/13] Bluetooth: Fix sending wrong authentication requirements
Date: Thu, 25 Aug 2011 20:02:27 -0300
Message-Id: <1314313359-12652-2-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Until we support any pairing method (Passkey Entry, OOB) that gives
MITM protection we shouldn't send that we have MITM protection.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0283d47..74afdb7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -204,18 +204,6 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 					msecs_to_jiffies(SMP_TIMEOUT));
 }
 
-static __u8 seclevel_to_authreq(__u8 level)
-{
-	switch (level) {
-	case BT_SECURITY_HIGH:
-		/* Right now we don't support bonding */
-		return SMP_AUTH_MITM;
-
-	default:
-		return SMP_AUTH_NONE;
-	}
-}
-
 static void build_pairing_cmd(struct l2cap_conn *conn,
 				struct smp_cmd_pairing *req,
 				struct smp_cmd_pairing *rsp,
@@ -556,7 +544,6 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct smp_chan *smp = conn->smp_chan;
-	__u8 authreq;
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
 
@@ -594,19 +581,17 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 	smp = smp_chan_create(conn);
 
-	authreq = seclevel_to_authreq(sec_level);
-
 	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 
-		build_pairing_cmd(conn, &cp, NULL, authreq);
+		build_pairing_cmd(conn, &cp, NULL, SMP_AUTH_NONE);
 		smp->preq[0] = SMP_CMD_PAIRING_REQ;
 		memcpy(&smp->preq[1], &cp, sizeof(cp));
 
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 	} else {
 		struct smp_cmd_security_req cp;
-		cp.auth_req = authreq;
+		cp.auth_req = SMP_AUTH_NONE;
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
-- 
1.7.6

