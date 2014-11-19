Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 08/15] android/handsfree-client: Add support for +CIEV events
Date: Wed, 19 Nov 2014 10:43:41 +0100
Message-Id: <1416390228-28330-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416390228-28330-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 150 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 79779c2..50c5821 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -95,11 +95,14 @@ enum hfp_indicator {
 	HFP_INDICATOR_LAST
 };
 
+typedef void (*ciev_func_t)(uint8_t val);
+
 struct indicator {
 	uint8_t index;
 	uint32_t min;
 	uint32_t max;
 	uint32_t val;
+	ciev_func_t cb;
 };
 
 struct hfp_codec {
@@ -833,6 +836,32 @@ static void clcc_cb(struct hfp_context *context, void *user_data)
 					sizeof(*ev) + ev->number_len, ev);
 }
 
+static void ciev_cb(struct hfp_context *context, void *user_data)
+{
+	struct device *dev = user_data;
+	unsigned int index, val;
+	int i;
+
+	DBG("");
+
+	if (!hfp_context_get_number(context, &index))
+		return;
+
+	if (!hfp_context_get_number(context, &val))
+		return;
+
+	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
+		if (dev->ag_ind[i].index != index)
+			continue;
+
+		if (dev->ag_ind[i].cb) {
+			dev->ag_ind[i].val = val;
+			dev->ag_ind[i].cb(val);
+			return;
+		}
+	}
+}
+
 static void slc_completed(struct device *dev)
 {
 	DBG("");
@@ -849,6 +878,7 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, vgs_cb, "+VGS", dev, NULL);
 	hfp_hf_register(dev->hf, brth_cb, "+BTRH", dev, NULL);
 	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
+	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
@@ -1019,6 +1049,119 @@ failed:
 	slc_error(dev);
 }
 
