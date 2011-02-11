Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next -v2 17/24] Bluetooth: Minor fix in SMP methods
Date: Thu, 10 Feb 2011 22:39:02 -0300
Message-Id: <1297388349-14878-18-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-17-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-8-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-9-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-10-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-11-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-12-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-13-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-14-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-15-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-16-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-17-git-send-email-vinicius.gomes@openbossa.org>
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
index 2679a1b..ddc4af6 100644
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
1.7.4

