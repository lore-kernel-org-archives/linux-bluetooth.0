Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 1/2] hog: Fix potencial segfault when sending a output report
Date: Fri, 23 Nov 2012 16:08:28 -0300
Message-Id: <1353697709-6497-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As UHID is not notified when the device is disconnected, it may be
possible that an output report is forwarded when the device is not
connected, one example, would be when the caps lock key is pressed on
another keyboard.
---
 profiles/input/hog_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index d231e00..994437f 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -573,6 +573,9 @@ static void forward_report(struct hog_device *hogdev,
 	DBG("Sending report type %d to device 0x%04X handle 0x%X", type,
 				hogdev->id, report->decl->value_handle);
 
+	if (hogdev->attrib == NULL)
+		return;
+
 	if (report->decl->properties & ATT_CHAR_PROPER_WRITE)
 		gatt_write_char(hogdev->attrib, report->decl->value_handle,
 				data, size, output_written_cb, hogdev);
-- 
1.8.0

