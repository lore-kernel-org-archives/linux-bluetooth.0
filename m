Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] input: Use defines for SDP attribute names
Date: Sun,  6 Jan 2013 11:26:54 -0400
Message-Id: <1357486014-24600-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357486014-24600-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357486014-24600-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/device.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 0c71786..6bcc6a5 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -207,15 +207,15 @@ static void extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 	sdp_data_t *pdlist, *pdlist2;
 	uint8_t attr_val;
 
-	pdlist = sdp_data_get(rec, 0x0101);
-	pdlist2 = sdp_data_get(rec, 0x0102);
+	pdlist = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
+	pdlist2 = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
 	if (pdlist && pdlist2 &&
 				strncmp(pdlist->val.str, pdlist2->val.str, 5)) {
 		snprintf(req->name, sizeof(req->name), "%s %s",
 					pdlist2->val.str, pdlist->val.str);
 	} else {
 		if (!pdlist)
-			pdlist = sdp_data_get(rec, 0x0100);
+			pdlist = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
 
 		if (pdlist)
 			snprintf(req->name, sizeof(req->name), "%s",
-- 
1.7.9.5

