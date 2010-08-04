Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 8/9] Bluetooth:  Use a stream-oriented recvmsg with SOCK_STREAM L2CAP sockets.
Date: Wed,  4 Aug 2010 15:49:05 -0700
Message-Id: <1280962146-22604-9-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
References: <1280962146-22604-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP ERTM sockets can be opened with the SOCK_STREAM socket type,
which is a mandatory request for ERTM mode.

However, these sockets still have SOCK_SEQPACKET read semantics when
bt_sock_recvmsg() is used to pull data from the receive queue.  If the
application is only reading part of a frame, then the unread portion
of the frame is discarded.  If the application requests more bytes
than are in the current frame, only the current frame's data is
returned.

This patch utilizes common code derived from RFCOMM's recvmsg()
function to make L2CAP SOCK_STREAM reads behave like RFCOMM reads (and
other SOCK_STREAM sockets in general).  The application may read one
byte at a time from the input stream and not lose any data, and may
also read across L2CAP frame boundaries.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index f0f3c7c..b9de88d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1956,7 +1956,10 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	release_sock(sk);
 
-	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
+	if (sock->type == SOCK_STREAM)
+		return bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
+	else
+		return bt_sock_recvmsg(iocb, sock, msg, len, flags);
 }
 
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
