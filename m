Return-Path: <gustavo@embeddedor.com>
Date: Tue, 14 Aug 2018 10:10:31 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Sean Wang <sean.wang@mediatek.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Bluetooth: mediatek: Fix memory leak
Message-ID: <20180814151031.GA25096@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

In case memory resources for *fw* were allocated, release them before
return.

Addresses-Coverity-ID: 1472611 ("Resource leak")
Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/bluetooth/btmtkuart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index ed2a5c7..4593baf 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -144,8 +144,10 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 	fw_size = fw->size;
 
 	/* The size of patch header is 30 bytes, should be skip */
-	if (fw_size < 30)
-		return -EINVAL;
+	if (fw_size < 30) {
+		err = -EINVAL;
+		goto free_fw;
+	}
 
 	fw_size -= 30;
 	fw_ptr += 30;
@@ -172,8 +174,8 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 		fw_ptr += dlen;
 	}
 
+free_fw:
 	release_firmware(fw);
-
 	return err;
 }
 
-- 
2.7.4
