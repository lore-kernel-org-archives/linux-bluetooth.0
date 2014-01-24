Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avrcp: Use NULL for zero pointers
Date: Fri, 24 Jan 2014 13:42:23 +0200
Message-Id: <1390563743-18889-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avrcp.c | 92 +++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 197959f..dbeaf38 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -281,72 +281,72 @@ static sdp_record_t *avrcp_ct_record(void)
 		return NULL;
 
 	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(0, &root_uuid);
+	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(record, root);
 
 	/* Service Class ID List */
 	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
-	svclass_id = sdp_list_append(0, &avrct);
+	svclass_id = sdp_list_append(NULL, &avrct);
 	sdp_uuid16_create(&avrctr, AV_REMOTE_CONTROLLER_SVCLASS_ID);
 	svclass_id = sdp_list_append(svclass_id, &avrctr);
 	sdp_set_service_classes(record, svclass_id);
 
 	/* Protocol Descriptor List */
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap);
+	proto[0] = sdp_list_append(NULL, &l2cap);
 	psm[0] = sdp_data_alloc(SDP_UINT16, &lp);
 	proto[0] = sdp_list_append(proto[0], psm[0]);
-	apseq = sdp_list_append(0, proto[0]);
+	apseq = sdp_list_append(NULL, proto[0]);
 
 	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto[1] = sdp_list_append(0, &avctp);
+	proto[1] = sdp_list_append(NULL, &avctp);
 	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
 	proto[1] = sdp_list_append(proto[1], version);
 	apseq = sdp_list_append(apseq, proto[1]);
 
-	aproto = sdp_list_append(0, apseq);
+	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
 	/* Additional Protocol Descriptor List */
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto1[0] = sdp_list_append(0, &l2cap);
+	proto1[0] = sdp_list_append(NULL, &l2cap);
 	psm[1] = sdp_data_alloc(SDP_UINT16, &ap);
 	proto1[0] = sdp_list_append(proto1[0], psm[1]);
-	apseq1 = sdp_list_append(0, proto1[0]);
+	apseq1 = sdp_list_append(NULL, proto1[0]);
 
 	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto1[1] = sdp_list_append(0, &avctp);
+	proto1[1] = sdp_list_append(NULL, &avctp);
 	proto1[1] = sdp_list_append(proto1[1], version);
 	apseq1 = sdp_list_append(apseq1, proto1[1]);
 
-	aproto1 = sdp_list_append(0, apseq1);
+	aproto1 = sdp_list_append(NULL, apseq1);
 	sdp_set_add_access_protos(record, aproto1);
 
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
 	profile[0].version = avrcp_ver;
-	pfseq = sdp_list_append(0, &profile[0]);
+	pfseq = sdp_list_append(NULL, &profile[0]);
 	sdp_set_profile_descs(record, pfseq);
 
 	features = sdp_data_alloc(SDP_UINT16, &feat);
 	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
 
-	sdp_set_info_attr(record, "AVRCP CT", 0, 0);
+	sdp_set_info_attr(record, "AVRCP CT", NULL, NULL);
 
 	free(psm[0]);
 	free(psm[1]);
 	free(version);
-	sdp_list_free(proto[0], 0);
-	sdp_list_free(proto[1], 0);
-	sdp_list_free(apseq, 0);
-	sdp_list_free(proto1[0], 0);
-	sdp_list_free(proto1[1], 0);
-	sdp_list_free(aproto1, 0);
-	sdp_list_free(apseq1, 0);
-	sdp_list_free(pfseq, 0);
-	sdp_list_free(aproto, 0);
-	sdp_list_free(root, 0);
-	sdp_list_free(svclass_id, 0);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(proto1[0], NULL);
+	sdp_list_free(proto1[1], NULL);
+	sdp_list_free(aproto1, NULL);
+	sdp_list_free(apseq1, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
 
 	return record;
 }
