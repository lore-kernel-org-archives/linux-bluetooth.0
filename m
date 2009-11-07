Return-Path: <cyrus@holtmann.org>
From: Ben Hutchings <ben@decadent.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 Nov 2009 21:41:18 +0000
Message-ID: <1257630078.15927.380.camel@localhost>
Mime-Version: 1.0
Subject: [PATCH 03/75] btmrvl-sdio: declare MODULE_FIRMWARE
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/bluetooth/btmrvl_sdio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdi=
o.c
index 5b33b85..8b211ef 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1001,3 +1001,5 @@ MODULE_AUTHOR("Marvell International Ltd.");
 MODULE_DESCRIPTION("Marvell BT-over-SDIO driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL v2");
+MODULE_FIRMWARE("sd8688_helper.bin");
+MODULE_FIRMWARE("sd8688.bin");
--=20
1.6.5.2
