Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 07/11] android/gatt: Fix not handling service change ccc write execute
Date: Thu,  8 Jan 2015 10:17:45 +0100
Message-Id: <1420708669-32600-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds prepare and execute write handling on Service Change CCC
descriptor.
---
 android/gatt.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b749705..c00eb9e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -171,6 +171,8 @@ struct gatt_device {
 	struct queue *autoconnect_apps;
 
 	struct queue *pending_requests;
+	bool wait_svc_change_execute_write;
+	uint16_t svc_change_ccc;
 };
 
 struct app_connection {
@@ -6599,6 +6601,28 @@ static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
 	uint8_t value;
 	struct pending_request *data;
 
+	/* handle embeded ccc */
+	if (dev->wait_svc_change_execute_write) {
+		uint8_t flags;
+
+		dec_exec_write_req(cmd, cmd_len, &flags);
+		dev->wait_svc_change_execute_write = false;
+
+		if (!!flags)
+			bt_store_gatt_ccc(&dev->bdaddr, dev->svc_change_ccc);
+
+		if (!pending_execute_write()) {
+			size_t mtu;
+			uint16_t len = 0;
+			uint8_t *rsp = g_attrib_get_buffer(dev->attrib, &mtu);
+
+			len = enc_exec_write_resp(rsp);
+			g_attrib_send(dev->attrib, 0, rsp, len, NULL, NULL,
+									NULL);
+			return 0;
+		}
+	}
+
 	/*
 	 * Check if there was any write prep before.
 	 * TODO: Try to find better error code if possible
@@ -7012,8 +7036,16 @@ static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	/* Set services changed indication value */
-	bt_store_gatt_ccc(bdaddr, get_le16(value));
+	switch (opcode) {
+	case ATT_OP_PREP_WRITE_REQ:
+		dev->wait_svc_change_execute_write = true;
+		dev->svc_change_ccc = get_le16(value);
+		break;
+	default:
+		/* Set services changed indication value */
+		bt_store_gatt_ccc(bdaddr, get_le16(value));
+		break;
+	}
 
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
-- 
1.9.1

