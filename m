Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: Fix invalid memory access when there's no SMP channel
Date: Wed,  1 Feb 2012 18:27:56 -0300
Message-Id: <1328131676-29171-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We only should try to free the SMP channel that was created if there
is a pending SMP session.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5818334..9ff56e1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -263,8 +263,11 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
 	mgmt_auth_failed(conn->hcon->hdev, conn->dst, reason);
-	cancel_delayed_work_sync(&conn->security_timer);
-	smp_chan_destroy(conn);
+
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
+		cancel_delayed_work_sync(&conn->security_timer);
+		smp_chan_destroy(conn);
+	}
 }
 
 #define JUST_WORKS	0x00
@@ -506,7 +509,7 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 {
 	struct smp_chan *smp = conn->smp_chan;
 
-	clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
+	BUG_ON(!smp);
 
 	if (smp->tfm)
 		crypto_free_blkcipher(smp->tfm);
-- 
1.7.8.1

