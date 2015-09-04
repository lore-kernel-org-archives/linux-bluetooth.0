Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt: Fix not exporting new services
Date: Fri,  4 Sep 2015 11:46:25 +0300
Message-Id: <1441356385-17913-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Ever since cache validation was introduced the services are no longer
cleared on disconnect so checking for queue empty is not valid anymore.
---
 src/gatt-client.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 3356ee4..d8a3429 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1538,6 +1538,9 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 	/* Set service active so we can skip discovering next time */
 	gatt_db_service_set_active(attr, true);
 
+	/* Mark the service as claimed since it going to be exported */
+	gatt_db_service_set_claimed(attr, true);
+
 	return service;
 }
 
@@ -1840,11 +1843,7 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
 
 	DBG("GATT client ready");
 
-	if (queue_isempty(client->services)) {
-		DBG("Exporting services");
-		create_services(client);
-		return;
-	}
+	create_services(client);
 
 	/*
 	 * Services have already been created before. Re-enable notifications
-- 
2.4.3

