Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 01/10] shared/hfp: Rename hfp_gw_result to hfp_context
Date: Mon,  3 Nov 2014 10:35:52 +0100
Message-Id: <1415007361-4177-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hfp_context seems to be better name for data we get in the result of HFP
GW. Especially that we want to use same for HFP HF response data.
---
 android/handsfree.c | 149 ++++++++++++++++++++++++++--------------------------
 src/shared/hfp.c    | 129 +++++++++++++++++++++++----------------------
 src/shared/hfp.h    |  21 ++++----
 unit/test-hfp.c     |  10 ++--
 4 files changed, 156 insertions(+), 153 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index aaf4f7a..a0bd9dd 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -342,8 +342,8 @@ static void at_cmd_unknown(const char *command, void *user_data)
 			HAL_EV_HANDSFREE_UNKNOWN_AT, sizeof(*ev) + ev->len, ev);
 }
 
-static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_vgm(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_volume ev;
@@ -353,10 +353,10 @@ static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 15)
+		if (!hfp_gw_result_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_MIC;
@@ -377,8 +377,8 @@ static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_vgs(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_volume ev;
@@ -388,10 +388,10 @@ static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 15)
+		if (!hfp_gw_result_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_SPEAKER;
@@ -412,21 +412,21 @@ static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_cops(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val != 3)
+		if (!hfp_gw_result_get_number(context, &val) || val != 3)
 			break;
 
-		if (!hfp_gw_result_get_number(result, &val) || val != 0)
+		if (!hfp_gw_result_get_number(context, &val) || val != 0)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
@@ -443,8 +443,8 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bia(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	unsigned int val, i, def;
@@ -462,7 +462,8 @@ static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		do {
 			def = (i < IND_COUNT) ? dev->inds[i].active : 0;
 
-			if (!hfp_gw_result_get_number_default(result, &val, def))
+			if (!hfp_gw_result_get_number_default(context, &val,
+									def))
 				goto failed;
 
 			if (val > 1)
@@ -472,7 +473,7 @@ static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 				tmp[i] = val || dev->inds[i].always_active;
 				i++;
 			}
-		} while (hfp_gw_result_has_next(result));
+		} while (hfp_gw_result_has_next(context));
 
 		for (i = 0; i < IND_COUNT; i++)
 			dev->inds[i].active = tmp[i];
@@ -489,8 +490,8 @@ failed:
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_a(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 
@@ -498,7 +499,7 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -516,8 +517,8 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_d(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	char buf[IPC_MTU];
@@ -528,7 +529,7 @@ static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(result,
+		if (!hfp_gw_result_get_unquoted_string(context,
 						(char *) ev->number, 255))
 			break;
 
@@ -560,8 +561,8 @@ static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_ccwa(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	unsigned int val;
@@ -570,10 +571,10 @@ static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		dev->ccwa_enabled = val;
@@ -589,8 +590,8 @@ static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_chup(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 
@@ -598,7 +599,7 @@ static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -616,8 +617,8 @@ static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_clcc(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 
@@ -625,7 +626,7 @@ static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -640,8 +641,8 @@ static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_cmee(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	unsigned int val;
@@ -650,10 +651,10 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		dev->cmee_enabled = val;
@@ -669,8 +670,8 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_clip(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	unsigned int val;
@@ -679,10 +680,10 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		dev->clip_enabled = val;
@@ -698,8 +699,8 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_vts(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_dtmf ev;
@@ -709,7 +710,7 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(result, str, 2))
+		if (!hfp_gw_result_get_unquoted_string(context, str, 2))
 			break;
 
 		if (!((str[0] >= '0' && str[0] <= '9') ||
@@ -717,7 +718,7 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 				str[0] == '*' || str[0] == '#'))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.tone = str[0];
@@ -737,8 +738,8 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_cnum(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 
@@ -746,7 +747,7 @@ static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -761,8 +762,8 @@ static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_binp(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 
@@ -773,8 +774,8 @@ static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bldn(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_dial ev;
@@ -783,7 +784,7 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.number_len = 0;
@@ -800,8 +801,8 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bvra(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_vr_state ev;
@@ -811,10 +812,10 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		if (val)
@@ -834,8 +835,8 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_nrec(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_nrec ev;
@@ -850,10 +851,10 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		 * callback, but spec allows HF to only disable AG's NREC
 		 * feature for SLC duration. Follow spec here.
 		 */
-		if (!hfp_gw_result_get_number(result, &val) || val != 0)
+		if (!hfp_gw_result_get_number(context, &val) || val != 0)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.nrec = HAL_HANDSFREE_NREC_STOP;
@@ -861,7 +862,7 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_EV_HANDSFREE_NREC, sizeof(ev), &ev);
 
-		/* Framework is not replying with result for AT+NREC */
+		/* Framework is not replying with context for AT+NREC */
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
@@ -873,8 +874,8 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bsir(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 
@@ -885,8 +886,8 @@ static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_btrh(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_btrh(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hf_device *dev = user_data;
 
@@ -1034,7 +1035,7 @@ static gboolean connect_sco_delayed(void *data)
 	return FALSE;
 }
 
-static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_bcc(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1070,7 +1071,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_bcs(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1113,7 +1114,7 @@ static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_ckpd(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1175,7 +1176,7 @@ static void register_post_slc_at(struct hf_device *dev)
 	hfp_gw_register(dev->gw, at_cmd_bcs, "+BCS", dev, NULL);
 }
 
-static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_cmer(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1224,7 +1225,7 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_disconnect(dev->gw);
 }
 
-static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_cind(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1285,7 +1286,7 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_disconnect(dev->gw);
 }
 
-static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_brsf(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1317,7 +1318,7 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		hfp_gw_disconnect(dev->gw);
 }
 
-static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_chld(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
@@ -1370,7 +1371,7 @@ static struct hfp_codec *find_codec_by_type(struct hf_device *dev, uint8_t type)
 	return NULL;
 }
 
-static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_bac(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 8f23ba2..565ddd3 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -94,7 +94,7 @@ struct cmd_handler {
 	hfp_result_func_t callback;
 };
 
-struct hfp_gw_result {
+struct hfp_context {
 	const char *data;
 	unsigned int offset;
 };
@@ -178,37 +178,37 @@ static void wakeup_writer(struct hfp_gw *hfp)
 	hfp->writer_active = true;
 }
 
-static void skip_whitespace(struct hfp_gw_result *result)
+static void skip_whitespace(struct hfp_context *context)
 {
-	while (result->data[result->offset] == ' ')
-		result->offset++;
+	while (context->data[context->offset] == ' ')
+		context->offset++;
 }
 
 static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
 {
 	struct cmd_handler *handler;
 	const char *separators = ";?=\0";
-	struct hfp_gw_result result;
+	struct hfp_context context;
 	enum hfp_gw_cmd_type type;
 	char lookup_prefix[18];
 	uint8_t pref_len = 0;
 	const char *prefix;
 	int i;
 
-	result.offset = 0;
-	result.data = data;
+	context.offset = 0;
+	context.data = data;
 
-	skip_whitespace(&result);
+	skip_whitespace(&context);
 
-	if (strlen(data + result.offset) < 3)
+	if (strlen(data + context.offset) < 3)
 		return false;
 
-	if (strncmp(data + result.offset, "AT", 2))
-		if (strncmp(data + result.offset, "at", 2))
+	if (strncmp(data + context.offset, "AT", 2))
+		if (strncmp(data + context.offset, "at", 2))
 			return false;
 
-	result.offset += 2;
-	prefix = data + result.offset;
+	context.offset += 2;
+	prefix = data + context.offset;
 
 	if (isalpha(prefix[0])) {
 		lookup_prefix[pref_len++] = toupper(prefix[0]);
@@ -222,17 +222,17 @@ static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
 	}
 
 	lookup_prefix[pref_len] = '\0';
-	result.offset += pref_len;
+	context.offset += pref_len;
 
 	if (lookup_prefix[0] == 'D') {
 		type = HFP_GW_CMD_TYPE_SET;
 		goto done;
 	}
 
-	if (data[result.offset] == '=') {
-		result.offset++;
-		if (data[result.offset] == '?') {
-			result.offset++;
+	if (data[context.offset] == '=') {
+		context.offset++;
+		if (data[context.offset] == '?') {
+			context.offset++;
 			type = HFP_GW_CMD_TYPE_TEST;
 		} else {
 			type = HFP_GW_CMD_TYPE_SET;
@@ -240,8 +240,8 @@ static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
 		goto done;
 	}
 
-	if (data[result.offset] == '?') {
-		result.offset++;
+	if (data[context.offset] == '?') {
+		context.offset++;
 		type = HFP_GW_CMD_TYPE_READ;
 		goto done;
 	}
@@ -255,98 +255,99 @@ done:
 	if (!handler)
 		return false;
 
-	handler->callback(&result, type, handler->user_data);
+	handler->callback(&context, type, handler->user_data);
 
 	return true;
 }
 
-static void next_field(struct hfp_gw_result *result)
+static void next_field(struct hfp_context *context)
 {
-	if (result->data[result->offset] == ',')
-		result->offset++;
+	if (context->data[context->offset] == ',')
+		context->offset++;
 }
 
-bool hfp_gw_result_get_number_default(struct hfp_gw_result *result,
+bool hfp_gw_result_get_number_default(struct hfp_context *context,
 						unsigned int *val,
 						unsigned int default_val)
 {
-	skip_whitespace(result);
+	skip_whitespace(context);
 
-	if (result->data[result->offset] == ',') {
+	if (context->data[context->offset] == ',') {
 		if (val)
 			*val = default_val;
 
-		result->offset++;
+		context->offset++;
 		return true;
 	}
 
-	return hfp_gw_result_get_number(result, val);
+	return hfp_gw_result_get_number(context, val);
 }
 
-bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val)
+bool hfp_gw_result_get_number(struct hfp_context *context,
+							unsigned int *val)
 {
 	unsigned int i;
 	int tmp = 0;
 
-	skip_whitespace(result);
+	skip_whitespace(context);
 
-	i = result->offset;
+	i = context->offset;
 
-	while (result->data[i] >= '0' && result->data[i] <= '9')
-		tmp = tmp * 10 + result->data[i++] - '0';
+	while (context->data[i] >= '0' && context->data[i] <= '9')
+		tmp = tmp * 10 + context->data[i++] - '0';
 
-	if (i == result->offset)
+	if (i == context->offset)
 		return false;
 
 	if (val)
 		*val = tmp;
-	result->offset = i;
+	context->offset = i;
 
-	skip_whitespace(result);
-	next_field(result);
+	skip_whitespace(context);
+	next_field(context);
 
 	return true;
 }
 
-bool hfp_gw_result_open_container(struct hfp_gw_result *result)
+bool hfp_gw_result_open_container(struct hfp_context *context)
 {
-	skip_whitespace(result);
+	skip_whitespace(context);
 
 	/* The list shall be preceded by a left parenthesis "(") */
-	if (result->data[result->offset] != '(')
+	if (context->data[context->offset] != '(')
 		return false;
 
-	result->offset++;
+	context->offset++;
 
 	return true;
 }
 
-bool hfp_gw_result_close_container(struct hfp_gw_result *result)
+bool hfp_gw_result_close_container(struct hfp_context *context)
 {
-	skip_whitespace(result);
+	skip_whitespace(context);
 
 	/* The list shall be followed by a right parenthesis (")" V250 5.7.3.1*/
-	if (result->data[result->offset] != ')')
+	if (context->data[context->offset] != ')')
 		return false;
 
-	result->offset++;
+	context->offset++;
 
 	return true;
 }
 
-bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
+bool hfp_gw_result_get_string(struct hfp_context *context, char *buf,
 								uint8_t len)
 {
 	int i = 0;
-	const char *data = result->data;
+	const char *data = context->data;
 	unsigned int offset;
 
-	skip_whitespace(result);
+	skip_whitespace(context);
 
-	if (data[result->offset] != '"')
+	if (data[context->offset] != '"')
 		return false;
 
-	offset = result->offset;
+	offset = context->offset;
 	offset++;
 
 	while (data[offset] != '\0' && data[offset] != '"') {
@@ -367,29 +368,29 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
 	else
 		return false;
 
-	result->offset = offset;
+	context->offset = offset;
 
-	skip_whitespace(result);
-	next_field(result);
+	skip_whitespace(context);
+	next_field(context);
 
 	return true;
 }
 
-bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
-								uint8_t len)
+bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
+							char *buf, uint8_t len)
 {
-	const char *data = result->data;
+	const char *data = context->data;
 	unsigned int offset;
 	int i = 0;
 	char c;
 
-	skip_whitespace(result);
+	skip_whitespace(context);
 
-	c = data[result->offset];
+	c = data[context->offset];
 	if (c == '"' || c == ')' || c == '(')
 		return false;
 
-	offset = result->offset;
+	offset = context->offset;
 
 	while (data[offset] != '\0' && data[offset] != ',' &&
 							data[offset] != ')') {
@@ -405,16 +406,16 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 
 	buf[i] = '\0';
 
-	result->offset = offset;
+	context->offset = offset;
 
-	next_field(result);
+	next_field(context);
 
 	return true;
 }
 
-bool hfp_gw_result_has_next(struct hfp_gw_result *result)
+bool hfp_gw_result_has_next(struct hfp_context *context)
 {
-	return result->data[result->offset] != '\0';
+	return context->data[context->offset] != '\0';
 }
 
 static void process_input(struct hfp_gw *hfp)
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 1467c62..998525c 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -69,9 +69,9 @@ enum hfp_gw_cmd_type {
 	HFP_GW_CMD_TYPE_COMMAND
 };
 
-struct hfp_gw_result;
+struct hfp_context;
 
-typedef void (*hfp_result_func_t)(struct hfp_gw_result *result,
+typedef void (*hfp_result_func_t)(struct hfp_context *context,
 				enum hfp_gw_cmd_type type, void *user_data);
 
 typedef void (*hfp_destroy_func_t)(void *user_data);
@@ -115,17 +115,18 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
 						hfp_destroy_func_t destroy);
 bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix);
 
-bool hfp_gw_result_get_number(struct hfp_gw_result *result, unsigned int *val);
-bool hfp_gw_result_get_number_default(struct hfp_gw_result *result,
+bool hfp_gw_result_get_number(struct hfp_context *context,
+							unsigned int *val);
+bool hfp_gw_result_get_number_default(struct hfp_context *context,
 						unsigned int *val,
 						unsigned int default_val);
-bool hfp_gw_result_open_container(struct hfp_gw_result *result);
-bool hfp_gw_result_close_container(struct hfp_gw_result *result);
-bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
+bool hfp_gw_result_open_container(struct hfp_context *context);
+bool hfp_gw_result_close_container(struct hfp_context *context);
+bool hfp_gw_result_get_string(struct hfp_context *context, char *buf,
 								uint8_t len);
-bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
-								uint8_t len);
-bool hfp_gw_result_has_next(struct hfp_gw_result *result);
+bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
+						char *buf, uint8_t len);
+bool hfp_gw_result_has_next(struct hfp_context *context);
 
 struct hfp_hf_result;
 
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index c11a424..6e58204 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -206,7 +206,7 @@ static void cmd_handler(const char *command, void *user_data)
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void prefix_handler(struct hfp_gw_result *result,
+static void prefix_handler(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -358,7 +358,7 @@ static void test_fragmented(gconstpointer data)
 	execute_context(context);
 }
 
-static void check_ustring_1(struct hfp_gw_result *result,
+static void check_ustring_1(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -385,7 +385,7 @@ static void check_ustring_1(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void check_ustring_2(struct hfp_gw_result *result,
+static void check_ustring_2(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -405,7 +405,7 @@ static void check_ustring_2(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void check_string_1(struct hfp_gw_result *result,
+static void check_string_1(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -433,7 +433,7 @@ static void check_string_1(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void check_string_2(struct hfp_gw_result *result,
+static void check_string_2(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
-- 
1.8.4

