Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bug in sdp_set_supp_features solved
Date: Wed, 28 Apr 2010 12:08:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <201004281208.35923.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 567522ed4ac5912d967fef3017bf905591b5c24e Mon Sep 17 00:00:00 2001
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Wed, 28 Apr 2010 12:02:31 +0200
Subject: [PATCH] Bug in sdp_set_supp_features solved

When the data is a string or a sequence, it is not ok to dereference
data->val because it is already a pointer.
---
 lib/sdp.c |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 5f1f2fc..f9a6541 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4709,6 +4709,7 @@ int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
 	for (p = sf, i = 0; p; p = p->next, i++) {
 		int plen, j;
 		void **dtds, **vals;
+		int *sizes;

 		plen = sdp_list_len(p->data);
 		dtds = malloc(plen * sizeof(void *));
@@ -4719,14 +4720,42 @@ int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
 			free(dtds);
 			goto fail;
 		}
+		sizes = malloc(plen * sizeof(int *));
+		if (!sizes) {
+			free(dtds);
+			free(vals);
+			goto fail;
+		}
 		for (r = p->data, j = 0; r; r = r->next, j++) {
 			sdp_data_t *data = (sdp_data_t*)r->data;
 			dtds[j] = &data->dtd;
-			vals[j] = &data->val;
+			switch (data->dtd) {
+			case SDP_URL_STR8:
+			case SDP_URL_STR16:
+			case SDP_TEXT_STR8:
+			case SDP_TEXT_STR16:
+				vals[j] = data->val.str;
+				sizes[j] = data->unitSize - sizeof(uint8_t);
+				break;
+			case SDP_ALT8:
+			case SDP_ALT16:
+			case SDP_ALT32:
+			case SDP_SEQ8:
+			case SDP_SEQ16:
+			case SDP_SEQ32:
+				vals[j] = data->val.dataseq;
+				sizes[j] = 0;
+				break;
+			default:
+				vals[j] = &data->val;
+				sizes[j] = 0;
+				break;
+			}
 		}
-		feat = sdp_seq_alloc(dtds, vals, plen);
+		feat = sdp_seq_alloc_with_length(dtds, vals, sizes, plen);
 		free(dtds);
 		free(vals);
+		free(sizes);
 		if (!feat)
 			goto fail;
 		seqDTDs[i] = &feat->dtd;
--
1.6.3.3

