Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] tools/sdptool: Add support for MAP service
Date: Fri, 21 Nov 2014 14:19:24 +0530
Message-id: <1416559765-26427-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for MAP service in local SDP server.

The MAP MAS record captured in local SDP server:

Service Name: OBEX Message Access Server
Service RecHandle: 0x1000e
Service Class ID List:
  "Message Access - MAS" (0x1132)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 17
  "OBEX" (0x0008)
Profile Descriptor List:
  "Message Access" (0x1134)
    Version: 0x0100

Now we are able to do sdptool search/add/del/get
for MAP service.
---
 tools/sdptool.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index f3aebd2..17561b1 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1916,6 +1916,86 @@ end:
 	return ret;
 }
 
+static int add_map(sdp_session_t *session, svc_info_t *si)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, map_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[3];
+	sdp_record_t record;
+	uint8_t chan = si->channel ? si->channel : 17;
+	sdp_data_t *channel;
+	uint8_t msg_formats[] = {0x0f};
+	uint32_t supp_features[] = {0x0000007f};
+	uint8_t dtd_msg = SDP_UINT8, dtd_sf = SDP_UINT32;
+	sdp_data_t *smlist;
+	sdp_data_t *sflist;
+	int ret = 0;
+
+	memset(&record, 0, sizeof(sdp_record_t));
+	record.handle = si->handle;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(&record, root);
+
+	sdp_uuid16_create(&map_uuid, MAP_MSE_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &map_uuid);
+	sdp_set_service_classes(&record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, MAP_PROFILE_ID);
+	profile[0].version = 0x0100;
+	pfseq = sdp_list_append(0, profile);
+	sdp_set_profile_descs(&record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(0, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &chan);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
+	proto[2] = sdp_list_append(0, &obex_uuid);
+	apseq = sdp_list_append(apseq, proto[2]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(&record, aproto);
+
+	smlist = sdp_data_alloc(dtd_msg, msg_formats);
+	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_MESSAGE_TYPES, smlist);
+
+	sflist = sdp_data_alloc(dtd_sf, supp_features);
+	sdp_attr_add(&record, SDP_ATTR_MAP_SUPPORTED_FEATURES, sflist);
+
+	sdp_set_info_attr(&record, "OBEX Message Access Server", 0, 0);
+
+	if (sdp_device_record_register(session, &interface, &record,
+			SDP_RECORD_PERSIST) < 0) {
+		printf("Service Record registration failed\n");
+		ret = -1;
+		goto end;
+	}
+
+	printf("MAP service registered\n");
+
+end:
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(proto[2], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return ret;
+}
+
 static int add_ftp(sdp_session_t *session, svc_info_t *si)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -3547,6 +3627,7 @@ struct {
 	{ "SAP",	SAP_SVCLASS_ID,			add_simaccess	},
 	{ "PBAP",	PBAP_SVCLASS_ID,		add_pbap,	},
 
+	{ "MAP",	MAP_SVCLASS_ID,			add_map,	},
 	{ "NAP",	NAP_SVCLASS_ID,			add_nap		},
 	{ "GN",		GN_SVCLASS_ID,			add_gn		},
 	{ "PANU",	PANU_SVCLASS_ID,		add_panu	},
-- 
1.9.1

