Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/5] Bluetooth: clean up l2cap code
Date: Wed,  1 Dec 2010 16:58:24 +0200
Message-Id: <1291215506-11398-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Do not initialize static vars to zero, macros with complex values
shall be enclosed with (), remove unneeded braces.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/l2cap.h |   10 +++++-----
 net/bluetooth/l2cap.c         |    7 +++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c819c8b..217bb91 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -417,11 +417,11 @@ static inline int l2cap_tx_window_full(struct sock *sk)
 	return sub == pi->remote_tx_win;
 }
 
-#define __get_txseq(ctrl) ((ctrl) & L2CAP_CTRL_TXSEQ) >> 1
-#define __get_reqseq(ctrl) ((ctrl) & L2CAP_CTRL_REQSEQ) >> 8
-#define __is_iframe(ctrl) !((ctrl) & L2CAP_CTRL_FRAME_TYPE)
-#define __is_sframe(ctrl) (ctrl) & L2CAP_CTRL_FRAME_TYPE
-#define __is_sar_start(ctrl) ((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START
+#define __get_txseq(ctrl)	(((ctrl) & L2CAP_CTRL_TXSEQ) >> 1)
+#define __get_reqseq(ctrl)	(((ctrl) & L2CAP_CTRL_REQSEQ) >> 8)
+#define __is_iframe(ctrl)	(!((ctrl) & L2CAP_CTRL_FRAME_TYPE))
+#define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
+#define __is_sar_start(ctrl)	(((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START)
 
 void l2cap_load(void);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 12b4aa2..d4b4fbd 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -57,7 +57,7 @@
 
 #define VERSION "2.15"
 
-static int disable_ertm = 0;
+static int disable_ertm;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -4162,11 +4162,10 @@ static inline void l2cap_data_channel_rrframe(struct sock *sk, u16 rx_control)
 			__mod_retrans_timer();
 
 		pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
-		if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
+		if (pi->conn_state & L2CAP_CONN_SREJ_SENT)
 			l2cap_send_ack(pi);
-		} else {
+		else
 			l2cap_ertm_send(sk);
-		}
 	}
 }
 
-- 
1.7.1

