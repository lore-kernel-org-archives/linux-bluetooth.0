Return-Path: <ianwmorrison@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, gustavo@padovan.org,
 johan.hedberg@gmail.com,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>
Cc: hdegoede@redhat.com, frederic.danis.oss@gmail.com
From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH v3 2/2] Bluetooth: btbcm: Add support for MINIX Z83-4 based
 devices
Message-ID: <79ddc489-3a34-0da6-daed-a97ed0347f18@gmail.com>
Date: Sat, 7 Oct 2017 17:15:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices use an AP6255 chip for wifi and bluetooth. Bluetooth requires an ACPI device id of BCM2EA4 with BCM4345 rev C0 firmware.

This patch defines the firmware subversion.

Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
---
v2: functionally unchanged but issued as an individual change as part of an revised patch set
v3: unchanged but reissued as part of an revised patch set
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index cc4bdefa6648..06e8bed4f5eb 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -327,6 +327,7 @@ static const struct {
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
+	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
 	{ }
 };
 
-- 
2.11.0
