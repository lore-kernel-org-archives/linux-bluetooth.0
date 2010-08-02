Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 7/8] Bluetooth:  Use a stream-oriented recvmsg with SOCK_STREAM L2CAP sockets.
Date: Mon,  2 Aug 2010 12:20:09 -0700
Message-Id: <1280776810-18213-8-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 582975b..8e9fa51 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1923,6 +1923,7 @@ done:
 static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
+	int len_or_err;
 
 	lock_sock(sk);
 
@@ -1956,7 +1957,13 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	release_sock(sk);
 
-	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
+	if (sock->type == SOCK_STREAM)
+		len_or_err = bt_sock_stream_recvmsg(iocb, sock, msg, len,
+						flags);
+	else
+		len_or_err = bt_sock_recvmsg(iocb, sock, msg, len, flags);
+
+	return len_or_err;
 }
 
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
