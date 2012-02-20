Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/2] sdp: Check type of sdp data before dereferencing
Date: Mon, 20 Feb 2012 21:57:57 +0100
Message-Id: <1329771478-3935-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1329771478-3935-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1329771478-3935-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    2 +-
 lib/sdp.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index a48ee14..57f630a 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2065,7 +2065,7 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 
 		if (SDP_IS_UUID(seq->dtd)) {
 			uuid = &seq->val.uuid;
-		} else {
+		} else if (SDP_IS_SEQ(seq->dtd)) {
 			sdp_data_t *puuid = seq->val.dataseq;
 			sdp_data_t *pVnum = seq->val.dataseq->next;
 			if (puuid && pVnum) {
diff --git a/lib/sdp.h b/lib/sdp.h
index 5f7d271..2fe74d5 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -432,6 +432,7 @@ typedef struct {
 } uuid_t;
 
 #define SDP_IS_UUID(x) ((x) == SDP_UUID16 || (x) == SDP_UUID32 || (x) ==SDP_UUID128)
+#define SDP_IS_SEQ(x)  ((x) == SDP_SEQ8 || (x) == SDP_SEQ16 || (x) == SDP_SEQ32)
 
 typedef struct _sdp_list sdp_list_t;
 struct _sdp_list {
-- 
1.7.5.4

