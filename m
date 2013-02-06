Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 5/7] gatt: List only GATT_UUID as remote UUID
Date: Wed,  6 Feb 2013 10:16:25 +0100
Message-Id: <1360142187-15347-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The probe function checks if both UUIDs are present, so there is no
need to list both in btd_profile.
---
 profiles/gatt/gas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 9360201..6a8571c 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -431,7 +431,7 @@ static void gatt_driver_remove(struct btd_profile *p,
 
 static struct btd_profile gatt_profile = {
 	.name		= "gap-gatt-profile",
-	.remote_uuids	= BTD_UUIDS(GAP_UUID, GATT_UUID),
+	.remote_uuids	= BTD_UUIDS(GATT_UUID),
 	.device_probe	= gatt_driver_probe,
 	.device_remove	= gatt_driver_remove
 };
-- 
1.8.1

