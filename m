Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] gatt: GAP and GATT services are mandatory
Date: Wed, 22 Aug 2012 16:38:49 -0300
Message-Id: <1345664329-30577-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes potential segmentation fault if the remote doesn't
support GAP and GATT services.
---
 profiles/gatt/manager.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
index a1fa756..0702d26 100644
--- a/profiles/gatt/manager.c
+++ b/profiles/gatt/manager.c
@@ -30,6 +30,7 @@
 #include "gattrib.h"
 #include "gatt.h"
 #include "gas.h"
+#include "log.h"
 #include "manager.h"
 
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
@@ -55,8 +56,12 @@ static int gatt_driver_probe(struct btd_device *device, GSList *uuids)
 	if (l)
 		gatt = l->data;
 
-	return gas_register(device, gap ? &gap->range : NULL,
-				gatt ? &gatt->range : NULL);
+	if (gap == NULL || gatt == NULL) {
+		error("GAP and GATT are mandatory");
+		return -EINVAL;
+	}
+
+	return gas_register(device, &gap->range, &gatt->range);
 }
 
 static void gatt_driver_remove(struct btd_device *device)
-- 
1.7.12

