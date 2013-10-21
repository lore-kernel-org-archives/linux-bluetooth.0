Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 1/5] Bluetooth: Remove not used struct sock
Date: Mon, 21 Oct 2013 14:21:37 -0200
Message-Id: <1382372501-28562-1-git-send-email-gustavo@padovan.org>
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
index d52bd0d..4141545 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3726,7 +3726,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan = NULL, *pchan;
-	struct sock *parent, *sk = NULL;
+	struct sock *parent;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
@@ -3765,8 +3765,6 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	if (!chan)
 		goto response;
 
-	sk = chan->sk;
-
 	/* For certain devices (ex: HID mouse), support for authentication,
 	 * pairing and bonding is optional. For such devices, inorder to avoid
 	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
-- 
1.8.3.1

