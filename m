Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 03/10] shared/hfp: Rename functions operating on context
Date: Mon,  3 Nov 2014 10:35:54 +0100
Message-Id: <1415007361-4177-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415007361-4177-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 91 ++++++++++++++++++++++++++---------------------------
 src/shared/hfp.c    | 16 +++++-----
 src/shared/hfp.h    | 14 ++++-----
 unit/test-hfp.c     |  8 ++---
 4 files changed, 64 insertions(+), 65 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index a0bd9dd..3aa4522 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -353,10 +353,10 @@ static void at_cmd_vgm(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 15)
+		if (!hfp_context_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_MIC;
@@ -388,10 +388,10 @@ static void at_cmd_vgs(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 15)
+		if (!hfp_context_get_number(context, &val) || val > 15)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.type = HAL_HANDSFREE_VOLUME_TYPE_SPEAKER;
@@ -420,13 +420,13 @@ static void at_cmd_cops(struct hfp_context *context,
 
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
 
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
@@ -462,8 +462,7 @@ static void at_cmd_bia(struct hfp_context *context,
 		do {
 			def = (i < IND_COUNT) ? dev->inds[i].active : 0;
 
-			if (!hfp_gw_result_get_number_default(context, &val,
-									def))
+			if (!hfp_context_get_number_default(context, &val, def))
 				goto failed;
 
 			if (val > 1)
@@ -473,7 +472,7 @@ static void at_cmd_bia(struct hfp_context *context,
 				tmp[i] = val || dev->inds[i].always_active;
 				i++;
 			}
-		} while (hfp_gw_result_has_next(context));
+		} while (hfp_context_has_next(context));
 
 		for (i = 0; i < IND_COUNT; i++)
 			dev->inds[i].active = tmp[i];
@@ -499,7 +498,7 @@ static void at_cmd_a(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -529,7 +528,7 @@ static void at_cmd_d(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(context,
+		if (!hfp_context_get_unquoted_string(context,
 						(char *) ev->number, 255))
 			break;
 
@@ -571,10 +570,10 @@ static void at_cmd_ccwa(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		dev->ccwa_enabled = val;
@@ -599,7 +598,7 @@ static void at_cmd_chup(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -626,7 +625,7 @@ static void at_cmd_clcc(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -651,10 +650,10 @@ static void at_cmd_cmee(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		dev->cmee_enabled = val;
@@ -680,10 +679,10 @@ static void at_cmd_clip(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		dev->clip_enabled = val;
@@ -710,7 +709,7 @@ static void at_cmd_vts(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_unquoted_string(context, str, 2))
+		if (!hfp_context_get_unquoted_string(context, str, 2))
 			break;
 
 		if (!((str[0] >= '0' && str[0] <= '9') ||
@@ -718,7 +717,7 @@ static void at_cmd_vts(struct hfp_context *context,
 				str[0] == '*' || str[0] == '#'))
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.tone = str[0];
@@ -747,7 +746,7 @@ static void at_cmd_cnum(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -784,7 +783,7 @@ static void at_cmd_bldn(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		ev.number_len = 0;
@@ -812,10 +811,10 @@ static void at_cmd_bvra(struct hfp_context *context,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(context, &val) || val > 1)
+		if (!hfp_context_get_number(context, &val) || val > 1)
 			break;
 
-		if (hfp_gw_result_has_next(context))
+		if (hfp_context_has_next(context))
 			break;
 
 		if (val)
@@ -851,10 +850,10 @@ static void at_cmd_nrec(struct hfp_context *context,
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
@@ -1047,7 +1046,7 @@ static void at_cmd_bcc(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		if (!codec_negotiation_supported(dev))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
@@ -1081,10 +1080,10 @@ static void at_cmd_bcs(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val))
+		if (!hfp_context_get_number(result, &val))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		/* Remote replied with other codec. Reply with error */
@@ -1124,10 +1123,10 @@ static void at_cmd_ckpd(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &val) || val != 200)
+		if (!hfp_context_get_number(result, &val) || val != 200)
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -1185,22 +1184,22 @@ static void at_cmd_cmer(struct hfp_context *result, enum hfp_gw_cmd_type type,
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
 
 		dev->indicators_enabled = val;
@@ -1294,10 +1293,10 @@ static void at_cmd_brsf(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!hfp_gw_result_get_number(result, &feat))
+		if (!hfp_context_get_number(result, &feat))
 			break;
 
-		if (hfp_gw_result_has_next(result))
+		if (hfp_context_has_next(result))
 			break;
 
 		/* TODO verify features */
@@ -1329,11 +1328,11 @@ static void at_cmd_chld(struct hfp_context *result, enum hfp_gw_cmd_type type,
 
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
@@ -1392,23 +1391,23 @@ static void at_cmd_bac(struct hfp_context *result, enum hfp_gw_cmd_type type,
 		 * At least CVSD mandatory codec must exist
 		 * HFP V1.6 4.34.1
 		 */
-		if (!hfp_gw_result_get_number(result, &val) ||
+		if (!hfp_context_get_number(result, &val) ||
 							val != CODEC_ID_CVSD)
 			goto failed;
 
 		dev->codecs[CVSD_OFFSET].remote_supported = true;
 
-		if (hfp_gw_result_get_number(result, &val)) {
+		if (hfp_context_get_number(result, &val)) {
 			if (val != CODEC_ID_MSBC)
 				goto failed;
 
 			dev->codecs[MSBC_OFFSET].remote_supported = true;
 		}
 
-		while (hfp_gw_result_has_next(result)) {
+		while (hfp_context_has_next(result)) {
 			struct hfp_codec *codec;
 
-			if (!hfp_gw_result_get_number(result, &val))
+			if (!hfp_context_get_number(result, &val))
 				goto failed;
 
 			codec = find_codec_by_type(dev, val);
diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index f3f75ab..037f63d 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -261,7 +261,7 @@ static void next_field(struct hfp_context *context)
 		context->offset++;
 }
 
-bool hfp_gw_result_get_number_default(struct hfp_context *context,
+bool hfp_context_get_number_default(struct hfp_context *context,
 						unsigned int *val,
 						unsigned int default_val)
 {
@@ -275,10 +275,10 @@ bool hfp_gw_result_get_number_default(struct hfp_context *context,
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
@@ -304,7 +304,7 @@ bool hfp_gw_result_get_number(struct hfp_context *context,
 	return true;
 }
 
-bool hfp_gw_result_open_container(struct hfp_context *context)
+bool hfp_context_open_container(struct hfp_context *context)
 {
 	skip_whitespace(context);
 
@@ -317,7 +317,7 @@ bool hfp_gw_result_open_container(struct hfp_context *context)
 	return true;
 }
 
-bool hfp_gw_result_close_container(struct hfp_context *context)
+bool hfp_context_close_container(struct hfp_context *context)
 {
 	skip_whitespace(context);
 
@@ -330,7 +330,7 @@ bool hfp_gw_result_close_container(struct hfp_context *context)
 	return true;
 }
 
-bool hfp_gw_result_get_string(struct hfp_context *context, char *buf,
+bool hfp_context_get_string(struct hfp_context *context, char *buf,
 								uint8_t len)
 {
 	int i = 0;
@@ -371,7 +371,7 @@ bool hfp_gw_result_get_string(struct hfp_context *context, char *buf,
 	return true;
 }
 
-bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
+bool hfp_context_get_unquoted_string(struct hfp_context *context,
 							char *buf, uint8_t len)
 {
 	const char *data = context->data;
@@ -408,7 +408,7 @@ bool hfp_gw_result_get_unquoted_string(struct hfp_context *context,
 	return true;
 }
 
-bool hfp_gw_result_has_next(struct hfp_context *context)
+bool hfp_context_has_next(struct hfp_context *context)
 {
 	return context->data[context->offset] != '\0';
 }
diff --git a/src/shared/hfp.h b/src/shared/hfp.h
index 6bb6d35..4ab7150 100644
--- a/src/shared/hfp.h
+++ b/src/shared/hfp.h
@@ -115,18 +115,18 @@ bool hfp_gw_register(struct hfp_gw *hfp, hfp_result_func_t callback,
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
 
 typedef void (*hfp_hf_result_func_t)(struct hfp_context *context,
 							void *user_data);
diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index f6bbe2b..e992cf7 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -370,7 +370,7 @@ static void check_ustring_1(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(hfp_gw_result_get_unquoted_string(result, str, sizeof(str)));
+	g_assert(hfp_context_get_unquoted_string(result, str, sizeof(str)));
 
 	while (context->data->pdu_list[1].data[i] != '\r') {
 		g_assert(j < sizeof(str));
@@ -398,7 +398,7 @@ static void check_ustring_2(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(!hfp_gw_result_get_unquoted_string(result, str, 3));
+	g_assert(!hfp_context_get_unquoted_string(result, str, 3));
 
 	g_assert(str[3] == 'X');
 
@@ -417,7 +417,7 @@ static void check_string_1(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(hfp_gw_result_get_string(result, str, sizeof(str)));
+	g_assert(hfp_context_get_string(result, str, sizeof(str)));
 
 	while (context->data->pdu_list[1].data[i] != '\"') {
 		g_assert(j < sizeof(str));
@@ -446,7 +446,7 @@ static void check_string_2(struct hfp_context *result,
 
 	g_assert(type == pdu->type);
 
-	g_assert(!hfp_gw_result_get_string(result, str, 3));
+	g_assert(!hfp_context_get_string(result, str, 3));
 
 	g_assert(str[3] == 'X');
 
-- 
1.8.4

