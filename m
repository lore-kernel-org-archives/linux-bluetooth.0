Return-Path: <cyrus@holtmann.org>
From: peterhuewe@gmx.de
To: Jiri Kosina <trivial@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Marcel Holtmann <marcel@holtmann.org>, Bing Zhao <bzhao@marvell.com>, Ben Hutchings <ben@decadent.org.uk>, =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>, Julia Lawall <julia@diku.dk>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] bluetooth: add __init/__exit macros to drivers/bluetooth/btmrvl_sdio.c
Date: Tue, 22 Dec 2009 09:34:20 +0100
Message-Id: <1261470861-23988-1-git-send-email-peterhuewe@gmx.de>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Peter Huewe <peterhuewe@gmx.de>

Trivial patch which adds the __init/__exit macros to the module_init/
module_exit functions of

drivers/bluetooth/btmrvl_sdio.c

Please have a look at the small patch and either pull it through
your tree, or please ack' it so Jiri can pull it through the trivial
tree.

Patch against linux-next-tree, 22. Dez 08:38:18 CET 2009
but also present in linus tree.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/bluetooth/btmrvl_sdio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index f36defa..e397170 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -975,7 +975,7 @@ static struct sdio_driver bt_mrvl_sdio = {
 	.remove		= btmrvl_sdio_remove,
 };
 
-static int btmrvl_sdio_init_module(void)
+static int __init btmrvl_sdio_init_module(void)
 {
 	if (sdio_register_driver(&bt_mrvl_sdio) != 0) {
 		BT_ERR("SDIO Driver Registration Failed");
@@ -988,7 +988,7 @@ static int btmrvl_sdio_init_module(void)
 	return 0;
 }
 
-static void btmrvl_sdio_exit_module(void)
+static void __exit btmrvl_sdio_exit_module(void)
 {
 	/* Set the flag as user is removing this module. */
 	user_rmmod = 1;
-- 
1.6.4.4
