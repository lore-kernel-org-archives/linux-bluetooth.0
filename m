Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/a2dp: Use NULL for zero pointer
Date: Mon, 18 Nov 2013 12:49:35 +0200
Message-Id: <1384771775-18659-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/a2dp.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 936c28e..4725e9e 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -280,31 +280,31 @@ static sdp_record_t *a2dp_record(void)
 		return NULL;
 
 	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(0, &root_uuid);
+	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(record, root);
 
 	sdp_uuid16_create(&a2dp_uuid, AUDIO_SOURCE_SVCLASS_ID);
-	svclass_id = sdp_list_append(0, &a2dp_uuid);
+	svclass_id = sdp_list_append(NULL, &a2dp_uuid);
 	sdp_set_service_classes(record, svclass_id);
 
 	sdp_uuid16_create(&profile[0].uuid, ADVANCED_AUDIO_PROFILE_ID);
 	profile[0].version = a2dp_ver;
-	pfseq = sdp_list_append(0, &profile[0]);
+	pfseq = sdp_list_append(NULL, &profile[0]);
 	sdp_set_profile_descs(record, pfseq);
 
 	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
 	psm = sdp_data_alloc(SDP_UINT16, &lp);
 	proto[0] = sdp_list_append(proto[0], psm);
-	apseq = sdp_list_append(0, proto[0]);
+	apseq = sdp_list_append(NULL, proto[0]);
 
 	sdp_uuid16_create(&avdtp_uuid, AVDTP_UUID);
-	proto[1] = sdp_list_append(0, &avdtp_uuid);
+	proto[1] = sdp_list_append(NULL, &avdtp_uuid);
 	version = sdp_data_alloc(SDP_UINT16, &avdtp_ver);
 	proto[1] = sdp_list_append(proto[1], version);
 	apseq = sdp_list_append(apseq, proto[1]);
 
-	aproto = sdp_list_append(0, apseq);
+	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
 	features = sdp_data_alloc(SDP_UINT16, &feat);
@@ -314,13 +314,13 @@ static sdp_record_t *a2dp_record(void)
 
 	free(psm);
 	free(version);
-	sdp_list_free(proto[0], 0);
-	sdp_list_free(proto[1], 0);
-	sdp_list_free(apseq, 0);
-	sdp_list_free(pfseq, 0);
-	sdp_list_free(aproto, 0);
-	sdp_list_free(root, 0);
-	sdp_list_free(svclass_id, 0);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
 
 	return record;
 }
-- 
1.7.10.4

