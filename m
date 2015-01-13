Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/pan: Change PAN record and name it as NAP record
Date: Tue, 13 Jan 2015 15:30:52 +0100
Message-Id: <1421159453-5535-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1421159453-5535-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1421159453-5535-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Current sdp record which is registering is NAP record it should be named
correctly.
---
 android/pan.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 714e926..e401001 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -710,10 +710,10 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ bt_pan_disconnect, false, sizeof(struct hal_cmd_pan_disconnect) },
 };
 
-static sdp_record_t *pan_record(void)
+static sdp_record_t *nap_record(void)
 {
 	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
-	uuid_t root_uuid, pan, l2cap, bnep;
+	uuid_t root_uuid, nap, l2cap, bnep;
 	sdp_profile_desc_t profile[1];
 	sdp_list_t *proto[2];
 	sdp_data_t *v, *p;
@@ -732,8 +732,8 @@ static sdp_record_t *pan_record(void)
 	record->attrlist = NULL;
 	record->pattern = NULL;
 
-	sdp_uuid16_create(&pan, NAP_SVCLASS_ID);
-	svclass = sdp_list_append(NULL, &pan);
+	sdp_uuid16_create(&nap, NAP_SVCLASS_ID);
+	svclass = sdp_list_append(NULL, &nap);
 	sdp_set_service_classes(record, svclass);
 
 	sdp_uuid16_create(&profile[0].uuid, NAP_PROFILE_ID);
@@ -787,41 +787,41 @@ static sdp_record_t *pan_record(void)
 
 bool bt_pan_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
-	sdp_record_t *rec;
+	sdp_record_t *nap_rec;
 	int err;
 
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
-	rec = pan_record();
-	if (!rec) {
+	nap_rec = nap_record();
+	if (!nap_rec) {
 		error("Failed to allocate PAN record");
 		return false;
 	}
 
-	if (bt_adapter_add_record(rec, SVC_HINT_NETWORKING) < 0) {
+	if (bt_adapter_add_record(nap_rec, SVC_HINT_NETWORKING) < 0) {
 		error("Failed to register PAN record");
-		sdp_record_free(rec);
+		sdp_record_free(nap_rec);
 		return false;
 	}
 
 	err = bnep_init();
 	if (err < 0) {
 		error("bnep init failed");
-		bt_adapter_remove_record(rec->handle);
+		bt_adapter_remove_record(nap_rec->handle);
 		return false;
 	}
 
 	err = register_nap_server();
 	if (err < 0) {
 		error("Failed to register NAP");
-		bt_adapter_remove_record(rec->handle);
+		bt_adapter_remove_record(nap_rec->handle);
 		bnep_cleanup();
 		return false;
 	}
 
-	nap_rec_id = rec->handle;
+	nap_rec_id = nap_rec->handle;
 
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_PAN, cmd_handlers,
-- 
1.9.3

