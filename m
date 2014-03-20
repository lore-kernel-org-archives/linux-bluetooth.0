Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 41/62] Replace att_get_uuid16() by get_le16()
Date: Thu, 20 Mar 2014 11:43:06 -0300
Message-Id: <1395326607-27068-42-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c         |  6 +++---
 attrib/gatt.c        | 11 ++++++++---
 attrib/gatttool.c    |  3 ++-
 attrib/interactive.c |  3 ++-
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index c408568..b353499 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -168,7 +168,7 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	*start = att_get_u16(&pdu[1]);
 	*end = att_get_u16(&pdu[3]);
 	if (len == min_len + 2)
-		*uuid = att_get_uuid16(&pdu[5]);
+		bt_uuid16_create(uuid, get_le16(&pdu[5]));
 	else
 		*uuid = att_get_uuid128(&pdu[5]);
 
@@ -297,7 +297,7 @@ uint16_t dec_find_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	/* Last requested handle number (2 octets) */
 	*end = att_get_u16(&pdu[3]);
 	/* 16-bit UUID to find (2 octets) */
-	*uuid = att_get_uuid16(&pdu[5]);
+	bt_uuid16_create(uuid, get_le16(&pdu[5]));
 
 	/* Attribute value to find */
 	*vlen = len - 7;
@@ -411,7 +411,7 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	*end = att_get_u16(&pdu[3]);
 
 	if (len == min_len + 2)
-		*uuid = att_get_uuid16(&pdu[5]);
+		bt_uuid16_create(uuid, get_le16(&pdu[5]));
 	else
 		*uuid = att_get_uuid128(&pdu[5]);
 
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 9c6dee1..0d43913 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -246,7 +246,9 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		end = att_get_u16(&data[2]);
 
 		if (list->len == 6) {
-			bt_uuid_t uuid16 = att_get_uuid16(&data[4]);
+			bt_uuid_t uuid16;
+
+			bt_uuid16_create(&uuid16, get_le16(&data[4]));
 			bt_uuid_to_uuid128(&uuid16, &uuid);
 		} else if (list->len == 20) {
 			uuid = att_get_uuid128(&data[4]);
@@ -385,8 +387,9 @@ static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
 
 	if (len == 8) {
 		bt_uuid_t uuid128;
-		bt_uuid_t uuid16 = att_get_uuid16(&buf[6]);
+		bt_uuid_t uuid16;
 
+		bt_uuid16_create(&uuid16, get_le16(&buf[6]));
 		bt_uuid_to_uuid128(&uuid16, &uuid128);
 		bt_uuid_to_string(&uuid128, incl->uuid, sizeof(incl->uuid));
 	}
@@ -505,7 +508,9 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		last = att_get_u16(value);
 
 		if (list->len == 7) {
-			bt_uuid_t uuid16 = att_get_uuid16(&value[5]);
+			bt_uuid_t uuid16;
+
+			bt_uuid16_create(&uuid16, get_le16(&value[5]));
 			bt_uuid_to_uuid128(&uuid16, &uuid);
 		} else
 			uuid = att_get_uuid128(&value[5]);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 9f2ead9..10415a8 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -35,6 +35,7 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "att.h"
 #include "btio/btio.h"
@@ -426,7 +427,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		handle = att_get_u16(value);
 
 		if (format == 0x01)
-			uuid = att_get_uuid16(&value[2]);
+			bt_uuid16_create(&uuid, get_le16(&value[2]));
 		else
 			uuid = att_get_uuid128(&value[2]);
 
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 70c091c..38403dd 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -38,6 +38,7 @@
 #include <readline/readline.h>
 #include <readline/history.h>
 
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "btio/btio.h"
 #include "att.h"
@@ -295,7 +296,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		handle = att_get_u16(value);
 
 		if (format == 0x01)
-			uuid = att_get_uuid16(&value[2]);
+			bt_uuid16_create(&uuid, get_le16(&value[2]));
 		else
 			uuid = att_get_uuid128(&value[2]);
 
-- 
1.8.3.1

