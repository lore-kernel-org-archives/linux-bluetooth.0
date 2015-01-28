Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] lib/sdp: Add sdp_find_record_with_class function
Date: Thu, 29 Jan 2015 00:30:59 +0100
Message-Id: <1422487860-13212-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function returns first records with specified service class.
It may happen that remote device provides more records with same
profile UUID. Device supporting HFP AG and HFP HS roles is example.
In such case we need to get proper records based on service class.
---
 lib/sdp.c     | 12 ++++++++++++
 lib/sdp_lib.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index 2107e28..e77826d 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1847,6 +1847,18 @@ int sdp_get_proto_port(const sdp_list_t *list, int proto)
 	return 0;
 }
 
+sdp_record_t *sdp_find_record_with_class(const sdp_list_t *recs, uuid_t uuid)
+{
+	for (; recs; recs = recs->next) {
+		sdp_record_t *rec = recs->data;
+
+		if (!sdp_uuid_cmp(&rec->svclass, &uuid))
+			return rec;
+	}
+
+	return NULL;
+}
+
 sdp_data_t *sdp_get_proto_desc(sdp_list_t *list, int proto)
 {
 	for (; list; list = list->next) {
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index 3ded393..9828efb 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -244,6 +244,11 @@ int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *proto);
 int sdp_get_proto_port(const sdp_list_t *list, int proto);
 
 /*
+ * Find record with specified service class
+ */
+sdp_record_t *sdp_find_record_with_class(const sdp_list_t *list, uuid_t uuid);
+
+/*
  * Get protocol descriptor.
  */
 sdp_data_t *sdp_get_proto_desc(sdp_list_t *list, int proto);
-- 
1.9.3

