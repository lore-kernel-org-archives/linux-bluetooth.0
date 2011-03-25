Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: check L2CAP info_rsp ident and state
Date: Fri, 25 Mar 2011 11:31:41 +0200
Message-Id: <1301045501-3346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Information requests/responses are unbound to L2CAP channel. Patch
fixes issue arising when two devices connects at the same time to
each other. This way we do not process out of the context messages.
We are safe dropping info_rsp since info_timer is left running.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap_core.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b5a1ce0..1426c03 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2460,6 +2460,11 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 
 	BT_DBG("type 0x%4.4x result 0x%2.2x", type, result);
 
+	/* L2CAP Info req/rsp are unbound to channels, add extra checks */
+	if (cmd->ident != conn->info_ident ||
+			conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE)
+		return 0;
+
 	del_timer(&conn->info_timer);
 
 	if (result != L2CAP_IR_SUCCESS) {
-- 
1.7.1

