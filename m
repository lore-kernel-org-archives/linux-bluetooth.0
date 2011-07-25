Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/5] Register primary service for Immediate Alert
Date: Mon, 25 Jul 2011 17:15:54 -0300
Message-Id: <1311624955-22360-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/reporter.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 1e0a5f5..fe18442 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -36,6 +36,7 @@
 #include "attrib-server.h"
 #include "reporter.h"
 
+#define IMMEDIATE_ALERT_SVC_UUID	0x1802
 #define LINK_LOSS_SVC_UUID		0x1803
 #define TX_POWER_SVC_UUID		0x1804
 #define ALERT_LEVEL_CHR_UUID		0x2A06
@@ -130,6 +131,43 @@ static void register_tx_power(void)
 	g_assert(h - start_handle == svc_size);
 }
 
+static void register_immediate_alert(void)
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
+	att_put_u16(IMMEDIATE_ALERT_SVC_UUID, &atval[0]);
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
@@ -141,6 +179,7 @@ int reporter_init(void)
 
 	register_link_loss();
 	register_tx_power();
+	register_immediate_alert();
 
 	return 0;
 }
-- 
1.7.0.4

