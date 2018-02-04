Return-Path: <mussitantesmortem@gmail.com>
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 3/5] drivers: bluetooth: ath3k: remove blank line after if
Date: Sun,  4 Feb 2018 23:59:32 +0300
Message-Id: <20180204205934.12117-3-mussitantesmortem@gmail.com>
In-Reply-To: <20180204205934.12117-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-1-mussitantesmortem@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Removed blank line after if.

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index b16c01a0b6d4..4df5b953a40d 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -523,7 +523,6 @@ static int ath3k_probe(struct usb_interface *intf,
 
 	/* load patch and sysconfig files for AR3012 */
 	if (id->driver_info & BTUSB_ATH3012) {
-
 		/* New firmware with patch and sysconfig files already loaded */
 		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001)
 			return -ENODEV;
-- 
2.16.1
