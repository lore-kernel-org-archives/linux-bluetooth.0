Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 09/14] Replace UUID128 values from char array to uint128_t on sdptool
Date: Fri, 18 Feb 2011 20:29:28 -0200
Message-Id: <1298068173-16518-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch doesn't change the UUID128 endianness on sdptool, it is only
the initial patch to convert from network to host order on sdptool.
---
 tools/sdptool.c |  111 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 62 insertions(+), 49 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 341e258..ae56ebf 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3013,8 +3013,9 @@ static int add_udi_te(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char sr1_uuid[] = {	0xbc, 0x19, 0x9c, 0x24, 0x95, 0x8b, 0x4c, 0xc0,
-					0xa2, 0xcb, 0xfd, 0x8a, 0x30, 0xbf, 0x32, 0x06 };
+#define SR1_UUID (&(uint128_t) {{ \
+			0xbc, 0x19, 0x9c, 0x24, 0x95, 0x8b, 0x4c, 0xc0, \
+			0xa2, 0xcb, 0xfd, 0x8a, 0x30, 0xbf, 0x32, 0x06 }})
 
 static int add_sr1(sdp_session_t *session, svc_info_t *si)
 {
@@ -3029,7 +3030,7 @@ static int add_sr1(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, (void *) sr1_uuid);
+	sdp_uuid128_create(&svclass_uuid, SR1_UUID);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3045,11 +3046,14 @@ static int add_sr1(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char syncmls_uuid[] = {	0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x10, 0x00,
-					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x02 };
+#define SYNCMLS_UUID (&(uint128_t) {{ \
+			0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x10, 0x00, \
+			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x02 }})
 
