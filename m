Return-Path: <cyrus@holtmann.org>
From: Anand Gadiyar <gadiyar@ti.com>
To: linux-bluetooth@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] bluetooth: remove unnecessary call to hci_sock_cleanup
Date: Tue, 22 Feb 2011 12:43:26 +0530
Message-Id: <1298358806-13257-1-git-send-email-gadiyar@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_sock_cleanup is already called after the sock_err label.
It appears that we can drop this call.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/af_bluetooth.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-omap-usb/net/bluetooth/af_bluetooth.c
===================================================================
--- linux-omap-usb.orig/net/bluetooth/af_bluetooth.c
+++ linux-omap-usb/net/bluetooth/af_bluetooth.c
@@ -550,10 +550,8 @@ static int __init bt_init(void)
 		goto error;
 
 	err = l2cap_init();
-	if (err < 0) {
-		hci_sock_cleanup();
+	if (err < 0)
 		goto sock_err;
-	}
 
 	err = sco_init();
 	if (err < 0) {
