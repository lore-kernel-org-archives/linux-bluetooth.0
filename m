Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Introduce trusted flag for management control sockets
Date: Sat, 14 Mar 2015 17:36:43 -0700
Message-Id: <1426379804-16300-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Providing a global trusted flag for management control sockets provides
an easy way for identifying sockets and imposing restriction on it. For
now all management sockets are trusted since they require CAP_NET_ADMIN.

The same applies to monitor sockets since they require CAP_NET_RAW and
with that are implicitly trusted.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_sock.c    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b8318711135a..7a24acaafeea 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -181,6 +181,7 @@ enum {
 
 /* HCI socket flags */
 enum {
+	HCI_SOCK_TRUSTED,
 	HCI_MGMT_INDEX_EVENTS,
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
 	HCI_MGMT_EXT_INDEX_EVENTS,
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 00775c4fef83..54118868b3f6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -796,6 +796,11 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
+		/* The monitor interface is restricted to CAP_NET_RAW
+		 * capabilities and with that implicitly trusted.
+		 */
+		hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
+
 		send_monitor_replay(sk);
 
 		atomic_inc(&monitor_promisc);
@@ -817,6 +822,12 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
+		/* Since the access to control channels is currently
+		 * restricted to CAP_NET_ADMIN capabilities, every
+		 * socket is implicitly trusted.
+		 */
+		hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
+
 		/* At the moment the index and unconfigured index events
 		 * are enabled unconditionally. Setting them on each
 		 * socket when binding keeps this functionality. They
-- 
2.1.0

