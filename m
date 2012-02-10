Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 14/16] Bluetooth: Change locking logic in security_cfm
Date: Fri, 10 Feb 2012 15:55:11 +0200
Message-Id: <1328882113-19810-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change bh_ locking functions to mutex_locks since we can now sleep.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad5092e..cbaa4e1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4589,9 +4589,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
-
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		BT_DBG("chan->scid %d", chan->scid);
 
@@ -4601,19 +4599,19 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				l2cap_chan_ready(chan);
 			}
 
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
 		if (test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
 		if (!status && (chan->state == BT_CONNECTED ||
 						chan->state == BT_CONFIG)) {
 			l2cap_check_encryption(chan, encrypt);
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
@@ -4634,9 +4632,12 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
 			}
 		} else if (chan->state == BT_CONNECT2) {
+			struct sock *sk = chan->sk;
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
+			lock_sock(sk);
+
 			if (!status) {
 				if (bt_sk(sk)->defer_setup) {
 					struct sock *parent = bt_sk(sk)->parent;
@@ -4657,6 +4658,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				stat = L2CAP_CS_NO_INFO;
 			}
 
+			release_sock(sk);
+
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
 			rsp.result = cpu_to_le16(res);
@@ -4665,7 +4668,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 							sizeof(rsp), &rsp);
 		}
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
-- 
1.7.8.3

