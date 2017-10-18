Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 04/11] profiles/input: Use sixaxis header to simplify device detection
Date: Wed, 18 Oct 2017 03:58:08 +0200
Message-Id: <20171018015815.10045-4-hadess@hadess.net>
In-Reply-To: <20171018015815.10045-1-hadess@hadess.net>
References: <20171018015815.10045-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the shared header to recognise whether a device is a Sixaxis device
or not.
---
 profiles/input/server.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index eb3fcf843..121c334d3 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -43,6 +43,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 
+#include "sixaxis.h"
 #include "device.h"
 #include "server.h"
 
@@ -123,6 +124,7 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	struct btd_device *device;
 	uint16_t vid, pid;
+	CablePairingType type;
 
 	device = btd_adapter_find_device(adapter_find(src), dst, BDADDR_BREDR);
 	if (!device)
@@ -131,18 +133,14 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 	vid = btd_device_get_vendor(device);
 	pid = btd_device_get_product(device);
 
-	/* DualShock 3 */
-	if (vid == 0x054c && pid == 0x0268)
+	type = get_pairing_type(vid, pid, NULL, NULL, NULL);
+	if (type == CABLE_PAIRING_SIXAXIS)
 		return true;
 
 	/* DualShock 4 */
 	if (vid == 0x054c && pid == 0x05c4)
 		return true;
 
-	/* Navigation Controller */
-	if (vid == 0x054c && pid == 0x042f)
-		return true;
-
 	return false;
 }
 
-- 
2.14.2

