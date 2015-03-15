Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Open management interface for untrusted users
Date: Sat, 14 Mar 2015 18:23:48 -0700
Message-Id: <1426382628-14785-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now the management interface was restricted to CAP_NET_ADMIN. With
this change every user can open the management socket. However the list
of commands is heavily restricted to getting basic information about the
attached controllers. No access for configuration or other operation is
provided. The events are also limited. This is done so that no keys can
leak or untrusted users can mess with the Bluetooth configuration.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index df23c184c897..f4b10344b1e5 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -795,16 +795,13 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
-		if (!capable(CAP_NET_ADMIN)) {
-			err = -EPERM;
-			goto done;
-		}
-
-		/* Since the access to control channels is currently
-		 * restricted to CAP_NET_ADMIN capabilities, every
-		 * socket is implicitly trusted.
+		/* Users with CAP_NET_ADMIN capabilities are allowed
+		 * access to all management commands and events. For
+		 * untrusted users the interface is restricted and
+		 * also only untrusted events are sent.
 		 */
-		hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
+		if (capable(CAP_NET_ADMIN))
+			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		/* At the moment the index and unconfigured index events
 		 * are enabled unconditionally. Setting them on each
-- 
2.1.0

