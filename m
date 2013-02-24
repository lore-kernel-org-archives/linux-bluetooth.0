Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 01/16] Bluetooth: discard bt_sock_unregister() errors
Date: Sun, 24 Feb 2013 19:36:51 +0100
Message-Id: <1361731026-7428-2-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

After we successfully registered a socket via bt_sock_register() there is
no reason to ever check the return code of bt_sock_unregister(). If
bt_sock_unregister() fails, it means the socket _is_ already unregistered
so we have what we want, don't we?

Also, to get bt_sock_unregister() to fail, another part of the kernel has
to unregister _our_ socket. This is sooo _wrong_ that it will break way
earlier than when we unregister our socket.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/bluetooth/bnep/sock.c   | 4 +---
 net/bluetooth/cmtp/sock.c   | 4 +---
 net/bluetooth/hci_sock.c    | 4 +---
 net/bluetooth/hidp/sock.c   | 4 +---
 net/bluetooth/l2cap_sock.c  | 4 +---
 net/bluetooth/rfcomm/sock.c | 3 +--
 net/bluetooth/sco.c         | 3 +--
 7 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index e7154a5..5b1c04e 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -253,8 +253,6 @@ error:
 void __exit bnep_sock_cleanup(void)
 {
 	bt_procfs_cleanup(&init_net, "bnep");
-	if (bt_sock_unregister(BTPROTO_BNEP) < 0)
-		BT_ERR("Can't unregister BNEP socket");
-
+	bt_sock_unregister(BTPROTO_BNEP);
 	proto_unregister(&bnep_proto);
 }
diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index 1c57482..58d9ede 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -264,8 +264,6 @@ error:
 void cmtp_cleanup_sockets(void)
 {
 	bt_procfs_cleanup(&init_net, "cmtp");
-	if (bt_sock_unregister(BTPROTO_CMTP) < 0)
-		BT_ERR("Can't unregister CMTP socket");
-
+	bt_sock_unregister(BTPROTO_CMTP);
 	proto_unregister(&cmtp_proto);
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 07f0739..20c92de 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1126,8 +1126,6 @@ error:
 void hci_sock_cleanup(void)
 {
 	bt_procfs_cleanup(&init_net, "hci");
-	if (bt_sock_unregister(BTPROTO_HCI) < 0)
-		BT_ERR("HCI socket unregistration failed");
-
+	bt_sock_unregister(BTPROTO_HCI);
 	proto_unregister(&hci_sk_proto);
 }
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 82a829d..5d0f1ca 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -304,8 +304,6 @@ error:
 void __exit hidp_cleanup_sockets(void)
 {
 	bt_procfs_cleanup(&init_net, "hidp");
-	if (bt_sock_unregister(BTPROTO_HIDP) < 0)
-		BT_ERR("Can't unregister HIDP socket");
-
+	bt_sock_unregister(BTPROTO_HIDP);
 	proto_unregister(&hidp_proto);
 }
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1bcfb84..7f97049 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1312,8 +1312,6 @@ error:
 void l2cap_cleanup_sockets(void)
 {
 	bt_procfs_cleanup(&init_net, "l2cap");
-	if (bt_sock_unregister(BTPROTO_L2CAP) < 0)
-		BT_ERR("L2CAP socket unregistration failed");
-
+	bt_sock_unregister(BTPROTO_L2CAP);
 	proto_unregister(&l2cap_proto);
 }
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index ce3f665..851ecc9 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1068,8 +1068,7 @@ void __exit rfcomm_cleanup_sockets(void)
 
 	debugfs_remove(rfcomm_sock_debugfs);
 
-	if (bt_sock_unregister(BTPROTO_RFCOMM) < 0)
-		BT_ERR("RFCOMM socket layer unregistration failed");
+	bt_sock_unregister(BTPROTO_RFCOMM);
 
 	proto_unregister(&rfcomm_proto);
 }
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 57f250c..da479cd 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1113,8 +1113,7 @@ void __exit sco_exit(void)
 
 	debugfs_remove(sco_debugfs);
 
-	if (bt_sock_unregister(BTPROTO_SCO) < 0)
-		BT_ERR("SCO socket unregistration failed");
+	bt_sock_unregister(BTPROTO_SCO);
 
 	proto_unregister(&sco_proto);
 }
-- 
1.8.1.4
