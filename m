Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jiafa Liu <pbx376@motorola.com>
Subject: [PATCH] Add support for registration of a PBAP service using sdptool
Date: Thu, 25 Jun 2009 17:28:04 -0700
Message-Id: <1245976084-8936-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jiafa Liu <pbx376@motorola.com>

---
 tools/sdptool.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 4707f4c..5fddb82 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1820,6 +1820,85 @@ end:
 	return ret;
 }
 
+static int add_pbap(sdp_session_t *session, svc_info_t *si)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, pbap_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[3];
+	sdp_record_t record;
+	uint8_t chan = si->channel ? si->channel : 19;
+	sdp_data_t *channel;
+	uint8_t formats[] = {0x03};
+	void *dtds[sizeof(formats)], *values[sizeof(formats)];
+	int i;
+	uint8_t dtd = SDP_UINT8;
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
+	sdp_uuid16_create(&pbap_uuid, PBAP_PSE_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &pbap_uuid);
+	sdp_set_service_classes(&record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, PBAP_PROFILE_ID);
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
+
+	for (i = 0; i < sizeof(formats); i++) {
+		dtds[i] = &dtd;
+		values[i] = &formats[i];
+	}
+	sflist = sdp_seq_alloc(dtds, values, sizeof(formats));
+	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_REPOSITORIES, sflist);
+
+	sdp_set_info_attr(&record, "OBEX Phonebook Access Server", 0, 0);
+
+	if (sdp_device_record_register(session, &interface, &record,
+			SDP_RECORD_PERSIST) < 0) {
+		printf("Service Record registration failed\n");
+		ret = -1;
+		goto end;
+	}
+
+	printf("PBAP service registered\n");
+
+end:
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(proto[2], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(aproto, 0);
+
+	return ret;
+}
+
 static int add_ftp(sdp_session_t *session, svc_info_t *si)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -3376,7 +3455,7 @@ struct {
 	{ "HF",		HANDSFREE_SVCLASS_ID,		add_handsfree	},
 	{ "HFAG",	HANDSFREE_AGW_SVCLASS_ID,	add_handsfree_ag},
 	{ "SAP",	SAP_SVCLASS_ID,			add_simaccess	},
-	{ "PBAP",	PBAP_SVCLASS_ID,		NULL,		},
+	{ "PBAP",	PBAP_SVCLASS_ID,		add_pbap,	},
 
 	{ "NAP",	NAP_SVCLASS_ID,			add_nap		},
 	{ "GN",		GN_SVCLASS_ID,			add_gn		},
-- 
1.6.3.1

