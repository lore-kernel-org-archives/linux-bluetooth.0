Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/4] input: Move HID device name creation to separate function
Date: Sun,  6 Jan 2013 15:45:56 -0400
Message-Id: <1357501558-3457-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357501558-3457-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357501558-3457-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The attributes used for composing the device name are all optional, and
thus need to be properly validated. A separate function will avoid
polluting the caller with variables used only for device name
composition.
---
 profiles/input/device.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 9e485cf..7a7e995 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -202,10 +202,9 @@ static void epox_endian_quirk(unsigned char *data, int size)
 	}
 }
 
-static int extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
+static int create_hid_dev_name(sdp_record_t *rec, struct hidp_connadd_req *req)
 {
 	sdp_data_t *pdlist, *pdlist2;
-	uint8_t attr_val;
 
 	pdlist = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
 	pdlist2 = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
@@ -222,6 +221,19 @@ static int extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 							pdlist->val.str);
 	}
 
+	return 0;
+}
+
+static int extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
+{
+	sdp_data_t *pdlist;
+	uint8_t attr_val;
+	int err;
+
+	err = create_hid_dev_name(rec, req);
+	if (err < 0)
+		DBG("No valid Service Name or Service Description found");
+
 	pdlist = sdp_data_get(rec, SDP_ATTR_HID_PARSER_VERSION);
 	req->parser = pdlist ? pdlist->val.uint16 : 0x0100;
 
-- 
1.7.9.5

