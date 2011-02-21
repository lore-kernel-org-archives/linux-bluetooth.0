Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 08/15] Bluetooth: Minor fix in SMP methods
Date: Mon, 21 Feb 2011 14:23:55 -0300
Message-Id: <28c3e01f3547d1e661c9b50bc7da54027827cdb5.1298307667.git.vinicius.gomes@openbossa.org>
In-Reply-To: <cover.1298307667.git.vinicius.gomes@openbossa.org>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
In-Reply-To: <cover.1298307667.git.vinicius.gomes@openbossa.org>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

Minor fix in smp_conn_security function.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 37224a7..52241fd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -352,12 +352,13 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
+	struct hci_conn *hcon = conn->hcon;
 	__u8 authreq;
 
-	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
+	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
 
-	if (IS_ERR(conn->hcon->hdev->tfm))
-		return PTR_ERR(conn->hcon->hdev->tfm);
+	if (IS_ERR(hcon->hdev->tfm))
+		return PTR_ERR(hcon->hdev->tfm);
 
 	switch (sec_level) {
 	case BT_SECURITY_MEDIUM:
@@ -375,7 +376,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		return 1;
 	}
 
-	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 		cp.io_capability = 0x00;
 		cp.oob_flag = 0x00;
-- 
1.7.4.1

