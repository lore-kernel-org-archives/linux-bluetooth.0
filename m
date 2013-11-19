Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 19/19] android/socket: Add SPP SDP record
Date: Tue, 19 Nov 2013 15:30:09 +0200
Message-Id: <1384867809-18135-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 0c71297..dc73dd1 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -225,9 +225,69 @@ static sdp_record_t *create_pbap_record(uint8_t chan)
 	sdp_list_free(proto[1], NULL);
 	sdp_list_free(apseq, NULL);
 	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
 	sdp_list_free(root, NULL);
 	sdp_list_free(svclass_id, NULL);
+
+	return record;
+}
+
+static sdp_record_t *create_spp_record(uint8_t chan)
+{
+	sdp_list_t *svclass_id, *apseq, *profiles, *root;
+	uuid_t root_uuid, sp_uuid, rfcomm;
+	sdp_profile_desc_t profile;
+	sdp_list_t *aproto, *proto[1];
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
+	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
+	proto[0] = sdp_list_append(NULL, &rfcomm);
+	channel = sdp_data_alloc(SDP_UINT8, &chan);
+	proto[0] = sdp_list_append(proto[0], channel);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_add_lang_attr(record);
+
+	sdp_set_info_attr(record, "Serial Port", "BlueZ", "COM Port");
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
+	sdp_list_free(apseq, NULL);
 	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+	sdp_list_free(profiles, NULL);
 
 	return record;
 }
@@ -266,7 +326,9 @@ static struct profile_info {
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
1.7.10.4

