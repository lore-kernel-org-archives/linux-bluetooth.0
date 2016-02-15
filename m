Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] core/device: Fix log when loading characteristic fails
Date: Mon, 15 Feb 2016 14:30:40 +0200
Message-Id: <1455539442-31843-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
References: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It should log that loading fails not saving.
---
 src/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1f7c895..235145a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3012,7 +3012,7 @@ static int load_chrc(char *handle, char *value,
 							&uuid, 0, properties,
 							NULL, NULL, NULL);
 	if (!att || gatt_db_attribute_get_handle(att) != value_handle) {
-		warn("saving characteristic to db failed");
+		warn("loading characteristic to db failed");
 		return -EIO;
 	}
 
@@ -3039,13 +3039,13 @@ static int load_incl(struct gatt_db *db, char *handle, char *value,
 
 	att = gatt_db_get_attribute(db, start);
 	if (!att) {
-		warn("saving included service to db failed - no such service");
+		warn("loading included service to db failed - no such service");
 		return -EIO;
 	}
 
 	att = gatt_db_service_add_included(service, att);
 	if (!att) {
-		warn("saving included service to db failed");
+		warn("loading included service to db failed");
 		return -EIO;
 	}
 
@@ -3082,7 +3082,7 @@ static int load_service(struct gatt_db *db, char *handle, char *value)
 	att = gatt_db_insert_service(db, start, &uuid, primary,
 							end - start + 1);
 	if (!att) {
-		DBG("ERROR saving service to db!");
+		error("Unable load service into db.");
 		return -EIO;
 	}
 
-- 
2.5.0

