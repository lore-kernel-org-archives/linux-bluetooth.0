Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Limit security mode 4 level 0 to connection oriented channels
Date: Sat, 12 Oct 2013 06:46:55 -0700
Message-Id: <1381585615-50786-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The exception for SDP and RFCOMM channels when it comes to security
mode 4 level 0 should only be checked when actually a connection
oriented channel is established.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_sock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 69e42db..bee98eb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -100,9 +100,13 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (err < 0)
 		goto done;
 
-	if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
-	    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
-		chan->sec_level = BT_SECURITY_SDP;
+	switch (chan->chan_type) {
+	case L2CAP_CHAN_CONN_ORIENTED:
+		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
+		    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
+			chan->sec_level = BT_SECURITY_SDP;
+		break;
+	}
 
 	bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
 
-- 
1.8.3.1

