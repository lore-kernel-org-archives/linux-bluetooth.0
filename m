Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Check SOL_HCI for raw socket options
Date: Sat, 27 Aug 2016 20:23:37 +0200
Message-Id: <1472322221-86761-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SOL_HCI level should be enforced when using socket options on the
HCI raw socket interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 96f04b7b9556..99dd1503ef56 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1440,6 +1440,9 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
+	if (level != SOL_HCI)
+		return -ENOPROTOOPT;
+
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
@@ -1523,6 +1526,9 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
+	if (level != SOL_HCI)
+		return -ENOPROTOOPT;
+
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-- 
2.7.4

