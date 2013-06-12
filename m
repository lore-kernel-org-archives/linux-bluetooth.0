Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] audio: Fix memory leak while creating SDP records
Date: Tue, 11 Jun 2013 21:06:40 -0300
Message-Id: <1370995600-24684-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix these leaks:

==674== 8 bytes in 1 blocks are definitely lost in loss record 45 of 201
==674==    at 0x402BE68: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==674==    by 0x80DF653: sdp_list_append (sdp.c:1742)
==674==    by 0x8063974: avrcp_ct_record (avrcp.c:297)
==674==    by 0x8068A6D: avrcp_remote_register (avrcp.c:3149)
==674==    by 0x805F31C: avrcp_remote_server_probe (manager.c:320)
==674==    by 0x80BCB4E: probe_profile (adapter.c:2629)
==674==    by 0x80C5880: btd_profile_foreach (profile.c:639)
==674==    by 0x80C3FD4: adapter_register (adapter.c:5619)
==674==    by 0x80C4A01: read_info_complete (adapter.c:5894)
==674==    by 0x80D489A: request_complete (mgmt.c:221)
==674==    by 0x80D4BA8: received_data (mgmt.c:319)
==674==    by 0x40BF17D: ??? (in
/lib/i386-linux-gnu/libglib-2.0.so.0.3200.3)
==674==
==674== 32 bytes in 1 blocks are definitely lost in loss record 127 of
201
==674==    at 0x402BE68: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==674==    by 0x80DCE49: sdp_data_alloc_with_length (sdp.c:360)
==674==    by 0x80DD33F: sdp_data_alloc (sdp.c:497)
==674==    by 0x806379D: avrcp_ct_record (avrcp.c:272)
==674==    by 0x8068A6D: avrcp_remote_register (avrcp.c:3149)
==674==    by 0x805F31C: avrcp_remote_server_probe (manager.c:320)
==674==    by 0x80BCB4E: probe_profile (adapter.c:2629)
==674==    by 0x80C5880: btd_profile_foreach (profile.c:639)
==674==    by 0x80C3FD4: adapter_register (adapter.c:5619)
==674==    by 0x80C4A01: read_info_complete (adapter.c:5894)
==674==    by 0x80D489A: request_complete (mgmt.c:221)
==674==    by 0x80D4BA8: received_data (mgmt.c:319)
---
 profiles/audio/avrcp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 715ab8f..e6d0e72 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -245,7 +245,7 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_profile_desc_t profile[1];
 	sdp_list_t *aproto, *aproto1, *proto[2], *proto1[2];
 	sdp_record_t *record;
-	sdp_data_t *psm, *version, *features;
+	sdp_data_t *psm[2], *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM, ap = AVCTP_BROWSING_PSM;
 	uint16_t avrcp_ver = 0x0105, avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
@@ -269,8 +269,8 @@ static sdp_record_t *avrcp_ct_record(void)
 	/* Protocol Descriptor List */
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
 	proto[0] = sdp_list_append(0, &l2cap);
-	psm = sdp_data_alloc(SDP_UINT16, &lp);
-	proto[0] = sdp_list_append(proto[0], psm);
+	psm[0] = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm[0]);
 	apseq = sdp_list_append(0, proto[0]);
 
 	sdp_uuid16_create(&avctp, AVCTP_UUID);
@@ -285,8 +285,8 @@ static sdp_record_t *avrcp_ct_record(void)
 	/* Additional Protocol Descriptor List */
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
 	proto1[0] = sdp_list_append(0, &l2cap);
-	psm = sdp_data_alloc(SDP_UINT16, &ap);
-	proto1[0] = sdp_list_append(proto1[0], psm);
+	psm[1] = sdp_data_alloc(SDP_UINT16, &ap);
+	proto1[0] = sdp_list_append(proto1[0], psm[1]);
 	apseq1 = sdp_list_append(0, proto1[0]);
 
 	sdp_uuid16_create(&avctp, AVCTP_UUID);
@@ -308,13 +308,15 @@ static sdp_record_t *avrcp_ct_record(void)
 
 	sdp_set_info_attr(record, "AVRCP CT", 0, 0);
 
-	free(psm);
+	free(psm[0]);
+	free(psm[1]);
 	free(version);
 	sdp_list_free(proto[0], 0);
 	sdp_list_free(proto[1], 0);
 	sdp_list_free(apseq, 0);
 	sdp_list_free(proto1[0], 0);
 	sdp_list_free(proto1[1], 0);
+	sdp_list_free(aproto1, 0);
 	sdp_list_free(apseq1, 0);
 	sdp_list_free(pfseq, 0);
 	sdp_list_free(aproto, 0);
-- 
1.8.1.2

