Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/4] Bluetooth: Validate PSM values in calls to connect() and bind()
Date: Wed,  8 Sep 2010 10:05:26 -0700
Message-Id: <1283965529-17068-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Valid L2CAP PSMs are odd numbers, and the least significant bit of the
most significant byte must be 0.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c784703..b5eff42 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1008,10 +1008,20 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		goto done;
 	}
 
-	if (la.l2_psm && __le16_to_cpu(la.l2_psm) < 0x1001 &&
-				!capable(CAP_NET_BIND_SERVICE)) {
-		err = -EACCES;
-		goto done;
+	if (la.l2_psm) {
+		__u16 psm = __le16_to_cpu(la.l2_psm);
+
+		/* PSM must be odd and lsb of upper byte must be 0 */
+		if ((psm & 0x0101) != 0x0001) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		/* Restrict usage of well-known PSMs */
+		if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE)) {
+			err = -EACCES;
+			goto done;
+		}
 	}
 
 	write_lock_bh(&l2cap_sk_list.lock);
@@ -1190,6 +1200,13 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 		goto done;
 	}
 
+	/* PSM must be odd and lsb of upper byte must be 0 */
+	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 &&
+		sk->sk_type != SOCK_RAW) {
+		err = -EINVAL;
+		goto done;
+	}
+
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
 	l2cap_pi(sk)->psm = la.l2_psm;
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
