Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] scanparam: Fix not handling accept properly
Date: Thu,  8 Sep 2016 15:38:58 +0300
Message-Id: <1473338340-7587-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
References: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

On accept the profile shall check about existing attribute, etc and once
done call btd_service_connecting_complete updating the service state
properly.
---
 profiles/scanparam/scan.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index d3ca762..d12e09e 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -201,7 +201,6 @@ static int scan_param_accept(struct btd_service *service)
 	gatt_db_unref(scan->db);
 	bt_gatt_client_unref(scan->client);
 
-
 	scan->db = gatt_db_ref(db);
 	scan->client = bt_gatt_client_ref(client);
 
@@ -209,6 +208,17 @@ static int scan_param_accept(struct btd_service *service)
 	gatt_db_foreach_service(db, &scan_parameters_uuid,
 					foreach_scan_param_service, scan);
 
+	if (!scan->attr) {
+		error("Scan Parameters attribute not found");
+		gatt_db_unref(scan->db);
+		scan->db = NULL;
+		bt_gatt_client_unref(scan->client);
+		scan->client = NULL;
+		return -1;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
 	return 0;
 }
 
-- 
2.7.4

