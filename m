Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] input: Fix buffer overflow when parsing HID SDP record
Date: Sun,  6 Jan 2013 11:26:52 -0400
Message-Id: <1357486014-24600-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If Service Description for HID service is greater than 126 characters,
req->name will overflow while being concatenated with Provider Name. Fix
by reserving space for the whitespace used for separator.
---
 profiles/input/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 9ab7509..6c152f3 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -212,7 +212,7 @@ static void extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
 	if (pdlist) {
 		if (pdlist2) {
 			if (strncmp(pdlist->val.str, pdlist2->val.str, 5)) {
-				strncpy(req->name, pdlist2->val.str, 127);
+				strncpy(req->name, pdlist2->val.str, 126);
 				strcat(req->name, " ");
 			}
 			strncat(req->name, pdlist->val.str, 127 - strlen(req->name));
-- 
1.7.9.5

