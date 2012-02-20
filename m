Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] sdp: Fix sdp_get_profile_descs for Mac Os X Lion
Date: Mon, 20 Feb 2012 21:57:58 +0100
Message-Id: <1329771478-3935-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1329771478-3935-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1329771478-3935-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 57f630a..97c0a08 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2064,7 +2064,12 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 		uint16_t version = 0x100;
 
 		if (SDP_IS_UUID(seq->dtd)) {
+			sdp_data_t *next = seq->next;
 			uuid = &seq->val.uuid;
+			if (next && next->dtd == SDP_UINT16) {
+				version = next->val.uint16;
+				seq = next;
+			}
 		} else if (SDP_IS_SEQ(seq->dtd)) {
 			sdp_data_t *puuid = seq->val.dataseq;
 			sdp_data_t *pVnum = seq->val.dataseq->next;
-- 
1.7.5.4

