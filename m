Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] sdptool: Fix sdptool output
Message-Id: <20140218213509.EB15A1005F0@puck.mtv.corp.google.com>
Date: Tue, 18 Feb 2014 13:35:09 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing newlines to sdp_record_print().
---
 lib/sdp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 3b26ec3..f957c46 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1604,13 +1604,13 @@ void sdp_record_print(const sdp_record_t *rec)
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
1.9.0.rc1.175.g0b1dcb5

