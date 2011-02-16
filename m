Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/4] Update the Device Name characteristic when the local name has changed
Date: Wed, 16 Feb 2011 21:07:30 -0200
Message-Id: <1297897651-27731-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1297897651-27731-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1297897651-27731-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c       |    4 ++++
 src/attrib-server.c |   12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e7b2495..2a19ace 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -892,6 +892,10 @@ void adapter_update_local_name(struct btd_adapter *adapter, const char *name)
 
 	strncpy(dev->name, name, MAX_NAME_LENGTH);
 
+	if (main_opts.attrib_server)
+		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
+			(const uint8_t *) dev->name, strlen(dev->name));
+
 	if (!adapter->name_stored) {
 		char *name_ptr = dev->name;
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index b4df137..c1ca5ba 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -72,6 +72,8 @@ static GIOChannel *le_io = NULL;
 static GSList *clients = NULL;
 static uint32_t sdp_handle = 0;
 
+/* GAP attribute handles */
+static uint16_t name_handle = 0x0000;
 static uint16_t appearance_handle = 0x0000;
 
 static uuid_t prim_uuid = {
@@ -809,16 +811,17 @@ static void register_core_services(void)
 	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
 
 	/* GAP service: device name characteristic */
+	name_handle = 0x0006;
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 	atval[0] = ATT_CHAR_PROPER_READ;
-	att_put_u16(0x0006, &atval[1]);
+	att_put_u16(name_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
 	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
 
 	/* GAP service: device name attribute */
 	sdp_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
 	len = strlen(main_opts.name);
-	attrib_db_add(0x0006, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+	attrib_db_add(name_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
 					(uint8_t *) main_opts.name, len);
 
 	/* GAP service: device appearance characteristic */
@@ -1011,11 +1014,14 @@ int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 	uuid_t u16;
 	uint16_t handle;
 
-	/* FIXME: Missing Name, Privacy and Reconnection Address */
+	/* FIXME: Missing Privacy and Reconnection Address */
 
 	sdp_uuid16_create(&u16, uuid);
 
 	switch (uuid) {
+	case GATT_CHARAC_DEVICE_NAME:
+		handle = name_handle;
+		break;
 	case GATT_CHARAC_APPEARANCE:
 		handle = appearance_handle;
 		break;
-- 
1.7.4.1

