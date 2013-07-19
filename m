Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 11/11] attrib: Reduce scope of variable declarations in char_discovered_cb()
Date: Fri, 19 Jul 2013 13:34:17 -0400
Message-Id: <1374255257-8753-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes it easy to identify where variables are being used.
---
 attrib/gatt.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 90427a9..bb2cae1 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -447,10 +447,6 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	struct discover_char *dc = user_data;
 	struct att_data_list *list;
 	unsigned int i, err = ATT_ECODE_ATTR_NOT_FOUND;
-	size_t buflen;
-	uint8_t *buf;
-	guint16 oplen;
-	bt_uuid_t uuid;
 	uint16_t last = 0;
 
 	if (status) {
@@ -497,6 +493,11 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	att_data_list_free(list);
 
 	if (last != 0 && (last + 1 < dc->end)) {
+		bt_uuid_t uuid;
+		guint16 oplen;
+		size_t buflen;
+		uint8_t *buf;
+
 		buf = g_attrib_get_buffer(dc->attrib, &buflen);
 
 		bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-- 
1.7.9.5

