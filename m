Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/3] android/gatt: Fix Find By Type request
Date: Mon, 16 Feb 2015 13:36:45 +0100
Message-Id: <1424090205-13432-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424090205-13432-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424090205-13432-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch GATT will correctly response with attribute not found if
there is no attributes matching.

Issue found and fix tested on UPF50
---
 android/gatt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f3a4e89..f8d5d38 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6290,10 +6290,8 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	data.search_value = search_value;
 	data.device = device;
 
-	gatt_db_find_by_type(gatt_db, start, end, &uuid,
-						find_by_type_request_cb, &data);
-
-	if (data.error == ATT_ECODE_ATTR_NOT_FOUND) {
+	if (gatt_db_find_by_type(gatt_db, start, end, &uuid,
+					find_by_type_request_cb, &data) == 0) {
 		size_t mtu;
 		uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
 
-- 
1.8.4

