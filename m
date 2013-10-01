Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Require CAP_NET_ADMIN for HCI User Channel operation
Date: Tue,  1 Oct 2013 07:40:01 -0700
Message-Id: <1380638401-39890-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI User Channel operation is an admin operation that puts the
device into promiscuous mode for single use. It is more suitable
to require CAP_NET_ADMIN than CAP_NET_RAW.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index c09e976..5798861 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -687,7 +687,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
-		if (!capable(CAP_NET_RAW)) {
+		if (!capable(CAP_NET_ADMIN)) {
 			err = -EPERM;
 			goto done;
 		}
-- 
1.8.3.1

