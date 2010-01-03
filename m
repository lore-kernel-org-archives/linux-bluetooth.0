Return-Path: <cyrus@holtmann.org>
Message-ID: <4B40CC74.1060508@gmail.com>
Date: Sun, 03 Jan 2010 17:57:24 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: Wrong variable tested
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

The return of the function sdio_readb() was not tested.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/bluetooth/btmrvl_sdio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index f36defa..cac5b5e 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -348,7 +348,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 		for (tries = 0; tries < MAX_POLL_TRIES; tries++) {
 			base0 = sdio_readb(card->func,
 					SQ_READ_BASE_ADDRESS_A0_REG, &ret);
-			if (ret) {
+			if (base0) {
 				BT_ERR("BASE0 register read failed:"
 					" base0 = 0x%04X(%d)."
 					" Terminating download",
@@ -358,7 +358,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 			}
 			base1 = sdio_readb(card->func,
 					SQ_READ_BASE_ADDRESS_A1_REG, &ret);
-			if (ret) {
+			if (base1) {
 				BT_ERR("BASE1 register read failed:"
 					" base1 = 0x%04X(%d)."
 					" Terminating download",
