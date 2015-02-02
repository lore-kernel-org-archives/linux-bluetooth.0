Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] android/handsfree: Fix not selecting correct SDP HFP record
Date: Mon,  2 Feb 2015 16:09:34 +0100
Message-Id: <1422889775-13162-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote device has both HFP AG and HFP HF records then we were
always selecting first record. This could result in not being able
to connect to HF if AG record happens to be first one.

Issue found on UPF 50.
---
 android/handsfree.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 98d40b3..ee6de10 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1621,10 +1621,10 @@ static int sdp_search_hsp(struct hf_device *dev)
 static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
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
@@ -1635,6 +1635,16 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
+	sdp_uuid16_create(&class, HANDSFREE_SVCLASS_ID);
+
+	/* Find record with proper service class */
+	for (; recs; recs = recs->next) {
+		sdp_record_t *rec = recs->data;
+
+		if (rec && !sdp_uuid_cmp(&rec->svclass, &class))
+			break;
+	}
+
 	if (!recs || !recs->data) {
 		info("handsfree: no HFP SDP records found, trying HSP");
 
@@ -1646,26 +1656,8 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		return;
 	}
 
-	if (sdp_get_service_classes(recs->data, &classes) < 0 || !classes) {
-		error("handsfree: unable to get service classes from record");
-		goto fail;
-	}
-
 	if (sdp_get_access_protos(recs->data, &protos) < 0) {
 		error("handsfree: unable to get access protocols from record");
-		sdp_list_free(classes, free);
-		goto fail;
-	}
-
-	/* TODO read remote version? */
-
-	memcpy(&uuid, classes->data, sizeof(uuid));
-	sdp_list_free(classes, free);
-
-	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16 ||
-			uuid.value.uuid16 != HANDSFREE_SVCLASS_ID) {
-		sdp_list_free(protos, NULL);
-		error("handsfree: invalid service record or not HFP");
 		goto fail;
 	}
 
@@ -1677,6 +1669,8 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
+	/* TODO read remote version? */
+
 	io = bt_io_connect(connect_cb, dev, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
-- 
1.9.3

