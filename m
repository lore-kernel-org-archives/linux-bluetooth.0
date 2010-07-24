Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/2] Bluetooth: Add __init and __exit marks to RFCOMM
Date: Sat, 24 Jul 2010 02:04:45 -0300
Message-Id: <1279947885-19304-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1279947885-19304-1-git-send-email-gustavo@padovan.org>
References: <1279947885-19304-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Those annotation save memory and space on the binary. __init code is
discarded just after execute and __exit code is discarded if the module is
built into the kernel image or unload of modules is not allowed.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/sock.c |    2 +-
 net/bluetooth/rfcomm/tty.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 43fbf6b..44a6232 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -1152,7 +1152,7 @@ error:
 	return err;
 }
 
-void rfcomm_cleanup_sockets(void)
+void __exit rfcomm_cleanup_sockets(void)
 {
 	debugfs_remove(rfcomm_sock_debugfs);
 
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 309b6c2..026205c 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1153,7 +1153,7 @@ static const struct tty_operations rfcomm_ops = {
 	.tiocmset		= rfcomm_tty_tiocmset,
 };
 
-int rfcomm_init_ttys(void)
+int __init rfcomm_init_ttys(void)
 {
 	rfcomm_tty_driver = alloc_tty_driver(RFCOMM_TTY_PORTS);
 	if (!rfcomm_tty_driver)
@@ -1183,7 +1183,7 @@ int rfcomm_init_ttys(void)
 	return 0;
 }
 
-void rfcomm_cleanup_ttys(void)
+void __exit rfcomm_cleanup_ttys(void)
 {
 	tty_unregister_driver(rfcomm_tty_driver);
 	put_tty_driver(rfcomm_tty_driver);
-- 
1.7.1.1
