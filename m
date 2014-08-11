Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/9] Bluetooth: Add SMP-internal timeout callback
Date: Mon, 11 Aug 2014 22:06:40 +0300
Message-Id: <1407784004-12448-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
References: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds an SMP-internal timeout callback to remove the depenency
on (the soon to be removed) l2cap_conn->security_timer. The behavior is
the same as with l2cap_conn->security_timer except that the new
l2cap_conn_shutdown() public function is used instead of the L2CAP core
internal l2cap_conn_del().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5103dc739a17..7ab5f52955cb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -44,7 +44,9 @@ enum {
 };
 
 struct smp_chan {
-	struct l2cap_conn *conn;
+	struct l2cap_conn	*conn;
+	struct delayed_work	security_timer;
+
 	u8		preq[7]; /* SMP Pairing Request */
 	u8		prsp[7]; /* SMP Pairing Response */
 	u8		prnd[16]; /* SMP Pairing Random (local) */
@@ -251,6 +253,7 @@ static int smp_s1(struct smp_chan *smp, u8 k[16], u8 r1[16], u8 r2[16],
 static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 {
 	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp;
 	struct kvec iv[2];
 	struct msghdr msg;
 
@@ -272,8 +275,14 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 
 	l2cap_chan_send(chan, &msg, 1 + len);
 
-	cancel_delayed_work_sync(&conn->security_timer);
-	schedule_delayed_work(&conn->security_timer, SMP_TIMEOUT);
+	if (!chan->data)
+		return;
+
+	smp = chan->data;
+
+	cancel_delayed_work_sync(&smp->security_timer);
+	if (test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
+		schedule_delayed_work(&smp->security_timer, SMP_TIMEOUT);
 }
 
 static __u8 authreq_to_seclevel(__u8 authreq)
@@ -359,6 +368,8 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
 static void smp_failure(struct l2cap_conn *conn, u8 reason)
 {
 	struct hci_conn *hcon = conn->hcon;
+	struct l2cap_chan *chan = conn->smp;
+	struct smp_chan *smp;
 
 	if (reason)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
@@ -368,7 +379,12 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 	mgmt_auth_failed(hcon->hdev, &hcon->dst, hcon->type, hcon->dst_type,
 			 HCI_ERROR_AUTH_FAILURE);
 
-	cancel_delayed_work_sync(&conn->security_timer);
+	if (!chan->data)
+		return;
+
+	smp = chan->data;
+
+	cancel_delayed_work_sync(&smp->security_timer);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		smp_chan_destroy(conn);
@@ -749,7 +765,7 @@ static int smp_distribute_keys(struct l2cap_conn *conn)
 		return 0;
 
 	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
-	cancel_delayed_work_sync(&conn->security_timer);
+	cancel_delayed_work_sync(&smp->security_timer);
 	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	smp_notify_keys(conn);
 
@@ -758,6 +774,17 @@ static int smp_distribute_keys(struct l2cap_conn *conn)
 	return 0;
 }
 
+static void smp_timeout(struct work_struct *work)
+{
+	struct smp_chan *smp = container_of(work, struct smp_chan,
+					    security_timer.work);
+	struct l2cap_conn *conn = smp->conn;
+
+	BT_DBG("conn %p", conn);
+
+	l2cap_conn_shutdown(conn, ETIMEDOUT);
+}
+
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 {
 	struct l2cap_chan *chan = conn->smp;
@@ -780,6 +807,8 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 	smp->conn = conn;
 	chan->data = smp;
 
+	INIT_DELAYED_WORK(&smp->security_timer, smp_timeout);
+
 	hci_conn_hold(conn->hcon);
 
 	return smp;
@@ -1479,11 +1508,12 @@ done:
 static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 {
 	struct l2cap_conn *conn = chan->conn;
+	struct smp_chan *smp = chan->data;
 
 	BT_DBG("chan %p", chan);
 
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
-		cancel_delayed_work_sync(&conn->security_timer);
+		cancel_delayed_work_sync(&smp->security_timer);
 		smp_chan_destroy(conn);
 	}
 
@@ -1493,6 +1523,7 @@ static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 
 static void smp_resume_cb(struct l2cap_chan *chan)
 {
+	struct smp_chan *smp = chan->data;
 	struct l2cap_conn *conn = chan->conn;
 	struct hci_conn *hcon = conn->hcon;
 
@@ -1500,7 +1531,9 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 
 	if (test_bit(HCI_CONN_ENCRYPT, &hcon->flags))
 		smp_distribute_keys(conn);
-	cancel_delayed_work(&conn->security_timer);
+
+	if (smp)
+		cancel_delayed_work(&smp->security_timer);
 }
 
 static void smp_ready_cb(struct l2cap_chan *chan)
@@ -1521,9 +1554,10 @@ static int smp_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = smp_sig_channel(chan, skb);
 	if (err) {
-		struct l2cap_conn *conn = chan->conn;
+		struct smp_chan *smp = chan->data;
 
-		cancel_delayed_work_sync(&conn->security_timer);
+		if (smp)
+			cancel_delayed_work_sync(&smp->security_timer);
 
 		l2cap_conn_shutdown(chan->conn, -err);
 	}
-- 
1.9.3

