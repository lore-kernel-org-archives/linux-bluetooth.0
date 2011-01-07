Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 3/3] Move GATT service to attribute server core
Date: Fri,  7 Jan 2011 16:12:13 -0400
Message-Id: <1294431133-8847-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1294431133-8847-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1294431133-8847-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT service (like GAP one) should be moved to the core attribute server
because there can be only one instance of it.

There was a "Attribute Opcodes Supported" characteristic inside the GATT
service in attrib/example.c which is not defined by the Core
specification and was removed before moving the code.
---
 attrib/example.c    |   18 ------------------
 src/attrib-server.c |    5 +++++
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index 41c76eb..1911912 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -78,24 +78,6 @@ static int register_attributes(void)
 	uuid_t uuid;
 	int len;
 
-	/* GATT service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
-
-	/* GATT service: attributes opcodes characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0012, &atval[1]);
-	att_put_u16(OPCODES_SUPPORTED_UUID, &atval[3]);
-	attrib_db_add(0x0011, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
-
-	/* GATT service: attribute opcodes supported */
-	sdp_uuid16_create(&uuid, OPCODES_SUPPORTED_UUID);
-	atval[0] = 0xFF;
-	atval[1] = 0x01;
-	attrib_db_add(0x0012, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
-
 	/* Battery state service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(BATTERY_STATE_SVC_UUID, &atval[0]);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 80f41de..5db1623 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -774,6 +774,11 @@ static void register_core_services(void)
 
 	/* TODO: Implement Appearance characteristic. It is mandatory for
 	 * Peripheral/Central GAP roles. */
+
+	/* GATT service: primary service definition */
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
+	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 }
 
 int attrib_server_init(void)
-- 
1.7.0.4

