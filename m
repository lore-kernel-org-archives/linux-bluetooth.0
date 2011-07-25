Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/5] Register primary service for Link Loss service
Date: Mon, 25 Jul 2011 17:15:52 -0300
Message-Id: <1311624955-22360-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/reporter.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index e8fd368..94c930b 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -26,19 +26,73 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
+#include <bluetooth/uuid.h>
+
 #include "log.h"
 
+#include "att.h"
+#include "gattrib.h"
+#include "attrib-server.h"
 #include "reporter.h"
 
+#define LINK_LOSS_SVC_UUID		0x1803
+#define ALERT_LEVEL_CHR_UUID		0x2A06
+
+enum {
+	NO_ALERT = 0x00,
+	MILD_ALERT = 0x01,
+	HIGH_ALERT = 0x02,
+};
+
+static void register_link_loss(void)
+{
+	uint16_t start_handle, h;
+	const int svc_size = 3;
+	uint8_t atval[256];
+	bt_uuid_t uuid;
+
+	start_handle = attrib_db_find_avail(svc_size);
+	if (start_handle == 0) {
+		error("Not enough free handles to register service");
+		return;
+	}
+
+	DBG("start_handle=0x%04x", start_handle);
+
+	h = start_handle;
+
+	/* Primary service definition */
+	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	att_put_u16(LINK_LOSS_SVC_UUID, &atval[0]);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+
+	/* Alert level characteristic */
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_WRITE;
+	att_put_u16(h + 1, &atval[1]);
+	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+
+	/* Alert level value */
+	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
+	att_put_u8(NO_ALERT, &atval[0]);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
+
+	g_assert(h - start_handle == svc_size);
+}
+
 int reporter_init(void)
 {
 	/*
 	 * TODO: Create/Update Proximity Reporter Characteristics
-	 * for Link Loss, Path Loss and Immediate Alert Services.
+	 * for Path Loss and Immediate Alert Services.
 	 */
 
 	DBG("Proximity Reporter");
 
+	register_link_loss();
+
 	return 0;
 }
 
-- 
1.7.0.4

