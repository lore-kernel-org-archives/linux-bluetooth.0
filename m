Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 4/4] Bluetooth: Use a stream-oriented recvmsg with SOCK_STREAM L2CAP sockets.
Date: Wed,  8 Sep 2010 10:05:29 -0700
Message-Id: <1283965529-17068-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
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
 net/bluetooth/l2cap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b5eff42..38aa78c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1961,6 +1961,9 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	release_sock(sk);
 
+	if (sock->type == SOCK_STREAM)
+		return bt_sock_stream_recvmsg(iocb, sock, msg, len, flags);
+
 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
 }
 
-- 
1.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
