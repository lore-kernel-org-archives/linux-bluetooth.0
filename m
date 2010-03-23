Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 17/19] Bluetooth: Ignore I-frames with a duplicated txSeq
Date: Tue, 23 Mar 2010 16:48:44 -0300
Message-Id: <1269373726-13209-18-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-17-git-send-email-padovan@profusion.mobi>
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
 <1269373726-13209-16-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-17-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP Enhanced Retransmission Mode shall ignore all I-frames with a
duplicated txSeq.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 85f97b9..b431dc5 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3413,6 +3413,13 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	if (tx_seq == pi->expected_tx_seq)
 		goto expected;
 
+	/* Check for duplicated tx_seq. This actually
+	 * subtracts 1 from expected_tx_seq */
+	if (tx_seq == (pi->expected_tx_seq + 63) % 64) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	if (pi->conn_state & L2CAP_CONN_SREJ_SENT) {
 		struct srej_list *first;
 
-- 
1.6.4.4
