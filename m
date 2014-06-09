Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] SDP: Make sdp_set_access_protos() return void
Date: Mon,  9 Jun 2014 15:08:19 +0300
Message-Id: <1402315699-30381-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402315699-30381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402315699-30381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function always returns 0, so there is sense to make it void function.
---
 lib/sdp.c     | 6 +-----
 lib/sdp_lib.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index e5e4622..da26b78 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2380,10 +2380,8 @@ static sdp_data_t *access_proto_to_dataseq(sdp_record_t *rec, sdp_list_t *proto)
  *
  * This function replaces the existing sdp_access_proto_t
  * structure (if any) with the new one specified.
- *
- * returns 0 if successful or -1 if there is a failure.
  */
-int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
+void sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 {
 	const sdp_list_t *p;
 	sdp_data_t *protos = NULL;
@@ -2394,8 +2392,6 @@ int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 	}
 
 	sdp_attr_add(rec, SDP_ATTR_PROTO_DESC_LIST, protos);
-
-	return 0;
 }
 
 int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index 3ded393..72922d6 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -231,7 +231,7 @@ static inline int sdp_set_browse_groups(sdp_record_t *rec, sdp_list_t *seq)
 /*
  * Set the access protocols of the record to those specified in proto
  */
-int sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
+void sdp_set_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
 
 /*
  * Set the additional access protocols of the record to those specified in proto
-- 
1.8.3.2