@@ -375,67 +375,67 @@ static sdp_record_t *avrcp_tg_record(void)
 		return NULL;
 
 	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(0, &root_uuid);
+	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(record, root);
 
 	/* Service Class ID List */
 	sdp_uuid16_create(&avrtg, AV_REMOTE_TARGET_SVCLASS_ID);
-	svclass_id = sdp_list_append(0, &avrtg);
+	svclass_id = sdp_list_append(NULL, &avrtg);
 	sdp_set_service_classes(record, svclass_id);
 
 	/* Protocol Descriptor List */
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto_control[0] = sdp_list_append(0, &l2cap);
+	proto_control[0] = sdp_list_append(NULL, &l2cap);
 	psm_control = sdp_data_alloc(SDP_UINT16, &lp);
 	proto_control[0] = sdp_list_append(proto_control[0], psm_control);
-	apseq = sdp_list_append(0, proto_control[0]);
+	apseq = sdp_list_append(NULL, proto_control[0]);
 
 	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto_control[1] = sdp_list_append(0, &avctp);
+	proto_control[1] = sdp_list_append(NULL, &avctp);
 	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
 	proto_control[1] = sdp_list_append(proto_control[1], version);
 	apseq = sdp_list_append(apseq, proto_control[1]);
 
-	aproto_control = sdp_list_append(0, apseq);
+	aproto_control = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto_control);
-	proto_browsing[0] = sdp_list_append(0, &l2cap);
+	proto_browsing[0] = sdp_list_append(NULL, &l2cap);
 	psm_browsing = sdp_data_alloc(SDP_UINT16, &lp_browsing);
 	proto_browsing[0] = sdp_list_append(proto_browsing[0], psm_browsing);
-	apseq_browsing = sdp_list_append(0, proto_browsing[0]);
+	apseq_browsing = sdp_list_append(NULL, proto_browsing[0]);
 
-	proto_browsing[1] = sdp_list_append(0, &avctp);
+	proto_browsing[1] = sdp_list_append(NULL, &avctp);
 	proto_browsing[1] = sdp_list_append(proto_browsing[1], version);
 	apseq_browsing = sdp_list_append(apseq_browsing, proto_browsing[1]);
 
-	aproto_browsing = sdp_list_append(0, apseq_browsing);
+	aproto_browsing = sdp_list_append(NULL, apseq_browsing);
 	sdp_set_add_access_protos(record, aproto_browsing);
 
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
 	profile[0].version = avrcp_ver;
-	pfseq = sdp_list_append(0, &profile[0]);
+	pfseq = sdp_list_append(NULL, &profile[0]);
 	sdp_set_profile_descs(record, pfseq);
 
 	features = sdp_data_alloc(SDP_UINT16, &feat);
 	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
 
-	sdp_set_info_attr(record, "AVRCP TG", 0, 0);
+	sdp_set_info_attr(record, "AVRCP TG", NULL, NULL);
 
 	free(psm_browsing);
-	sdp_list_free(proto_browsing[0], 0);
-	sdp_list_free(proto_browsing[1], 0);
-	sdp_list_free(apseq_browsing, 0);
-	sdp_list_free(aproto_browsing, 0);
+	sdp_list_free(proto_browsing[0], NULL);
+	sdp_list_free(proto_browsing[1], NULL);
+	sdp_list_free(apseq_browsing, NULL);
+	sdp_list_free(aproto_browsing, NULL);
 
 	free(psm_control);
 	free(version);
-	sdp_list_free(proto_control[0], 0);
-	sdp_list_free(proto_control[1], 0);
-	sdp_list_free(apseq, 0);
-	sdp_list_free(aproto_control, 0);
-	sdp_list_free(pfseq, 0);
-	sdp_list_free(root, 0);
-	sdp_list_free(svclass_id, 0);
+	sdp_list_free(proto_control[0], NULL);
+	sdp_list_free(proto_control[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto_control, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
 
 	return record;
 }
-- 
1.8.3.2

