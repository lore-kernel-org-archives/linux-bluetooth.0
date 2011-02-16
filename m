Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/4] Add static Device Appearance Characteristic
Date: Wed, 16 Feb 2011 21:07:28 -0200
Message-Id: <1297897651-27731-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Declaration and definition of the Device Appearance Characteristic
defined in the GAP Characteristics for Low Energy section: Bluetooth
Core Specification, Volume 3, Part C, section 12.2.
---
 src/attrib-server.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 85b39a8..fe5d68c 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -799,6 +799,7 @@ static void register_core_services(void)
 	uint8_t atval[256];
 	uuid_t uuid;
 	int len;
+	uint16_t appearance = 0x0000;
 
 	/* GAP service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
@@ -818,8 +819,17 @@ static void register_core_services(void)
 	attrib_db_add(0x0006, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 					(uint8_t *) main_opts.name, len);
 
-	/* TODO: Implement Appearance characteristic. It is mandatory for
-	 * Peripheral/Central GAP roles. */
+	/* GAP service: device appearance characteristic */
+	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	atval[0] = ATT_CHAR_PROPER_READ;
+	att_put_u16(0x0008, &atval[1]);
+	att_put_u16(GATT_CHARAC_APPEARANCE, &atval[3]);
+	attrib_db_add(0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+
+	/* GAP service: device appearance attribute */
+	sdp_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
+	att_put_u16(appearance, &atval[0]);
+	attrib_db_add(0x0008, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* GATT service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-- 
1.7.4.1

