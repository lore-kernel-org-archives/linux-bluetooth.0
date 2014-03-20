Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 33/62] lib: Remove hton128() from bt_uuid_to_string()
Date: Thu, 20 Mar 2014 11:42:58 -0300
Message-Id: <1395326607-27068-34-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_uuid_to_string() helper should get the raw UUID value. Caller should
convert the 128-bit UUID before call this helper if necessary. bt_uuid_t
stores 128-bit UUID on big-endian format (human-readable format), swap
byte order is not necessary.
---
 lib/uuid.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index aa2d0cf..dbca330 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -154,10 +154,7 @@ int bt_uuid_to_string(const bt_uuid_t *uuid, char *str, size_t n)
 		unsigned int   data4;
 		unsigned short data5;
 
-		uint128_t nvalue;
-		const uint8_t *data = (uint8_t *) &nvalue;
-
-		hton128(&uuid->value.u128, &nvalue);
+		const uint8_t *data = (uint8_t *) &uuid->value.u128;
 
 		memcpy(&data0, &data[0], 4);
 		memcpy(&data1, &data[4], 2);
-- 
1.8.3.1

