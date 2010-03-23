Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 06/19] Bluetooth: Fix expected_tx_seq calculation on L2CAP
Date: Tue, 23 Mar 2010 16:48:33 -0300
Message-Id: <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

All operation related to the txWindow should be modulo 64.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 36fac64..03caa2c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3660,7 +3660,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (pi->expected_tx_seq == tx_seq)
 			pi->expected_tx_seq = (pi->expected_tx_seq + 1) % 64;
 		else
-			pi->expected_tx_seq = tx_seq + 1;
+			pi->expected_tx_seq = (tx_seq + 1) % 64;
 
 		l2cap_sar_reassembly_sdu(sk, skb, control);
 
-- 
1.6.4.4
