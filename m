Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Restrict access to management interface
Date: Mon, 20 Feb 2012 20:54:10 +0100
Message-Id: <1329767650-6355-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The management interface on the HCI control channel should be restricted
to applications with CAP_NET_ADMIN permission.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 213697d..8c429a1 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -656,6 +656,11 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 			goto done;
 		}
 
+		if (!capable(CAP_NET_ADMIN)) {
+			err = -EPERM;
+			goto done;
+		}
+
 		set_bit(HCI_PI_MGMT_INIT, &hci_pi(sk)->flags);
 		break;
 
-- 
1.7.7.6

