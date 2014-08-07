Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/9] Bluetooth: Resume BT_CONNECTED state after LE security elevation
Date: Thu,  7 Aug 2014 22:56:44 +0300
Message-Id: <1407441410-13312-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
References: <1407441410-13312-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The LE ATT socket uses a special trick where it temporarily sets
BT_CONFIG state for the duration of a security level elevation. In order
to not require special hacks for going back to BT_CONNECTED state in the
l2cap_core.c code the most reasonable place to resume the state is the
resume callback. This patch adds a new flag to track the pending
security level change and ensures that the state is set back to
BT_CONNECTED in the resume callback in case the flag is set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_sock.c    | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8df15ad0d43f..4a51e7596608 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -708,6 +708,7 @@ enum {
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
+	FLAG_PENDING_SECURITY,
 };
 
 enum {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1884f72083c2..5a42f6a818c0 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -790,6 +790,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (chan->scid == L2CAP_CID_ATT) {
 			if (smp_conn_security(conn->hcon, sec.level))
 				break;
+			set_bit(FLAG_PENDING_SECURITY, &chan->flags);
 			sk->sk_state = BT_CONFIG;
 			chan->state = BT_CONFIG;
 
@@ -1359,6 +1360,11 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (test_and_clear_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
+		sk->sk_state = BT_CONNECTED;
+		chan->state = BT_CONNECTED;
+	}
+
 	clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
 	sk->sk_state_change(sk);
 }
-- 
1.9.3

