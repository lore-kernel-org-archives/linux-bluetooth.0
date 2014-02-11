Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 04/11] android/socket: Simplify SDP records handling
Date: Tue, 11 Feb 2014 17:58:14 +0100
Message-ID: <1392137901-3403-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392137901-3403-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Records are now created using helper function which creates SDP record
with common contents like service class, name and protocols. Other
attributes are then added by custom functions.
---
 android/socket.c | 281 ++++++++++++++++---------------------------------------
 1 file changed, 80 insertions(+), 201 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 5045911..32de91a 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -180,18 +180,14 @@ static struct rfcomm_sock *create_rfsock(int bt_sock, int *hal_sock)
 	return rfsock;
 }
 
-static sdp_record_t *create_opp_record(uint8_t chan, const char *svc_name)
+static sdp_record_t *create_rfcomm_record(uint8_t chan, uuid_t *uuid,
+						const char *svc_name,
+						bool has_obex)
 {
-	const char *service_name = "OBEX Object Push";
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, opush_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
-	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *proto[3];
-	uint8_t formats[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0xff };
-	void *dtds[sizeof(formats)], *values[sizeof(formats)];
-	unsigned int i;
-	uint8_t dtd = SDP_UINT8;
-	sdp_data_t *sflist;
+	sdp_list_t *svclass_id;
+	sdp_list_t *seq, *proto_seq, *pbg_seq;
+	sdp_list_t *proto[2];
+	uuid_t l2cap_uuid, rfcomm_uuid, obex_uuid, pbg_uuid;
 	sdp_data_t *channel;
 	sdp_record_t *record;
 
@@ -201,267 +197,150 @@ static sdp_record_t *create_opp_record(uint8_t chan, const char *svc_name)
 
 	record->handle =  sdp_next_handle();
 
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&opush_uuid, OBEX_OBJPUSH_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &opush_uuid);
+	svclass_id = sdp_list_append(NULL, uuid);
 	sdp_set_service_classes(record, svclass_id);
 
-	sdp_uuid16_create(&profile[0].uuid, OBEX_OBJPUSH_PROFILE_ID);
-	profile[0].version = 0x0100;
-	pfseq = sdp_list_append(NULL, profile);
-	sdp_set_profile_descs(record, pfseq);
-
 	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
 	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
-	apseq = sdp_list_append(NULL, proto[0]);
+	seq = sdp_list_append(NULL, proto[0]);
 
 	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
 	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
 	channel = sdp_data_alloc(SDP_UINT8, &chan);
 	proto[1] = sdp_list_append(proto[1], channel);
-	apseq = sdp_list_append(apseq, proto[1]);
+	seq = sdp_list_append(seq, proto[1]);
 
-	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
-	proto[2] = sdp_list_append(NULL, &obex_uuid);
-	apseq = sdp_list_append(apseq, proto[2]);
+	if (has_obex) {
+		sdp_uuid16_create(&obex_uuid, OBEX_UUID);
+		proto[2] = sdp_list_append(NULL, &obex_uuid);
+		seq = sdp_list_append(seq, proto[2]);
+	}
 
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
+	proto_seq = sdp_list_append(NULL, seq);
+	sdp_set_access_protos(record, proto_seq);
 
-	for (i = 0; i < sizeof(formats); i++) {
-		dtds[i] = &dtd;
-		values[i] = &formats[i];
-	}
-	sflist = sdp_seq_alloc(dtds, values, sizeof(formats));
-	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FORMATS_LIST, sflist);
+	sdp_uuid16_create(&pbg_uuid, PUBLIC_BROWSE_GROUP);
+	pbg_seq = sdp_list_append(NULL, &pbg_uuid);
+	sdp_set_browse_groups(record, pbg_seq);
 
 	if (svc_name)
-		service_name = svc_name;
-
-	sdp_set_info_attr(record, service_name, NULL, NULL);
+		sdp_set_info_attr(record, svc_name, NULL, NULL);
 
 	sdp_data_free(channel);
 	sdp_list_free(proto[0], NULL);
 	sdp_list_free(proto[1], NULL);
