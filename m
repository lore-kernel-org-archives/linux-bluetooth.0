Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 2/2] tools/btgatt-server: Handle Charc Value Indication
Date: Wed, 26 Aug 2015 15:29:55 +0530
Message-id: <1440583195-11541-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1440583195-11541-1-git-send-email-gowtham.ab@samsung.com>
References: <1440583195-11541-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch verifies that a Generic Attribute Profile server can
send a Characteristic Value Indication.
TC_GAI_SR_BV_01_C - PASS
---
 tools/btgatt-server.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 292b584..5b38d47 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -94,6 +94,8 @@ struct server {
 	bool hr_msrmt_enabled;
 	int hr_ee_count;
 	unsigned int hr_timeout_id;
+
+	bool indicate;
 };
 
 static void print_prompt(void)
@@ -285,6 +287,11 @@ static void hr_msrmt_ccc_read_cb(struct gatt_db_attribute *attrib,
 	gatt_db_attribute_read_result(attrib, id, 0, value, 2);
 }
 
+static void conf_callback(void *user_data)
+{
+	PRLOG("GATT server received confirmation\n");
+}
+
 static bool hr_msrmt_cb(void *user_data)
 {
 	struct server *server = user_data;
@@ -302,11 +309,15 @@ static bool hr_msrmt_cb(void *user_data)
 		len += 2;
 	}
 
-	bt_gatt_server_send_notification(server->gatt,
+	if (server->indicate)
+		bt_gatt_server_send_indication(server->gatt,
+					server->hr_msrmt_handle,
+					pdu, len, conf_callback, NULL, NULL);
+	else
+		bt_gatt_server_send_notification(server->gatt,
 						server->hr_msrmt_handle,
 						pdu, len);
 
-
 	cur_ee = server->hr_energy_expended;
 	server->hr_energy_expended = MIN(UINT16_MAX, cur_ee + 10);
 	server->hr_ee_count++;
@@ -350,7 +361,14 @@ static void hr_msrmt_ccc_write_cb(struct gatt_db_attribute *attrib,
 			PRLOG("HR Measurement Already Enabled\n");
 			goto done;
 		}
-
+		server->hr_msrmt_enabled = true;
+	}
+	else if (value[0] == 0x02) {
+		if (server->hr_msrmt_enabled) {
+			PRLOG("HR Measurement Already Enabled\n");
+			goto done;
+		}
+		server->indicate = true;
 		server->hr_msrmt_enabled = true;
 	} else
 		ecode = 0x80;
@@ -494,7 +512,8 @@ static void populate_hr_service(struct server *server)
 	bt_uuid16_create(&uuid, UUID_HEART_RATE_MSRMT);
 	hr_msrmt = gatt_db_service_add_characteristic(service, &uuid,
 						BT_ATT_PERM_NONE,
-						BT_GATT_CHRC_PROP_NOTIFY,
+						BT_GATT_CHRC_PROP_NOTIFY |
+						BT_GATT_CHRC_PROP_INDICATE,
 						NULL, NULL, NULL);
 	server->hr_msrmt_handle = gatt_db_attribute_get_handle(hr_msrmt);
 
@@ -533,8 +552,8 @@ static void populate_hr_service(struct server *server)
 static void populate_db(struct server *server)
 {
 	populate_gap_service(server);
-	populate_gatt_service(server);
 	populate_hr_service(server);
+	populate_gatt_service(server);
 }
 
 static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
@@ -589,6 +608,7 @@ static struct server *server_create(int fd, uint16_t mtu, bool hr_visible)
 	}
 
 	server->hr_visible = hr_visible;
+	server->indicate = false;
 
 	if (verbose) {
 		bt_att_set_debug(server->att, att_debug_cb, "att: ", NULL);
-- 
1.9.1

