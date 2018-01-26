Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Tedd Ho-Jeong An <tedd.an@linux.intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: remove extraneous semicolon
Date: Fri, 26 Jan 2018 14:06:39 +0100
Message-Id: <20180126130652.3499127-1-arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

The newly added btintel_download_firmware() dummy helper definition is
incorrect, causing a build error when CONFIG_BT_INTEL is disabled:

In file included from drivers/bluetooth/hci_ldisc.c:49:0:
drivers/bluetooth/btintel.h:196:1: error: expected identifier or '(' before '{' token
drivers/bluetooth/btintel.h:193:19: error: 'btintel_download_firmware' declared 'static' but never defined [-Werror=unused-function]

Removing the semicolon makes it work again.

Fixes: 0bd4ded3287d ("Bluetooth: btintel: Create common function for firmware download")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btintel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 01728e212267..41c642cc523f 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -192,7 +192,7 @@ static inline int btintel_read_boot_params(struct hci_dev *hdev,
 
 static inline int btintel_download_firmware(struct hci_dev *dev,
 					    const struct firmware *fw,
-					    u32 *boot_param);
+					    u32 *boot_param)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.9.0
