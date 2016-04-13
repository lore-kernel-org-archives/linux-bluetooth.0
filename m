Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v6 1/5] btgatt-server: Fix GATT device name properties
Date: Wed, 13 Apr 2016 23:09:53 +0200
Message-Id: <1460581797-3541-2-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1460581797-3541-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1460581797-3541-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since GATT device name characteristic has extended characteristic
property descriptor, that should be set in properties as well.
This patch fixes that.
---
 tools/btgatt-server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 292b584..099db8a 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -419,7 +419,8 @@ static void populate_gap_service(struct server *server)
 	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
 	gatt_db_service_add_characteristic(service, &uuid,
 					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
-					BT_GATT_CHRC_PROP_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_EXT_PROP,
 					gap_device_name_read_cb,
 					gap_device_name_write_cb,
 					server);
-- 
2.5.0

