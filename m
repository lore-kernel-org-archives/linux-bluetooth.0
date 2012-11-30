Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 3/4] gatt: Fix memory leak in characteristic discovery
Date: Fri, 30 Nov 2012 15:31:32 -0300
Message-Id: <1354300294-9105-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1354300294-9105-1-git-send-email-paulo.borges@openbossa.org>
References: <1354300294-9105-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the Discover Characteristics by UUID sub-procedure has been
executed and the first characteristic is not the target, a memory
leak occurs.

This commit fixes this leak by postponing the allocation to after
the UUID verification.
---
 attrib/gatt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 963fa20..b834b13 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -475,15 +475,15 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		} else
 			uuid = att_get_uuid128(&value[5]);
 
+		if (dc->uuid && bt_uuid_cmp(dc->uuid, &uuid))
+			break;
+
 		chars = g_try_new0(struct gatt_char, 1);
 		if (!chars) {
 			err = ATT_ECODE_INSUFF_RESOURCES;
 			goto done;
 		}
 
-		if (dc->uuid && bt_uuid_cmp(dc->uuid, &uuid))
-			break;
-
 		chars->handle = last;
 		chars->properties = value[2];
 		chars->value_handle = att_get_u16(&value[3]);
-- 
1.7.9.5

