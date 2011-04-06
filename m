Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 10/15] Bluetooth: Use the stored LTK for restabilishing security
Date: Tue,  5 Apr 2011 23:11:23 -0300
Message-Id: <1302055888-28177-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that it's possible that the exchanged key is present in
the link key list, we may be able to estabilish security with
an already existing key, without need to perform any SMP
procedure.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4a314cc..3fd97db 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -487,6 +487,20 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	authreq = seclevel_to_authreq(sec_level);
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
+		struct link_key *key;
+
+		key = hci_find_link_key_type(hcon->hdev, conn->dst,
+							KEY_TYPE_LTK);
+		if (key) {
+			struct key_master_id *master = (void *) key->data;
+
+			hci_le_start_enc(hcon, master->ediv, master->rand,
+								key->val);
+			goto done;
+		}
+	}
+
+	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 
 		build_pairing_cmd(conn, &cp, NULL, authreq);
@@ -503,6 +517,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
+done:
 	hcon->pending_sec_level = sec_level;
 	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
 
-- 
1.7.4.1