-	sdp_list_free(proto[2], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(aproto, NULL);
-	sdp_list_free(root, NULL);
+	if (has_obex)
+		sdp_list_free(proto[2], NULL);
+	sdp_list_free(seq, NULL);
+	sdp_list_free(proto_seq, NULL);
+	sdp_list_free(pbg_seq, NULL);
 	sdp_list_free(svclass_id, NULL);
 
 	return record;
 }
 
-static sdp_record_t *create_pbap_record(uint8_t chan, const char *svc_name)
+static sdp_record_t *create_opp_record(uint8_t chan, const char *svc_name)
 {
-	const char *service_name = "OBEX Phonebook Access Server";
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, pbap_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
-	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *proto[3];
-	sdp_data_t *channel;
-	uint8_t formats[] = { 0x01 };
+	uint8_t formats[] = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0xff };
 	uint8_t dtd = SDP_UINT8;
-	sdp_data_t *sflist;
+	uuid_t uuid;
+	sdp_list_t *seq;
+	sdp_profile_desc_t profile[1];
+	void *dtds[sizeof(formats)], *values[sizeof(formats)];
+	sdp_data_t *formats_list;
 	sdp_record_t *record;
+	size_t i;
 
-	record = sdp_record_alloc();
+	sdp_uuid16_create(&uuid, OBEX_OBJPUSH_SVCLASS_ID);
+
+	record = create_rfcomm_record(chan, &uuid, svc_name, true);
 	if (!record)
 		return NULL;
 
-	record->handle =  sdp_next_handle();
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&pbap_uuid, PBAP_PSE_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &pbap_uuid);
-	sdp_set_service_classes(record, svclass_id);
-
-	sdp_uuid16_create(&profile[0].uuid, PBAP_PROFILE_ID);
+	sdp_uuid16_create(&profile[0].uuid, OBEX_OBJPUSH_PROFILE_ID);
 	profile[0].version = 0x0100;
-	pfseq = sdp_list_append(NULL, profile);
-	sdp_set_profile_descs(record, pfseq);
+	seq = sdp_list_append(NULL, profile);
+	sdp_set_profile_descs(record, seq);
 
-	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
-	apseq = sdp_list_append(NULL, proto[0]);
+	for (i = 0; i < sizeof(formats); i++) {
+		dtds[i] = &dtd;
+		values[i] = &formats[i];
+	}
+	formats_list = sdp_seq_alloc(dtds, values, sizeof(formats));
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FORMATS_LIST, formats_list);
 
-	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
-	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
-	channel = sdp_data_alloc(SDP_UINT8, &chan);
-	proto[1] = sdp_list_append(proto[1], channel);
-	apseq = sdp_list_append(apseq, proto[1]);
+	sdp_list_free(seq, NULL);
 
