Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/handsfree: Add support for WBS mode
Date: Mon, 17 Mar 2014 13:40:22 +0100
Message-Id: <1395060022-478-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395060022-478-1-git-send-email-szymon.janc@tieto.com>
References: <1395060022-478-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for WBS mode in handsfree HAl as well as
redefining current modes.

"persist.sys.bluetooth.handsfree" property can be used to tune
handsfree HAL. Setting it to "hfp" or "hfp_wbs" values enables HFP
profile with narrowband only or with both narrowband and wideband
speech support. Any other value or lack of property defaults to
HSP only mode.
---

The open point is the name of property used to control mode. If it should be
persist.sys or maybe just ro. ? Do we want to allow priviledged user to be
able to runtime control which mode is enabled?

Note: property name must be <32 characters.

 android/hal-handsfree.c | 14 ++++++++++----
 android/hal-msg.h       |  4 +++-
 android/handsfree.c     | 51 +++++++++++++++++++++++++++++++++++--------------
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 31793b0..5a05975 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -28,6 +28,8 @@
 #include "ipc-common.h"
 #include "hal-ipc.h"
 
+#define MODE_PROPERTY_NAME "persist.sys.bluetooth.handsfree"
+
 static const bthf_callbacks_t *cbs = NULL;
 
 static bool interface_ready(void)
@@ -210,11 +212,15 @@ static uint8_t get_mode(void)
 {
 	char value[PROPERTY_VALUE_MAX];
 
-	if (property_get("bluetooth.handsfree_mode", value, "") > 0 &&
-					(!strcasecmp(value, "hsp_only")))
-		return HAL_MODE_HANDSFREE_HSP_ONLY;
+	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
+					(!strcasecmp(value, "hfp")))
+		return HAL_MODE_HANDSFREE_HFP;
+
+	if (property_get(MODE_PROPERTY_NAME, value, "") > 0 &&
+					(!strcasecmp(value, "hfp_wbs")))
+		return HAL_MODE_HANDSFREE_HFP_WBS;
 
-	return HAL_MODE_DEFAULT;
+	return HAL_MODE_HANDSFREE_HSP_ONLY;
 }
 
 static bt_status_t init(bthf_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e325f21..4c1f42b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -426,7 +426,9 @@ struct hal_cmd_health_destroy_channel {
 
 /* Handsfree HAL API */
 
-#define HAL_MODE_HANDSFREE_HSP_ONLY		0x01
+#define HAL_MODE_HANDSFREE_HSP_ONLY		HAL_MODE_DEFAULT
+#define HAL_MODE_HANDSFREE_HFP			0x01
+#define HAL_MODE_HANDSFREE_HFP_WBS		0x02
 
 #define HAL_OP_HANDSFREE_CONNECT		0x01
 struct hal_cmd_handsfree_connect {
diff --git a/android/handsfree.c b/android/handsfree.c
index c8e5f8a..1afe011 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -71,8 +71,7 @@
 
 #define HFP_AG_FEATURES ( HFP_AG_FEAT_3WAY | HFP_AG_FEAT_ECNR |\
 			HFP_AG_FEAT_VR | HFP_AG_FEAT_REJ_CALL |\
-			HFP_AG_FEAT_ECS | HFP_AG_FEAT_EXT_ERR |\
-			HFP_AG_FEAT_CODEC )
+			HFP_AG_FEAT_ECS | HFP_AG_FEAT_EXT_ERR )
 
 #define HFP_AG_CHLD "0,1,2,3"
 
@@ -153,6 +152,8 @@ static struct {
 	guint sco_watch;
 } device;
 
+static uint32_t hfp_ag_features = 0;
+
 static bdaddr_t adapter_addr;
 static struct ipc *hal_ipc = NULL;
 
@@ -204,6 +205,14 @@ static void device_set_audio_state(uint8_t state)
 				HAL_EV_HANDSFREE_AUDIO_STATE, sizeof(ev), &ev);
 }
 
+static void init_codecs(void)
+{
+	memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+
+	if (hfp_ag_features & HFP_AG_FEAT_CODEC)
+		device.codecs[MSBC_OFFSET].local_supported = true;
+}
+
 static void device_init(const bdaddr_t *bdaddr)
 {
 	bacpy(&device.bdaddr, bdaddr);
@@ -212,7 +221,7 @@ static void device_init(const bdaddr_t *bdaddr)
 
 	memcpy(device.inds, inds_defaults, sizeof(device.inds));
 
-	memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+	init_codecs();
 
 	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
 }
@@ -1182,7 +1191,7 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		/* TODO verify features */
 		device.features = feat;
 
-		hfp_gw_send_info(device.gw, "+BRSF: %u", HFP_AG_FEATURES);
+		hfp_gw_send_info(device.gw, "+BRSF: %u", hfp_ag_features);
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
@@ -1257,8 +1266,8 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (!(device.features & HFP_HF_FEAT_CODEC))
 			goto failed;
 
-		/* Clear list of codecs */
-		memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+		/* set codecs to defaults */
+		init_codecs();
 		device.negotiated_codec = 0;
 
 		/* At least CVSD mandatory codec must exist
@@ -2411,8 +2420,8 @@ static sdp_record_t *hfp_ag_record(void)
 	apseq = sdp_list_append(apseq, proto[1]);
 
 	/* Codec Negotiation bit in SDP feature is different then in BRSF */
-	sdpfeat = HFP_AG_FEATURES & 0x0000003F;
-	if (HFP_AG_FEATURES & HFP_AG_FEAT_CODEC)
+	sdpfeat = hfp_ag_features & 0x0000003F;
+	if (hfp_ag_features & HFP_AG_FEAT_CODEC)
 		sdpfeat |= 0x00000020;
 	else
 		sdpfeat &= ~0x00000020;
@@ -2535,17 +2544,29 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	if (!enable_hsp_ag())
 		return false;
 
-	if (mode != HAL_MODE_HANDSFREE_HSP_ONLY && !enable_hfp_ag()) {
-		cleanup_hsp_ag();
-		return false;
-	}
-
 	if (!enable_sco_server()) {
 		cleanup_hsp_ag();
-		cleanup_hfp_ag();
 		return false;
 	}
 
+	if (mode == HAL_MODE_HANDSFREE_HSP_ONLY)
+		goto done;
+
+	hfp_ag_features = HFP_AG_FEATURES;
+
+	if (mode == HAL_MODE_HANDSFREE_HFP_WBS)
+		hfp_ag_features |= HFP_AG_FEAT_CODEC;
+
+	if (enable_hfp_ag())
+		goto done;
+
+	cleanup_hsp_ag();
+	disable_sco_server();
+	hfp_ag_features = 0;
+
+	return false;
+
+done:
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
@@ -2563,4 +2584,6 @@ void bt_handsfree_unregister(void)
 	cleanup_hfp_ag();
 	cleanup_hsp_ag();
 	disable_sco_server();
+
+	hfp_ag_features = 0;
 }
-- 
1.8.5.3

