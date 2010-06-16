Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Fixes sdp_get_supp_feat function
Date: Wed, 16 Jun 2010 13:30:48 -0300
Message-Id: <1276705848-22401-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of string data items, value is a pointer by itself.
---
 lib/sdp.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 79f4ae5..17745ac 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4769,13 +4769,32 @@ int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
 
 		if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
 			goto fail;
+
 		subseq = NULL;
+
 		for (dd = d->val.dataseq; dd; dd = dd->next) {
 			sdp_data_t *data;
-			if (dd->dtd != SDP_UINT8 && dd->dtd != SDP_UINT16 &&
-						dd->dtd != SDP_TEXT_STR8)
+			void *val;
+			int length;
+
+			switch (dd->dtd) {
+			case SDP_URL_STR8:
+			case SDP_URL_STR16:
+			case SDP_TEXT_STR8:
+			case SDP_TEXT_STR16:
+				val = dd->val.str;
+				length = dd->unitSize - sizeof(uint8_t);
+				break;
+			case SDP_UINT8:
+			case SDP_UINT16:
+				val = &dd->val;
+				length = 0;
+				break;
+			default:
 				goto fail;
-			data = sdp_data_alloc(dd->dtd, &dd->val);
+			}
+
+			data = sdp_data_alloc_with_length(dd->dtd, val, length);
 			if (data)
 				subseq = sdp_list_append(subseq, data);
 		}
-- 
1.7.0.4

