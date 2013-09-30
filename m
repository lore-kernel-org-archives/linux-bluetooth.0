Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] lib: Fix use of uninitialized variable in sdp_set_profile_descs
Date: Mon, 30 Sep 2013 15:06:03 +0200
Message-ID: <1380546363-10722-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Error path on default case was not breaking loop. To keep error
handling similar all error path were converted to use goto.

This fix following:
target  C: libbluetooth <= external/bluetooth/bluez/android/../lib/sdp.c
lib/sdp.c: In function 'sdp_set_profile_descs':
lib/sdp.c:487:10: warning: 'values[0]' may be used uninitialized in
    this function [-Wmaybe-uninitialized]
lib/sdp.c:2562:19: note: 'values[0]' was declared here
lib/sdp.c:545:11: warning: 'dtds[0]' may be used uninitialized in this
    function [-Wmaybe-uninitialized]
lib/sdp.c:2562:9: note: 'dtds[0]' was declared here
---
 lib/sdp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 54a99b6..1405c50 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2546,6 +2546,7 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *profiles)
 	int i = 0, seqlen = sdp_list_len(profiles);
 	void **seqDTDs, **seqs;
 	const sdp_list_t *p;
+	sdp_data_t *pAPSeq;
 
 	seqDTDs = malloc(seqlen * sizeof(void *));
 	if (!seqDTDs)
@@ -2563,7 +2564,7 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *profiles)
 		sdp_profile_desc_t *profile = p->data;
 		if (!profile) {
 			status = -1;
-			break;
+			goto end;
 		}
 		switch (profile->uuid.type) {
 		case SDP_UUID16:
@@ -2580,7 +2581,7 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *profiles)
 			break;
 		default:
 			status = -1;
-			break;
+			goto end;
 		}
 		dtds[1] = &uint16;
 		values[1] = &profile->version;
@@ -2588,7 +2589,7 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *profiles)
 
 		if (seq == NULL) {
 			status = -1;
-			break;
+			goto end;
 		}
 
 		seqDTDs[i] = &seq->dtd;
@@ -2596,10 +2597,10 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *profiles)
 		sdp_pattern_add_uuid(rec, &profile->uuid);
 		i++;
 	}
-	if (status == 0) {
-		sdp_data_t *pAPSeq = sdp_seq_alloc(seqDTDs, seqs, seqlen);
-		sdp_attr_add(rec, SDP_ATTR_PFILE_DESC_LIST, pAPSeq);
-	}
+
+	pAPSeq = sdp_seq_alloc(seqDTDs, seqs, seqlen);
+	sdp_attr_add(rec, SDP_ATTR_PFILE_DESC_LIST, pAPSeq);
+end:
 	free(seqDTDs);
 	free(seqs);
 	return status;
-- 
1.8.4

