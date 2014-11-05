Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/7] android/handsfree-client: Add SLC creation procedure
Date: Wed,  5 Nov 2014 12:22:09 +0100
Message-Id: <1415186531-23288-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415186531-23288-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415186531-23288-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements SLC procedure for HFP HF.
---
 android/handsfree-client.c | 536 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 535 insertions(+), 1 deletion(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 6be9851..def057d 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -36,6 +36,7 @@
 #include "lib/sdp_lib.h"
 #include "src/sdp-client.h"
 #include "src/shared/queue.h"
+#include "src/shared/hfp.h"
 #include "btio/btio.h"
 #include "ipc.h"
 #include "ipc-common.h"
@@ -59,15 +60,70 @@
 #define HFP_HF_FEAT_HF_IND	0x00000100
 #define HFP_HF_FEAT_ESCO_S4_T2	0x00000200
 
+#define HFP_AG_FEAT_3WAY	0x00000001
+#define HFP_AG_FEAT_ECNR	0x00000002
+#define HFP_AG_FEAT_VR		0x00000004
+#define HFP_AG_FEAT_INBAND	0x00000008
+#define HFP_AG_FEAT_VTAG	0x00000010
+#define HFP_AG_FEAT_REJ_CALL	0x00000020
+#define HFP_AG_FEAT_ECS		0x00000040
+#define HFP_AG_FEAT_ECC		0x00000080
+#define HFP_AG_FEAT_EXT_ERR	0x00000100
+#define HFP_AG_FEAT_CODEC	0x00000200
 
 #define HFP_HF_FEATURES (HFP_HF_FEAT_ECNR | HFP_HF_FEAT_3WAY |\
 				HFP_HF_FEAT_CLI | HFP_HF_FEAT_VR |\
 				HFP_HF_FEAT_RVC | HFP_HF_FEAT_ECS |\
 				HFP_HF_FEAT_ECC)
 
+#define CVSD_OFFSET 0
+#define MSBC_OFFSET 1
+#define CODECS_COUNT (MSBC_OFFSET + 1)
+
+#define CODEC_ID_CVSD 0x01
+#define CODEC_ID_MSBC 0x02
+
+enum hfp_indicator {
+	HFP_INDICATOR_SERVICE = 0,
+	HFP_INDICATOR_CALL,
+	HFP_INDICATOR_CALLSETUP,
+	HFP_INDICATOR_CALLHELD,
+	HFP_INDICATOR_SIGNAL,
+	HFP_INDICATOR_ROAM,
+	HFP_INDICATOR_BATTCHG,
+	HFP_INDICATOR_LAST
+};
+
+struct indicator {
+	uint8_t index;
+	uint32_t min;
+	uint32_t max;
+	uint32_t val;
+};
+
+struct hfp_codec {
+	uint8_t type;
+	bool local_supported;
+	bool remote_supported;
+};
+
 struct device {
 	bdaddr_t bdaddr;
+	bool slc_created;
+	struct hfp_hf *hf;
 	uint8_t state;
+
+	uint32_t features;
+	struct hfp_codec codecs[2];
+
+	struct indicator ag_ind[HFP_INDICATOR_LAST];
+
+	uint32_t chld_features;
+};
+
+static const struct hfp_codec codecs_defaults[] = {
+	{ CODEC_ID_CVSD, true, false},
+	{ CODEC_ID_MSBC, false, false},
 };
 
 static bdaddr_t adapter_addr;
@@ -93,6 +149,14 @@ static struct device *find_device(const bdaddr_t *addr)
 	return queue_find(devices, match_by_bdaddr, addr);
 }
 
+static void init_codecs(struct device *dev)
+{
+	memcpy(&dev->codecs, codecs_defaults, sizeof(dev->codecs));
+
+	if (hfp_hf_features & HFP_HF_FEAT_CODEC)
+		dev->codecs[MSBC_OFFSET].local_supported = true;
+}
+
 static struct device *device_create(const bdaddr_t *bdaddr)
 {
 	struct device *dev;
@@ -109,6 +173,8 @@ static struct device *device_create(const bdaddr_t *bdaddr)
 
 	bacpy(&dev->bdaddr, bdaddr);
 
+	init_codecs(dev);
+
 	return dev;
 }
 
