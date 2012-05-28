Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 08/10] Bluetooth: check for already existent channel before create new one
Date: Sun, 27 May 2012 22:27:58 -0300
Message-Id: <1338168480-9646-8-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Move this check to before the channel time creation simplifies the code
and avoid memory allocation if the channel already exist.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 35c2c52..584c66f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3341,21 +3341,16 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	result = L2CAP_CR_NO_MEM;
 
+	/* Check if we already have channel with that dcid */
+	if (__l2cap_get_chan_by_dcid(conn, scid))
+		goto response;
+
 	chan = pchan->ops->new_connection(pchan);
 	if (!chan)
 		goto response;
 
 	sk = chan->sk;
 
-	/* Check if we already have channel with that dcid */
-	if (__l2cap_get_chan_by_dcid(conn, scid)) {
-		if (chan->ops->teardown)
-			chan->ops->teardown(chan, 0);
-
-		chan->ops->close(chan);
-		goto response;
-	}
-
 	hci_conn_hold(conn->hcon);
 
 	bacpy(&bt_sk(sk)->src, conn->src);
-- 
1.7.10.2

