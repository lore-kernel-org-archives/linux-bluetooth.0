Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/gatt: Fix service class id of built in gatt services
Date: Tue, 15 Jul 2014 12:54:53 +0200
Message-Id: <1405421694-13466-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405421694-13466-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405421694-13466-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 0aa71ad..4cd94b8 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6199,6 +6199,7 @@ static void register_gap_service(void)
 	gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
 
 	/* SDP */
+	bt_uuid16_create(&uuid, 0x1800);
 	start = gap_srvc_data.srvc;
 	end = gatt_db_get_end_handle(gatt_db, gap_srvc_data.srvc);
 	gap_sdp_handle = add_sdp_record(&uuid, start, end,
@@ -6308,6 +6309,7 @@ static void register_device_info_service(void)
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 
 	/* SDP */
+	bt_uuid16_create(&uuid, 0x180a);
 	end_handle = gatt_db_get_end_handle(gatt_db, srvc_handle);
 	dis_sdp_handle = add_sdp_record(&uuid, srvc_handle, end_handle,
 						"Device Information Service");
@@ -6404,6 +6406,7 @@ static void register_gatt_service(void)
 	gatt_db_service_set_active(gatt_db, srvc_handle, true);
 
 	/* SDP */
+	bt_uuid16_create(&uuid, 0x1801);
 	end_handle = gatt_db_get_end_handle(gatt_db, srvc_handle);
 	gatt_sdp_handle = add_sdp_record(&uuid, srvc_handle, end_handle,
 						"Generic Attribute Profile");
-- 
1.9.0

