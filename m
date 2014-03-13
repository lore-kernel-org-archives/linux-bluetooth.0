Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/handsfree: Add initial implementation of Codec Negotiation feature
Date: Thu, 13 Mar 2014 15:04:35 +0100
Message-Id: <1394719477-7590-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will handle AT+BAC command and update list of available codecs.
It will check if mandatory codec CVSD is present on list and, if
Wide Band Speech supported, MSBC codec is on next place. Other codecs
can be also used after extending codecs_defaults array.
It will also handle incorrect SLC establishment, when HF supports
Codec Negotiation, but didn't send AT+BAC.
---
 android/handsfree.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index b71c28e..44d1f32 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -71,7 +71,8 @@
 
 #define HFP_AG_FEATURES ( HFP_AG_FEAT_3WAY | HFP_AG_FEAT_ECNR |\
 			HFP_AG_FEAT_VR | HFP_AG_FEAT_REJ_CALL |\
-			HFP_AG_FEAT_ECS | HFP_AG_FEAT_EXT_ERR )
+			HFP_AG_FEAT_ECS | HFP_AG_FEAT_EXT_ERR |\
+			HFP_AG_FEAT_CODEC )
 
 #define HFP_AG_CHLD "0,1,2,3"
 
@@ -87,6 +88,13 @@
 
 #define RING_TIMEOUT 2
 
+#define CVSD_OFFSET 0
+#define MSBC_OFFSET 1
+#define CODECS_COUNT (MSBC_OFFSET + 1)
+
+#define CODEC_ID_CVSD 0x01
+#define CODEC_ID_MSBC 0x02
+
 struct indicator {
 	const char *name;
 	int min;
@@ -96,6 +104,12 @@ struct indicator {
 	bool active;
 };
 
+struct hfp_codec {
+	uint8_t type;
+	bool local_supported;
+	bool remote_supported;
+};
+
 static const struct indicator inds_defaults[] = {
 		{ "service",   0, 1, 0, false, true },
 		{ "call",      0, 1, 0, true, true },
@@ -106,6 +120,11 @@ static const struct indicator inds_defaults[] = {
 		{ "battchg",   0, 5, 0, false, true },
 };
 
+static const struct hfp_codec codecs_defaults[] = {
+	{ CODEC_ID_CVSD, true, false},
+	{ CODEC_ID_MSBC, false, false},
+};
+
 static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
@@ -116,6 +135,9 @@ static struct {
 	bool ccwa_enabled;
 	bool indicators_enabled;
 	struct indicator inds[IND_COUNT];
+	uint8_t negotiated_codec;
+	uint8_t proposed_codec;
+	struct hfp_codec codecs[CODECS_COUNT];
 	guint ring;
 	bool hsp;
 	struct hfp_gw *gw;
@@ -180,6 +202,8 @@ static void device_init(const bdaddr_t *bdaddr)
 
 	memcpy(device.inds, inds_defaults, sizeof(device.inds));
 
+	memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+
 	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
 }
 
@@ -924,6 +948,13 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	switch (type) {
 	case HFP_GW_CMD_TYPE_TEST:
 
+		/* If device supports Codec Negotiation, AT+BAC should be
+		 * received first
+		 */
+		if ((device.features & HFP_HF_FEAT_CODEC))
+			if (!device.codecs[CVSD_OFFSET].remote_supported)
+				break;
+
 		len = strlen("+CIND:") + 1;
 
 		for (i = 0; i < IND_COUNT; i++) {
@@ -1032,13 +1063,72 @@ static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
+static struct hfp_codec *find_codec_by_type(uint8_t type)
+{
+	int i;
+
+	for (i = 0; i < CODECS_COUNT; i++)
+		if (type == device.codecs[i].type)
+			return &device.codecs[i];
+
+	return NULL;
+}
+
 static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	unsigned int val;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!(device.features & HFP_HF_FEAT_CODEC))
+			goto failed;
+
+		/* Clear list of codecs */
+		memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+		device.negotiated_codec = 0;
+
+		/* At least CVSD mandatory codec must exist
+		 * HFP V1.6 4.34.1
+		 */
+		if (!hfp_gw_result_get_number(result, &val)
+				|| val != CODEC_ID_CVSD)
+			goto failed;
 
+		device.codecs[CVSD_OFFSET].remote_supported = true;
+
+		if (hfp_gw_result_get_number(result, &val)) {
+			if (val != CODEC_ID_MSBC)
+				goto failed;
+
+			device.codecs[MSBC_OFFSET].remote_supported = true;
+		}
+
+		while (hfp_gw_result_has_next(result)) {
+			struct hfp_codec *codec;
+
+			if (!hfp_gw_result_get_number(result, &val))
+				goto failed;
+
+			codec = find_codec_by_type(val);
+			if (!codec)
+				continue;
+
+			codec->remote_supported = true;
+		}
+
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		return;
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
+
+failed:
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-- 
1.8.3.1

