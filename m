Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] core/device: Fix not clearing Attributes before storing
Date: Mon, 15 Feb 2016 14:30:42 +0200
Message-Id: <1455539442-31843-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
References: <1455539442-31843-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This can leave the storage in a bad state if device start changing its
attributes the old one are never removed as the code reloads them with
g_key_file_load_from_file.
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 89462ca..14e850e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2114,6 +2114,9 @@ static void store_gatt_db(struct btd_device *device)
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
+	/* Remove current attributes since it might have changed */
+	g_key_file_remove_group(key_file, "Attributes", NULL);
+
 	saver.key_file = key_file;
 	saver.device = device;
 
@@ -3082,7 +3085,7 @@ static int load_service(struct gatt_db *db, char *handle, char *value)
 	att = gatt_db_insert_service(db, start, &uuid, primary,
 							end - start + 1);
 	if (!att) {
-		error("Unable load service into db.");
+		error("Unable load service into db!");
 		return -EIO;
 	}
 
-- 
2.5.0

