Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 1/7] Bluetooth: Remove leftover debug messages
Date: Fri, 13 May 2011 16:20:44 -0300
Message-Id: <1305314450-25493-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305314450-25493-1-git-send-email-padovan@profusion.mobi>
References: <1305314450-25493-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

They were added by me while testing and I forgot to remove.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d0769a8..a5ab4a2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2095,7 +2095,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
 	__le16 psm = req->psm;
 
-	BT_ERR("psm 0x%2.2x scid 0x%4.4x", psm, scid);
+	BT_DBG("psm 0x%2.2x scid 0x%4.4x", psm, scid);
 
 	/* Check if we have socket listening on psm */
 	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, conn->src);
@@ -2104,8 +2104,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto sendresp;
 	}
 
-	BT_ERR("%p 0x%2.2x", pchan, pchan->psm);
-
 	parent = pchan->sk;
 
 	bh_lock_sock(parent);
-- 
1.7.5.rc3

