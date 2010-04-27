Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] patch to request new firmware for AR3011 Chip
From: suraj <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <dwmw2@infradead.org>, <Luis.Rodriguez@Atheros.com>,
	<Jothikumar.Mothilal@Atheros.com>, <marcel@holtmann.org>,
	<vkandukuri@atheros.com>
In-Reply-To: <1272349190.1393.11.camel@atheros013-desktop>
References: <1268629296.21425.23.camel@atheros013-desktop>
	 <1271758832.6585.33.camel@atheros013-desktop>
	 <1271845337.15010.1.camel@atheros013-desktop>
	 <1271927414.1409.3.camel@atheros013-desktop>
	 <1272279623.11239.1.camel@atheros013-desktop>
	 <1272349190.1393.11.camel@atheros013-desktop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 13:58:42 +0530
Message-ID: <1272356922.1393.14.camel@atheros013-desktop>
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Vikram Kandukuri <vkandukuri@atheros.com>
---
 drivers/bluetooth/ath3k.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 128cae4..7bda549 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -122,9 +122,12 @@ static int ath3k_probe(struct usb_interface *intf,
 
 	data->udev = udev;
 
-	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
-		kfree(data);
-		return -EIO;
+	if (request_firmware(&firmware, "ath3k-2.fw", &udev->dev) < 0) {
+		BT_DBG("requesting old firmware");
+		if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
+			kfree(data);
+			return -EIO;
+		}
 	}
 
 	size = max_t(uint, firmware->size, 4096);
-- 
1.7.0



