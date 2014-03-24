Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 11/22] attrib: Use LE helpers defined in src/shared/util.h
Date: Mon, 24 Mar 2014 16:25:32 -0300
Message-Id: <1395689143-11091-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 1db34be..9c6dee1 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -32,6 +32,7 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "att.h"
 #include "gattrib.h"
@@ -138,6 +139,15 @@ static struct discover_char *discover_char_ref(struct discover_char *dc)
 	return dc;
 }
 
+static void put_uuid_le(const bt_uuid_t *uuid, void *dst)
+{
+	if (uuid->type == BT_UUID16)
+		put_le16(uuid->value.u16, dst);
+	else
+		/* Convert from 128-bit BE to LE */
+		bswap_128(&uuid->value.u128, dst);
+}
+
 static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, uint8_t *pdu, size_t len)
 {
@@ -150,22 +160,12 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 		/* Discover all primary services */
 		plen = enc_read_by_grp_req(start, end, &prim, pdu, len);
 	} else {
-		uint16_t u16;
-		uint128_t u128;
-		const void *value;
+		uint8_t value[16];
 		size_t vlen;
 
 		/* Discover primary service by service UUID */
-
-		if (uuid->type == BT_UUID16) {
-			u16 = htobs(uuid->value.u16);
-			value = &u16;
-			vlen = sizeof(u16);
-		} else {
-			htob128(&uuid->value.u128, &u128);
-			value = &u128;
-			vlen = sizeof(u128);
-		}
+		put_uuid_le(uuid, value);
+		vlen = bt_uuid_len(uuid);
 
 		plen = enc_find_by_type_req(start, end, &prim, value, vlen,
 								pdu, len);
-- 
1.8.3.1

