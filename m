Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/14] device: Retrieve records from tmp_records only
Date: Wed, 12 Dec 2012 16:48:02 +0100
Message-Id: <1355327283-1558-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDP records are no more stored, so they can only be retrieved
from remote device (tmp_records during bonding).
---
 src/device.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6cec4a0..a7f85d1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4220,24 +4220,20 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 							const char *uuid)
 {
-	if (device->tmp_records) {
-		const sdp_record_t *record;
+	const sdp_record_t *record;
 
-		record = find_record_in_list(device->tmp_records, uuid);
-		if (record != NULL)
-			return record;
-
-		sdp_list_free(device->tmp_records,
-					(sdp_free_func_t) sdp_record_free);
-		device->tmp_records = NULL;
-	}
-
-	device->tmp_records = read_records(adapter_get_address(device->adapter),
-							&device->bdaddr);
 	if (!device->tmp_records)
 		return NULL;
 
-	return find_record_in_list(device->tmp_records, uuid);
+	record = find_record_in_list(device->tmp_records, uuid);
+	if (record != NULL)
+		return record;
+
+	sdp_list_free(device->tmp_records,
+				(sdp_free_func_t) sdp_record_free);
+	device->tmp_records = NULL;
+
+	return NULL;
 }
 
 struct btd_device *btd_device_ref(struct btd_device *device)
-- 
1.7.9.5

