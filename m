Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix setting end handle
Date: Wed, 19 Nov 2014 14:45:29 +0100
Message-Id: <1416404729-32570-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If found attribute was service attribute, range->end was always set
to 1, because gatt_db_attribute_get_service_handles return bool.

> ACL Data RX: Handle 8 flags 0x02 dlen 13
      ATT: Find By Type Value Request (0x06) len 8
        Handle range: 0x0002-0xffff
        Attribute type: Primary Service (0x2800)
          UUID: Device Information (0x180a)
< ACL Data TX: Handle 8 flags 0x00 dlen 9
      ATT: Find By Type Value Response (0x07) len 4
        Handle range: 0x0008-0x0001
---
 android/gatt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index ddc1561..ea5cead 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4532,15 +4532,15 @@ static void send_dev_complete_response(struct gatt_device *device,
 
 			range->start = gatt_db_attribute_get_handle(
 								val->attrib);
-			range->end = range->start;
 
 			type = gatt_db_attribute_get_type(val->attrib);
 			if (is_service(type))
-				range->end =
-					gatt_db_attribute_get_service_handles(
+				gatt_db_attribute_get_service_handles(
 								val->attrib,
 								NULL,
 								&range->end);
+			else
+				range->end = range->start;
 
 			list = g_slist_append(list, range);
 
-- 
1.9.3

