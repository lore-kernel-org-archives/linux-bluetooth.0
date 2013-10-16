Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/7] Bluetooth: Remove not used struct sock
Date: Wed, 16 Oct 2013 16:08:29 -0300
Message-Id: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

It is a leftover from the recent effort of remove sk usage from L2CAP
core.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8af34d2..5d99394 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3718,7 +3718,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	struct sock *parent, *sk = NULL;
+	struct sock *parent;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3757,8 +3757,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	if (!chan)
 		goto response;
 
-	sk = chan->sk;
-
 	/* For certain devices (ex: HID mouse), support for authentication,
 	 * pairing and bonding is optional. For such devices, inorder to avoid
 	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
-- 
1.8.3.1

