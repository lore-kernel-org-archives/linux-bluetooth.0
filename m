Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv9 11/21] android/socket: Add SPP SDP record
Date: Mon, 25 Nov 2013 15:08:47 +0200
Message-Id: <1385384937-29858-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index c053a1e..a8f9a6b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -261,6 +261,75 @@ static sdp_record_t *create_pbap_record(uint8_t chan, const char *svc_name)
 	return record;
 }
 
+static sdp_record_t *create_spp_record(uint8_t chan, const char *svc_name)
+{
+	const char *service_name = "Serial Port";
+	sdp_list_t *svclass_id, *apseq, *profiles, *root;
+	uuid_t root_uuid, sp_uuid, l2cap, rfcomm;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[2];
+	sdp_data_t *channel;
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
+	sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &sp_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile.uuid, SERIAL_PORT_PROFILE_ID);
+	profile.version = 0x0100;
+	profiles = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, profiles);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm);
+	channel = sdp_data_alloc(SDP_UINT8, &chan);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_add_lang_attr(record);
+
+	if (svc_name)
+		service_name = svc_name;
+
+	sdp_set_info_attr(record, service_name, "BlueZ", "COM Port");
+
+	sdp_set_url_attr(record, "http://www.bluez.org/",
+			"http://www.bluez.org/", "http://www.bluez.org/");
+
+	sdp_set_service_id(record, sp_uuid);
+	sdp_set_service_ttl(record, 0xffff);
+	sdp_set_service_avail(record, 0xff);
+	sdp_set_record_state(record, 0x00001234);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+	sdp_list_free(profiles, NULL);
+
+	return record;
+}
+
 static struct profile_info {
 	uint8_t		uuid[16];
 	uint8_t		channel;
@@ -295,7 +364,9 @@ static struct profile_info {
 			0x00, 0x00, 0x11, 0x01, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
-		.channel = SPP_DEFAULT_CHANNEL
+		.channel = SPP_DEFAULT_CHANNEL,
+		.svc_hint = 0,
+		.create_record = create_spp_record
 	},
 };
 
-- 
1.8.3.2

