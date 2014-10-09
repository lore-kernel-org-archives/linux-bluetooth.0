Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/8] shared/hfp: Rename hfp_gw_result to hfp_context
Date: Fri, 10 Oct 2014 01:50:45 +0200
Message-Id: <1412898652-12281-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hfp_context seems to be better name for data we get in the result of HFP
GW. Especially that we want to use same for HFP HF response data.
---
 android/handsfree.c | 149 ++++++++++++++++++++++++++--------------------------
 src/shared/hfp.c    | 123 ++++++++++++++++++++++---------------------
 src/shared/hfp.h    |  21 ++++----
 unit/test-hfp.c     |  10 ++--
 4 files changed, 153 insertions(+), 150 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index a815d3b..2bff183 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -291,8 +291,8 @@ static void at_cmd_unknown(const char *command, void *user_data)
 			HAL_EV_HANDSFREE_UNKNOWN_AT, sizeof(*ev) + ev->len, ev);
 }
 
-static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_vgm(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hal_ev_handsfree_volume ev;
 	unsigned int val;
@@ -301,10 +301,10 @@ static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 15)
+		if (!hfp_gw_result_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_MIC;
@@ -325,8 +325,8 @@ static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_vgs(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hal_ev_handsfree_volume ev;
 	unsigned int val;
@@ -335,10 +335,10 @@ static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 15)
+		if (!hfp_gw_result_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_SPEAKER;
@@ -359,20 +359,20 @@ static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_cops(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
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
 
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
@@ -389,8 +389,8 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bia(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	unsigned int val, i, def;
 	bool tmp[IND_COUNT];
@@ -407,7 +407,8 @@ static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		do {
 			def = (i < IND_COUNT) ? device.inds[i].active : 0;
 
-			if (!hfp_gw_result_get_number_default(result, &val, def))
+			if (!hfp_gw_result_get_number_default(context, &val,
+									def))
 				goto failed;
 
 			if (val > 1)
@@ -417,7 +418,7 @@ static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 				tmp[i] = val || device.inds[i].always_active;
 				i++;
 			}
-		} while (hfp_gw_result_has_next(result));
+		} while (hfp_gw_result_has_next(context));
 
 		for (i = 0; i < IND_COUNT; i++)
 			device.inds[i].active = tmp[i];
@@ -434,14 +435,14 @@ failed:
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_a(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	DBG("");
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -459,8 +460,8 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_d(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	char buf[IPC_MTU];
 	struct hal_ev_handsfree_dial *ev = (void *) buf;
@@ -470,7 +471,7 @@ static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(result,
+		if (!hfp_gw_result_get_unquoted_string(context,
 						(char *) ev->number, 255))
 			break;
 
@@ -502,8 +503,8 @@ static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_ccwa(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	unsigned int val;
 
@@ -511,10 +512,10 @@ static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		device.ccwa_enabled = val;
@@ -530,14 +531,14 @@ static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_chup(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	DBG("");
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -555,14 +556,14 @@ static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_clcc(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	DBG("");
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -577,8 +578,8 @@ static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_cmee(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	unsigned int val;
 
@@ -586,10 +587,10 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		device.cmee_enabled = val;
@@ -605,8 +606,8 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_clip(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	unsigned int val;
 
@@ -614,10 +615,10 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		device.clip_enabled = val;
@@ -633,8 +634,8 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_vts(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hal_ev_handsfree_dtmf ev;
 	char str[2];
@@ -643,7 +644,7 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(result, str, 2))
+		if (!hfp_gw_result_get_unquoted_string(context, str, 2))
 			break;
 
 		if (!((str[0] >= '0' && str[0] <= '9') ||
@@ -651,7 +652,7 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 				str[0] == '*' || str[0] == '#'))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.tone = str[0];
@@ -671,14 +672,14 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_cnum(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	DBG("");
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -693,8 +694,8 @@ static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_binp(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	DBG("");
 
@@ -703,8 +704,8 @@ static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bldn(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hal_ev_handsfree_dial ev;
 
@@ -712,7 +713,7 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		ev.number_len = 0;
@@ -729,8 +730,8 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bvra(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hal_ev_handsfree_vr_state ev;
 	unsigned int val;
@@ -739,10 +740,10 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_gw_result_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_gw_result_has_next(context))
 			break;
 
 		if (val)
@@ -762,8 +763,8 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_nrec(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct hal_ev_handsfree_nrec ev;
 	unsigned int val;
@@ -777,10 +778,10 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
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
@@ -788,7 +789,7 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_EV_HANDSFREE_NREC, sizeof(ev), &ev);
 
-		/* Framework is not replying with result for AT+NREC */
+		/* Framework is not replying with context for AT+NREC */
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
@@ -800,8 +801,8 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_bsir(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	DBG("");
 
@@ -810,8 +811,8 @@ static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_btrh(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
-								void *user_data)
+static void at_cmd_btrh(struct hfp_context *context,
+				enum hfp_gw_cmd_type type, void *user_data)
 {
 	DBG("");
 
@@ -929,7 +930,7 @@ static bool connect_sco(void)
 	return true;
 }
 
-static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_bcc(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	DBG("");
@@ -966,7 +967,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_bcs(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	unsigned int val;
@@ -1004,7 +1005,7 @@ static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_ckpd(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	unsigned int val;
@@ -1065,7 +1066,7 @@ static void register_post_slc_at(void)
 	hfp_gw_register(device.gw, at_cmd_bcs, "+BCS", NULL, NULL);
 }
 
-static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_cmer(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	unsigned int val;
@@ -1110,7 +1111,7 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_cind(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	char *buf, *ptr;
@@ -1167,7 +1168,7 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_brsf(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	unsigned int feat;
@@ -1195,7 +1196,7 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
-static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_chld(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hal_ev_handsfree_chld ev;
@@ -1244,7 +1245,7 @@ static struct hfp_codec *find_codec_by_type(uint8_t type)
 	return NULL;
 }
 
-static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
+static void at_cmd_bac(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	unsigned int val;
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 8bebe97..1b15da6 100644
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
@@ -182,7 +182,7 @@ static void wakeup_writer(struct hfp_gw *hfp)
 	hfp->writer_active = true;
 }
 
-static void skip_whitespace(struct hfp_gw_result *result)
+static void skip_whitespace(struct hfp_context *result)
 {
 	while (result->data[result->offset] == ' ')
 		result->offset++;
@@ -192,27 +192,27 @@ static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
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
@@ -226,17 +226,17 @@ static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
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
@@ -244,8 +244,8 @@ static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
 		goto done;
 	}
 
-	if (data[result.offset] == '?') {
-		result.offset++;
+	if (data[context.offset] == '?') {
+		context.offset++;
 		type = HFP_GW_CMD_TYPE_READ;
 		goto done;
 	}
@@ -259,98 +259,99 @@ done:
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
@@ -371,29 +372,29 @@ bool hfp_gw_result_get_string(struct hfp_gw_result *result, char *buf,
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
@@ -409,14 +410,14 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_gw_result *result, char *buf,
 
 	buf[i] = '\0';
 
-	result->offset = offset;
+	context->offset = offset;
 
-	next_field(result);
+	next_field(context);
 
 	return true;
 }
 
-bool hfp_gw_result_has_next(struct hfp_gw_result *result)
+bool hfp_gw_result_has_next(struct hfp_context *result)
 {
 	return result->data[result->offset] != '\0';
 }
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 5ee3017..e57306a 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -69,10 +69,10 @@ enum hfp_gw_cmd_type {
 	HFP_GW_CMD_TYPE_COMMAND
 };
 
-struct hfp_gw_result;
+struct hfp_context;
 struct hfp_hf_result;
 
-typedef void (*hfp_result_func_t)(struct hfp_gw_result *result,
+typedef void (*hfp_result_func_t)(struct hfp_context *context,
 				enum hfp_gw_cmd_type type, void *user_data);
 
 typedef void (*hfp_hf_result_func_t)(struct hfp_hf_result *result,
@@ -125,17 +125,18 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
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
 
 struct hfp_hf *hfp_hf_new(int fd);
 struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp);
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 2515f26..da8a5c9 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -207,7 +207,7 @@ static void cmd_handler(const char *command, void *user_data)
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void prefix_handler(struct hfp_gw_result *result,
+static void prefix_handler(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -359,7 +359,7 @@ static void test_fragmented(gconstpointer data)
 	execute_context(context);
 }
 
-static void check_ustring_1(struct hfp_gw_result *result,
+static void check_ustring_1(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -386,7 +386,7 @@ static void check_ustring_1(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void check_ustring_2(struct hfp_gw_result *result,
+static void check_ustring_2(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -406,7 +406,7 @@ static void check_ustring_2(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void check_string_1(struct hfp_gw_result *result,
+static void check_string_1(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
@@ -434,7 +434,7 @@ static void check_string_1(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
-static void check_string_2(struct hfp_gw_result *result,
+static void check_string_2(struct hfp_context *result,
 				enum hfp_gw_cmd_type type, void *user_data)
 {
 	struct context *context = user_data;
-- 
1.8.4

