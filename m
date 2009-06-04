Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 1/6] Create A2DP Sink SDP record.
Date: Thu,  4 Jun 2009 16:09:51 -0300
Message-Id: <1244142596-8076-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 2c4d047..1ef23c4 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -995,7 +995,62 @@ static sdp_record_t *a2dp_source_record()
 
 static sdp_record_t *a2dp_sink_record()
 {
-	return NULL;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap, avdtp, a2snk;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *psm, *version, *features;
+	uint16_t lp = AVDTP_UUID, ver = 0x0100, feat = 0x000F;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&a2snk, AUDIO_SINK_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &a2snk);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, ADVANCED_AUDIO_PROFILE_ID);
+	profile[0].version = 0x0100;
+	pfseq = sdp_list_append(0, &profile[0]);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&avdtp, AVDTP_UUID);
+	proto[1] = sdp_list_append(0, &avdtp);
+	version = sdp_data_alloc(SDP_UINT16, &ver);
+	proto[1] = sdp_list_append(proto[1], version);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	features = sdp_data_alloc(SDP_UINT16, &feat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	sdp_set_info_attr(record, "Audio Sink", 0, 0);
+
+	free(psm);
+	free(version);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
 }
 
 static struct a2dp_sep *a2dp_add_sep(struct a2dp_server *server, uint8_t type,
-- 
1.6.0.4

