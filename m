Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix mask for H5 header len
Date: Thu, 19 Nov 2015 11:29:11 +0200
Message-Id: <1447925351-1677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes mask when calculating three-wire (h5) length.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 drivers/bluetooth/hci_h5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index ebefe5e..012248e 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -51,7 +51,7 @@
 #define H5_HDR_CRC(hdr)		(((hdr)[0] >> 6) & 0x01)
 #define H5_HDR_RELIABLE(hdr)	(((hdr)[0] >> 7) & 0x01)
 #define H5_HDR_PKT_TYPE(hdr)	((hdr)[1] & 0x0f)
-#define H5_HDR_LEN(hdr)		((((hdr)[1] >> 4) & 0xff) + ((hdr)[2] << 4))
+#define H5_HDR_LEN(hdr)		((((hdr)[1] >> 4) & 0x0f) + ((hdr)[2] << 4))
 
 #define SLIP_DELIMITER	0xc0
 #define SLIP_ESC	0xdb
-- 
2.5.0

