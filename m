Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 10/12] android/handsfree: Pass device to phone state and indicators functions
Date: Wed,  8 Oct 2014 12:15:12 +0200
Message-Id: <1412763314-12871-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
References: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 172 +++++++++++++++++++++++++++-------------------------
 1 file changed, 89 insertions(+), 83 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 4a55559..aab2fbb 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1822,23 +1822,23 @@ static void handle_volume_control(const void *buf, uint16_t len)
 				HAL_OP_HANDSFREE_VOLUME_CONTROL, status);
 }
 
-static void update_indicator(int ind, uint8_t val)
+static void update_indicator(struct hf_device *dev, int ind, uint8_t val)
 {
-	DBG("ind=%u new=%u old=%u", ind, val, device.inds[ind].val);
+	DBG("ind=%u new=%u old=%u", ind, val, dev->inds[ind].val);
 
-	if (device.inds[ind].val == val)
+	if (dev->inds[ind].val == val)
 		return;
 
-	device.inds[ind].val = val;
+	dev->inds[ind].val = val;
 
-	if (!device.indicators_enabled)
+	if (!dev->indicators_enabled)
 		return;
 
-	if (!device.inds[ind].active)
+	if (!dev->inds[ind].active)
 		return;
 
 	/* indicator numbers in CIEV start from 1 */
-	hfp_gw_send_info(device.gw, "+CIEV: %u,%u", ind + 1, val);
+	hfp_gw_send_info(dev->gw, "+CIEV: %u,%u", ind + 1, val);
 }
 
 static void handle_device_status_notif(const void *buf, uint16_t len)
@@ -1847,10 +1847,10 @@ static void handle_device_status_notif(const void *buf, uint16_t len)
 
 	DBG("");
 
-	update_indicator(IND_SERVICE, cmd->state);
-	update_indicator(IND_ROAM, cmd->type);
-	update_indicator(IND_SIGNAL, cmd->signal);
-	update_indicator(IND_BATTCHG, cmd->battery);
+	update_indicator(&device, IND_SERVICE, cmd->state);
+	update_indicator(&device, IND_ROAM, cmd->type);
+	update_indicator(&device, IND_SIGNAL, cmd->signal);
+	update_indicator(&device, IND_BATTCHG, cmd->battery);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 					HAL_OP_HANDSFREE_DEVICE_STATUS_NOTIF,
@@ -2032,171 +2032,176 @@ static gboolean ring_cb(gpointer user_data)
 	return TRUE;
 }
 
-static void phone_state_dialing(int num_active, int num_held)
+static void phone_state_dialing(struct hf_device *dev, int num_active,
+								int num_held)
 {
-	update_indicator(IND_CALLSETUP, 2);
+	update_indicator(dev, IND_CALLSETUP, 2);
 
 	if (num_active == 0 && num_held > 0)
-		update_indicator(IND_CALLHELD, 2);
+		update_indicator(dev, IND_CALLHELD, 2);
 
-	if (device.num_active == 0 && device.num_held == 0)
-		connect_audio(&device);
+	if (dev->num_active == 0 && dev->num_held == 0)
+		connect_audio(dev);
 }
 
-static void phone_state_alerting(int num_active, int num_held)
+static void phone_state_alerting(struct hf_device *dev, int num_active,
+								int num_held)
 {
-	update_indicator(IND_CALLSETUP, 3);
+	update_indicator(dev, IND_CALLSETUP, 3);
 }
 
