Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/bluetooth: Add debug log to select_device_bearer
Date: Wed, 20 Aug 2014 10:10:24 +0200
Message-Id: <1408522224-27670-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1408522224-27670-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1408522224-27670-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch refactor a bit select_device_bearer function so we can get
debug log out of it. This log might be very useful in dual mode devices
scenarios
---
 android/bluetooth.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 59dd047..20f2c8c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -4216,14 +4216,21 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 
 static uint8_t select_device_bearer(struct device *dev)
 {
+	uint8_t res;
+
 	if (dev->bredr && dev->le) {
 		if (dev->le_seen > dev->bredr_seen)
-			return dev->bdaddr_type;
+			res = dev->bdaddr_type;
+		else
+			res = BDADDR_BREDR;
 
-		return BDADDR_BREDR;
+	} else {
+		res = dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
 	}
 
-	return dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
+	DBG("Selected bearer %d", res);
+
+	return res;
 }
 
 uint8_t bt_device_last_seen_bearer(const bdaddr_t *bdaddr)
-- 
1.8.4

