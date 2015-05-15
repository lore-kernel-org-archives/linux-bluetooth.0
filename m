Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/ad: Fix data matching
Date: Fri, 15 May 2015 15:32:51 +0300
Message-Id: <1431693171-8088-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The user_data was never used so adding new data will always fail if one
already exists.
---
 src/shared/ad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 83f01e4..00d138d 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -474,7 +474,7 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
 static bool manufacturer_data_match(const void *data, const void *user_data)
 {
 	const struct bt_ad_manufacturer_data *m1 = data;
-	const struct bt_ad_manufacturer_data *m2 = data;
+	const struct bt_ad_manufacturer_data *m2 = user_data;
 
 	if (m1->manufacturer_id != m2->manufacturer_id)
 		return false;
@@ -599,7 +599,7 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
 static bool service_data_match(const void *data, const void *user_data)
 {
 	const struct bt_ad_service_data *s1 = data;
-	const struct bt_ad_service_data *s2 = data;
+	const struct bt_ad_service_data *s2 = user_data;
 
 	if (bt_uuid_cmp(&s1->uuid, &s2->uuid))
 		return false;
-- 
2.1.0

