Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v2 1/1] Makes extract_svclass_uuid function public
Date: Thu, 13 May 2010 12:08:36 -0300
Message-Id: <1273763316-28425-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes the extract_svclass_uuid function public,
so it may be used by applications that link to libbluetooth.
---
 lib/sdp.c     |    8 ++++----
 lib/sdp_lib.h |    1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index aa22c63..fb8ccdc 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -591,7 +591,7 @@ sdp_data_t *sdp_seq_alloc(void **dtds, void **values, int len)
 	return sdp_data_alloc(SDP_SEQ8, seq);
 }
 
-static void extract_svclass_uuid(sdp_data_t *data, uuid_t *uuid)
+void sdp_extract_svclass_uuid(sdp_data_t *data, uuid_t *uuid)
 {
 	sdp_data_t *d;
 
@@ -619,7 +619,7 @@ int sdp_attr_add(sdp_record_t *rec, uint16_t attr, sdp_data_t *d)
 	rec->attrlist = sdp_list_insert_sorted(rec->attrlist, d, sdp_attrid_comp_func);
 
 	if (attr == SDP_ATTR_SVCLASS_ID_LIST)
-		extract_svclass_uuid(d, &rec->svclass);
+		sdp_extract_svclass_uuid(d, &rec->svclass);
 
 	return 0;
 }
@@ -978,7 +978,7 @@ void sdp_attr_replace(sdp_record_t *rec, uint16_t attr, sdp_data_t *d)
 	rec->attrlist = sdp_list_insert_sorted(rec->attrlist, d, sdp_attrid_comp_func);
 
 	if (attr == SDP_ATTR_SVCLASS_ID_LIST)
-		extract_svclass_uuid(d, &rec->svclass);
+		sdp_extract_svclass_uuid(d, &rec->svclass);
 }
 
 int sdp_attrid_comp_func(const void *key1, const void *key2)
@@ -1478,7 +1478,7 @@ sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scanned)
 			rec->handle = data->val.uint32;
 
 		if (attr == SDP_ATTR_SVCLASS_ID_LIST)
-			extract_svclass_uuid(data, &rec->svclass);
+			sdp_extract_svclass_uuid(data, &rec->svclass);
 
 		extracted += n;
 		p += n;
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index e506ac1..3d70f0e 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -167,6 +167,7 @@ sdp_data_t *sdp_seq_alloc(void **dtds, void **values, int len);
 sdp_data_t *sdp_seq_alloc_with_length(void **dtds, void **values, int *length, int len);
 sdp_data_t *sdp_seq_append(sdp_data_t *seq, sdp_data_t *data);
 
+void sdp_extract_svclass_uuid(sdp_data_t *data, uuid_t *uuid);
 int sdp_attr_add(sdp_record_t *rec, uint16_t attr, sdp_data_t *data);
 void sdp_attr_remove(sdp_record_t *rec, uint16_t attr);
 void sdp_attr_replace(sdp_record_t *rec, uint16_t attr, sdp_data_t *data);
-- 
1.7.0.4

