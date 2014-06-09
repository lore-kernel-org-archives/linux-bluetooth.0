Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] SDP: Make sdp_set_add_access_protos() return void
Date: Mon,  9 Jun 2014 15:14:50 +0300
Message-Id: <1402316090-437-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402316090-437-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402316090-437-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function always returns 0, make it void function.
---
 lib/sdp.c     | 4 +---
 lib/sdp_lib.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index da26b78..11bd532 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2394,7 +2394,7 @@ void sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 	sdp_attr_add(rec, SDP_ATTR_PROTO_DESC_LIST, protos);
 }
 
-int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
+void sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 {
 	const sdp_list_t *p;
 	sdp_data_t *protos = NULL;
@@ -2406,8 +2406,6 @@ int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 
 	sdp_attr_add(rec, SDP_ATTR_ADD_PROTO_DESC_LIST,
 			protos ? sdp_data_alloc(SDP_SEQ8, protos) : NULL);
-
-	return 0;
 }
 
 /*
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index 72922d6..5b2d551 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -236,7 +236,7 @@ void sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
 /*
  * Set the additional access protocols of the record to those specified in proto
  */
-int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
+void sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
 
 /*
  * Get protocol port (i.e. PSM for L2CAP, Channel for RFCOMM)
-- 
1.8.3.2

