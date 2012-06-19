Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0] Bluetooth: Fix lost socket error code
Date: Tue, 19 Jun 2012 16:20:37 +0200
Message-Id: <1340115637-2595-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Using sock_error() here to check the status of the socket is wrong
because it resets sk->sk_err to zero. For RFCOMM sockets, this means the
disconnect reason is not exposed to userland in the socket options.

Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
This a second attempt to expose ACL disconnect reason to userland, as proposed first in "[RFC v0] Bluetooth: mgmt: Add device disconnect reason".

The motivation behind was explained in the userspace patchset "[RFC BlueZ v0 0/5] ACL disconnect reason".

This second approach focuses on RFCOMM sockets given that L2CAP is already exposing such information.

 net/bluetooth/af_bluetooth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index f7db579..4799338 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -313,7 +313,7 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 			if (copied >= target)
 				break;
 
-			err = sock_error(sk);
+			err = sk->sk_err;
 			if (err)
 				break;
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
-- 
1.7.7.6

