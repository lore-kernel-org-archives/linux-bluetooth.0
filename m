Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 26 Mar 2012 15:30:53 +0200
Subject: RFC:[PATCH Bluez 1/3] Added TG Record for AVRCP 1.4 and Browsing
 Support
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B21A7973F28@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I would like to propose patches for Browsing Channel Creation for AVRCP 1.4 - TG Role.
This patch adds TG Record for AVRCP 1.4 support and Browsing Support.

>From 241e84b7fec2d73c7ed3133471d7cf40f92b94d3 Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Mon, 26 Mar 2012 12:17:12 +0530
Subject: [PATCH Bluez 1/3] Added TG Record for AVRCP 1.4 and Browsing Support

---
 audio/avctp.h |    1 +
 audio/avrcp.c |   23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 audio/avrcp.c

diff --git a/audio/avctp.h b/audio/avctp.h
index 9727485..fb6be2f 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -23,6 +23,7 @@
  */
 
 #define AVCTP_PSM 23
+#define AVCTP_BROWSING_PSM	27
 
 #define AVC_MTU 512
 #define AVC_HEADER_LENGTH 3
diff --git a/audio/avrcp.c b/audio/avrcp.c
old mode 100644
new mode 100755
index 8eba046..4219572
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -232,14 +232,17 @@ static sdp_record_t *avrcp_ct_record(void)
 
 static sdp_record_t *avrcp_tg_record(void)
 {
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root, *apseq_1_4;
 	uuid_t root_uuid, l2cap, avctp, avrtg;
 	sdp_profile_desc_t profile[1];
 	sdp_list_t *aproto, *proto[2];
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_PSM;
-	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
+	uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103, feat = 0x000f;
+	sdp_list_t *aproto_1_4, *proto_1_4[2] = {0};
+	sdp_data_t *psm_brow;
+	uint16_t browsing_lp = AVCTP_BROWSING_PSM;
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -270,6 +273,22 @@ static sdp_record_t *avrcp_tg_record(void)
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_access_protos(record, aproto);
 
+	proto_1_4[0] = sdp_list_append(0, &l2cap);
+	psm_brow = sdp_data_alloc(SDP_UINT16, &browsing_lp);
+	proto_1_4[0] = sdp_list_append(proto_1_4[0], psm_brow);
+	apseq_1_4 = sdp_list_append(0, proto_1_4[0]);
+
+	proto_1_4[1] = sdp_list_append(0, &avctp);
+	proto_1_4[1] = sdp_list_append(proto_1_4[1], version);
+	apseq_1_4 = sdp_list_append(apseq_1_4, proto_1_4[1]);
+
+	aproto_1_4 = sdp_list_append(0, apseq_1_4);
+	sdp_set_add_access_protos(record, aproto_1_4);
+
+	free(psm_brow);
+	sdp_list_free(proto_1_4[0], 0);
+	sdp_list_free(proto_1_4[1], 0);
+	sdp_list_free(aproto_1_4, 0);
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
 	profile[0].version = avrcp_ver;
-- 
1.7.5.4

-Vani
