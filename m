Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv7 10/14] android/socket: Add PBAP SDP record
Date: Fri, 22 Nov 2013 10:34:51 +0200
Message-Id: <1385109295-11445-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This adds SDP service record like shown below:

Service Name: OBEX Phonebook Access Server
Service RecHandle: 0x10002
Service Class ID List:
  "Phonebook Access - PSE" (0x112f)
Protocol Descriptor List:
  "RFCOMM" (0x0003)
    Channel: 15
  "OBEX" (0x0008)
Profile Descriptor List:
  "Phonebook Access" (0x1130)
    Version: 0x0100
---
 android/socket.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 36f2f2e..5af0bf6 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -186,6 +186,71 @@ static sdp_record_t *create_opp_record(uint8_t chan, const char *svc_name)
 	return record;
 }
 
+static sdp_record_t *create_pbap_record(uint8_t chan, const char *svc_name)
+{
+	const char *service_name = "OBEX Phonebook Access Server";
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, pbap_uuid, rfcomm_uuid, obex_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[2];
+	sdp_data_t *channel;
+	uint8_t formats[] = { 0x01 };
+	uint8_t dtd = SDP_UINT8;
+	sdp_data_t *sflist;
+	sdp_record_t *record;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	record->handle =  sdp_next_handle();
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&pbap_uuid, PBAP_PSE_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &pbap_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, PBAP_PROFILE_ID);
+	profile[0].version = 0x0100;
+	pfseq = sdp_list_append(NULL, profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[0] = sdp_list_append(NULL, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &chan);
+	proto[0] = sdp_list_append(proto[0], channel);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
+	proto[1] = sdp_list_append(NULL, &obex_uuid);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sflist = sdp_data_alloc(dtd, formats);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_REPOSITORIES, sflist);
+
+	if (svc_name)
+		service_name = svc_name;
+
+	sdp_set_info_attr(record, service_name, NULL, NULL);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+
+	return record;
+}
+
 static struct profile_info {
 	uint8_t		uuid[16];
 	uint8_t		channel;
@@ -198,7 +263,9 @@ static struct profile_info {
 			0x00, 0x00, 0x11, 0x2F, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
-		.channel = PBAP_DEFAULT_CHANNEL
+		.channel = PBAP_DEFAULT_CHANNEL,
+		.svc_hint = SVC_HINT_OBEX,
+		.create_record = create_pbap_record
 	}, {
 		.uuid = {
 			0x00, 0x00, 0x11, 0x05, 0x00, 0x00, 0x10, 0x00,
-- 
1.8.3.2

