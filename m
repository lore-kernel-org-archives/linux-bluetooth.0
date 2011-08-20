Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/7] Bluetooth: Reset the security timer when a command is queued
Date: Fri, 19 Aug 2011 21:06:50 -0300
Message-Id: <1313798816-8647-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each time a SMP command is enqueued, we reset the SMP timer,
this way we follow exactly what the spec mandates:

"The Security Manager Timer shall be reset when an L2CAP SMP command is
queued for transmission." Vol. 3, Part H, Section 3.4

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 391888b..20c82c7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -182,6 +182,9 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 		return;
 
 	hci_send_acl(conn->hcon, skb, 0);
+
+	mod_timer(&conn->security_timer, jiffies +
+					msecs_to_jiffies(SMP_TIMEOUT));
 }
 
 static __u8 seclevel_to_authreq(__u8 level)
@@ -267,9 +270,6 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(rsp), &rsp);
 
-	mod_timer(&conn->security_timer, jiffies +
-					msecs_to_jiffies(SMP_TIMEOUT));
-
 	return 0;
 }
 
@@ -351,9 +351,6 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 	}
 
-	mod_timer(&conn->security_timer, jiffies +
-					msecs_to_jiffies(SMP_TIMEOUT));
-
 	return 0;
 }
 
@@ -446,9 +443,6 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
-	mod_timer(&conn->security_timer, jiffies +
-					msecs_to_jiffies(SMP_TIMEOUT));
-
 	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
 
 	return 0;
@@ -498,9 +492,6 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		conn->preq[0] = SMP_CMD_PAIRING_REQ;
 		memcpy(&conn->preq[1], &cp, sizeof(cp));
 
-		mod_timer(&conn->security_timer, jiffies +
-					msecs_to_jiffies(SMP_TIMEOUT));
-
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 	} else {
 		struct smp_cmd_security_req cp;
-- 
1.7.6