+static void ciev_service_cb(uint8_t val)
+{
+	struct hal_ev_hf_client_net_state ev;
+
+	DBG("");
+
+	if (val > HAL_HF_CLIENT_NET_ROAMING_TYPE_ROAMING) {
+		error("hf-client: Incorrect state %u:", val);
+		return;
+	}
+
+	ev.state = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_EV_HF_CLIENT_NET_STATE, sizeof(ev), &ev);
+}
+
+static void ciev_call_cb(uint8_t val)
+{
+	struct hal_ev_hf_client_call_indicator ev;
+
+	DBG("");
+
+	if (val > HAL_HF_CLIENT_CALL_IND_CALL_IN_PROGERSS) {
+		error("hf-client: Incorrect call state %u:", val);
+		return;
+	}
+
+	ev.call = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_EV_HF_CLIENT_CALL_INDICATOR, sizeof(ev), &ev);
+}
+
+static void ciev_callsetup_cb(uint8_t val)
+{
+	struct hal_ev_hf_client_call_setup_indicator ev;
+
+	DBG("");
+
+	if (val > HAL_HF_CLIENT_CALL_SETUP_ALERTING) {
+		error("hf-client: Incorrect call setup state  %u:", val);
+		return;
+	}
+
+	ev.call_setup = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_HF_CLIENT_CALL_SETUP_INDICATOR,
+					sizeof(ev), &ev);
+}
+
+static void ciev_callheld_cb(uint8_t val)
+{
+	struct hal_ev_hf_client_call_held_indicator ev;
+
+	DBG("");
+
+	if (val > HAL_HF_CLIENT_CALL_SETUP_IND_HOLD) {
+		error("hf-client: Incorrect call held state  %u:", val);
+		return;
+	}
+
+	ev.call_held = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_HF_CLIENT_CALL_HELD_INDICATOR,
+					sizeof(ev), &ev);
+}
+
+static void ciev_signal_cb(uint8_t val)
+{
+	struct hal_ev_hf_client_net_signal_strength ev;
+
+	DBG("");
+
+	ev.signal_strength = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_HF_CLIENT_NET_SIGNAL_STRENGTH,
+					sizeof(ev), &ev);
+}
+
+static void ciev_roam_cb(uint8_t val)
+{
+	struct hal_ev_hf_client_net_roaming_type ev;
+
+	DBG("");
+
+	if (val > HAL_HF_CLIENT_NET_ROAMING_TYPE_ROAMING) {
+		error("hf-client: Incorrect roaming state  %u:", val);
+		return;
+	}
+
+	ev.state = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_EV_HF_CLIENT_NET_ROAMING_TYPE,
+					sizeof(ev), &ev);
+}
+
+static void ciev_battchg_cb(uint8_t val)
+{
+	struct hal_ev_hf_client_battery_level ev;
+
+	DBG("");
+
+	ev.battery_level = val;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_EV_HF_CLIENT_BATTERY_LEVEL, sizeof(ev), &ev);
+}
+
 static void set_indicator_parameters(uint8_t index, const char *indicator,
 						unsigned int min,
 						unsigned int max,
@@ -1032,6 +1175,7 @@ static void set_indicator_parameters(uint8_t index, const char *indicator,
 		ag_ind[HFP_INDICATOR_SERVICE].index = index;
 		ag_ind[HFP_INDICATOR_SERVICE].min = min;
 		ag_ind[HFP_INDICATOR_SERVICE].max = max;
+		ag_ind[HFP_INDICATOR_SERVICE].cb = ciev_service_cb;
 		return;
 	}
 
@@ -1039,6 +1183,7 @@ static void set_indicator_parameters(uint8_t index, const char *indicator,
 		ag_ind[HFP_INDICATOR_CALL].index = index;
 		ag_ind[HFP_INDICATOR_CALL].min = min;
 		ag_ind[HFP_INDICATOR_CALL].max = max;
+		ag_ind[HFP_INDICATOR_CALL].cb = ciev_call_cb;
 		return;
 	}
 
@@ -1046,6 +1191,7 @@ static void set_indicator_parameters(uint8_t index, const char *indicator,
 		ag_ind[HFP_INDICATOR_CALLSETUP].index = index;
 		ag_ind[HFP_INDICATOR_CALLSETUP].min = min;
 		ag_ind[HFP_INDICATOR_CALLSETUP].max = max;
+		ag_ind[HFP_INDICATOR_CALLSETUP].cb = ciev_callsetup_cb;
 		return;
 	}
 
@@ -1053,6 +1199,7 @@ static void set_indicator_parameters(uint8_t index, const char *indicator,
 		ag_ind[HFP_INDICATOR_CALLHELD].index = index;
 		ag_ind[HFP_INDICATOR_CALLHELD].min = min;
 		ag_ind[HFP_INDICATOR_CALLHELD].max = max;
+		ag_ind[HFP_INDICATOR_CALLHELD].cb = ciev_callheld_cb;
 		return;
 	}
 
@@ -1060,6 +1207,7 @@ static void set_indicator_parameters(uint8_t index, const char *indicator,
 		ag_ind[HFP_INDICATOR_SIGNAL].index = index;
 		ag_ind[HFP_INDICATOR_SIGNAL].min = min;
 		ag_ind[HFP_INDICATOR_SIGNAL].max = max;
+		ag_ind[HFP_INDICATOR_SIGNAL].cb = ciev_signal_cb;
 		return;
 	}
 
@@ -1067,6 +1215,7 @@ static void set_indicator_parameters(uint8_t index, const char *indicator,
 		ag_ind[HFP_INDICATOR_ROAM].index = index;
 		ag_ind[HFP_INDICATOR_ROAM].min = min;
 		ag_ind[HFP_INDICATOR_ROAM].max = max;
+		ag_ind[HFP_INDICATOR_ROAM].cb = ciev_roam_cb;
 		return;
 	}
 
@@ -1074,6 +1223,7 @@ static void set_indicator_parameters(uint8_t index, const char *indicator,
 		ag_ind[HFP_INDICATOR_BATTCHG].index = index;
 		ag_ind[HFP_INDICATOR_BATTCHG].min = min;
 		ag_ind[HFP_INDICATOR_BATTCHG].max = max;
+		ag_ind[HFP_INDICATOR_BATTCHG].cb = ciev_battchg_cb;
 		return;
 	}
 
-- 
1.8.4

