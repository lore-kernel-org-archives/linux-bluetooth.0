Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/15] AVRCP: Add additional protocol discriptor list for Browsing channel
Date: Mon, 10 Jun 2013 13:37:00 +0300
Message-Id: <1370860630-30359-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is documented in the spec and is checked by PTS when testing the
browsing channel.
---
 profiles/audio/avrcp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 092639f..e7ce9b5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -240,13 +240,13 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event);
 
 static sdp_record_t *avrcp_ct_record(void)
 {
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	sdp_list_t *svclass_id, *pfseq, *apseq, *apseq1, *root;
 	uuid_t root_uuid, l2cap, avctp, avrct;
 	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *proto[2];
+	sdp_list_t *aproto, *aproto1, *proto[2], *proto1[2];
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
-	uint16_t lp = AVCTP_CONTROL_PSM;
+	uint16_t lp = AVCTP_CONTROL_PSM, ap = AVCTP_BROWSING_PSM;
 	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
@@ -282,6 +282,21 @@ static sdp_record_t *avrcp_ct_record(void)
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_access_protos(record, aproto);
 
+	/* Additional Protocol Descriptor List */
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto1[0] = sdp_list_append(0, &l2cap);
+	psm = sdp_data_alloc(SDP_UINT16, &ap);
+	proto1[0] = sdp_list_append(proto1[0], psm);
+	apseq1 = sdp_list_append(0, proto1[0]);
+
+	sdp_uuid16_create(&avctp, AVCTP_UUID);
+	proto1[1] = sdp_list_append(0, &avctp);
+	proto1[1] = sdp_list_append(proto1[1], version);
+	apseq1 = sdp_list_append(apseq1, proto1[1]);
+
+	aproto1 = sdp_list_append(0, apseq1);
+	sdp_set_add_access_protos(record, aproto1);
+
 	/* Bluetooth Profile Descriptor List */
 	sdp_uuid16_create(&profile[0].uuid, AV_REMOTE_PROFILE_ID);
 	profile[0].version = avrcp_ver;
@@ -298,6 +313,9 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_list_free(proto[0], 0);
 	sdp_list_free(proto[1], 0);
 	sdp_list_free(apseq, 0);
+	sdp_list_free(proto1[0], 0);
+	sdp_list_free(proto1[1], 0);
+	sdp_list_free(apseq1, 0);
 	sdp_list_free(pfseq, 0);
 	sdp_list_free(aproto, 0);
 	sdp_list_free(root, 0);
-- 
1.8.1.4

