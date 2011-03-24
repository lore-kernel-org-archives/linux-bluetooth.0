Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 1/3] Bluetooth: check info_rsp ident and states
Date: Thu, 24 Mar 2011 17:16:06 +0200
Message-Id: <1300979768-31963-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Information requests/responses are unbound to L2CAP channel. Patch
fixes issue arising when two devices connects at the same time to
each other. This way we do not process out of the context messages.
We are safe dropping info_rsp since info_timer is left running.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap_core.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ca27f3a..fd58b8f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2462,6 +2462,16 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 
 	BT_DBG("type 0x%4.4x result 0x%2.2x", type, result);
 
+	if (cmd->ident != conn->info_ident) {
+		BT_DBG("Collision receiving info response");
+		return 0;
+	}
+
+	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
+		BT_DBG("Information request already done");
+		return 0;
+	}
+
 	del_timer(&conn->info_timer);
 
 	if (result != L2CAP_IR_SUCCESS) {
-- 
1.7.1

