Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH BlueZ] lib/sdp.c: Prevent passing unitialised argument
Date: Tue, 24 Jan 2012 14:22:43 +0100
Message-Id: <1327411363-18773-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of sdp_seq_alloc() failures in loop, unitialised seqDTDs would
be passed to final sdp_seq_alloc.
---
 lib/sdp.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index a48ee14..f618252 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2523,11 +2523,15 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *profiles)
 		dtds[1] = &uint16;
 		values[1] = &profile->version;
 		seq = sdp_seq_alloc(dtds, values, 2);
-		if (seq) {
-			seqDTDs[i] = &seq->dtd;
-			seqs[i] = seq;
-			sdp_pattern_add_uuid(rec, &profile->uuid);
+
+		if (seq == NULL) {
+			status = -1;
+			break;
 		}
+
+		seqDTDs[i] = &seq->dtd;
+		seqs[i] = seq;
+		sdp_pattern_add_uuid(rec, &profile->uuid);
 		i++;
 	}
 	if (status == 0) {
-- 
1.7.4.1