-	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
-	proto[2] = sdp_list_append(NULL, &obex_uuid);
-	apseq = sdp_list_append(apseq, proto[2]);
+	return record;
+}
 
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
+static sdp_record_t *create_pbap_record(uint8_t chan, const char *svc_name)
+{
+	sdp_list_t *seq;
+	sdp_profile_desc_t profile[1];
+	uint8_t formats = 0x01;
+	sdp_record_t *record;
+	uuid_t uuid;
 
-	sflist = sdp_data_alloc(dtd, formats);
-	sdp_attr_add(record, SDP_ATTR_SUPPORTED_REPOSITORIES, sflist);
+	sdp_uuid16_create(&uuid, PBAP_PSE_SVCLASS_ID);
 
-	if (svc_name)
-		service_name = svc_name;
+	record = create_rfcomm_record(chan, &uuid, svc_name, true);
+	if (!record)
+		return NULL;
 
-	sdp_set_info_attr(record, service_name, NULL, NULL);
+	sdp_uuid16_create(&profile[0].uuid, PBAP_PROFILE_ID);
+	profile[0].version = 0x0100;
+	seq = sdp_list_append(NULL, profile);
+	sdp_set_profile_descs(record, seq);
 
-	sdp_data_free(channel);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(proto[2], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(aproto, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
+	sdp_attr_add_new(record, SDP_ATTR_SUPPORTED_REPOSITORIES, SDP_UINT8,
+								&formats);
+
+	sdp_list_free(seq, NULL);
 
 	return record;
 }
 
 static sdp_record_t *create_mas_record(uint8_t chan, const char *svc_name)
 {
-	const char *service_name = "MAP MAS SMS";
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, mse_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
+	sdp_list_t *seq;
 	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *proto[3];
-	sdp_data_t *channel;
 	uint8_t minst = DEFAULT_MAS_INSTANCE;
 	uint8_t mtype = DEFAULT_MAS_MSG_TYPE;
 	sdp_record_t *record;
+	uuid_t uuid;
 
-	record = sdp_record_alloc();
+	sdp_uuid16_create(&uuid, MAP_MSE_SVCLASS_ID);
+
+	record = create_rfcomm_record(chan, &uuid, svc_name, true);
 	if (!record)
 		return NULL;
 
-	record->handle =  sdp_next_handle();
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&mse_uuid, MAP_MSE_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &mse_uuid);
-	sdp_set_service_classes(record, svclass_id);
-
 	sdp_uuid16_create(&profile[0].uuid, MAP_PROFILE_ID);
 	profile[0].version = 0x0101;
-	pfseq = sdp_list_append(NULL, profile);
-	sdp_set_profile_descs(record, pfseq);
+	seq = sdp_list_append(NULL, profile);
+	sdp_set_profile_descs(record, seq);
 
 	sdp_attr_add_new(record, SDP_ATTR_MAS_INSTANCE_ID, SDP_UINT8, &minst);
 	sdp_attr_add_new(record, SDP_ATTR_SUPPORTED_MESSAGE_TYPES, SDP_UINT8,
 									&mtype);
 
-	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
-	apseq = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
-	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
-	channel = sdp_data_alloc(SDP_UINT8, &chan);
-	proto[1] = sdp_list_append(proto[1], channel);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
-	proto[2] = sdp_list_append(NULL, &obex_uuid);
-	apseq = sdp_list_append(apseq, proto[2]);
-
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	if (svc_name)
-		service_name = svc_name;
-
-	sdp_set_info_attr(record, service_name, NULL, NULL);
-
-	sdp_data_free(channel);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(proto[2], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(aproto, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
+	sdp_list_free(seq, NULL);
 
 	return record;
 }
 
 static sdp_record_t *create_spp_record(uint8_t chan, const char *svc_name)
 {
-	const char *service_name = "Serial Port";
-	sdp_list_t *svclass_id, *apseq, *profiles, *root;
-	uuid_t root_uuid, sp_uuid, l2cap, rfcomm;
-	sdp_profile_desc_t profile;
-	sdp_list_t *aproto, *proto[2];
-	sdp_data_t *channel;
 	sdp_record_t *record;
+	uuid_t uuid;
 
-	record = sdp_record_alloc();
+	sdp_uuid16_create(&uuid, SERIAL_PORT_SVCLASS_ID);
+
+	record = create_rfcomm_record(chan, &uuid, svc_name, false);
 	if (!record)
 		return NULL;
 
-	record->handle =  sdp_next_handle();
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &sp_uuid);
-	sdp_set_service_classes(record, svclass_id);
-
-	sdp_uuid16_create(&profile.uuid, SERIAL_PORT_PROFILE_ID);
-	profile.version = 0x0100;
-	profiles = sdp_list_append(NULL, &profile);
-	sdp_set_profile_descs(record, profiles);
-
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap);
-	apseq = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
-	proto[1] = sdp_list_append(NULL, &rfcomm);
-	channel = sdp_data_alloc(SDP_UINT8, &chan);
-	proto[1] = sdp_list_append(proto[1], channel);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	sdp_add_lang_attr(record);
-
-	if (svc_name)
-		service_name = svc_name;
-
-	sdp_set_info_attr(record, service_name, "BlueZ", "COM Port");
-
-	sdp_set_url_attr(record, "http://www.bluez.org/",
-			"http://www.bluez.org/", "http://www.bluez.org/");
-
-	sdp_set_service_id(record, sp_uuid);
-	sdp_set_service_ttl(record, 0xffff);
-	sdp_set_service_avail(record, 0xff);
-	sdp_set_record_state(record, 0x00001234);
-
-	sdp_data_free(channel);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(aproto, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
-	sdp_list_free(profiles, NULL);
-
 	return record;
 }
 
-- 
1.8.5.3

