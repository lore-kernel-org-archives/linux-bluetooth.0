Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] Remove use of read_device_id in wiimote plugin
Date: Thu, 22 Sep 2011 18:51:52 +0300
Message-Id: <1316706712-17611-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
References: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make use of btd_device_get_vendor and btd_device_get_product intead.
---
 plugins/wiimote.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index e60231b..fead72a 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -60,20 +60,21 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
 {
 	uint16_t vendor, product;
 	bdaddr_t sba, dba;
-	char src_addr[18], dst_addr[18];
+	char addr[18];
 
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba);
-	ba2str(&sba, src_addr);
-	ba2str(&dba, dst_addr);
-
-	if (0 == read_device_id(src_addr, dst_addr, NULL, &vendor, &product,
-									NULL)) {
-		if (vendor == 0x057e && product == 0x0306) {
-			DBG("Forcing fixed pin on detected wiimote %s", dst_addr);
-			memcpy(pinbuf, &sba, 6);
-			return 6;
-		}
+	ba2str(&dba, addr);
+
+	vendor = btd_device_get_vendor(device);
+	if (vendor != 0x057e)
+		return 0;
+
+	product = btd_device_get_product(device);
+	if (product == 0x0306) {
+		DBG("Forcing fixed pin on detected wiimote %s", addr);
+		memcpy(pinbuf, &sba, 6);
+		return 6;
 	}
 
 	return 0;
-- 
1.7.6.2

