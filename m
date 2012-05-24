Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 09/12] Bluetooth: check for already existent channel before create new one
Date: Thu, 24 May 2012 19:59:49 -0300
Message-Id: <1337900389-30915-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
References: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Move this check to before the channel time creation simplifies the code
and avoid memory allocation if the channel already exist.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7719508..0df7f49 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3340,21 +3340,16 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	result = L2CAP_CR_NO_MEM;
 
+	/* Check if we already have channel with that dcid */
+	if (__l2cap_get_chan_by_dcid(conn, scid))
+		goto response;
+
 	chan = pchan->ops->new_connection(pchan->data);
 	if (!chan)
 		goto response;
 
 	sk = chan->sk;
 
-	/* Check if we already have channel with that dcid */
-	if (__l2cap_get_chan_by_dcid(conn, scid)) {
-		if (chan->ops->teardown)
-			chan->ops->teardown(chan->data, 0);
-
-		chan->ops->close(chan->data);
-		goto response;
-	}
-
 	hci_conn_hold(conn->hcon);
 
 	bacpy(&bt_sk(sk)->src, conn->src);
-- 
1.7.10.1

