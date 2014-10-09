Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/8] shared/hfp: Rename functions operating on context
Date: Fri, 10 Oct 2014 01:50:47 +0200
Message-Id: <1412898652-12281-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898652-12281-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 91 ++++++++++++++++++++++++++---------------------------
 src/shared/hfp.c    | 16 +++++-----
 src/shared/hfp.h    | 14 ++++-----
 unit/test-hfp.c     |  8 ++---
 4 files changed, 64 insertions(+), 65 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 2bff183..6abc99b 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -301,10 +301,10 @@ static void at_cmd_vgm(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 15)
+		if (!hfp_context_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_MIC;
@@ -335,10 +335,10 @@ static void at_cmd_vgs(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 15)
+		if (!hfp_context_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_SPEAKER;
@@ -366,13 +366,13 @@ static void at_cmd_cops(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val != 3)
+		if (!hfp_context_get_number(context, &val) || val != 3)
 			break;
 
-		if (!hfp_gw_result_get_number(context, &val) || val != 0)
+		if (!hfp_context_get_number(context, &val) || val != 0)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
@@ -407,8 +407,7 @@ static void at_cmd_bia(struct hfp_context *context,
 		do {
 			def = (i < IND_COUNT) ? device.inds[i].active : 0;
 
-			if (!hfp_gw_result_get_number_default(context, &val,
-									def))
+			if (!hfp_context_get_number_default(context, &val, def))
 				goto failed;
 
 			if (val > 1)
@@ -418,7 +417,7 @@ static void at_cmd_bia(struct hfp_context *context,
 				tmp[i] = val || device.inds[i].always_active;
 				i++;
 			}
-		} while (hfp_gw_result_has_next(context));
+		} while (hfp_context_has_next(context));
 
 		for (i = 0; i < IND_COUNT; i++)
 			device.inds[i].active = tmp[i];
@@ -442,7 +441,7 @@ static void at_cmd_a(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -471,7 +470,7 @@ static void at_cmd_d(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(context,
+		if (!hfp_context_get_unquoted_string(context,
 						(char *) ev->number, 255))
 			break;
 
@@ -512,10 +511,10 @@ static void at_cmd_ccwa(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		device.ccwa_enabled = val;
@@ -538,7 +537,7 @@ static void at_cmd_chup(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -563,7 +562,7 @@ static void at_cmd_clcc(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -587,10 +586,10 @@ static void at_cmd_cmee(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		device.cmee_enabled = val;
@@ -615,10 +614,10 @@ static void at_cmd_clip(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		device.clip_enabled = val;
@@ -644,7 +643,7 @@ static void at_cmd_vts(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(context, str, 2))
+		if (!hfp_context_get_unquoted_string(context, str, 2))
 			break;
 
 		if (!((str[0] >= '0' && str[0] <= '9') ||
@@ -652,7 +651,7 @@ static void at_cmd_vts(struct hfp_context *context,
 				str[0] == '*' || str[0] == '#'))
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.tone = str[0];
@@ -679,7 +678,7 @@ static void at_cmd_cnum(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -713,7 +712,7 @@ static void at_cmd_bldn(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.number_len = 0;
@@ -740,10 +739,10 @@ static void at_cmd_bvra(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		if (val)
@@ -778,10 +777,10 @@ static void at_cmd_nrec(struct hfp_context *context,
 		 * callback, but spec allows HF to only disable AG's NREC
 		 * feature for SLC duration. Follow spec here.
 		 */
-		if (!hfp_gw_result_get_number(context, &val) || val != 0)
+		if (!hfp_context_get_number(context, &val) || val != 0)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.nrec = HAL_HANDSFREE_NREC_STOP;
@@ -940,7 +939,7 @@ static void at_cmd_bcc(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		if (!(device.features & HFP_HF_FEAT_CODEC))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
@@ -976,10 +975,10 @@ static void at_cmd_bcs(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val))
+		if (!hfp_context_get_number(result, &val))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		/* Remote replied with other codec. Reply with error */
@@ -1014,10 +1013,10 @@ static void at_cmd_ckpd(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val != 200)
+		if (!hfp_context_get_number(result, &val) || val != 200)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -1074,22 +1073,22 @@ static void at_cmd_cmer(struct hfp_context *result, enum hfp_gw_cmd_type type,
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
 		/* mode must be =3 */
-		if (!hfp_gw_result_get_number(result, &val) || val != 3)
+		if (!hfp_context_get_number(result, &val) || val != 3)
 			break;
 
 		/* keyp is don't care */
-		if (!hfp_gw_result_get_number(result, &val))
+		if (!hfp_context_get_number(result, &val))
 			break;
 
 		/* disp is don't care */
-		if (!hfp_gw_result_get_number(result, &val))
+		if (!hfp_context_get_number(result, &val))
 			break;
 
 		/* ind must be 0 or 1 */
-		if (!hfp_gw_result_get_number(result, &val) || val > 1)
+		if (!hfp_context_get_number(result, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		device.indicators_enabled = val;
@@ -1175,10 +1174,10 @@ static void at_cmd_brsf(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &feat))
+		if (!hfp_context_get_number(result, &feat))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		/* TODO verify features */
@@ -1206,11 +1205,11 @@ static void at_cmd_chld(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val > 3)
+		if (!hfp_context_get_number(result, &val) || val > 3)
 			break;
 
 		/* No ECC support */
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		/* value match HAL type */
@@ -1265,23 +1264,23 @@ static void at_cmd_bac(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		 * At least CVSD mandatory codec must exist
 		 * HFP V1.6 4.34.1
 		 */
-		if (!hfp_gw_result_get_number(result, &val) ||
+		if (!hfp_context_get_number(result, &val) ||
 							val != CODEC_ID_CVSD)
 			goto failed;
 
 		device.codecs[CVSD_OFFSET].remote_supported = true;
 
-		if (hfp_gw_result_get_number(result, &val)) {
+		if (hfp_context_get_number(result, &val)) {
 			if (val != CODEC_ID_MSBC)
 				goto failed;
 
 			device.codecs[MSBC_OFFSET].remote_supported = true;
 		}
 
-		while (hfp_gw_result_has_next(result)) {
+		while (hfp_context_has_next(result)) {
 			struct hfp_codec *codec;
 
-			if (!hfp_gw_result_get_number(result, &val))
+			if (!hfp_context_get_number(result, &val))
 				goto failed;
 
 			codec = find_codec_by_type(val);
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 8170a16..87e4017 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -265,7 +265,7 @@ static void next_field(struct hfp_context *context)
 		context->offset++;
 }
 
-bool hfp_gw_result_get_number_default(struct hfp_context *context,
+bool hfp_context_get_number_default(struct hfp_context *context,
 						unsigned int *val,
 						unsigned int default_val)
 {
@@ -279,10 +279,10 @@ bool hfp_gw_result_get_number_default(struct hfp_context *context,
 		return true;
 	}
 
-	return hfp_gw_result_get_number(context, val);
+	return hfp_context_get_number(context, val);
 }
 
-bool hfp_gw_result_get_number(struct hfp_context *context,
+bool hfp_context_get_number(struct hfp_context *context,
 							unsigned int *val)
 {
 	unsigned int i;
@@ -308,7 +308,7 @@ bool hfp_gw_result_get_number(struct hfp_context *context,
 	return true;
 }
 
-bool hfp_gw_result_open_container(struct hfp_context *context)
+bool hfp_context_open_container(struct hfp_context *context)
 {
 	skip_whitespace(context);
 
@@ -321,7 +321,7 @@ bool hfp_gw_result_open_container(struct hfp_context *context)
 	return true;
 }
 
-bool hfp_gw_result_close_container(struct hfp_context *context)
+bool hfp_context_close_container(struct hfp_context *context)
 {
 	skip_whitespace(context);
 
@@ -334,7 +334,7 @@ bool hfp_gw_result_close_container(struct hfp_context *context)
 	return true;
 }
 
-bool hfp_gw_result_get_string(struct hfp_context *context, char *buf,
+bool hfp_context_get_string(struct hfp_context *context, char *buf,
 								uint8_t len)
 {
 	int i = 0;
@@ -375,7 +375,7 @@ bool hfp_gw_result_get_string(struct hfp_context *context, char *buf,
 	return true;
 }
 
-bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
+bool hfp_context_get_unquoted_string(struct hfp_context *context,
 							char *buf, uint8_t len)
 {
 	const char *data = context->data;
@@ -412,7 +412,7 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
 	return true;
 }
 
-bool hfp_gw_result_has_next(struct hfp_context *result)
+bool hfp_context_has_next(struct hfp_context *result)
 {
 	return result->data[result->offset] != '\0';
 }
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 02df713..27c26a2 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -124,18 +124,18 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
 						hfp_destroy_func_t destroy);
 bool hfp_gw_unregister(struct hfp_gw *hfp, const char *prefix);
 
-bool hfp_gw_result_get_number(struct hfp_context *context,
+bool hfp_context_get_number(struct hfp_context *context,
 							unsigned int *val);
-bool hfp_gw_result_get_number_default(struct hfp_context *context,
+bool hfp_context_get_number_default(struct hfp_context *context,
 						unsigned int *val,
 						unsigned int default_val);
-bool hfp_gw_result_open_container(struct hfp_context *context);
-bool hfp_gw_result_close_container(struct hfp_context *context);
-bool hfp_gw_result_get_string(struct hfp_context *context, char *buf,
+bool hfp_context_open_container(struct hfp_context *context);
+bool hfp_context_close_container(struct hfp_context *context);
+bool hfp_context_get_string(struct hfp_context *context, char *buf,
 								uint8_t len);
-bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
+bool hfp_context_get_unquoted_string(struct hfp_context *context,
 						char *buf, uint8_t len);
-bool hfp_gw_result_has_next(struct hfp_context *context);
+bool hfp_context_has_next(struct hfp_context *context);
 
 struct hfp_hf *hfp_hf_new(int fd);
 struct hfp_hf *hfp_hf_ref(struct hfp_hf *hfp);
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 7dd3b33..c597fd0 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -371,7 +371,7 @@ static void check_ustring_1(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(hfp_gw_result_get_unquoted_string(result, str, sizeof(str)));
+	g_assert(hfp_context_get_unquoted_string(result, str, sizeof(str)));
 
 	while (context->data->pdu_list[1].data[i] != '\r') {
 		g_assert(j < sizeof(str));
@@ -399,7 +399,7 @@ static void check_ustring_2(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(!hfp_gw_result_get_unquoted_string(result, str, 3));
+	g_assert(!hfp_context_get_unquoted_string(result, str, 3));
 
 	g_assert(str[3] == 'X');
 
@@ -418,7 +418,7 @@ static void check_string_1(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(hfp_gw_result_get_string(result, str, sizeof(str)));
+	g_assert(hfp_context_get_string(result, str, sizeof(str)));
 
 	while (context->data->pdu_list[1].data[i] != '\"') {
 		g_assert(j < sizeof(str));
@@ -447,7 +447,7 @@ static void check_string_2(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(!hfp_gw_result_get_string(result, str, 3));
+	g_assert(!hfp_context_get_string(result, str, 3));
 
 	g_assert(str[3] == 'X');
 
-- 
1.8.4

