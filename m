Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFCv2 2/8] Bluetooth: Remove unused function
Date: Fri, 27 Apr 2012 16:50:49 -0700
Message-Id: <1335570655-30878-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_get_chan_by_ident was not used, but didn't generate a compiler
warning because it was an inline function.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 78a334b..c3d3cfc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -121,17 +121,6 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8
 	return NULL;
 }
 
-static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
-{
-	struct l2cap_chan *c;
-
-	mutex_lock(&conn->chan_lock);
-	c = __l2cap_get_chan_by_ident(conn, ident);
-	mutex_unlock(&conn->chan_lock);
-
-	return c;
-}
-
 static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
 {
 	struct l2cap_chan *c;
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
