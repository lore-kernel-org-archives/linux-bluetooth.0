Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 5/5] gatt: List only GATT_UUID as remote UUID
Date: Tue, 18 Dec 2012 15:01:27 +0100
Message-Id: <1355839287-8373-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1355839287-8373-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1355839287-8373-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The probe function checks if both UUIDs are present, so there is no
need to list both in btd_profile.
---
 profiles/gatt/manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
index ce0ed91..e554007 100644
--- a/profiles/gatt/manager.c
+++ b/profiles/gatt/manager.c
@@ -59,7 +59,7 @@ static void gatt_driver_remove(struct btd_profile *p,
 
 static struct btd_profile gatt_profile = {
 	.name		= "gap-gatt-profile",
-	.remote_uuids	= BTD_UUIDS(GAP_UUID, GATT_UUID),
+	.remote_uuids	= BTD_UUIDS(GATT_UUID),
 	.device_probe	= gatt_driver_probe,
 	.device_remove	= gatt_driver_remove
 };
-- 
1.7.11.7

