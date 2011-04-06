Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 08/15] Bluetooth: Minor fix in SMP methods
Date: Tue,  5 Apr 2011 22:51:49 -0300
Message-Id: <1302054716-24534-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

Minor fix in smp_conn_security function.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fd9c3ff..f03513d 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -355,11 +355,12 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
+	struct hci_conn *hcon = conn->hcon;
 	__u8 authreq;
 
-	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
+	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
 
-	if (IS_ERR(conn->hcon->hdev->tfm))
+	if (IS_ERR(hcon->hdev->tfm))
 		return 1;
 
 	switch (sec_level) {
@@ -378,7 +379,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		return 1;
 	}
 
-	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
 		cp.io_capability = 0x00;
 		cp.oob_flag = 0x00;
-- 
1.7.4.1

