Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 4/7] Add att_get_u128
Date: Fri, 11 Feb 2011 18:37:03 -0200
Message-Id: <1297456626-22837-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Function to convert 128-bits values from little endian to host
order. Different than SDP, ATT uses little endian format.
---
 attrib/att.c      |   12 ++++++++----
 attrib/att.h      |   10 ++++++++++
 attrib/gatt.c     |   13 ++++++++-----
 attrib/gatttool.c |    6 ++++--
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index dff8597..5b851a2 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -141,8 +141,10 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, int len, uint16_t *start,
 	*end = att_get_u16(&pdu[3]);
 	if (len == min_len + 2)
 		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
-	else
-		sdp_uuid128_create(uuid, &pdu[5]);
+	else {
+		uint128_t h128 = att_get_u128(&pdu[5]);
+		sdp_uuid128_create(uuid, &h128);
+	}
 
 	return len;
 }
@@ -370,8 +372,10 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, int len, uint16_t *start,
 
 	if (len == min_len + 2)
 		sdp_uuid16_create(uuid, att_get_u16(&pdu[5]));
-	else
-		sdp_uuid128_create(uuid, &pdu[5]);
+	else {
+		uint128_t h128 = att_get_u128(&pdu[5]);
+		sdp_uuid128_create(uuid, &h128);
+	}
 
 	return len;
 }
diff --git a/attrib/att.h b/attrib/att.h
index 7e81dc4..0cd6626 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -170,6 +170,16 @@ static inline uint32_t att_get_u32(const void *ptr)
 	return btohl(bt_get_unaligned(u32_ptr));
 }
 
+static inline uint128_t att_get_u128(const void *ptr)
+{
+	const uint128_t *u128_ptr = ptr;
+	uint128_t dst;
+
+	btoh128(u128_ptr, &dst);
+
+	return dst;
+}
+
 static inline void att_put_u8(uint8_t src, void *dst)
 {
 	bt_put_unaligned(src, (uint8_t *) dst);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index b99d39c..3fedcc4 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -174,9 +174,10 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 					att_get_u16(&data[4]));
 			sdp_uuid16_to_uuid128(&u128, &u16);
 
-		} else if (list->len == 20)
-			sdp_uuid128_create(&u128, &data[4]);
-		else
+		} else if (list->len == 20) {
+			uint128_t h128 = att_get_u128(&data[4]);
+			sdp_uuid128_create(&u128, &h128);
+		} else
 			/* Skipping invalid data */
 			continue;
 
@@ -271,8 +272,10 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		if (list->len == 7) {
 			sdp_uuid16_create(&u16, att_get_u16(&value[5]));
 			sdp_uuid16_to_uuid128(&u128, &u16);
-		} else
-			sdp_uuid128_create(&u128, &value[5]);
+		} else {
+			uint128_t h128 = att_get_u128(&value[5]);
+			sdp_uuid128_create(&u128, &h128);
+		}
 
 		chars = g_try_new0(struct att_char, 1);
 		if (!chars) {
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 8e8ed8e..6c9394e 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -464,8 +464,10 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		if (format == 0x01)
 			sdp_uuid16_create(&uuid, att_get_u16(&value[2]));
-		else
-			sdp_uuid128_create(&uuid, &value[2]);
+		else {
+			uint128_t h128 = att_get_u128(&value[2]);
+			sdp_uuid128_create(&uuid, &h128);
+		}
 
 		sdp_uuid2strn(&uuid, uuidstr, MAX_LEN_UUID_STR);
 		g_print("handle = 0x%04x, uuid = %s\n", handle, uuidstr);
-- 
1.7.4

