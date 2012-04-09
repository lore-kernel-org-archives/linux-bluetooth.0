Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Apr 2012 22:49:49 +0200 (CEST)
From: Jesper Juhl <jj@chaosbits.net>
To: linux-kernel@vger.kernel.org
cc: trivial@kernel.org, linux-bluetooth@vger.kernel.org,
    Johan Hedberg <johan.hedberg@gmail.com>,
    Gustavo Padovan <gustavo@padovan.org>,
    Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 01/26] Bluetooth: btmrvl_sdio: remove pointless conditional
 before release_firmware()
In-Reply-To: <alpine.LNX.2.00.1204092157340.13925@swampdragon.chaosbits.net>
Message-ID: <alpine.LNX.2.00.1204092158070.13925@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1204092157340.13925@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

release_firmware() deals gracefullt with NULL pointers so there's no
reason to test for one prior to calling the function.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/bluetooth/btmrvl_sdio.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 27b74b0..ed62c7f 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -339,9 +339,7 @@ static int btmrvl_sdio_download_helper(struct btmrvl_sdio_card *card)
 
 done:
 	kfree(tmphlprbuf);
-	if (fw_helper)
-		release_firmware(fw_helper);
-
+	release_firmware(fw_helper);
 	return ret;
 }
 
@@ -484,10 +482,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 
 done:
 	kfree(tmpfwbuf);
-
-	if (fw_firmware)
-		release_firmware(fw_firmware);
-
+	release_firmware(fw_firmware);
 	return ret;
 }
 
-- 
1.7.10


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
