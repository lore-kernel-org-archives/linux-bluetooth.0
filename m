Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Assign the channel early when binding HCI sockets
Date: Tue, 30 Aug 2016 05:00:37 +0200
Message-Id: <1472526040-21804-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Assignment of the hci_pi(sk)->channel should be done early when binding
the HCI socket. This avoids confusion with the RAW channel that is used
for legacy access.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6137cda1c87c..5c7d3fba9817 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1045,6 +1045,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			atomic_inc(&hdev->promisc);
 		}
 
+		hci_pi(sk)->channel = haddr.hci_channel;
 		hci_pi(sk)->hdev = hdev;
 		break;
 
@@ -1107,9 +1108,10 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			}
 		}
 
-		atomic_inc(&hdev->promisc);
-
+		hci_pi(sk)->channel = haddr.hci_channel;
 		hci_pi(sk)->hdev = hdev;
+
+		atomic_inc(&hdev->promisc);
 		break;
 
 	case HCI_CHANNEL_MONITOR:
@@ -1123,6 +1125,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
+		hci_pi(sk)->channel = haddr.hci_channel;
+
 		/* The monitor interface is restricted to CAP_NET_RAW
 		 * capabilities and with that implicitly trusted.
 		 */
@@ -1149,6 +1153,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			err = -EPERM;
 			goto done;
 		}
+
+		hci_pi(sk)->channel = haddr.hci_channel;
 		break;
 
 	default:
@@ -1170,6 +1176,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		if (capable(CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
+		hci_pi(sk)->channel = haddr.hci_channel;
+
 		/* At the moment the index and unconfigured index events
 		 * are enabled unconditionally. Setting them on each
 		 * socket when binding keeps this functionality. They
@@ -1180,7 +1188,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 * received by untrusted users. Example for such events
 		 * are changes to settings, class of device, name etc.
 		 */
-		if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
+		if (hci_pi(sk)->channel == HCI_CHANNEL_CONTROL) {
 			struct sk_buff *skb;
 
 			hci_sock_gen_cookie(sk);
@@ -1203,8 +1211,6 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		break;
 	}
 
-
-	hci_pi(sk)->channel = haddr.hci_channel;
 	sk->sk_state = BT_BOUND;
 
 done:
-- 
2.7.4

