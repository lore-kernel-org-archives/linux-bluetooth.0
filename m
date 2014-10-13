Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	jukka.rissanen@linux.intel.com,
	johan.hedberg@gmail.com,
	Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH bluetooth] Bluetooth: Fix missing channel unlock in l2cap_le_credits
Date: Mon, 13 Oct 2014 19:24:45 +0100
Message-Id: <1413224685-3700-1-git-send-email-mtownsend1973@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

In the error case where credits is greater than max_credits there
is a missing l2cap_chan_unlock before returning.

Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
---
 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 46547b9..bfb6af8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5544,6 +5544,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	if (credits > max_credits) {
 		BT_ERR("LE credits overflow");
 		l2cap_send_disconn_req(chan, ECONNRESET);
+		l2cap_chan_unlock(chan);
 
 		/* Return 0 so that we don't trigger an unnecessary
 		 * command reject packet.
-- 
1.9.1
