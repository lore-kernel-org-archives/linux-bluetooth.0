Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/3] Move GAP service registration to src/attrib-server.c
Date: Fri,  7 Jan 2011 16:12:12 -0400
Message-Id: <1294431133-8847-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1294431133-8847-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1294431133-8847-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GAP service shall be registered only once, so it makes sense to move it
to the core attribute server code.

The GAP "Device Name" characteristic was always "Example Device" on the
example server. This has been changed to use the Name attribute from
main.conf.
---
 attrib/example.c    |   19 -------------------
 src/attrib-server.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index f28068a..41c76eb 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -61,7 +61,6 @@
 
 static int register_attributes(void)
 {
-	const char *devname = "Example Device";
 	const char *desc_out_temp = "Outside Temperature";
 	const char *desc_out_hum = "Outside Relative Humidity";
 	const char *desc_weight = "Rucksack Weight";
@@ -79,24 +78,6 @@ static int register_attributes(void)
 	uuid_t uuid;
 	int len;
 
-	/* GAP service: primary service definition */
-	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
-
-	/* GAP service: device name characteristic */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0006, &atval[1]);
-	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
-	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
-
-	/* GAP service: device name attribute */
-	sdp_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
-	len = strlen(devname);
-	strncpy((char *) atval, devname, len);
-	attrib_db_add(0x0006, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, len);
-
 	/* GATT service: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index cbc01ee..80f41de 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -748,6 +748,34 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
+static void register_core_services(void)
+{
+	uint8_t atval[256];
+	uuid_t uuid;
+	int len;
+
+	/* GAP service: primary service definition */
+	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
+	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
+	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+
+	/* GAP service: device name characteristic */
+	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	atval[0] = ATT_CHAR_PROPER_READ;
+	att_put_u16(0x0006, &atval[1]);
+	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
+	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+
+	/* GAP service: device name attribute */
+	sdp_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
+	len = strlen(main_opts.name);
+	attrib_db_add(0x0006, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+					(uint8_t *) main_opts.name, len);
+
+	/* TODO: Implement Appearance characteristic. It is mandatory for
+	 * Peripheral/Central GAP roles. */
+}
+
 int attrib_server_init(void)
 {
 	GError *gerr = NULL;
@@ -781,6 +809,8 @@ int attrib_server_init(void)
 
 	sdp_handle = record->handle;
 
+	register_core_services();
+
 	if (!main_opts.le)
 		return 0;
 
-- 
1.7.0.4

