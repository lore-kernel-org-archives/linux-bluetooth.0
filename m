Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/1] Fixes sdp_get_supp_feat function
Date: Fri, 14 May 2010 00:13:30 -0300
Message-Id: <1273806810-29602-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of string data items, value is a pointer by itself.
---
 lib/sdp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index fb8ccdc..c75a000 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4801,10 +4801,15 @@ int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
 		subseq = NULL;
 		for (dd = d->val.dataseq; dd; dd = dd->next) {
 			sdp_data_t *data;
+			void *val;
 			if (dd->dtd != SDP_UINT8 && dd->dtd != SDP_UINT16 &&
 						dd->dtd != SDP_TEXT_STR8)
 				goto fail;
-			data = sdp_data_alloc(dd->dtd, &dd->val);
+			if (dd->dtd == SDP_TEXT_STR8)
+				val = dd->val.str;
+			else
+				val = &dd->val;
+			data = sdp_data_alloc(dd->dtd, val);
 			if (data)
 				subseq = sdp_list_append(subseq, data);
 		}
-- 
1.7.0.4

