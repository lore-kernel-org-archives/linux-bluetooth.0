Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 08/12] Bluetooth: Use the stored LTK for restabilishing security
Date: Fri,  1 Jul 2011 16:07:43 -0300
Message-Id: <1309547267-9514-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
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
index 34d236d..191aaec 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -476,6 +476,20 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	authreq = seclevel_to_authreq(sec_level);
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
+		struct link_key *key;
+
+		key = hci_find_link_key_type(hcon->hdev, conn->dst,
+							HCI_LK_SMP_LTK);
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
@@ -492,6 +506,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
+done:
 	hcon->pending_sec_level = sec_level;
 	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
 
-- 
1.7.6

