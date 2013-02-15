Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 07/13] lib: Add missing DTD validation in sdp_record_print()
Date: Fri, 15 Feb 2013 11:07:50 -0400
Message-Id: <1360940876-6314-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940876-6314-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 9c1eeb5..782d9bd 100644
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

