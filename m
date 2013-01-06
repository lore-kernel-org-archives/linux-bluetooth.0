Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/4] input: Use SDP library functions for reading attributes
Date: Sun,  6 Jan 2013 15:45:57 -0400
Message-Id: <1357501558-3457-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357501558-3457-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357501558-3457-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These functions do the necessary validation that is lacking from
previous code.
---
 profiles/input/device.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 7a7e995..eaf5681 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -204,21 +204,19 @@ static void epox_endian_quirk(unsigned char *data, int size)
 
 static int create_hid_dev_name(sdp_record_t *rec, struct hidp_connadd_req *req)
 {
-	sdp_data_t *pdlist, *pdlist2;
-
-	pdlist = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
-	pdlist2 = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
-	if (pdlist && pdlist2 &&
-			strncmp(pdlist->val.str, pdlist2->val.str, 5) != 0) {
-		snprintf(req->name, sizeof(req->name), "%s %s",
-					pdlist2->val.str, pdlist->val.str);
-	} else {
-		if (!pdlist)
-			pdlist = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
+	char sdesc[sizeof(req->name)];
+
+	if (sdp_get_service_desc(rec, sdesc, sizeof(sdesc)) == 0) {
+		char pname[sizeof(req->name)];
 
-		if (pdlist)
-			snprintf(req->name, sizeof(req->name), "%s",
-							pdlist->val.str);
+		if (sdp_get_provider_name(rec, pname, sizeof(pname)) == 0 &&
+						strncmp(sdesc, pname, 5) != 0)
+			snprintf(req->name, sizeof(req->name), "%s %s", pname,
+									sdesc);
+		else
+			snprintf(req->name, sizeof(req->name), "%s", sdesc);
+	} else {
+		return sdp_get_service_name(rec, req->name, sizeof(req->name));
 	}
 
 	return 0;
-- 
1.7.9.5

