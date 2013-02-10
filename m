Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 07/13] lib: Add missing DTD validation in sdp_record_print()
Date: Sun, 10 Feb 2013 17:26:31 -0400
Message-Id: <1360531597-3506-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index f65138c..21dfe1b 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1603,13 +1603,13 @@ static void print_dataseq(sdp_data_t *p)
 void sdp_record_print(const sdp_record_t *rec)
 {
 	sdp_data_t *d = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
-	if (d)
+	if (d && SDP_IS_TEXT_STR(d->dtd))
 		printf("Service Name: %.*s\n", d->unitSize, d->val.str);
 	d = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
-	if (d)
+	if (d && SDP_IS_TEXT_STR(d->dtd))
 		printf("Service Description: %.*s\n", d->unitSize, d->val.str);
 	d = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
-	if (d)
+	if (d && SDP_IS_TEXT_STR(d->dtd))
 		printf("Service Provider: %.*s\n", d->unitSize, d->val.str);
 }
 
-- 
1.7.9.5

