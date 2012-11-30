Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 4/4] gatt: Improve characteristics discovery
Date: Fri, 30 Nov 2012 15:31:33 -0300
Message-Id: <1354300294-9105-4-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1354300294-9105-1-git-send-email-paulo.borges@openbossa.org>
References: <1354300294-9105-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the Discover Characteristics by UUID sub-procedure, if a fetched
characteristic doesn't matches with the target UUID, all others
characteristics in that response were discarded.

Because of this, the procedure will make a new request to possibly
rediscover the characteristics in the range beyond this last
characteristic.

At present, this procedure works because the gatt library will send a
Read by Type Request starting at the first attribute after the non
matching characteristic.

This commit makes the rest of the characteristics to be checked for a
matching type, which should reduce the number of requests sent during
the discovery of characteristics.
---
 attrib/gatt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index b834b13..38c050e 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -476,7 +476,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 			uuid = att_get_uuid128(&value[5]);
 
 		if (dc->uuid && bt_uuid_cmp(dc->uuid, &uuid))
-			break;
+			continue;
 
 		chars = g_try_new0(struct gatt_char, 1);
 		if (!chars) {
-- 
1.7.9.5

