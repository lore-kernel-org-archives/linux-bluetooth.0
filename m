Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/handsfree: Add handling of AT+BCS and AT+BCC
Date: Thu, 13 Mar 2014 15:04:37 +0100
Message-Id: <1394719477-7590-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394719477-7590-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394719477-7590-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will service codec nogotiation and establish SCO connection with
negotiated parameters. If SCO establishment failed, try to connect
with mandatory codec CVSD.
---
 android/handsfree.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 1aee695..7fefccd 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -824,6 +824,33 @@ static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
+static void select_codec(uint8_t codec_type)
+{
+	uint8_t type = CODEC_ID_CVSD;
+	int i;
+
+	if (codec_type > 0) {
+		type = codec_type;
+		goto done;
+	}
+
+	for (i = CODECS_COUNT - 1; i >= CVSD_OFFSET; i--) {
+		if (!device.codecs[i].local_supported)
+			continue;
+
+		if (!device.codecs[i].remote_supported)
+			continue;
+
+		type = device.codecs[i].type;
+		break;
+	}
+
+done:
+	device.proposed_codec = type;
+
+	hfp_gw_send_info(device.gw, "+BCS: %u", type);
+}
+
 static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	if (err) {
@@ -833,6 +860,13 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		status = HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED;
 		device_set_audio_state(status);
 
+		if (!(device.features & HFP_HF_FEAT_CODEC))
+			return;
+
+		if (device.negotiated_codec != CODEC_ID_CVSD)
+			/* If other failed, try connect CVSD */
+			select_codec(CODEC_ID_CVSD);
+
 		return;
 	}
 
@@ -849,13 +883,21 @@ static bool connect_sco(void)
 {
 	GIOChannel *io;
 	GError *gerr = NULL;
+	uint16_t voice_settings;
 
 	if (device.sco)
 		return false;
 
+	if ((device.features & HFP_HF_FEAT_CODEC) && device.negotiated_codec
+							!= CODEC_ID_CVSD)
+		voice_settings = BT_VOICE_TRANSPARENT;
+	else
+		voice_settings = BT_VOICE_CVSD_16BIT;
+
 	io = bt_io_connect(connect_sco_cb, NULL, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
+				BT_IO_OPT_VOICE, voice_settings,
 				BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -876,7 +918,33 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 {
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_COMMAND:
+		if (!(device.features & HFP_HF_FEAT_CODEC))
+			break;
+
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		/* we haven't negotiated codec, start selection */
+		if (!device.negotiated_codec) {
+			select_codec(0);
+			return;
+		}
+		/* we try connect to negotiated codec. If it fails, and it isn't
+		 * CVSD codec, try connect CVSD
+		 */
+		if (!connect_sco() && device.negotiated_codec != CODEC_ID_CVSD)
+			select_codec(CODEC_ID_CVSD);
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_SET:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
@@ -884,9 +952,38 @@ static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 static void at_cmd_bcs(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
+	unsigned int val;
+
 	DBG("");
 
-	/* TODO */
+	switch (type) {
+	case HFP_GW_CMD_TYPE_SET:
+		if (!hfp_gw_result_get_number(result, &val))
+			break;
+
+		if (hfp_gw_result_has_next(result))
+			break;
+
+		/* Remote replied with other codec. Reply with error */
+		if (device.proposed_codec != val) {
+			device.proposed_codec = 0;
+			break;
+		}
+
+		device.proposed_codec = 0;
+		device.negotiated_codec = val;
+
+		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+		/* Connect sco with negotiated parameters */
+		connect_sco();
+
+		return;
+	case HFP_GW_CMD_TYPE_READ:
+	case HFP_GW_CMD_TYPE_TEST:
+	case HFP_GW_CMD_TYPE_COMMAND:
+		break;
+	}
 
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
@@ -1543,6 +1640,19 @@ static bool disconnect_sco(void)
 	return true;
 }
 
+static bool connect_audio(void)
+{
+	if ((device.features & HFP_HF_FEAT_CODEC) && !device.negotiated_codec) {
+		/* It's probably first connection, select best codec
+		 * and try connect
+		 */
+		select_codec(0);
+		return true;
+	}
+
+	return connect_sco();
+}
+
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_connect_audio *cmd = buf;
@@ -1559,7 +1669,7 @@ static void handle_connect_audio(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	status = connect_sco() ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+	status = connect_audio() ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
 
 done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-- 
1.8.3.1