-static unsigned char syncmlc_uuid[] = {	0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x10, 0x00,
-					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x02 };
+
+#define SYNCMLC_UUID (&(uint128_t) {{ \
+			0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x10, 0x00, \
+			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x02 }})
 
 static int add_syncml(sdp_session_t *session, svc_info_t *si)
 {
@@ -3065,7 +3069,7 @@ static int add_syncml(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, (void *) syncmlc_uuid);
+	sdp_uuid128_create(&svclass_uuid, SYNCMLC_UUID);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3093,8 +3097,9 @@ static int add_syncml(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char async_uuid[] = {	0x03, 0x50, 0x27, 0x8F, 0x3D, 0xCA, 0x4E, 0x62,
-					0x83, 0x1D, 0xA4, 0x11, 0x65, 0xFF, 0x90, 0x6C };
+#define ASYNC_UUID (&(uint128_t) {{ \
+			0x03, 0x50, 0x27, 0x8F, 0x3D, 0xCA, 0x4E, 0x62, \
+			0x83, 0x1D, 0xA4, 0x11, 0x65, 0xFF, 0x90, 0x6C }})
 
 static int add_activesync(sdp_session_t *session, svc_info_t *si)
 {
@@ -3119,7 +3124,7 @@ static int add_activesync(sdp_session_t *session, svc_info_t *si)
 
 	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
 
-	sdp_uuid128_create(&svclass_uuid, (void *) async_uuid);
+	sdp_uuid128_create(&svclass_uuid, ASYNC_UUID);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3135,8 +3140,9 @@ static int add_activesync(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char hotsync_uuid[] = {	0xD8, 0x0C, 0xF9, 0xEA, 0x13, 0x4C, 0x11, 0xD5,
-					0x83, 0xCE, 0x00, 0x30, 0x65, 0x7C, 0x54, 0x3C };
+#define HOTSYNC_UUID (&(uint128_t) {{ \
+			0xD8, 0x0C, 0xF9, 0xEA, 0x13, 0x4C, 0x11, 0xD5, \
+			0x83, 0xCE, 0x00, 0x30, 0x65, 0x7C, 0x54, 0x3C }})
 
 static int add_hotsync(sdp_session_t *session, svc_info_t *si)
 {
@@ -3161,7 +3167,7 @@ static int add_hotsync(sdp_session_t *session, svc_info_t *si)
 
 	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
 
-	sdp_uuid128_create(&svclass_uuid, (void *) hotsync_uuid);
+	sdp_uuid128_create(&svclass_uuid, HOTSYNC_UUID);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3177,8 +3183,9 @@ static int add_hotsync(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char palmos_uuid[] = {	0xF5, 0xBE, 0xB6, 0x51, 0x41, 0x71, 0x40, 0x51,
-					0xAC, 0xF5, 0x6C, 0xA7, 0x20, 0x22, 0x42, 0xF0 };
+#define PALMOS_UUID (&(uint128_t) {{ \
+			0xF5, 0xBE, 0xB6, 0x51, 0x41, 0x71, 0x40, 0x51, \
+			0xAC, 0xF5, 0x6C, 0xA7, 0x20, 0x22, 0x42, 0xF0 }})
 
 static int add_palmos(sdp_session_t *session, svc_info_t *si)
 {
@@ -3193,7 +3200,7 @@ static int add_palmos(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, (void *) palmos_uuid);
+	sdp_uuid128_create(&svclass_uuid, PALMOS_UUID);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3207,8 +3214,9 @@ static int add_palmos(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char nokid_uuid[] = {	0x00, 0x00, 0x55, 0x55, 0x00, 0x00, 0x10, 0x00,
-					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
+#define NOKID_UUID (&(uint128_t) {{ \
+			0x00, 0x00, 0x55, 0x55, 0x00, 0x00, 0x10, 0x00, \
+			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 }})
 
 static int add_nokiaid(sdp_session_t *session, svc_info_t *si)
 {
@@ -3225,7 +3233,7 @@ static int add_nokiaid(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_uuid128_create(&svclass_uuid, (void *) nokid_uuid);
+	sdp_uuid128_create(&svclass_uuid, NOKID_UUID);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3242,8 +3250,9 @@ static int add_nokiaid(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char pcsuite_uuid[] = {	0x00, 0x00, 0x50, 0x02, 0x00, 0x00, 0x10, 0x00,
-					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
+#define PCSUITE_UUID (&(uint128_t) {{ \
+			0x00, 0x00, 0x50, 0x02, 0x00, 0x00, 0x10, 0x00, \
+			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 }})
 
 static int add_pcsuite(sdp_session_t *session, svc_info_t *si)
 {
@@ -3268,7 +3277,7 @@ static int add_pcsuite(sdp_session_t *session, svc_info_t *si)
 
 	sdp_set_access_protos(&record, sdp_list_append(NULL, proto));
 
-	sdp_uuid128_create(&svclass_uuid, (void *) pcsuite_uuid);
+	sdp_uuid128_create(&svclass_uuid, PCSUITE_UUID);
 	svclass = sdp_list_append(NULL, &svclass_uuid);
 	sdp_set_service_classes(&record, svclass);
 
@@ -3284,17 +3293,21 @@ static int add_pcsuite(sdp_session_t *session, svc_info_t *si)
 	return 0;
 }
 
-static unsigned char nftp_uuid[] = {	0x00, 0x00, 0x50, 0x05, 0x00, 0x00, 0x10, 0x00,
-					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
+#define NFTP_UUID (&(uint128_t) {{ \
+			0x00, 0x00, 0x50, 0x05, 0x00, 0x00, 0x10, 0x00, \
+			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 }})
 
-static unsigned char nsyncml_uuid[] = {	0x00, 0x00, 0x56, 0x01, 0x00, 0x00, 0x10, 0x00,
-					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
+#define NSYNCML_UUID (&(uint128_t) {{ \
+			0x00, 0x00, 0x56, 0x01, 0x00, 0x00, 0x10, 0x00, \
+			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 }})
 
-static unsigned char ngage_uuid[] = {	0x00, 0x00, 0x13, 0x01, 0x00, 0x00, 0x10, 0x00,
-					0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 };
+#define NGAGE_UUID (&(uint128_t) {{ \
+			0x00, 0x00, 0x13, 0x01, 0x00, 0x00, 0x10, 0x00, \
+			0x80, 0x00, 0x00, 0x02, 0xEE, 0x00, 0x00, 0x01 }})
 
