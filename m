Return-Path: <cyrus@holtmann.org>
From: Frank Praznik <frank.praznik@oh.rr.com>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@gmail.com, simon@mungewell.org,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/1] HIDP: Add a special case for the Dualshock 4
Date: Mon, 20 Jan 2014 18:37:02 -0500
Message-Id: <1390261022-3113-2-git-send-email-frank.praznik@oh.rr.com>
In-Reply-To: <1390261022-3113-1-git-send-email-frank.praznik@oh.rr.com>
References: <1390261022-3113-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Dualshock 4 wants reports with type 0x52 sent on the ctrlchannel when
running over bluetooth. This adds a special case so that the reports can
be successfully sent.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 net/bluetooth/hidp/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 292e619..e597e3f 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -360,9 +360,17 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 	int ret;
 
 	if (report_type == HID_OUTPUT_REPORT) {
-		report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
-		return hidp_send_intr_message(session, report_type,
+		/* The Dualshock 4 wants report type 0x52 sent via the ctrl channel */
+		if(hid->vendor == 0x54c && hid->product == 0x5c4) {
+			report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
+			return hidp_send_ctrl_message(session, report_type,
 					      data, count);
+		}
+		else {
+			report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
+			return hidp_send_intr_message(session, report_type,
+					      data, count);
+		}
 	} else if (report_type != HID_FEATURE_REPORT) {
 		return -EINVAL;
 	}
-- 
1.8.4.2

