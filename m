Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/7] android/gatt: Use better name for matching function
Date: Wed, 26 Mar 2014 18:00:54 +0100
Message-Id: <1395853259-15618-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As there is no static type check for matching functions, we should keep
their names more descriptive, like 'match_dev_by_conn_id' is.
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index aeb0585..2ea99e4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -151,7 +151,7 @@ static bool match_dev_by_conn_id(const void *data, const void *user_data)
 	return dev->conn_id == conn_id;
 }
 
-static bool match_srvc_by_gatt_id(const void *data, const void *user_data)
+static bool match_srvc_by_element_id(const void *data, const void *user_data)
 {
 	const struct element_id *exp_id = user_data;
 	const struct service *service = data;
@@ -1052,7 +1052,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 	}
 
 	hal_srvc_id_to_gatt_id(&cmd->srvc_id, &match_id);
-	srvc = queue_find(dev->services, match_srvc_by_gatt_id, &match_id);
+	srvc = queue_find(dev->services, match_srvc_by_element_id, &match_id);
 	if (!srvc) {
 		error("gatt: Service with inst_id: %d not found",
 							match_id.instance);
-- 
1.9.0

