Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] device: Fix sending unneeded property change signals
Date: Fri, 21 Mar 2014 16:06:34 +0100
Message-Id: <1395414394-32126-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send property change for Modalias only if it changed. This fix sending
multiple unneeded property change events during discovery.
---
 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index 601dfdc..a69cfa6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4811,6 +4811,10 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version)
 {
+	if (device->vendor_src == source && device->version == version &&
+			device->vendor == vendor && device->product == product)
+		return;
+
 	device->vendor_src = source;
 	device->vendor = vendor;
 	device->product = product;
-- 
1.8.3.2