@@ -265,6 +331,9 @@ static void device_set_state(struct device *dev, uint8_t state)
 	bdaddr2android(&dev->bdaddr, ev.bdaddr);
 	ev.state = state;
 
+	ev.chld_feat = dev->chld_features;
+	ev.peer_feat = dev->features;
+
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
 				HAL_EV_HF_CLIENT_CONN_STATE, sizeof(ev), &ev);
 }
@@ -274,9 +343,462 @@ static void device_destroy(void *data)
 	struct device *dev = data;
 
 	queue_remove(devices, dev);
+
+	if (dev->hf)
+		hfp_hf_unref(dev->hf);
+
 	free(dev);
 }
 
+static void disconnect_watch(void *user_data)
+{
+	DBG("");
+
+	device_destroy(user_data);
+}
+
+static void slc_error(struct device *dev)
+{
+	error("hf-client: Could not create SLC - dropping connection");
+	hfp_hf_disconnect(dev->hf);
+}
+
+static void set_chld_feat(struct device *dev, char *feat)
+{
+	DBG(" %s", feat);
+
+	if (strcmp(feat, "0") == 0)
+		dev->chld_features |= HAL_HF_CLIENT_CHLD_FEAT_REL;
+	else if (strcmp(feat, "1") == 0)
+		dev->chld_features |= HAL_HF_CLIENT_CHLD_FEAT_REL_ACC;
+	else if (strcmp(feat, "1x") == 0)
+		dev->chld_features |= HAL_HF_CLIENT_CHLD_FEAT_REL_X;
+	else if (strcmp(feat, "2") == 0)
+		dev->chld_features |= HAL_HF_CLIENT_CHLD_FEAT_HOLD_ACC;
+	else if (strcmp(feat, "2x") == 0)
+		dev->chld_features |= HAL_HF_CLIENT_CHLD_FEAT_PRIV_X;
+	else if (strcmp(feat, "3") == 0)
+		dev->chld_features |= HAL_HF_CLIENT_CHLD_FEAT_MERGE;
+	else if (strcmp(feat, "4") == 0)
+		dev->chld_features |= HAL_HF_CLIENT_CHLD_FEAT_MERGE_DETACH;
+}
+
+static void get_local_codecs_string(struct device *dev, char *buf,
+								uint8_t len)
+{
+	int i;
+	uint8_t offset;
+
+	memset(buf, 0, len);
+	buf[0] = '\0';
+	offset = 0;
+
+	for (i = 0; i < CODECS_COUNT; i++) {
+		if (!dev->codecs[i].local_supported)
+			continue;
+
+		offset += sprintf(&buf[offset], "%d,", dev->codecs[i].type);
+	}
+}
+
+static void slc_completed(struct device *dev)
+{
+	DBG("");
+
+	dev->slc_created = true;
+	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED);
+
+	/*
+	 * TODO: Notify Android with indicators, register unsolicited result
+	 * handlers
+	 */
+}
+
+static void slc_chld_cb(struct hfp_context *context, void *user_data)
+{
+	struct device *dev = user_data;
+	char feat[3];
+
+	if (!hfp_context_open_container(context))
+		goto failed;
+
+	while (hfp_context_get_unquoted_string(context, feat, sizeof(feat)))
+		set_chld_feat(dev, feat);
+
+	if (!hfp_context_close_container(context))
+		info("hf-client: incorrect AT format? Lets be relax on this");
+
+	return;
+
+failed:
+	error("hf-client: Error on CHLD response");
+	slc_error(dev);
+}
+
+static void slc_chld_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct device *dev = user_data;
+
+	DBG("");
+
+	hfp_hf_unregister(dev->hf, "+CHLD");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CHLD error: %d", result);
+		slc_error(dev);
+		return;
+	}
+
+	slc_completed(dev);
+}
+
+static void slc_cmer_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CMER error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!(dev->features & HFP_AG_FEAT_3WAY)) {
+		slc_completed(dev);
+		return;
+	}
+
+	if (!hfp_hf_register(dev->hf, slc_chld_cb, "+CHLD", dev, NULL)) {
+		error("hf-client: Could not register +CHLD");
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, slc_chld_resp, dev, "AT+CHLD=?")) {
+		error("hf-client: Could not send AT+CHLD");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static void set_indicator_value(uint8_t index, uint32_t val,
+						struct indicator *ag_ind)
+{
+	int i;
+
+	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
+		if (index != ag_ind[i].index)
+			continue;
+
+		ag_ind[i].val = val;
+		return;
+	}
+}
+
+static void slc_cind_status_cb(struct hfp_context *context,
+							void *user_data)
+{
+	struct device *dev = user_data;
+	uint8_t index = 1;
+
+	DBG("");
+
+	while (hfp_context_has_next(context)) {
+		uint32_t val;
+
+		if (!hfp_context_get_number(context, &val)) {
+			error("hf-client: Error on CIND status response");
+			return;
+		}
+
+		set_indicator_value(index++, val, dev->ag_ind);
+	}
+}
+
+static void slc_cind_status_resp(enum hfp_result result,
+							enum hfp_error cme_err,
+							void *user_data)
+{
+	struct device *dev = user_data;
+
+	DBG("");
+
+	hfp_hf_unregister(dev->hf, "+CIND");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CIND error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_send_command(dev->hf, slc_cmer_resp, dev,
+							"AT+CMER=3,0,0,1")) {
+		error("hf-client: Counld not send AT+CMER");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static void slc_cind_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct device *dev = user_data;
+
+	DBG("");
+
+	hfp_hf_unregister(dev->hf, "+CIND");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: CIND error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_register(dev->hf, slc_cind_status_cb, "+CIND", dev,
+								NULL)) {
+		error("hf-client: Counld not register +CIND");
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, slc_cind_status_resp, dev,
+								"AT+CIND?")) {
+		error("hf-client: Counld not send AT+CIND?");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static void set_indicator_parameters(uint8_t index, const char *indicator,
+						uint32_t min, uint32_t max,
+						struct indicator *ag_ind)
+{
+	DBG("%s, %i", indicator, index);
+
+	if (strcmp("service", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_SERVICE].index = index;
+		ag_ind[HFP_INDICATOR_SERVICE].min = min;
+		ag_ind[HFP_INDICATOR_SERVICE].max = max;
+		return;
+	}
+
+	if (strcmp("call", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_CALL].index = index;
+		ag_ind[HFP_INDICATOR_CALL].min = min;
+		ag_ind[HFP_INDICATOR_CALL].max = max;
+		return;
+	}
+
+	if (strcmp("callsetup", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_CALLSETUP].index = index;
+		ag_ind[HFP_INDICATOR_CALLSETUP].min = min;
+		ag_ind[HFP_INDICATOR_CALLSETUP].max = max;
+		return;
+	}
+
+	if (strcmp("callheld", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_CALLHELD].index = index;
+		ag_ind[HFP_INDICATOR_CALLHELD].min = min;
+		ag_ind[HFP_INDICATOR_CALLHELD].max = max;
+		return;
+	}
+
+	if (strcmp("signal", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_SIGNAL].index = index;
+		ag_ind[HFP_INDICATOR_SIGNAL].min = min;
+		ag_ind[HFP_INDICATOR_SIGNAL].max = max;
+		return;
+	}
+
+	if (strcmp("roam", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_ROAM].index = index;
+		ag_ind[HFP_INDICATOR_ROAM].min = min;
+		ag_ind[HFP_INDICATOR_ROAM].max = max;
+		return;
+	}
+
+	if (strcmp("battchg", indicator) == 0) {
+		ag_ind[HFP_INDICATOR_BATTCHG].index = index;
+		ag_ind[HFP_INDICATOR_BATTCHG].min = min;
+		ag_ind[HFP_INDICATOR_BATTCHG].max = max;
+		return;
+	}
+
+	error("hf-client: Unknown indicator: %s", indicator);
+}
+
+static void slc_cind_cb(struct hfp_context *context, void *user_data)
+{
+	struct device *dev = user_data;
+	int index = 1;
+
+	DBG("");
+
+	while (hfp_context_has_next(context)) {
+		char name[255];
+		unsigned int min, max;
+
+		/*e.g ("callsetup",(0-3))*/
+		if (!hfp_context_open_container(context))
+			break;
+
+		if (!hfp_context_get_string(context, name, sizeof(name))) {
+			error("hf-client: Could not get string");
+			goto failed;
+		}
+
+		if (!hfp_context_open_container(context)) {
+			error("hf-client: Could not open container");
+			goto failed;
+		}
+
+		if (!hfp_context_get_range(context, &min, &max)) {
+			if (!hfp_context_get_number(context, &min)) {
+				error("hf-client: Could not get number");
+				goto failed;
+			}
+
+			if (!hfp_context_get_number(context, &max)) {
+				error("hf-client: Could not get number");
+				goto failed;
+			}
+		}
+
+		if (!hfp_context_close_container(context)) {
+			error("hf-client: Could not close container");
+			goto failed;
+		}
+
+		if (!hfp_context_close_container(context)) {
+			error("hf-client: Could not close container");
+			goto failed;
+		}
+
+		set_indicator_parameters(index, name, min, max, dev->ag_ind);
+		index++;
+	}
+
+	return;
+
+failed:
+	error("hf-client: Error on CIND response");
+	slc_error(dev);
+}
+
+static void slc_bac_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct device *dev = user_data;
+
+	DBG("");
+
+	if (result != HFP_RESULT_OK)
+		goto failed;
+
+	/* Continue with SLC creation */
+	if (!hfp_hf_register(dev->hf, slc_cind_cb, "+CIND", dev, NULL)) {
+		error("hf-client: Could not register for +CIND");
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, slc_cind_resp, dev, "AT+CIND=?"))
+		goto failed;
+
+	return;
+
+failed:
+	error("hf-client: Error on BAC response");
+	slc_error(dev);
+}
+
+static bool send_supported_codecs(struct device *dev)
+{
+	char codecs_string[8];
+	char bac[16];
+
+	memset(bac, 0, sizeof(bac));
+
+	strcpy(bac, "AT+BAC=");
+
+	get_local_codecs_string(dev, codecs_string, sizeof(codecs_string));
+	strcat(bac, codecs_string);
+
+	return hfp_hf_send_command(dev->hf, slc_bac_resp, dev, bac);
+}
+
+static void slc_brsf_cb(struct hfp_context *context, void *user_data)
+{
+	uint32_t feat;
+	struct device *dev = user_data;
+
+	DBG("");
+
+	if (hfp_context_get_number(context, &feat))
+		dev->features = feat;
+}
+
+static void slc_brsf_resp(enum hfp_result result, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct device *dev = user_data;
+
+	hfp_hf_unregister(dev->hf, "+BRSF");
+
+	if (result != HFP_RESULT_OK) {
+		error("hf-client: BRSF error: %d", result);
+		goto failed;
+	}
+
+	/* Continue with SLC creation */
+	if (dev->features & HFP_AG_FEAT_CODEC) {
+		if (send_supported_codecs(dev))
+			return;
+
+		error("hf-client: Could not send BAC command");
+		goto failed;
+	}
+
+	/* No WBS on remote side. Continue with indicators */
+	if (!hfp_hf_register(dev->hf, slc_cind_cb, "+CIND", dev, NULL)) {
+		error("hf-client: Could not register for +CIND");
+		goto failed;
+	}
+
+	if (!hfp_hf_send_command(dev->hf, slc_cind_resp, dev, "AT+CIND=?")) {
+		error("hf-client: Could not send AT+CIND command");
+		goto failed;
+	}
+
+	return;
+
+failed:
+	slc_error(dev);
+}
+
+static bool create_slc(struct device *dev)
+{
+	DBG("");
+
+	if (!hfp_hf_register(dev->hf, slc_brsf_cb, "+BRSF", dev, NULL))
+		return false;
+
+	return hfp_hf_send_command(dev->hf, slc_brsf_resp, dev, "AT+BRSF=%u",
+							hfp_hf_features);
+}
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct device *dev = user_data;
@@ -288,9 +810,21 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
+	dev->hf = hfp_hf_new(g_io_channel_unix_get_fd(chan));
+	if (!dev->hf) {
+		error("hf-client: Could not create hfp io");
+		goto failed;
+	}
+
 	g_io_channel_set_close_on_unref(chan, FALSE);
 
-	/* TODO Create SLC here. For now do nothing, link will be dropped */
+	hfp_hf_set_close_on_unref(dev->hf, true);
+	hfp_hf_set_disconnect_handler(dev->hf, disconnect_watch, dev, NULL);
+
+	if (!create_slc(dev)) {
+		error("hf-client: Could not start SLC creation");
+		hfp_hf_disconnect(dev->hf);
+	}
 
 	return;
 
-- 
1.8.4

