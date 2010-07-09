Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/2] Bluetooth: Fix bug in kzalloc allocation size
Date: Fri,  9 Jul 2010 16:38:34 -0300
Message-Id: <1278704315-28192-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Probably a typo error. We were using the wrong struct to get size.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e366be0..419e2c3 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -530,7 +530,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 						conn->feat_mask)
 						&& l2cap_pi(sk)->conf_state &
 						L2CAP_CONF_STATE2_DEVICE) {
-					tmp1 = kzalloc(sizeof(struct srej_list),
+					tmp1 = kzalloc(sizeof(struct sock_del_list),
 							GFP_ATOMIC);
 					tmp1->sk = sk;
 					list_add_tail(&tmp1->list, &del.list);
-- 
1.7.1

