Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 2/5] Bluetooth: Validate PSM values in calls to connect() and bind().
Date: Tue, 10 Aug 2010 12:00:47 -0700
Message-Id: <1281466850-5297-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1281466850-5297-1-git-send-email-mathewm@codeaurora.org>
References: <1281466850-5297-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Valid L2CAP PSMs are odd numbers, and the least significant bit of the
most significant byte must be 0.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c784703..61aa961 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1008,10 +1008,19 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		goto done;
 	}
 
-	if (la.l2_psm && __le16_to_cpu(la.l2_psm) < 0x1001 &&
-				!capable(CAP_NET_BIND_SERVICE)) {
-		err = -EACCES;
-		goto done;
+	/* If specified, PSM must be odd and lsb of upper byte must be 0 */
+	if (la.l2_psm) {
+		__u16 psm = __le16_to_cpu(la.l2_psm);
+
+		if ((psm & 0x0101) != 0x0001) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE)) {
+			err = -EACCES;
+			goto done;
+		}
 	}
 
 	write_lock_bh(&l2cap_sk_list.lock);
@@ -1190,6 +1199,12 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 		goto done;
 	}
 
+	/* PSM must be odd and lsb of upper byte must be 0 */
+	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001) {
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
