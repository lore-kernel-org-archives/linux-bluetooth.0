Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 32/62] lib: Remove ntoh128() from bt_string_to_uuid128()
Date: Thu, 20 Mar 2014 11:42:57 -0300
Message-Id: <1395326607-27068-33-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No matter the system, 128-bit UUIDs should not be converted to any byte
order when creating the UUID. Conversion to big/little endian should be
performed when transfering the data over-the-air only. bt_uuid_t should
handle 128-bit UUID on big-endian format (human-readable format).
---
 lib/uuid.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 4363aee..aa2d0cf 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -231,8 +231,8 @@ static int bt_string_to_uuid128(bt_uuid_t *uuid, const char *string)
 {
 	uint32_t data0, data4;
 	uint16_t data1, data2, data3, data5;
-	uint128_t n128, u128;
-	uint8_t *val = (uint8_t *) &n128;
+	uint128_t u128;
+	uint8_t *val = (uint8_t *) &u128;
 
 	if (sscanf(string, "%08x-%04hx-%04hx-%04hx-%08x%04hx",
 				&data0, &data1, &data2,
@@ -253,8 +253,6 @@ static int bt_string_to_uuid128(bt_uuid_t *uuid, const char *string)
 	memcpy(&val[10], &data4, 4);
 	memcpy(&val[14], &data5, 2);
 
-	ntoh128(&n128, &u128);
-
 	bt_uuid128_create(uuid, u128);
 
 	return 0;
-- 
1.8.3.1

