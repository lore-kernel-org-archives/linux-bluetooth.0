Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Bluetooth: Fix out of scope variable access in
 hci_sock_cmsg()
From: Johann Felix Soden <johfel@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Feb 2010 22:23:48 +0100
Message-ID: <1266269028.8680.4.camel@LAPJFS>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johann Felix Soden <johfel@users.sourceforge.net>

The pointer data can point to the variable ctv.
Access to data happens when ctv is already out of scope.

Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
---
 net/bluetooth/hci_sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 688cfeb..b0e6108 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -338,8 +338,8 @@ static inline void hci_sock_cmsg(struct sock *sk, struct msghdr *msg, struct sk_
 		data = &tv;
 		len = sizeof(tv);
 #ifdef CONFIG_COMPAT
+		struct compat_timeval ctv;
 		if (msg->msg_flags & MSG_CMSG_COMPAT) {
-			struct compat_timeval ctv;
 			ctv.tv_sec = tv.tv_sec;
 			ctv.tv_usec = tv.tv_usec;
 			data = &ctv;
-- 
1.6.6.2
