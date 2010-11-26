Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/4] Bluetooth: clean up l2cap code
Date: Fri, 26 Nov 2010 17:22:44 +0200
Message-Id: <1290784965-4508-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

clean extra spaces, do not initialize static to zero, macros
with complex values enclosed to ().

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/l2cap.h |   22 +++++++++++-----------
 net/bluetooth/l2cap.c         |    7 +++----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c819c8b..7ad25ca 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -1,4 +1,4 @@
-/* 
+/*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
    Copyright (C) 2009-2010 Gustavo F. Padovan <gustavo@padovan.org>
@@ -14,13 +14,13 @@
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
    IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
-   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
-   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
-   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 
-   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
-   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
    SOFTWARE IS DISCLAIMED.
 */
 
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