-static void phone_state_waiting(int num_active, int num_held, uint8_t type,
+static void phone_state_waiting(struct hf_device *dev, int num_active,
+					int num_held, uint8_t type,
 					const uint8_t *number, int number_len)
 {
 	char *num;
 
-	if (!device.ccwa_enabled)
+	if (!dev->ccwa_enabled)
 		return;
 
 	num = number_len ? (char *) number : "";
 
 	if (type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL && num[0] != '+')
-		hfp_gw_send_info(device.gw, "+CCWA: \"+%s\",%u", num, type);
+		hfp_gw_send_info(dev->gw, "+CCWA: \"+%s\",%u", num, type);
 	else
-		hfp_gw_send_info(device.gw, "+CCWA: \"%s\",%u", num, type);
+		hfp_gw_send_info(dev->gw, "+CCWA: \"%s\",%u", num, type);
 
-	update_indicator(IND_CALLSETUP, 1);
+	update_indicator(dev, IND_CALLSETUP, 1);
 }
 
-static void phone_state_incoming(int num_active, int num_held, uint8_t type,
+static void phone_state_incoming(struct hf_device *dev, int num_active,
+					int num_held, uint8_t type,
 					const uint8_t *number, int number_len)
 {
 	char *num;
 
-	if (device.setup_state == HAL_HANDSFREE_CALL_STATE_INCOMING) {
-		if (device.num_active != num_active ||
-						device.num_held != num_held) {
+	if (dev->setup_state == HAL_HANDSFREE_CALL_STATE_INCOMING) {
+		if (dev->num_active != num_active ||
+						dev->num_held != num_held) {
 			/*
 			 * calls changed while waiting call ie. due to
 			 * termination of active call
 			 */
-			update_indicator(IND_CALLHELD,
+			update_indicator(dev, IND_CALLHELD,
 					num_held ? (num_active ? 1 : 2) : 0);
-			update_indicator(IND_CALL, !!(num_active + num_held));
+			update_indicator(dev, IND_CALL,
+						!!(num_active + num_held));
 		}
 
 		return;
 	}
 
-	if (device.call_hanging_up)
+	if (dev->call_hanging_up)
 		return;
 
 	if (num_active > 0 || num_held > 0) {
-		phone_state_waiting(num_active, num_held, type, number,
+		phone_state_waiting(dev, num_active, num_held, type, number,
 								number_len);
 		return;
 	}
 
-	update_indicator(IND_CALLSETUP, 1);
+	update_indicator(dev, IND_CALLSETUP, 1);
 
 	num = number_len ? (char *) number : "";
 
 	if (type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL && num[0] != '+')
-		device.clip = g_strdup_printf("+CLIP: \"+%s\",%u", num, type);
+		dev->clip = g_strdup_printf("+CLIP: \"+%s\",%u", num, type);
 	else
-		device.clip = g_strdup_printf("+CLIP: \"%s\",%u", num, type);
+		dev->clip = g_strdup_printf("+CLIP: \"%s\",%u", num, type);
 
 	/* send first RING */
-	ring_cb(&device);
+	ring_cb(dev);
 
-	device.ring = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
+	dev->ring = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
 							RING_TIMEOUT, ring_cb,
-							&device, NULL);
-	if (!device.ring) {
-		g_free(device.clip);
-		device.clip = NULL;
+							dev, NULL);
+	if (!dev->ring) {
+		g_free(dev->clip);
+		dev->clip = NULL;
 	}
 }
 
-static void phone_state_idle(int num_active, int num_held)
+static void phone_state_idle(struct hf_device *dev, int num_active,
+								int num_held)
 {
-	if (device.ring) {
-		g_source_remove(device.ring);
-		device.ring = 0;
+	if (dev->ring) {
+		g_source_remove(dev->ring);
+		dev->ring = 0;
 
-		if (device.clip) {
-			g_free(device.clip);
-			device.clip = NULL;
+		if (dev->clip) {
+			g_free(dev->clip);
+			dev->clip = NULL;
 		}
 	}
 
-	switch (device.setup_state) {
+	switch (dev->setup_state) {
 	case HAL_HANDSFREE_CALL_STATE_INCOMING:
-		if (num_active > device.num_active) {
-			update_indicator(IND_CALL, 1);
+		if (num_active > dev->num_active) {
+			update_indicator(dev, IND_CALL, 1);
 
-			if (device.num_active == 0 && device.num_held == 0)
-				connect_audio(&device);
+			if (dev->num_active == 0 && dev->num_held == 0)
+				connect_audio(dev);
 		}
 
-		if (num_held > device.num_held)
-			update_indicator(IND_CALLHELD, 1);
+		if (num_held > dev->num_held)
+			update_indicator(dev, IND_CALLHELD, 1);
 
-		update_indicator(IND_CALLSETUP, 0);
+		update_indicator(dev, IND_CALLSETUP, 0);
 
-		if (num_active == device.num_active &&
-						num_held == device.num_held)
-			device.call_hanging_up = true;
+		if (num_active == dev->num_active && num_held == dev->num_held)
+			dev->call_hanging_up = true;
 
 		break;
 	case HAL_HANDSFREE_CALL_STATE_DIALING:
 	case HAL_HANDSFREE_CALL_STATE_ALERTING:
-		if (num_active > device.num_active)
-			update_indicator(IND_CALL, 1);
+		if (num_active > dev->num_active)
+			update_indicator(dev, IND_CALL, 1);
 
-		update_indicator(IND_CALLHELD,
+		update_indicator(dev, IND_CALLHELD,
 					num_held ? (num_active ? 1 : 2) : 0);
 
-		update_indicator(IND_CALLSETUP, 0);
+		update_indicator(dev, IND_CALLSETUP, 0);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_IDLE:
 
-		if (device.call_hanging_up) {
-			device.call_hanging_up = false;
+		if (dev->call_hanging_up) {
+			dev->call_hanging_up = false;
 			return;
 		}
 
 		/* check if calls swapped */
 		if (num_held != 0 && num_active != 0 &&
-				device.num_active == num_held &&
-				device.num_held == num_active) {
+				dev->num_active == num_held &&
+				dev->num_held == num_active) {
 			/* TODO better way for forcing indicator */
-			device.inds[IND_CALLHELD].val = 0;
+			dev->inds[IND_CALLHELD].val = 0;
 		} else if ((num_active > 0 || num_held > 0) &&
-						device.num_active == 0 &&
-						device.num_held == 0) {
+						dev->num_active == 0 &&
+						dev->num_held == 0) {
 			/*
 			 * If number of active or held calls change but there
 			 * was no call setup change this means that there were
 			 * calls present when headset was connected.
 			 */
-			connect_audio(&device);
+			connect_audio(dev);
 		} else if (num_active == 0 && num_held == 0) {
-			disconnect_sco(&device);
+			disconnect_sco(dev);
 		}
 
-		update_indicator(IND_CALLHELD,
+		update_indicator(dev, IND_CALLHELD,
 					num_held ? (num_active ? 1 : 2) : 0);
-		update_indicator(IND_CALL, !!(num_active + num_held));
-		update_indicator(IND_CALLSETUP, 0);
+		update_indicator(dev, IND_CALL, !!(num_active + num_held));
+		update_indicator(dev, IND_CALLSETUP, 0);
 
 		/* If call was terminated due to carrier lost send NO CARRIER */
 		if (num_active == 0 && num_held == 0 &&
-				device.inds[IND_SERVICE].val == 0 &&
-				(device.num_active > 0 || device.num_held > 0))
-			hfp_gw_send_info(device.gw, "NO CARRIER");
+				dev->inds[IND_SERVICE].val == 0 &&
+				(dev->num_active > 0 || dev->num_held > 0))
+			hfp_gw_send_info(dev->gw, "NO CARRIER");
 
 		break;
 	default:
-		DBG("unhandled state %u", device.setup_state);
+		DBG("unhandled state %u", dev->setup_state);
 		break;
 	}
 }
@@ -2218,17 +2223,18 @@ static void handle_phone_state_change(const void *buf, uint16_t len)
 
 	switch (cmd->state) {
 	case HAL_HANDSFREE_CALL_STATE_DIALING:
-		phone_state_dialing(cmd->num_active, cmd->num_held);
+		phone_state_dialing(&device, cmd->num_active, cmd->num_held);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_ALERTING:
-		phone_state_alerting(cmd->num_active, cmd->num_held);
+		phone_state_alerting(&device, cmd->num_active, cmd->num_held);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_INCOMING:
-		phone_state_incoming(cmd->num_active, cmd->num_held, cmd->type,
-						cmd->number, cmd->number_len);
+		phone_state_incoming(&device, cmd->num_active, cmd->num_held,
+						cmd->type, cmd->number,
+						cmd->number_len);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_IDLE:
-		phone_state_idle(cmd->num_active, cmd->num_held);
+		phone_state_idle(&device, cmd->num_active, cmd->num_held);
 		break;
 	default:
 		DBG("unhandled new state %u (current state %u)", cmd->state,
-- 
1.9.1

