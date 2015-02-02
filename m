Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] android/handsfree: Fix not selecting correct SDP HSP record
Date: Mon,  2 Feb 2015 16:09:35 +0100
Message-Id: <1422889775-13162-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1422889775-13162-1-git-send-email-szymon.janc@tieto.com>
References: <1422889775-13162-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote device has both HSP AG and HSP HF records then we were
always selecting first record. This could result in not being able
to connect to HF if AG record happens to be first one.
---
 android/handsfree.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index ee6de10..76f5653 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1536,10 +1536,10 @@ drop:
 static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 {
 	struct hf_device *dev = data;
-	sdp_list_t *protos, *classes;
+	sdp_list_t *protos;
 	GError *gerr = NULL;
 	GIOChannel *io;
-	uuid_t uuid;
+	uuid_t class;
 	int channel;
 
 	DBG("");
@@ -1550,35 +1550,29 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
-	if (!recs || !recs->data) {
-		info("handsfree: no HSP SDP records found");
-		goto fail;
+	sdp_uuid16_create(&class, HEADSET_SVCLASS_ID);
+
+	/* Find record with proper service class */
+	for (; recs; recs = recs->next) {
+		sdp_record_t *rec = recs->data;
+
+		if (rec && !sdp_uuid_cmp(&rec->svclass, &class))
+			break;
 	}
 
-	if (sdp_get_service_classes(recs->data, &classes) < 0 || !classes) {
-		error("handsfree: unable to get service classes from record");
+	if (!recs || !recs->data) {
+		info("handsfree: no valid HSP SDP records found");
 		goto fail;
 	}
 
 	if (sdp_get_access_protos(recs->data, &protos) < 0) {
 		error("handsfree: unable to get access protocols from record");
-		sdp_list_free(classes, free);
 		goto fail;
 	}
 
 	/* TODO read remote version? */
 	/* TODO read volume control support */
 
-	memcpy(&uuid, classes->data, sizeof(uuid));
-	sdp_list_free(classes, free);
-
-	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16 ||
-			uuid.value.uuid16 != HEADSET_SVCLASS_ID) {
-		sdp_list_free(protos, NULL);
-		error("handsfree: invalid service record or not HSP");
-		goto fail;
-	}
-
 	channel = sdp_get_proto_port(protos, RFCOMM_UUID);
 	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
 	sdp_list_free(protos, NULL);
-- 
1.9.3

