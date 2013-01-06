Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] input: Refactor req->name composition code
Date: Sun,  6 Jan 2013 11:26:53 -0400
Message-Id: <1357486014-24600-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357486014-24600-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357486014-24600-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use snprintf() instead of strncpy()/strcat()/strncat() to avoid
error-prone size calculations.

Note that this commit introduces a slight change: if Service Description
and Provider Name are used to compose req->name, the old code built it
as:

[up to 126 bytes of Provider Name][whitespace][up to 127 bytes of
Service Description, limited to req->name remaining buffer size]

Now it should be:

[up to 127 bytes of Provider Name][whitespace + Service Description,
limited to req->name remaining buffer size]

Hopefully, this change will not affect normal usage.
---
 profiles/input/device.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 6c152f3..0c71786 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -209,19 +209,17 @@ static void extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 
 	pdlist = sdp_data_get(rec, 0x0101);
 	pdlist2 = sdp_data_get(rec, 0x0102);
-	if (pdlist) {
-		if (pdlist2) {
-			if (strncmp(pdlist->val.str, pdlist2->val.str, 5)) {
-				strncpy(req->name, pdlist2->val.str, 126);
-				strcat(req->name, " ");
-			}
-			strncat(req->name, pdlist->val.str, 127 - strlen(req->name));
-		} else
-			strncpy(req->name, pdlist->val.str, 127);
+	if (pdlist && pdlist2 &&
+				strncmp(pdlist->val.str, pdlist2->val.str, 5)) {
+		snprintf(req->name, sizeof(req->name), "%s %s",
+					pdlist2->val.str, pdlist->val.str);
 	} else {
-		pdlist2 = sdp_data_get(rec, 0x0100);
-		if (pdlist2)
-			strncpy(req->name, pdlist2->val.str, 127);
+		if (!pdlist)
+			pdlist = sdp_data_get(rec, 0x0100);
+
+		if (pdlist)
+			snprintf(req->name, sizeof(req->name), "%s",
+							pdlist->val.str);
 	}
 
 	pdlist = sdp_data_get(rec, SDP_ATTR_HID_PARSER_VERSION);
-- 
1.7.9.5

