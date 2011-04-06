Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 06/15] Bluetooth: Add support for providing parameters to LE Start Encryption
Date: Tue,  5 Apr 2011 23:11:19 -0300
Message-Id: <1302055888-28177-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With LTK support we need to be able to provide LE Start Encryption
with EDIV (Encrypted Diversifier) and Rand (just an 64 bit random
number).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_conn.c         |    5 ++++-
 net/bluetooth/smp.c              |    8 +++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 72305d6..79b84d7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -870,7 +870,8 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result);
 
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
-void hci_le_start_enc(struct hci_conn *conn, u8 ltk[16]);
+void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
+							__u8 ltk[16]);
 void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 173806e..07337d3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -205,7 +205,8 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 }
 EXPORT_SYMBOL(hci_le_conn_update);
 
-void hci_le_start_enc(struct hci_conn *conn, u8 ltk[16])
+void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
+							__u8 ltk[16])
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_start_enc cp;
@@ -216,6 +217,8 @@ void hci_le_start_enc(struct hci_conn *conn, u8 ltk[16])
 
 	cp.handle = cpu_to_le16(conn->handle);
 	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
+	cp.ediv = ediv;
+	memcpy(cp.rand, rand, sizeof(rand));
 
 	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3240be7..1f1b318 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -371,13 +371,19 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	if (conn->hcon->out) {
+		__le16 ediv;
+		u8 rand[8];
+
 		smp_s1(tfm, conn->tk, random, conn->prnd, key);
 		swap128(key, hcon->ltk);
 
 		memset(hcon->ltk + conn->smp_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
 
-		hci_le_start_enc(hcon, hcon->ltk);
+
+		memset(rand, 0, sizeof(rand));
+		ediv = 0;
+		hci_le_start_enc(hcon, ediv, rand, hcon->ltk);
 
 		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
 							sizeof(buf), 0);
-- 
1.7.4.1

