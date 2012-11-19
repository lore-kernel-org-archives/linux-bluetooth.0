Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] device: Fix minor whitespace issues
Date: Mon, 19 Nov 2012 16:02:46 +0100
Message-ID: <1353337366-21590-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
References: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 44e58ac..4b5363f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -191,7 +191,7 @@ struct btd_device {
 
 	gint		ref;
 
-	GIOChannel      *att_io;
+	GIOChannel	*att_io;
 	guint		cleanup_id;
 	guint		store_id;
 };
@@ -1506,7 +1506,6 @@ static const GDBusSignalTable device_signals[] = {
 	{ }
 };
 
-
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
 	{ "Name", "s", dev_property_get_name, NULL, dev_property_exists_name },
@@ -4037,4 +4036,3 @@ void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 	device_set_product(device, product_id);
 	device_set_version(device, product_ver);
 }
-
-- 
1.7.9.5

