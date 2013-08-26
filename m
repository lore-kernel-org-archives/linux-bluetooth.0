Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix error handling for HCI socket options
Date: Mon, 26 Aug 2013 09:29:39 -0700
Message-Id: <1377534579-5781-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI sockets for monitor and control do not support any HCI specific
socket options and if tried, an error will be returned. However the
error used is EINVAL and that is not really descriptive. To make it
clear that these sockets are not handling HCI socket options, return
EBADFD instead.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 49c5c62..f92e913 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -921,7 +921,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
-		err = -EINVAL;
+		err = -EBADFD;
 		goto done;
 	}
 
@@ -1007,7 +1007,7 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
-		err = -EINVAL;
+		err = -EBADFD;
 		goto done;
 	}
 
-- 
1.8.3.1

