Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/18 v2] Bluetooth: Add Three-wire header value convenience macros
Date: Mon, 16 Jul 2012 16:12:07 +0300
Message-Id: <1342444339-1627-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1342444339-1627-1-git-send-email-johan.hedberg@gmail.com>
References: <1342444339-1627-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds convenience macros for reading Three-wire header values.
This will help make the code more readable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index f9ab29d..5fec2b3 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -43,6 +43,14 @@
  */
 #define H5_MAX_LEN (4 + 0xfff + 2)
 
+/* Convenience macros for reading Three-wire header values */
+#define H5_HDR_SEQ(hdr)		((hdr)[0] & 0x07)
+#define H5_HDR_ACK(hdr)		(((hdr)[0] >> 3) & 0x07)
+#define H5_HDR_CRC(hdr)		(((hdr)[0] >> 6) & 0x01)
+#define H5_HDR_RELIABLE(hdr)	(((hdr)[0] >> 7) & 0x01)
+#define H5_HDR_PKT_TYPE(hdr)	((hdr)[1] & 0x0f)
+#define H5_HDR_LEN(hdr)		((((hdr)[1] >> 4) & 0xff) + ((hdr)[2] << 4))
+
 #define SLIP_DELIMITER	0xc0
 #define SLIP_ESC	0xdb
 #define SLIP_ESC_DELIM	0xdc
-- 
1.7.10.4

