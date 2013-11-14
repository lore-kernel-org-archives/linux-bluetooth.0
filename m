Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/a2dp: Add implementation of SDP record
Date: Thu, 14 Nov 2013 16:16:14 +0200
Message-Id: <1384438574-5791-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following record:

Service Name: Audio Source
Service RecHandle: 0x10001
Service Class ID List:
  "Audio Source" (0x110a)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x103
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0103
---
 android/a2dp.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 32b6aa3..d8fe416 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -27,6 +27,7 @@
 
 #include <stdint.h>
 #include <stdbool.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -34,18 +35,23 @@
 
 #include "btio/btio.h"
 #include "lib/bluetooth.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
 #include "log.h"
 #include "a2dp.h"
 #include "hal-msg.h"
 #include "ipc.h"
 #include "utils.h"
+#include "bluetooth.h"
 
 #define L2CAP_PSM_AVDTP 0x19
+#define SVC_HINT_CAPTURING 0x08
 
 static int notification_sk = -1;
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
 static bdaddr_t adapter_addr;
+static uint32_t record_id = 0;
 
 struct a2dp_device {
 	bdaddr_t	dst;
@@ -258,9 +264,71 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	signaling_connect_cb(chan, err, dev);
 }
 
+static sdp_record_t *a2dp_record(void)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap_uuid, avdtp_uuid, a2dp_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *psm, *version, *features;
+	uint16_t lp = AVDTP_UUID;
+	uint16_t a2dp_ver = 0x0103, avdtp_ver = 0x0103, feat = 0x000f;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&a2dp_uuid, AUDIO_SOURCE_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &a2dp_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, ADVANCED_AUDIO_PROFILE_ID);
+	profile[0].version = a2dp_ver;
+	pfseq = sdp_list_append(0, &profile[0]);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&avdtp_uuid, AVDTP_UUID);
+	proto[1] = sdp_list_append(0, &avdtp_uuid);
+	version = sdp_data_alloc(SDP_UINT16, &avdtp_ver);
+	proto[1] = sdp_list_append(proto[1], version);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	features = sdp_data_alloc(SDP_UINT16, &feat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	sdp_set_info_attr(record, "Audio Source", 0, 0);
+
+	free(psm);
+	free(version);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
+}
+
 bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 {
 	GError *err = NULL;
+	sdp_record_t *rec;
 
 	DBG("");
 
@@ -277,6 +345,16 @@ bool bt_a2dp_register(int sk, const bdaddr_t *addr)
 		return false;
 	}
 
+	rec = a2dp_record();
+	if (bt_adapter_add_record(rec, SVC_HINT_CAPTURING) < 0) {
+		error("Failed to register on A2DP record");
+		g_io_channel_shutdown(server, TRUE, NULL);
+		g_io_channel_unref(server);
+		server = NULL;
+		return false;
+	}
+	record_id = rec->handle;
+
 	notification_sk = sk;
 
 	return true;
@@ -288,6 +366,9 @@ void bt_a2dp_unregister(void)
 
 	notification_sk = -1;
 
+	bt_adapter_remove_record(record_id);
+	record_id = 0;
+
 	if (server) {
 		g_io_channel_shutdown(server, TRUE, NULL);
 		g_io_channel_unref(server);
-- 
1.8.3.1

