Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 10/14] Create UUID128 on host order on sdptool
Date: Fri, 18 Feb 2011 20:29:29 -0200
Message-Id: <1298068173-16518-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Converts from network to host order UUID128 values before to call
sdp_uuid128_create function. Internally, SDP library now stores the
UUID128 values on host order.
---
 tools/sdptool.c |   36 +++++++++++++++++++++++++++---------
 1 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index ae56ebf..55e5dab 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3022,6 +3022,7 @@ static int add_sr1(sdp_session_t *session, svc_info_t *si)
 	sdp_record_t record;
 	sdp_list_t *root, *svclass;
 	uuid_t root_uuid, svclass_uuid;
+	uint128_t h128;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3030,7 +3031,8 @@ static int add_sr1(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, SR1_UUID);
+	ntoh128(SR1_UUID, &h128);
+	sdp_uuid128_create(&svclass_uuid, &h128);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3061,6 +3063,7 @@ static int add_syncml(sdp_session_t *session, svc_info_t *si)
 	sdp_list_t *root, *svclass, *proto;
 	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
 	uint8_t channel = si->channel ? si->channel: 15;
+	uint128_t h128;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3069,7 +3072,8 @@ static int add_syncml(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, SYNCMLC_UUID);
+	ntoh128(SYNCMLC_UUID, &h128);
+	sdp_uuid128_create(&svclass_uuid, &h128);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3107,6 +3111,7 @@ static int add_activesync(sdp_session_t *session, svc_info_t *si)
 	sdp_list_t *root, *svclass, *proto;
 	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
 	uint8_t channel = si->channel ? si->channel: 21;
+	uint128_t h128;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3124,7 +3129,8 @@ static int add_activesync(sdp_session_t *session, svc_info_t *si)
 
 	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
 
-	sdp_uuid128_create(&svclass_uuid, ASYNC_UUID);
+	ntoh128(ASYNC_UUID, &h128);
+	sdp_uuid128_create(&svclass_uuid, &h128);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3150,6 +3156,7 @@ static int add_hotsync(sdp_session_t *session, svc_info_t *si)
 	sdp_list_t *root, *svclass, *proto;
 	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
 	uint8_t channel = si->channel ? si->channel: 22;
+	uint128_t h128;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3167,7 +3174,8 @@ static int add_hotsync(sdp_session_t *session, svc_info_t *si)
 
 	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
 
-	sdp_uuid128_create(&svclass_uuid, HOTSYNC_UUID);
+	ntoh128(HOTSYNC_UUID, &h128);
+	sdp_uuid128_create(&svclass_uuid, &h128);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3192,6 +3200,7 @@ static int add_palmos(sdp_session_t *session, svc_info_t *si)
 	sdp_record_t record;
 	sdp_list_t *root, *svclass;
 	uuid_t root_uuid, svclass_uuid;
+	uint128_t h128;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3200,7 +3209,8 @@ static int add_palmos(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, PALMOS_UUID);
+	ntoh128(PALMOS_UUID, &h128);
+	sdp_uuid128_create(&svclass_uuid, &h128);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3225,6 +3235,7 @@ static int add_nokiaid(sdp_session_t *session, svc_info_t *si)
 	uuid_t root_uuid, svclass_uuid;
 	uint16_t verid = 0x005f;
 	sdp_data_t *version = sdp_data_alloc(SDP_UINT16, &verid);
+	uint128_t h128;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3233,7 +3244,8 @@ static int add_nokiaid(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, NOKID_UUID);
+	ntoh128(NOKID_UUID, &h128);
+	sdp_uuid128_create(&svclass_uuid, &h128);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3260,6 +3272,7 @@ static int add_pcsuite(sdp_session_t *session, svc_info_t *si)
 	sdp_list_t *root, *svclass, *proto;
 	uuid_t root_uuid, svclass_uuid, l2cap_uuid, rfcomm_uuid;
 	uint8_t channel = si->channel ? si->channel: 14;
+	uint128_t h128;
 
 	memset(&record, 0, sizeof(record));
 	record.handle = si->handle;
@@ -3277,7 +3290,8 @@ static int add_pcsuite(sdp_session_t *session, svc_info_t *si)
 
 	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
 
-	sdp_uuid128_create(&svclass_uuid, PCSUITE_UUID);
+	ntoh128(PCSUITE_UUID, &h128);
+	sdp_uuid128_create(&svclass_uuid, &h128);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -4004,8 +4018,12 @@ static int cmd_search(int argc, char **argv)
 			uint16_t class16 = class & 0xffff;
 			sdp_uuid16_create(&context.group, class16);
 		}
-	} else
-		sdp_uuid128_create(&context.group, &n128);
+	} else {
+		uint128_t h128;
+
+		ntoh128(n128, &h128);
+		sdp_uuid128_create(&context.group, &h128);
+	}
 
 	if (has_addr)
 		return do_search(&bdaddr, &context);
-- 
1.7.4.1

