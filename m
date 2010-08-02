Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 3/8] Bluetooth:  Validate PSM values in calls to connect() and bind().
Date: Mon,  2 Aug 2010 12:20:05 -0700
Message-Id: <1280776810-18213-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index aed72f2..44bc6ee 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1008,6 +1008,12 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		goto done;
 	}
 
+	/* If specified, PSM must be odd and lsb of upper byte must be 0 */
+	if (la.l2_psm && (__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001) {
+		err = -EINVAL;
+		goto done;
+	}
+
 	if (la.l2_psm && __le16_to_cpu(la.l2_psm) < 0x1001 &&
 				!capable(CAP_NET_BIND_SERVICE)) {
 		err = -EACCES;
@@ -1190,6 +1196,12 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
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
