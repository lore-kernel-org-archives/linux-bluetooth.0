Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add option for disabling legacy ioctl interfaces
Date: Mon, 21 Aug 2017 01:29:08 -0700
Message-Id: <20170821082908.12296-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The legacy ioctl interfaces are only useful for BR/EDR operation and
since Linux 3.4 no longer needed anyway. This options allows disabling
them alltogether and use only management interfaces for setup and
control.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/Kconfig    | 10 ++++++++++
 net/bluetooth/hci_sock.c |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index db82a40875e8..c18115d22f00 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -126,4 +126,14 @@ config BT_DEBUGFS
 	  Provide extensive information about internal Bluetooth states
 	  in debugfs.
 
+config BT_LEGACY_IOCTL
+	bool "Enable legacy ioctl interfaces"
+	depends on BT && BT_BREDR
+	default y
+	help
+	  Enable support for legacy ioctl interfaces.  This is only needed
+	  for old and deprecated applications using direct ioctl calls for
+	  controller management.  Since Linux 3.4 all configuration and
+	  setup is done via mgmt interface and this is no longer needed.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 65d734c165bd..0bad296fe0af 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -878,6 +878,7 @@ static int hci_sock_release(struct socket *sock)
 	return 0;
 }
 
+#ifdef CONFIG_BT_LEGACY_IOCTL
 static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
 {
 	bdaddr_t bdaddr;
@@ -1049,6 +1050,7 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	release_sock(sk);
 	return err;
 }
+#endif
 
 static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
@@ -1969,7 +1971,11 @@ static const struct proto_ops hci_sock_ops = {
 	.getname	= hci_sock_getname,
 	.sendmsg	= hci_sock_sendmsg,
 	.recvmsg	= hci_sock_recvmsg,
+#ifdef CONFIG_BT_LEGACY_IOCTL
 	.ioctl		= hci_sock_ioctl,
+#else
+	.ioctl		= sock_no_ioctl,
+#endif
 	.poll		= datagram_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.13.5

