Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] lib/sdp: Fix printing of multiple record fields
Date: Fri,  7 Feb 2014 16:14:46 -0400
Message-Id: <1391804086-14428-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1391804086-14428-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1391804086-14428-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there are multiple fields to print, sdp_record_print() was missing a
newline between entries.
---
 lib/sdp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 0a7cb6f..e5e4622 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1605,13 +1605,13 @@ void sdp_record_print(const sdp_record_t *rec)
 {
 	sdp_data_t *d = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
 	if (d && SDP_IS_TEXT_STR(d->dtd))
-		printf("Service Name: %.*s", d->unitSize, d->val.str);
+		printf("Service Name: %.*s\n", d->unitSize, d->val.str);
 	d = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
 	if (d && SDP_IS_TEXT_STR(d->dtd))
-		printf("Service Description: %.*s", d->unitSize, d->val.str);
+		printf("Service Description: %.*s\n", d->unitSize, d->val.str);
 	d = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
 	if (d && SDP_IS_TEXT_STR(d->dtd))
-		printf("Service Provider: %.*s", d->unitSize, d->val.str);
+		printf("Service Provider: %.*s\n", d->unitSize, d->val.str);
 }
 
 #ifdef SDP_DEBUG
-- 
1.7.9.5

