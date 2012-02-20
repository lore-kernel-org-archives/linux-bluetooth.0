Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Limit HCI raw socket options to actual raw sockets
Date: Mon, 20 Feb 2012 11:58:36 +0100
Message-Id: <1329735520-23539-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently the socket options of HCI sockets can be set on raw and control
sockets, but on control sockets they make no sense. So just return EINVAL
in that case.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d3381f9..3d86aa6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -601,6 +601,11 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname, char
 
 	lock_sock(sk);
 
+	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
+		err = -EINVAL;
+		goto done;
+	}
+
 	switch (optname) {
 	case HCI_DATA_DIR:
 		if (get_user(opt, (int __user *)optval)) {
@@ -663,6 +668,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname, char
 		break;
 	}
 
+done:
 	release_sock(sk);
 	return err;
 }
-- 
1.7.7.6

