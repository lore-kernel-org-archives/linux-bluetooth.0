Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	<luiz.dentz@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/2] android/map: Add support for MAP/MAS
Date: Thu, 2 Jan 2014 13:51:40 +0100
Message-ID: <1388667100-28806-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1388667100-28806-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1388667100-28806-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Theres no HAL API exposed to application to register different MAS
instances. Android 4.4 does support only MAS SMS. All Instance ID,
supported msg type and rfcomm channel are hardcoded in the stack.
Unfortunatelly we need to do the same way and wait for new HAL API
which is expected.

Change-Id: Ie151e34db8eed1e07c73aeb400bdfd2e5bd79f0d
---
 android/socket.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 15c1bb8..11d64f8 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -52,6 +52,14 @@
 
 #define SVC_HINT_OBEX 0x10
 
+/* Hardcoded MAP stuff needed for MAS SMS Instance.*/
+#define DEFAULT_MAS_INSTANCE	0x00
+
+#define MAP_MSG_TYPE_SMS_GSM	0x02
+#define MAP_MSG_TYPE_SMS_CDMA	0x04
+#define DEFAULT_MAS_MSG_TYPE	(MAP_MSG_TYPE_SMS_GSM | MAP_MSG_TYPE_SMS_CDMA)
+
+
 static bdaddr_t adapter_addr;
 
 /* Simple list of RFCOMM server sockets */
@@ -311,6 +319,76 @@ static sdp_record_t *create_pbap_record(uint8_t chan, const char *svc_name)
 	return record;
 }
 
+static sdp_record_t *create_mas_record(uint8_t chan, const char *svc_name)
+{
+	const char *service_name = "MAP MAS SMS";
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, mse_uuid, l2cap_uuid, rfcomm_uuid, obex_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[3];
+	sdp_data_t *channel;
+	uint8_t minst = DEFAULT_MAS_INSTANCE;
+	uint8_t mtype = DEFAULT_MAS_MSG_TYPE;
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
+	sdp_uuid16_create(&mse_uuid, MAP_MSE_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &mse_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, MAP_PROFILE_ID);
+	profile[0].version = 0x0101;
+	pfseq = sdp_list_append(NULL, profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_attr_add_new(record, SDP_ATTR_MAS_INSTANCE_ID, SDP_UINT8, &minst);
+	sdp_attr_add_new(record, SDP_ATTR_SUPPORTED_MESSAGE_TYPES, SDP_UINT8,
+									&mtype);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap_uuid);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm_uuid);
+	channel = sdp_data_alloc(SDP_UINT8, &chan);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	sdp_uuid16_create(&obex_uuid, OBEX_UUID);
+	proto[2] = sdp_list_append(NULL, &obex_uuid);
+	apseq = sdp_list_append(apseq, proto[2]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	if (svc_name)
+		service_name = svc_name;
+
+	sdp_set_info_attr(record, service_name, NULL, NULL);
+
+	sdp_data_free(channel);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(proto[2], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(svclass_id, NULL);
+
+	return record;
+}
+
 static sdp_record_t *create_spp_record(uint8_t chan, const char *svc_name)
 {
 	const char *service_name = "Serial Port";
@@ -411,9 +489,9 @@ static const struct profile_info {
 			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
 		},
 		.channel = MAS_DEFAULT_CHANNEL,
-		.svc_hint = 0,
+		.svc_hint = SVC_HINT_OBEX,
 		.sec_level = BT_IO_SEC_MEDIUM,
-		.create_record = NULL
+		.create_record = create_mas_record
 	}, {
 		.uuid = {
 			0x00, 0x00, 0x11, 0x01, 0x00, 0x00, 0x10, 0x00,
-- 
1.8.4

