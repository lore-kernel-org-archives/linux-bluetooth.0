Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 15/19] Bluetooth: Remove duplicate use of __get_reqseq() macro on L2CAP
Date: Tue, 23 Mar 2010 16:48:42 -0300
Message-Id: <1269373726-13209-16-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-15-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-9-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-10-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-11-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-12-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-13-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-14-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-15-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

tx_seq var already has the value of __get_reqseq().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d6667fa..9546f59 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3529,7 +3529,7 @@ static inline void l2cap_data_channel_rejframe(struct sock *sk, u16 rx_control)
 
 	pi->conn_state &= ~L2CAP_CONN_REMOTE_BUSY;
 
-	pi->expected_ack_seq = __get_reqseq(rx_control);
+	pi->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(sk);
 
 	if (rx_control & L2CAP_CTRL_FINAL) {
-- 
1.6.4.4