-static unsigned char apple_uuid[] = {	0xf0, 0x72, 0x2e, 0x20, 0x0f, 0x8b, 0x4e, 0x90,
-					0x8c, 0xc2, 0x1b, 0x46, 0xf5, 0xf2, 0xef, 0xe2 };
+#define APPLE_UUID (&(uint128_t) {{ \
+			0xf0, 0x72, 0x2e, 0x20, 0x0f, 0x8b, 0x4e, 0x90, \
+			0x8c, 0xc2, 0x1b, 0x46, 0xf5, 0xf2, 0xef, 0xe2 }})
 
 static int add_apple(sdp_session_t *session, svc_info_t *si)
 {
@@ -3312,7 +3325,7 @@ static int add_apple(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(NULL, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	sdp_attr_add_new(&record, 0x0780, SDP_UUID128, (void *) apple_uuid);
+	sdp_attr_add_new(&record, 0x0780, SDP_UUID128, (void *) APPLE_UUID);
 	sdp_attr_add_new(&record, 0x0781, SDP_TEXT_STR8, (void *) "Macmini");
 	sdp_attr_add_new(&record, 0x0782, SDP_TEXT_STR8, (void *) "PowerMac10,1");
 	sdp_attr_add_new(&record, 0x0783, SDP_UINT32, (void *) &attr783);
@@ -3497,7 +3510,7 @@ struct {
 	char		*name;
 	uint32_t	class;
 	int		(*add)(sdp_session_t *sess, svc_info_t *si);
-	unsigned char *uuid;
+	const uint128_t	*uuid128;
 } service[] = {
 	{ "DID",	PNP_INFO_SVCLASS_ID,		NULL,		},
 
@@ -3537,18 +3550,18 @@ struct {
 
 	{ "SEMCHLA",	0x8e771301,			add_semchla	},
 
-	{ "SR1",	0,				add_sr1,	sr1_uuid	},
-	{ "SYNCML",	0,				add_syncml,	syncmlc_uuid	},
-	{ "SYNCMLSERV",	0,				NULL,		syncmls_uuid	},
-	{ "ACTIVESYNC",	0,				add_activesync,	async_uuid	},
-	{ "HOTSYNC",	0,				add_hotsync,	hotsync_uuid	},
-	{ "PALMOS",	0,				add_palmos,	palmos_uuid	},
-	{ "NOKID",	0,				add_nokiaid,	nokid_uuid	},
-	{ "PCSUITE",	0,				add_pcsuite,	pcsuite_uuid	},
-	{ "NFTP",	0,				NULL,		nftp_uuid	},
-	{ "NSYNCML",	0,				NULL,		nsyncml_uuid	},
-	{ "NGAGE",	0,				NULL,		ngage_uuid	},
-	{ "APPLE",	0,				add_apple,	apple_uuid	},
+	{ "SR1",	0,				add_sr1,	SR1_UUID	},
+	{ "SYNCML",	0,				add_syncml,	SYNCMLC_UUID	},
+	{ "SYNCMLSERV",	0,				NULL,		SYNCMLS_UUID	},
+	{ "ACTIVESYNC",	0,				add_activesync,	ASYNC_UUID	},
+	{ "HOTSYNC",	0,				add_hotsync,	HOTSYNC_UUID	},
+	{ "PALMOS",	0,				add_palmos,	PALMOS_UUID	},
+	{ "NOKID",	0,				add_nokiaid,	NOKID_UUID	},
+	{ "PCSUITE",	0,				add_pcsuite,	PCSUITE_UUID	},
+	{ "NFTP",	0,				NULL,		NFTP_UUID	},
+	{ "NSYNCML",	0,				NULL,		NSYNCML_UUID	},
+	{ "NGAGE",	0,				NULL,		NGAGE_UUID	},
+	{ "APPLE",	0,				add_apple,	APPLE_UUID	},
 
 	{ "ISYNC",	APPLE_AGENT_SVCLASS_ID,		add_isync,	},
 	{ "GATT",	GENERIC_ATTRIB_SVCLASS_ID,	add_gatt,	},
@@ -3921,7 +3934,7 @@ static const char *search_help =
 static int cmd_search(int argc, char **argv)
 {
 	struct search_context context;
-	unsigned char *uuid = NULL;
+	const uint128_t *n128 = NULL;
 	uint32_t class = 0;
 	bdaddr_t bdaddr;
 	int has_addr = 0;
@@ -3975,10 +3988,10 @@ static int cmd_search(int argc, char **argv)
 		for (i = 0; service[i].name; i++)
 			if (strcasecmp(context.svc, service[i].name) == 0) {
 				class = service[i].class;
-				uuid = service[i].uuid;
+				n128 = service[i].uuid128;
 				break;
 			}
-		if (!class && !uuid) {
+		if (!class && !n128) {
 			printf("Unknown service %s\n", context.svc);
 			return -1;
 		}
@@ -3992,7 +4005,7 @@ static int cmd_search(int argc, char **argv)
 			sdp_uuid16_create(&context.group, class16);
 		}
 	} else
-		sdp_uuid128_create(&context.group, uuid);
+		sdp_uuid128_create(&context.group, &n128);
 
 	if (has_addr)
 		return do_search(&bdaddr, &context);
-- 
1.7.4.1

