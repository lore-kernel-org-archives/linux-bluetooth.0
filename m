Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] Bluetooth: l2cap_set_timer needs jiffies as timeout value
Date: Wed, 4 Jan 2012 12:10:42 +0100
Message-ID: <1325675442-24658-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After moving L2CAP timers to workqueues l2cap_set_timer expects timeout
value to be specified in jiffies but constants defined in miliseconds
are used. This makes timeouts unreliable when CONFIG_HZ is not set to
1000.

__set_chan_timer macro still uses jiffies as input to avoid multiple
conversions from/to jiffies for sk_sndtimeo value which is already
specified in jiffies.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/l2cap.h |    6 +++---
 net/bluetooth/l2cap_core.c    |   12 ++++++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9572cbd..b564142 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -626,13 +626,13 @@ static inline void l2cap_clear_timer(struct l2cap_chan *chan,
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
-		L2CAP_DEFAULT_RETRANS_TO);
+		msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
 #define __clear_retrans_timer(c) l2cap_clear_timer(c, &c->retrans_timer)
 #define __set_monitor_timer(c) l2cap_set_timer(c, &c->monitor_timer, \
-		L2CAP_DEFAULT_MONITOR_TO);
+		msecs_to_jiffies(L2CAP_DEFAULT_MONITOR_TO));
 #define __clear_monitor_timer(c) l2cap_clear_timer(c, &c->monitor_timer)
 #define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
-		L2CAP_DEFAULT_ACK_TO);
+		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
 #define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
 
 static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3ee9bde..97f8549 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2970,7 +2970,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	default:
 		sk->sk_err = ECONNRESET;
-		__set_chan_timer(chan, L2CAP_DISC_REJ_TIMEOUT);
+		__set_chan_timer(chan,
+				msecs_to_jiffies(L2CAP_DISC_REJ_TIMEOUT));
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
 		goto done;
 	}
@@ -4478,7 +4479,8 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	if (encrypt == 0x00) {
 		if (chan->sec_level == BT_SECURITY_MEDIUM) {
 			__clear_chan_timer(chan);
-			__set_chan_timer(chan, L2CAP_ENC_TIMEOUT);
+			__set_chan_timer(chan,
+					msecs_to_jiffies(L2CAP_ENC_TIMEOUT));
 		} else if (chan->sec_level == BT_SECURITY_HIGH)
 			l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
@@ -4546,7 +4548,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					L2CAP_CONN_REQ, sizeof(req), &req);
 			} else {
 				__clear_chan_timer(chan);
-				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
+				__set_chan_timer(chan,
+					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
 			}
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
@@ -4566,7 +4569,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				}
 			} else {
 				l2cap_state_change(chan, BT_DISCONN);
-				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
+				__set_chan_timer(chan,
+					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
 				res = L2CAP_CR_SEC_BLOCK;
 				stat = L2CAP_CS_NO_INFO;
 			}
-- 
on behalf of ST-Ericsson

