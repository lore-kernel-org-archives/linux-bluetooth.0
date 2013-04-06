Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 16/16] Bluetooth: hidp: fix sending output reports on intr channel
Date: Sat,  6 Apr 2013 20:28:52 +0200
Message-Id: <1365272932-571-17-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the specifications, data output reports must be sent on the
interrupt channel. See also usbhid implementation.
Sending these reports on the control channel breaks newer Wii Remotes.

Note that this will make output reports asynchronous. However, that's how
hid_output_raw_report() is supposed to work with HID_OUTPUT_REPORT as
report type. There are no responses to output reports.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 13a0a05..940f5ac 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -335,14 +335,11 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 	struct hidp_session *session = hid->driver_data;
 	int ret;
 
-	switch (report_type) {
-	case HID_FEATURE_REPORT:
-		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
-		break;
-	case HID_OUTPUT_REPORT:
+	if (report_type == HID_OUTPUT_REPORT) {
 		report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
-		break;
-	default:
+		return hidp_send_intr_message(session, report_type,
+					      data, count);
+	} else if (report_type != HID_FEATURE_REPORT) {
 		return -EINVAL;
 	}
 
@@ -351,6 +348,7 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 
 	/* Set up our wait, and send the report request to the device. */
 	set_bit(HIDP_WAITING_FOR_SEND_ACK, &session->flags);
+	report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
 	ret = hidp_send_ctrl_message(session, report_type, data, count);
 	if (ret)
 		goto err;
-- 
1.8.2

