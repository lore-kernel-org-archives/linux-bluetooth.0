Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 1/2] Bluetooth: Return proper error codes on rfcomm tty init
Date: Mon, 24 Oct 2011 15:30:57 +0200
Message-Id: <1319463058-29311-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Forward error codes from tty core to the rfcomm_init caller instead of using
generic -1 errors.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/rfcomm/tty.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index c258796..2b753a3 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1155,9 +1155,11 @@ static const struct tty_operations rfcomm_ops = {
 
 int __init rfcomm_init_ttys(void)
 {
+	int error;
+
 	rfcomm_tty_driver = alloc_tty_driver(RFCOMM_TTY_PORTS);
 	if (!rfcomm_tty_driver)
-		return -1;
+		return -ENOMEM;
 
 	rfcomm_tty_driver->owner	= THIS_MODULE;
 	rfcomm_tty_driver->driver_name	= "rfcomm";
@@ -1172,10 +1174,11 @@ int __init rfcomm_init_ttys(void)
 	rfcomm_tty_driver->init_termios.c_lflag &= ~ICANON;
 	tty_set_operations(rfcomm_tty_driver, &rfcomm_ops);
 
-	if (tty_register_driver(rfcomm_tty_driver)) {
+	error = tty_register_driver(rfcomm_tty_driver);
+	if (error) {
 		BT_ERR("Can't register RFCOMM TTY driver");
 		put_tty_driver(rfcomm_tty_driver);
-		return -1;
+		return error;
 	}
 
 	BT_INFO("RFCOMM TTY layer initialized");
-- 
1.7.7

