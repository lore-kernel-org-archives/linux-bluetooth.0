Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 2/3] Bluetooth: remove duplicated code
Date: Thu, 24 Mar 2011 17:16:07 +0200
Message-Id: <1300979768-31963-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

info_timer takes care about removed code

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap_core.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fd58b8f..4255f00 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2472,16 +2472,10 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 		return 0;
 	}
 
-	del_timer(&conn->info_timer);
-
-	if (result != L2CAP_IR_SUCCESS) {
-		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
-		conn->info_ident = 0;
-
-		l2cap_conn_start(conn);
-
+	if (result != L2CAP_IR_SUCCESS)
 		return 0;
-	}
+
+	del_timer(&conn->info_timer);
 
 	if (type == L2CAP_IT_FEAT_MASK) {
 		conn->feat_mask = get_unaligned_le32(rsp->data);
-- 
1.7.1

