Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/4] input: Change extract_hid_record() return type
Date: Sun,  6 Jan 2013 15:45:55 -0400
Message-Id: <1357501558-3457-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow returning error values when necessary.
---
 profiles/input/device.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 759603a..9e485cf 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -202,7 +202,7 @@ static void epox_endian_quirk(unsigned char *data, int size)
 	}
 }
 
-static void extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
+static int extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 {
 	sdp_data_t *pdlist, *pdlist2;
 	uint8_t attr_val;
@@ -255,6 +255,8 @@ static void extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 			epox_endian_quirk(req->rd_data, req->rd_size);
 		}
 	}
+
+	return 0;
 }
 
 static int ioctl_connadd(struct hidp_connadd_req *req)
@@ -346,8 +348,13 @@ static int hidp_add_connection(struct input_device *idev)
 	rec = record_from_string(str);
 	g_free(str);
 
-	extract_hid_record(rec, req);
+	err = extract_hid_record(rec, req);
 	sdp_record_free(rec);
+	if (err < 0) {
+		error("Could not parse HID SDP record: %s (%d)", strerror(-err),
+									-err);
+		goto cleanup;
+	}
 
 	req->vendor = btd_device_get_vendor(idev->device);
 	req->product = btd_device_get_product(idev->device);
-- 
1.7.9.5

