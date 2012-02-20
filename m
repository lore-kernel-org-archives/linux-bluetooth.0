Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Simplify HCI socket bind handling
Date: Mon, 20 Feb 2012 11:58:39 +0100
Message-Id: <1329735520-23539-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI socket bind handling checks a few too many times the channel
we are binding. So centralize this and make the function easier to read.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |   47 ++++++++++++++++++++++++++++++---------------
 1 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 3d4d669..1b47d71 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -367,34 +367,49 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 	if (haddr.hci_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (haddr.hci_channel > HCI_CHANNEL_CONTROL)
-		return -EINVAL;
-
-	if (haddr.hci_channel == HCI_CHANNEL_CONTROL) {
-		if (!enable_mgmt)
-			return -EINVAL;
-		set_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags);
-	}
-
 	lock_sock(sk);
 
-	if (sk->sk_state == BT_BOUND || hci_pi(sk)->hdev) {
+	if (sk->sk_state == BT_BOUND) {
 		err = -EALREADY;
 		goto done;
 	}
 
-	if (haddr.hci_dev != HCI_DEV_NONE) {
-		hdev = hci_dev_get(haddr.hci_dev);
-		if (!hdev) {
-			err = -ENODEV;
+	switch (haddr.hci_channel) {
+	case HCI_CHANNEL_RAW:
+		if (hci_pi(sk)->hdev) {
+			err = -EALREADY;
 			goto done;
 		}
 
-		atomic_inc(&hdev->promisc);
+		if (haddr.hci_dev != HCI_DEV_NONE) {
+			hdev = hci_dev_get(haddr.hci_dev);
+			if (!hdev) {
+				err = -ENODEV;
+				goto done;
+			}
+
+			atomic_inc(&hdev->promisc);
+		}
+
+		hci_pi(sk)->hdev = hdev;
+		break;
+
+	case HCI_CHANNEL_CONTROL:
+		if (haddr.hci_dev != HCI_DEV_NONE || !enable_mgmt) {
+			err = -EINVAL;
+			goto done;
+		}
+
+		set_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags);
+		break;
+
+	default:
+		err = -EINVAL;
+		goto done;
 	}
 
+
 	hci_pi(sk)->channel = haddr.hci_channel;
-	hci_pi(sk)->hdev = hdev;
 	sk->sk_state = BT_BOUND;
 
 done:
-- 
1.7.7.6

