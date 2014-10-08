Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/13] android/handsfree: Pass device as user data to AT handlers
Date: Wed,  8 Oct 2014 09:12:13 +0200
Message-Id: <1412752343-7001-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
References: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 264 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 150 insertions(+), 114 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 7fa8cfd..d49d13b 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -271,12 +271,13 @@ static void disconnect_watch(void *user_data)
 
 static void at_cmd_unknown(const char *command, void *user_data)
 {
+	struct hf_device *dev = user_data;
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_handsfree_unknown_at *ev = (void *) buf;
 
-	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED) {
-		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
-		hfp_gw_disconnect(device.gw);
+	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED) {
+		hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
+		hfp_gw_disconnect(dev->gw);
 		return;
 	}
 
@@ -285,7 +286,7 @@ static void at_cmd_unknown(const char *command, void *user_data)
 	memcpy(ev->buf, command, ev->len);
 
 	if (ev->len > IPC_MTU - sizeof(*ev)) {
-		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 		return;
 	}
 
@@ -296,6 +297,7 @@ static void at_cmd_unknown(const char *command, void *user_data)
 static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_volume ev;
 	unsigned int val;
 
@@ -316,7 +318,7 @@ static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 				HAL_EV_HANDSFREE_VOLUME, sizeof(ev), &ev);
 
 		/* Framework is not replying with result for AT+VGM */
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -324,12 +326,13 @@ static void at_cmd_vgm(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_volume ev;
 	unsigned int val;
 
@@ -350,7 +353,7 @@ static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 				HAL_EV_HANDSFREE_VOLUME, sizeof(ev), &ev);
 
 		/* Framework is not replying with result for AT+VGS */
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -358,12 +361,13 @@ static void at_cmd_vgs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	switch (type) {
@@ -377,7 +381,7 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
@@ -388,12 +392,13 @@ static void at_cmd_cops(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val, i, def;
 	bool tmp[IND_COUNT];
 
@@ -402,12 +407,12 @@ static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
 		for (i = 0; i < IND_COUNT; i++)
-			tmp[i] = device.inds[i].active;
+			tmp[i] = dev->inds[i].active;
 
 		i = 0;
 
 		do {
-			def = (i < IND_COUNT) ? device.inds[i].active : 0;
+			def = (i < IND_COUNT) ? dev->inds[i].active : 0;
 
 			if (!hfp_gw_result_get_number_default(result, &val, def))
 				goto failed;
@@ -416,15 +421,15 @@ static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 				goto failed;
 
 			if (i < IND_COUNT) {
-				tmp[i] = val || device.inds[i].always_active;
+				tmp[i] = val || dev->inds[i].always_active;
 				i++;
 			}
 		} while (hfp_gw_result_has_next(result));
 
 		for (i = 0; i < IND_COUNT; i++)
-			device.inds[i].active = tmp[i];
+			dev->inds[i].active = tmp[i];
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
@@ -433,12 +438,14 @@ static void at_cmd_bia(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	}
 
 failed:
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	switch (type) {
@@ -450,7 +457,7 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 					HAL_EV_HANDSFREE_ANSWER, 0, NULL);
 
 		/* Framework is not replying with result for ATA */
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_SET:
 	case HFP_GW_CMD_TYPE_READ:
@@ -458,12 +465,13 @@ static void at_cmd_a(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	char buf[IPC_MTU];
 	struct hal_ev_handsfree_dial *ev = (void *) buf;
 	int cnt;
@@ -501,12 +509,13 @@ static void at_cmd_d(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	DBG("");
@@ -519,9 +528,9 @@ static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
-		device.ccwa_enabled = val;
+		dev->ccwa_enabled = val;
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -529,12 +538,14 @@ static void at_cmd_ccwa(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	switch (type) {
@@ -546,7 +557,7 @@ static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 					HAL_EV_HANDSFREE_HANGUP, 0, NULL);
 
 		/* Framework is not replying with result for AT+CHUP */
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -554,12 +565,14 @@ static void at_cmd_chup(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	switch (type) {
@@ -576,12 +589,13 @@ static void at_cmd_clcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	DBG("");
@@ -594,9 +608,9 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
-		device.cmee_enabled = val;
+		dev->cmee_enabled = val;
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -604,12 +618,13 @@ static void at_cmd_cmee(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	DBG("");
@@ -622,9 +637,9 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
-		device.clip_enabled = val;
+		dev->clip_enabled = val;
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -632,12 +647,13 @@ static void at_cmd_clip(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_dtmf ev;
 	char str[2];
 
@@ -662,7 +678,7 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 					HAL_EV_HANDSFREE_DTMF, sizeof(ev), &ev);
 
 		/* Framework is not replying with result for AT+VTS */
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -670,12 +686,14 @@ static void at_cmd_vts(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	switch (type) {
@@ -692,22 +710,25 @@ static void at_cmd_cnum(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_binp(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	/* TODO */
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_dial ev;
 
 	DBG("");
@@ -728,12 +749,13 @@ static void at_cmd_bldn(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_vr_state ev;
 	unsigned int val;
 
@@ -761,12 +783,13 @@ static void at_cmd_bvra(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_nrec ev;
 	unsigned int val;
 
@@ -791,7 +814,7 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 					HAL_EV_HANDSFREE_NREC, sizeof(ev), &ev);
 
 		/* Framework is not replying with result for AT+NREC */
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -799,27 +822,31 @@ static void at_cmd_nrec(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_bsir(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	/* TODO */
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_btrh(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	/* TODO */
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
@@ -932,20 +959,22 @@ static bool connect_sco(void)
 static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_COMMAND:
-		if (!(device.features & HFP_HF_FEAT_CODEC))
+		if (!(dev->features & HFP_HF_FEAT_CODEC))
 			break;
 
 		if (hfp_gw_result_has_next(result))
 			break;
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		/* we haven't negotiated codec, start selection */
-		if (!device.negotiated_codec) {
+		if (!dev->negotiated_codec) {
 			select_codec(0);
 			return;
 		}
@@ -953,7 +982,7 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		 * we try connect to negotiated codec. If it fails, and it isn't
 		 * CVSD codec, try connect CVSD
 		 */
-		if (!connect_sco() && device.negotiated_codec != CODEC_ID_CVSD)
+		if (!connect_sco() && dev->negotiated_codec != CODEC_ID_CVSD)
 			select_codec(CODEC_ID_CVSD);
 
 		return;
@@ -963,12 +992,13 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	DBG("");
@@ -982,15 +1012,15 @@ static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			break;
 
 		/* Remote replied with other codec. Reply with error */
-		if (device.proposed_codec != val) {
-			device.proposed_codec = 0;
+		if (dev->proposed_codec != val) {
+			dev->proposed_codec = 0;
 			break;
 		}
 
-		device.proposed_codec = 0;
-		device.negotiated_codec = val;
+		dev->proposed_codec = 0;
+		dev->negotiated_codec = val;
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		/* Connect sco with negotiated parameters */
 		connect_sco();
@@ -1001,12 +1031,13 @@ static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	DBG("");
@@ -1022,7 +1053,7 @@ static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 				HAL_EV_HANDSFREE_HSP_KEY_PRESS, 0, NULL);
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -1030,44 +1061,45 @@ static void at_cmd_ckpd(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void register_post_slc_at(void)
 {
 	if (device.hsp) {
-		hfp_gw_register(device.gw, at_cmd_ckpd, "+CKPD", NULL, NULL);
-		hfp_gw_register(device.gw, at_cmd_vgs, "+VGS", NULL, NULL);
-		hfp_gw_register(device.gw, at_cmd_vgm, "+VGM", NULL, NULL);
+		hfp_gw_register(device.gw, at_cmd_ckpd, "+CKPD", &device, NULL);
+		hfp_gw_register(device.gw, at_cmd_vgs, "+VGS", &device, NULL);
+		hfp_gw_register(device.gw, at_cmd_vgm, "+VGM", &device, NULL);
 		return;
 	}
 
-	hfp_gw_register(device.gw, at_cmd_a, "A", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_d, "D", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_ccwa, "+CCWA", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_chup, "+CHUP", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_clcc, "+CLCC", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_cops, "+COPS", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_cmee, "+CMEE", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_clip, "+CLIP", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_vts, "+VTS", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_cnum, "+CNUM", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_bia, "+BIA", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_binp, "+BINP", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_bldn, "+BLDN", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_bvra, "+BVRA", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_nrec, "+NREC", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_vgs, "+VGS", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_vgm, "+VGM", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_bsir, "+BSIR", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_btrh, "+BTRH", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_bcc, "+BCC", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_bcs, "+BCS", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_a, "A", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_d, "D", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_ccwa, "+CCWA", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_chup, "+CHUP", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_clcc, "+CLCC", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_cops, "+COPS", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_cmee, "+CMEE", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_clip, "+CLIP", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_vts, "+VTS", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_cnum, "+CNUM", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_bia, "+BIA", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_binp, "+BINP", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_bldn, "+BLDN", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_bvra, "+BVRA", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_nrec, "+NREC", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_vgs, "+VGS", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_vgm, "+VGM", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_bsir, "+BSIR", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_btrh, "+BTRH", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_bcc, "+BCC", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_bcs, "+BCS", &device, NULL);
 }
 
 static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	switch (type) {
@@ -1091,15 +1123,15 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (hfp_gw_result_has_next(result))
 			break;
 
-		device.indicators_enabled = val;
+		dev->indicators_enabled = val;
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
-		if (device.features & HFP_HF_FEAT_3WAY)
+		if (dev->features & HFP_HF_FEAT_3WAY)
 			return;
 
 		register_post_slc_at();
-		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
+		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
@@ -1107,12 +1139,13 @@ static void at_cmd_cmer(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	char *buf, *ptr;
 	int len;
 	unsigned int i;
@@ -1124,15 +1157,15 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		 * If device supports Codec Negotiation, AT+BAC should be
 		 * received first
 		 */
-		if ((device.features & HFP_HF_FEAT_CODEC) &&
-				!device.codecs[CVSD_OFFSET].remote_supported)
+		if ((dev->features & HFP_HF_FEAT_CODEC) &&
+				!dev->codecs[CVSD_OFFSET].remote_supported)
 			break;
 
 		len = strlen("+CIND:") + 1;
 
 		for (i = 0; i < IND_COUNT; i++) {
 			len += strlen("(\"\",(X,X)),");
-			len += strlen(device.inds[i].name);
+			len += strlen(dev->inds[i].name);
 		}
 
 		buf = g_malloc(len);
@@ -1141,17 +1174,17 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 		for (i = 0; i < IND_COUNT; i++) {
 			ptr += sprintf(ptr, "(\"%s\",(%d%c%d)),",
-					device.inds[i].name,
-					device.inds[i].min,
-					device.inds[i].max == 1 ? ',' : '-',
-					device.inds[i].max);
+					dev->inds[i].name,
+					dev->inds[i].min,
+					dev->inds[i].max == 1 ? ',' : '-',
+					dev->inds[i].max);
 		}
 
 		ptr--;
 		*ptr = '\0';
 
-		hfp_gw_send_info(device.gw, "%s", buf);
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_info(dev->gw, "%s", buf);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		g_free(buf);
 		return;
@@ -1164,12 +1197,13 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int feat;
 
 	switch (type) {
@@ -1181,10 +1215,10 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			break;
 
 		/* TODO verify features */
-		device.features = feat;
+		dev->features = feat;
 
-		hfp_gw_send_info(device.gw, "+BRSF: %u", hfp_ag_features);
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_info(dev->gw, "+BRSF: %u", hfp_ag_features);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_TEST:
@@ -1192,12 +1226,13 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	struct hal_ev_handsfree_chld ev;
 	unsigned int val;
 
@@ -1219,18 +1254,18 @@ static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 					HAL_EV_HANDSFREE_CHLD, sizeof(ev), &ev);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
-		hfp_gw_send_info(device.gw, "+CHLD: (%s)", HFP_AG_CHLD);
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_info(dev->gw, "+CHLD: (%s)", HFP_AG_CHLD);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
 		register_post_slc_at();
-		set_state(&device, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
+		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED);
 		return;
 	case HFP_GW_CMD_TYPE_READ:
 	case HFP_GW_CMD_TYPE_COMMAND:
 		break;
 	}
 
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static struct hfp_codec *find_codec_by_type(uint8_t type)
@@ -1247,18 +1282,19 @@ static struct hfp_codec *find_codec_by_type(uint8_t type)
 static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
+	struct hf_device *dev = user_data;
 	unsigned int val;
 
 	DBG("");
 
 	switch (type) {
 	case HFP_GW_CMD_TYPE_SET:
-		if (!(device.features & HFP_HF_FEAT_CODEC))
+		if (!(dev->features & HFP_HF_FEAT_CODEC))
 			goto failed;
 
 		/* set codecs to defaults */
-		init_codecs(&device);
-		device.negotiated_codec = 0;
+		init_codecs(dev);
+		dev->negotiated_codec = 0;
 
 		/*
 		 * At least CVSD mandatory codec must exist
@@ -1268,13 +1304,13 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							val != CODEC_ID_CVSD)
 			goto failed;
 
-		device.codecs[CVSD_OFFSET].remote_supported = true;
+		dev->codecs[CVSD_OFFSET].remote_supported = true;
 
 		if (hfp_gw_result_get_number(result, &val)) {
 			if (val != CODEC_ID_MSBC)
 				goto failed;
 
-			device.codecs[MSBC_OFFSET].remote_supported = true;
+			dev->codecs[MSBC_OFFSET].remote_supported = true;
 		}
 
 		while (hfp_gw_result_has_next(result)) {
@@ -1290,9 +1326,9 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 			codec->remote_supported = true;
 		}
 
-		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+		hfp_gw_send_result(dev->gw, HFP_RESULT_OK);
 
-		if (device.proposed_codec)
+		if (dev->proposed_codec)
 			select_codec(0);
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
@@ -1302,16 +1338,16 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	}
 
 failed:
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 }
 
 static void register_slc_at(void)
 {
-	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_chld, "+CHLD", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_bac, "+BAC", NULL, NULL);
+	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_chld, "+CHLD", &device, NULL);
+	hfp_gw_register(device.gw, at_cmd_bac, "+BAC", &device, NULL);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
-- 
1.9.1

