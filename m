Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/5] Register primary service for Tx Power service
Date: Mon, 25 Jul 2011 17:15:53 -0300
Message-Id: <1311624955-22360-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/reporter.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 94c930b..1e0a5f5 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -37,7 +37,9 @@
 #include "reporter.h"
 
 #define LINK_LOSS_SVC_UUID		0x1803
+#define TX_POWER_SVC_UUID		0x1804
 #define ALERT_LEVEL_CHR_UUID		0x2A06
+#define POWER_LEVEL_CHR_UUID		0x2A07
 
 enum {
 	NO_ALERT = 0x00,
@@ -45,6 +47,8 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
+static uint16_t tx_power_handle;
+
 static void register_link_loss(void)
 {
 	uint16_t start_handle, h;
@@ -82,6 +86,50 @@ static void register_link_loss(void)
 	g_assert(h - start_handle == svc_size);
 }
 
+static void register_tx_power(void)
+{
+	uint16_t start_handle, h;
+	const int svc_size = 4;
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
+	att_put_u16(TX_POWER_SVC_UUID, &atval[0]);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+
+	/* Power level characteristic */
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
+	att_put_u16(h + 1, &atval[1]);
+	att_put_u16(POWER_LEVEL_CHR_UUID, &atval[3]);
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+
+	/* Power level value */
+	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
+	att_put_u8(0x00, &atval[0]);
+	tx_power_handle = h;
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
+
+	/* Client characteristic configuration */
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+	atval[0] = 0x00;
+	atval[1] = 0x00;
+	attrib_db_add(h++, &uuid, ATT_NONE, ATT_NONE, atval, 2);
+
+	g_assert(h - start_handle == svc_size);
+}
+
 int reporter_init(void)
 {
 	/*
@@ -92,6 +140,7 @@ int reporter_init(void)
 	DBG("Proximity Reporter");
 
 	register_link_loss();
+	register_tx_power();
 
 	return 0;
 }
-- 
1.7.0.4

