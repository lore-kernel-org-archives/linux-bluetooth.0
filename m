Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 5/6] Revert "Bluetooth: Don't accept ConfigReq if we aren't in the BT_CONFIG state"
Date: Fri, 24 Sep 2010 22:01:43 -0300
Message-Id: <1285376504-3541-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1285376504-3541-5-git-send-email-gustavo@padovan.org>
References: <1285376504-3541-1-git-send-email-gustavo@padovan.org>
 <1285376504-3541-2-git-send-email-gustavo@padovan.org>
 <1285376504-3541-3-git-send-email-gustavo@padovan.org>
 <1285376504-3541-4-git-send-email-gustavo@padovan.org>
 <1285376504-3541-5-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

This reverts commit 8cb8e6f1684be13b51f8429b15f39c140326b327.

That commit introduced a regression with the Bluetooth Profile Tuning
Suite(PTS), Reverting this make sure that L2CAP is in a qualificable
state.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index f2062aa..44a8fb0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3089,14 +3089,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!sk)
 		return -ENOENT;
 
-	if (sk->sk_state != BT_CONFIG) {
-		struct l2cap_cmd_rej rej;
-
-		rej.reason = cpu_to_le16(0x0002);
-		l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
-				sizeof(rej), &rej);
+	if (sk->sk_state == BT_DISCONN)
 		goto unlock;
-	}
 
 	/* Reject if config buffer is too small. */
 	len = cmd_len - sizeof(*req);
-- 
1.7.2.2

