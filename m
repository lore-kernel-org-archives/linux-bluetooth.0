Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2] Remove automatic battery state change on attribute example
Date: Tue,  7 Dec 2010 18:41:38 -0300
Message-Id: <1291758098-31350-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <20101207213537.GA30415@jh-x301>
References: <20101207213537.GA30415@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Legacy code implemented to test Indication and Notification
---
 attrib/example.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/attrib/example.c b/attrib/example.c
index 4307804..6987fac 100644
--- a/attrib/example.c
+++ b/attrib/example.c
@@ -59,22 +59,6 @@
 #define FMT_KILOGRAM_UUID		0xA010
 #define FMT_HANGING_UUID		0xA011
 
-static guint timeout_id = 0;
-
-static gboolean change_battery_state(gpointer user_data)
-{
-	static uint8_t state =  0x05;
-	uuid_t uuid;
-	uint8_t atval[1];
-
-	/* Battery state is being increased every 10 seconds. */
-	atval[0] = state++;
-	sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
-	attrib_db_update(0x0110, &uuid, atval, 1);
-
-	return TRUE;
-}
-
 static int register_attributes(void)
 {
 	const char *devname = "Example Device";
@@ -170,8 +154,6 @@ static int register_attributes(void)
 	atval[1] = 0x00;
 	attrib_db_add(0x0111, &uuid, ATT_NONE, ATT_AUTHENTICATION, atval, 2);
 
-	timeout_id = g_timeout_add_seconds(10, change_battery_state, NULL);
-
 	/* Thermometer: primary service definition */
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	u16 = htons(THERM_HUMIDITY_SVC_UUID);
@@ -436,5 +418,4 @@ int server_example_init(void)
 
 void server_example_exit(void)
 {
-	g_source_remove(timeout_id);
 }
-- 
1.7.3.2

