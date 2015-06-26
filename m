Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] core/device: Don't overwrite SDP record cache
Date: Fri, 26 Jun 2015 14:58:58 +0300
Message-Id: <1435319940-13943-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
References: <1435319940-13943-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_device_get_record should not overwrite existing cache if record
cannot be found since the cache should alway be up to date as it is
reloaded from file if the cache is empty.
---
 src/device.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3ef0340..85a6aa6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5545,22 +5545,13 @@ static sdp_list_t *read_device_records(struct btd_device *device)
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 							const char *uuid)
 {
-	if (device->tmp_records) {
-		const sdp_record_t *record;
-
-		record = find_record_in_list(device->tmp_records, uuid);
-		if (record != NULL)
-			return record;
-
-		sdp_list_free(device->tmp_records,
-					(sdp_free_func_t) sdp_record_free);
-		device->tmp_records = NULL;
+	/* Load records from storage if there is nothing in cache */
+	if (!device->tmp_records) {
+		device->tmp_records = read_device_records(device);
+		if (!device->tmp_records)
+			return NULL;
 	}
 
-	device->tmp_records = read_device_records(device);
-	if (!device->tmp_records)
-		return NULL;
-
 	return find_record_in_list(device->tmp_records, uuid);
 }
 
-- 
2.1.0

